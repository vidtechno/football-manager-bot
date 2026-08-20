-- SQL Migration: Permanent Player Transfer Market with Human and Bot Purchases
-- Creates league_transfer_listings table, domain ENUMs, indexes, constraints, and atomic RPC functions:
--   create_player_transfer_listing
--   cancel_player_transfer_listing
--   purchase_player_transfer_listing
--   process_bot_transfer_reviews

-- 1. Domain ENUMs
CREATE TYPE public.enum_transfer_listing_status AS ENUM (
    'ACTIVE',
    'SOLD',
    'CANCELLED',
    'INVALIDATED'
);

CREATE TYPE public.enum_transfer_buyer_type AS ENUM (
    'HUMAN',
    'BOT'
);


-- 2. Table: league_transfer_listings
CREATE TABLE public.league_transfer_listings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    league_id UUID NOT NULL REFERENCES public.leagues(id) ON DELETE CASCADE,
    seller_club_id UUID NOT NULL REFERENCES public.league_clubs(id) ON DELETE CASCADE,
    league_player_id UUID NOT NULL REFERENCES public.league_players(id) ON DELETE CASCADE,
    
    player_name_snapshot VARCHAR(150) NOT NULL CHECK (char_length(trim(player_name_snapshot)) > 0),
    position_code public.enum_player_position NOT NULL,
    overall_rating INT NOT NULL CHECK (overall_rating BETWEEN 1 AND 99),
    original_market_value_eur NUMERIC(15, 2) NOT NULL CHECK (original_market_value_eur >= 0),
    asking_price_eur NUMERIC(15, 2) NOT NULL CHECK (asking_price_eur > 0),
    
    status public.enum_transfer_listing_status NOT NULL DEFAULT 'ACTIVE',
    buyer_club_id UUID NULL REFERENCES public.league_clubs(id) ON DELETE SET NULL,
    buyer_type public.enum_transfer_buyer_type NULL,
    
    listed_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    bot_eligible_at TIMESTAMPTZ NOT NULL DEFAULT (NOW() + INTERVAL '24 hours'),
    completed_at TIMESTAMPTZ NULL,
    cancelled_at TIMESTAMPTZ NULL,
    
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    
    CONSTRAINT chk_asking_price_positive CHECK (asking_price_eur > 0),
    CONSTRAINT chk_completed_at_when_sold CHECK (status <> 'SOLD' OR (completed_at IS NOT NULL AND buyer_club_id IS NOT NULL AND buyer_type IS NOT NULL)),
    CONSTRAINT chk_cancelled_at_when_cancelled CHECK (status <> 'CANCELLED' OR cancelled_at IS NOT NULL)
);

-- Partial Unique Index: At most one ACTIVE listing per player
CREATE UNIQUE INDEX uq_active_listing_per_player 
    ON public.league_transfer_listings (league_player_id) 
    WHERE (status = 'ACTIVE');

-- Indexes
CREATE INDEX idx_transfer_listings_league_status ON public.league_transfer_listings(league_id, status);
CREATE INDEX idx_transfer_listings_seller_status ON public.league_transfer_listings(seller_club_id, status);
CREATE INDEX idx_transfer_listings_buyer_status ON public.league_transfer_listings(buyer_club_id, status);
CREATE INDEX idx_transfer_listings_bot_eligible ON public.league_transfer_listings(status, bot_eligible_at);

CREATE TRIGGER trg_league_transfer_listings_updated_at
    BEFORE UPDATE ON public.league_transfer_listings
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


-- 3. RPC: create_player_transfer_listing
CREATE OR REPLACE FUNCTION public.create_player_transfer_listing(
    p_league_player_id UUID,
    p_asking_price_eur NUMERIC,
    p_user_id UUID
)
RETURNS JSONB AS $$
DECLARE
    v_player RECORD;
    v_seller_club RECORD;
    v_active_count INT;
    v_seller_squad_count INT;
    v_position_code public.enum_player_position;
    v_new_listing_id UUID;
BEGIN
    -- 1. Validate asking price
    IF p_asking_price_eur IS NULL OR p_asking_price_eur <= 0 THEN
        RAISE EXCEPTION 'INVALID_ASKING_PRICE' USING ERRCODE = 'P0001';
    END IF;

    -- 2. Fetch league player record
    SELECT * INTO v_player
    FROM public.league_players
    WHERE id = p_league_player_id;

    IF v_player IS NULL THEN
        RAISE EXCEPTION 'PLAYER_NOT_FOUND' USING ERRCODE = 'P0001';
    END IF;

    -- 3. Fetch seller club record & verify ownership
    SELECT * INTO v_seller_club
    FROM public.league_clubs
    WHERE id = v_player.league_club_id;

    IF v_seller_club.human_manager_id IS NULL OR v_seller_club.human_manager_id <> p_user_id THEN
        RAISE EXCEPTION 'UNAUTHORIZED_SELLER' USING ERRCODE = 'P0001';
    END IF;

    -- 4. Check active listings count for seller club in this league (max 4)
    SELECT COUNT(*) INTO v_active_count
    FROM public.league_transfer_listings
    WHERE seller_club_id = v_seller_club.id AND status = 'ACTIVE';

    IF v_active_count >= 4 THEN
        RAISE EXCEPTION 'MAX_ACTIVE_LISTINGS_REACHED' USING ERRCODE = 'P0001';
    END IF;

    -- 5. Verify seller squad size (must remain >= 18 after selling)
    SELECT COUNT(*) INTO v_seller_squad_count
    FROM public.league_players
    WHERE league_club_id = v_seller_club.id;

    IF v_seller_squad_count < 19 THEN
        RAISE EXCEPTION 'SELLER_SQUAD_TOO_SMALL' USING ERRCODE = 'P0001';
    END IF;

    -- 6. Fetch primary position
    SELECT position_code INTO v_position_code
    FROM public.league_player_positions
    WHERE league_player_id = v_player.id AND is_primary = TRUE
    LIMIT 1;

    IF v_position_code IS NULL THEN
        SELECT primary_position INTO v_position_code
        FROM public.player_templates
        WHERE id = v_player.player_template_id;
    END IF;

    -- 7. Insert listing
    INSERT INTO public.league_transfer_listings (
        league_id,
        seller_club_id,
        league_player_id,
        player_name_snapshot,
        position_code,
        overall_rating,
        original_market_value_eur,
        asking_price_eur,
        status,
        listed_at,
        bot_eligible_at
    ) VALUES (
        v_player.league_id,
        v_seller_club.id,
        v_player.id,
        v_player.full_name,
        v_position_code,
        v_player.overall_rating,
        v_player.market_value_eur,
        p_asking_price_eur,
        'ACTIVE',
        NOW(),
        NOW() + INTERVAL '24 hours'
    ) RETURNING id INTO v_new_listing_id;

    RETURN jsonb_build_object(
        'success', TRUE,
        'listing_id', v_new_listing_id,
        'asking_price_eur', p_asking_price_eur
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;


-- 4. RPC: cancel_player_transfer_listing
CREATE OR REPLACE FUNCTION public.cancel_player_transfer_listing(
    p_listing_id UUID,
    p_user_id UUID
)
RETURNS JSONB AS $$
DECLARE
    v_listing RECORD;
    v_seller_club RECORD;
BEGIN
    SELECT * INTO v_listing
    FROM public.league_transfer_listings
    WHERE id = p_listing_id FOR UPDATE;

    IF v_listing IS NULL THEN
        RAISE EXCEPTION 'LISTING_NOT_FOUND' USING ERRCODE = 'P0001';
    END IF;

    IF v_listing.status <> 'ACTIVE' THEN
        RAISE EXCEPTION 'LISTING_NOT_ACTIVE' USING ERRCODE = 'P0001';
    END IF;

    SELECT * INTO v_seller_club
    FROM public.league_clubs
    WHERE id = v_listing.seller_club_id;

    IF v_seller_club.human_manager_id IS NULL OR v_seller_club.human_manager_id <> p_user_id THEN
        RAISE EXCEPTION 'UNAUTHORIZED_CANCEL' USING ERRCODE = 'P0001';
    END IF;

    UPDATE public.league_transfer_listings
    SET status = 'CANCELLED',
        cancelled_at = NOW()
    WHERE id = p_listing_id;

    RETURN jsonb_build_object(
        'success', TRUE,
        'message', 'Listing cancelled successfully'
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;


-- 5. RPC: purchase_player_transfer_listing
CREATE OR REPLACE FUNCTION public.purchase_player_transfer_listing(
    p_listing_id UUID,
    p_buyer_club_id UUID,
    p_user_id UUID
)
RETURNS JSONB AS $$
DECLARE
    v_listing RECORD;
    v_buyer_club RECORD;
    v_seller_club RECORD;
    v_buyer_finance RECORD;
    v_seller_finance RECORD;
    v_buyer_squad_count INT;
    v_seller_squad_count INT;
    v_idempotency_buyer VARCHAR(100);
    v_idempotency_seller VARCHAR(100);
BEGIN
    -- 1. Lock listing record FOR UPDATE
    SELECT * INTO v_listing
    FROM public.league_transfer_listings
    WHERE id = p_listing_id FOR UPDATE;

    IF v_listing IS NULL THEN
        RAISE EXCEPTION 'LISTING_NOT_FOUND' USING ERRCODE = 'P0001';
    END IF;

    IF v_listing.status <> 'ACTIVE' THEN
        RAISE EXCEPTION 'LISTING_NOT_ACTIVE' USING ERRCODE = 'P0001';
    END IF;

    -- 2. Verify seller is different from buyer
    IF v_listing.seller_club_id = p_buyer_club_id THEN
        RAISE EXCEPTION 'CANNOT_BUY_OWN_PLAYER' USING ERRCODE = 'P0001';
    END IF;

    -- 3. Lock and verify buyer club & ownership
    SELECT * INTO v_buyer_club
    FROM public.league_clubs
    WHERE id = p_buyer_club_id;

    IF v_buyer_club IS NULL OR v_buyer_club.league_id <> v_listing.league_id THEN
        RAISE EXCEPTION 'INVALID_BUYER_CLUB' USING ERRCODE = 'P0001';
    END IF;

    IF v_buyer_club.human_manager_id IS NULL OR v_buyer_club.human_manager_id <> p_user_id THEN
        RAISE EXCEPTION 'UNAUTHORIZED_BUYER' USING ERRCODE = 'P0001';
    END IF;

    -- 4. Verify seller squad count (must not fall below 18)
    SELECT COUNT(*) INTO v_seller_squad_count
    FROM public.league_players
    WHERE league_club_id = v_listing.seller_club_id;

    IF v_seller_squad_count < 19 THEN
        RAISE EXCEPTION 'SELLER_SQUAD_TOO_SMALL' USING ERRCODE = 'P0001';
    END IF;

    -- 5. Verify buyer squad count (must not exceed 30)
    SELECT COUNT(*) INTO v_buyer_squad_count
    FROM public.league_players
    WHERE league_club_id = p_buyer_club_id;

    IF v_buyer_squad_count >= 30 THEN
        RAISE EXCEPTION 'BUYER_SQUAD_FULL' USING ERRCODE = 'P0001';
    END IF;

    -- 6. Lock finances FOR UPDATE
    SELECT * INTO v_buyer_finance
    FROM public.club_finances
    WHERE league_club_id = p_buyer_club_id FOR UPDATE;

    SELECT * INTO v_seller_finance
    FROM public.club_finances
    WHERE league_club_id = v_listing.seller_club_id FOR UPDATE;

    IF v_buyer_finance.total_balance < v_listing.asking_price_eur THEN
        RAISE EXCEPTION 'INSUFFICIENT_FUNDS' USING ERRCODE = 'P0001';
    END IF;

    -- 7. Deduct from buyer, credit seller
    UPDATE public.club_finances
    SET total_balance = total_balance - v_listing.asking_price_eur
    WHERE league_club_id = p_buyer_club_id;

    UPDATE public.club_finances
    SET total_balance = total_balance + v_listing.asking_price_eur
    WHERE league_club_id = v_listing.seller_club_id;

    -- 8. Transfer player ownership
    UPDATE public.league_players
    SET league_club_id = p_buyer_club_id
    WHERE id = v_listing.league_player_id;

    -- 9. Update listing status to SOLD
    UPDATE public.league_transfer_listings
    SET status = 'SOLD',
        buyer_club_id = p_buyer_club_id,
        buyer_type = 'HUMAN',
        completed_at = NOW()
    WHERE id = p_listing_id;

    -- 10. Financial ledger entries
    v_idempotency_buyer := 'tr-buy-' || p_listing_id::text;
    v_idempotency_seller := 'tr-sell-' || p_listing_id::text;

    INSERT INTO public.financial_ledger (
        league_id,
        league_club_id,
        transaction_type,
        amount_eur,
        balance_before,
        balance_after,
        reserved_before,
        reserved_after,
        idempotency_key,
        description
    ) VALUES (
        v_listing.league_id,
        p_buyer_club_id,
        'TRANSFER_PURCHASE',
        -v_listing.asking_price_eur,
        v_buyer_finance.total_balance,
        v_buyer_finance.total_balance - v_listing.asking_price_eur,
        v_buyer_finance.reserved_balance,
        v_buyer_finance.reserved_balance,
        v_idempotency_buyer,
        'Human transfer purchase: ' || v_listing.player_name_snapshot
    );

    INSERT INTO public.financial_ledger (
        league_id,
        league_club_id,
        transaction_type,
        amount_eur,
        balance_before,
        balance_after,
        reserved_before,
        reserved_after,
        idempotency_key,
        description
    ) VALUES (
        v_listing.league_id,
        v_listing.seller_club_id,
        'TRANSFER_SALE',
        v_listing.asking_price_eur,
        v_seller_finance.total_balance,
        v_seller_finance.total_balance + v_listing.asking_price_eur,
        v_seller_finance.reserved_balance,
        v_seller_finance.reserved_balance,
        v_idempotency_seller,
        'Human transfer sale: ' || v_listing.player_name_snapshot
    );

    RETURN jsonb_build_object(
        'success', TRUE,
        'price_eur', v_listing.asking_price_eur,
        'remaining_budget', v_buyer_finance.total_balance - v_listing.asking_price_eur
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;


-- 6. RPC: process_bot_transfer_reviews
CREATE OR REPLACE FUNCTION public.process_bot_transfer_reviews(
    p_batch_limit INT DEFAULT 20
)
RETURNS JSONB AS $$
DECLARE
    v_listing RECORD;
    v_ratio NUMERIC;
    v_chance FLOAT;
    v_roll FLOAT;
    v_bot_club RECORD;
    v_seller_squad_count INT;
    v_seller_finance RECORD;
    v_bot_finance RECORD;
    v_idempotency_buyer VARCHAR(100);
    v_idempotency_seller VARCHAR(100);
    v_processed_count INT := 0;
    v_purchased_count INT := 0;
BEGIN
    FOR v_listing IN
        SELECT l.*, p.player_template_id
        FROM public.league_transfer_listings l
        JOIN public.league_players p ON l.league_player_id = p.id
        WHERE l.status = 'ACTIVE'
          AND l.bot_eligible_at <= NOW()
          AND l.overall_rating <= 82
          AND l.asking_price_eur <= (l.original_market_value_eur * 1.20)
        ORDER BY l.bot_eligible_at ASC
        LIMIT p_batch_limit
    LOOP
        v_processed_count := v_processed_count + 1;

        -- 1. Check seller squad size (must remain >= 18)
        SELECT COUNT(*) INTO v_seller_squad_count
        FROM public.league_players
        WHERE league_club_id = v_listing.seller_club_id;

        IF v_seller_squad_count < 19 THEN
            CONTINUE;
        END IF;

        -- 2. Calculate probability
        v_ratio := v_listing.asking_price_eur / GREATEST(v_listing.original_market_value_eur, 1.0);
        IF v_ratio <= 1.00 THEN
            v_chance := 0.70;
        ELSIF v_ratio <= 1.10 THEN
            v_chance := 0.45;
        ELSE
            v_chance := 0.25;
        END IF;

        v_roll := random();
        IF v_roll > v_chance THEN
            CONTINUE;
        END IF;

        -- 3. Find candidate bot club in this league
        SELECT lc.* INTO v_bot_club
        FROM public.league_clubs lc
        JOIN public.club_finances cf ON lc.id = cf.league_club_id
        WHERE lc.league_id = v_listing.league_id
          AND lc.human_manager_id IS NULL
          AND lc.id <> v_listing.seller_club_id
          AND cf.total_balance >= v_listing.asking_price_eur
          AND NOT EXISTS (
              SELECT 1 FROM public.league_players lp
              WHERE lp.league_club_id = lc.id AND lp.player_template_id = v_listing.player_template_id
          )
          AND (
              SELECT COUNT(*) FROM public.league_players lp WHERE lp.league_club_id = lc.id
          ) < 30
        ORDER BY
          (
            SELECT COUNT(*) FROM public.league_players lp
            JOIN public.league_player_positions lpp ON lp.id = lpp.league_player_id
            WHERE lp.league_club_id = lc.id AND lpp.position_code = v_listing.position_code AND lpp.is_primary = TRUE
          ) ASC,
          random()
        LIMIT 1;

        IF v_bot_club IS NULL THEN
            CONTINUE;
        END IF;

        -- 4. Lock & Execute bot purchase
        SELECT * INTO v_seller_finance
        FROM public.club_finances
        WHERE league_club_id = v_listing.seller_club_id FOR UPDATE;

        SELECT * INTO v_bot_finance
        FROM public.club_finances
        WHERE league_club_id = v_bot_club.id FOR UPDATE;

        IF v_bot_finance.total_balance < v_listing.asking_price_eur THEN
            CONTINUE;
        END IF;

        UPDATE public.club_finances
        SET total_balance = total_balance - v_listing.asking_price_eur
        WHERE league_club_id = v_bot_club.id;

        UPDATE public.club_finances
        SET total_balance = total_balance + v_listing.asking_price_eur
        WHERE league_club_id = v_listing.seller_club_id;

        UPDATE public.league_players
        SET league_club_id = v_bot_club.id
        WHERE id = v_listing.league_player_id;

        UPDATE public.league_transfer_listings
        SET status = 'SOLD',
            buyer_club_id = v_bot_club.id,
            buyer_type = 'BOT',
            completed_at = NOW()
        WHERE id = v_listing.id;

        v_idempotency_buyer := 'bot-buy-' || v_listing.id::text;
        v_idempotency_seller := 'bot-sell-' || v_listing.id::text;

        INSERT INTO public.financial_ledger (
            league_id,
            league_club_id,
            transaction_type,
            amount_eur,
            balance_before,
            balance_after,
            reserved_before,
            reserved_after,
            idempotency_key,
            description
        ) VALUES (
            v_listing.league_id,
            v_bot_club.id,
            'TRANSFER_PURCHASE',
            -v_listing.asking_price_eur,
            v_bot_finance.total_balance,
            v_bot_finance.total_balance - v_listing.asking_price_eur,
            v_bot_finance.reserved_balance,
            v_bot_finance.reserved_balance,
            v_idempotency_buyer,
            'Bot transfer purchase: ' || v_listing.player_name_snapshot
        );

        INSERT INTO public.financial_ledger (
            league_id,
            league_club_id,
            transaction_type,
            amount_eur,
            balance_before,
            balance_after,
            reserved_before,
            reserved_after,
            idempotency_key,
            description
        ) VALUES (
            v_listing.league_id,
            v_listing.seller_club_id,
            'TRANSFER_SALE',
            v_listing.asking_price_eur,
            v_seller_finance.total_balance,
            v_seller_finance.total_balance + v_listing.asking_price_eur,
            v_seller_finance.reserved_balance,
            v_seller_finance.reserved_balance,
            v_idempotency_seller,
            'Bot transfer sale: ' || v_listing.player_name_snapshot
        );

        v_purchased_count := v_purchased_count + 1;
    END LOOP;

    RETURN jsonb_build_object(
        'success', TRUE,
        'processed_count', v_processed_count,
        'purchased_count', v_purchased_count
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;


-- 7. Permissions & Grants
REVOKE ALL ON FUNCTION public.create_player_transfer_listing(UUID, NUMERIC, UUID) FROM anon, authenticated;
REVOKE ALL ON FUNCTION public.cancel_player_transfer_listing(UUID, UUID) FROM anon, authenticated;
REVOKE ALL ON FUNCTION public.purchase_player_transfer_listing(UUID, UUID, UUID) FROM anon, authenticated;
REVOKE ALL ON FUNCTION public.process_bot_transfer_reviews(INT) FROM anon, authenticated;

GRANT EXECUTE ON FUNCTION public.create_player_transfer_listing(UUID, NUMERIC, UUID) TO service_role;
GRANT EXECUTE ON FUNCTION public.cancel_player_transfer_listing(UUID, UUID) TO service_role;
GRANT EXECUTE ON FUNCTION public.purchase_player_transfer_listing(UUID, UUID, UUID) TO service_role;
GRANT EXECUTE ON FUNCTION public.process_bot_transfer_reviews(INT) TO service_role;
