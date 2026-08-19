-- SQL Migration: Phase 4F - Squad Limit Expansion (18-30) and Legend Transfers Foundation
-- Updates instantiate_league_players function to allow squad sizes up to 30 players per club.
-- Creates global legend_templates, per-league legend_market, transactional purchase RPC, and RLS policies.

-- 0. Expand enum_player_position with LWB, RWB, CF
ALTER TYPE public.enum_player_position ADD VALUE IF NOT EXISTS 'LWB';
ALTER TYPE public.enum_player_position ADD VALUE IF NOT EXISTS 'RWB';
ALTER TYPE public.enum_player_position ADD VALUE IF NOT EXISTS 'CF';

-- 1. Update instantiate_league_players for 18-30 squad size limit
CREATE OR REPLACE FUNCTION public.instantiate_league_players(p_league_id UUID)
RETURNS INT AS $$
DECLARE
    v_existing_count INT;
    v_active_template_count INT;
    v_club RECORD;
    v_club_player_count INT;
    v_club_gk_count INT;
    v_inserted_count INT := 0;
    v_player_rec RECORD;
    v_new_league_player_id UUID;
BEGIN
    -- Check if players already instantiated for this league
    SELECT COUNT(*) INTO v_existing_count
    FROM public.league_players lp
    JOIN public.league_clubs lc ON lp.league_club_id = lc.id
    WHERE lc.league_id = p_league_id;

    IF v_existing_count > 0 THEN
        RETURN v_existing_count;
    END IF;

    -- Check if global player_templates has active records
    SELECT COUNT(*) INTO v_active_template_count
    FROM public.player_templates
    WHERE is_active = TRUE;

    IF v_active_template_count = 0 THEN
        RAISE EXCEPTION 'PLAYER_TEMPLATES_EMPTY' USING ERRCODE = 'P0001';
    END IF;

    -- Iterate through each league club in the league
    FOR v_club IN 
        SELECT lc.id AS league_club_id, lc.club_template_id
        FROM public.league_clubs lc
        WHERE lc.league_id = p_league_id
    LOOP
        -- Check per-club template player count (must be between 18 and 30)
        SELECT COUNT(*) INTO v_club_player_count
        FROM public.player_templates pt
        WHERE pt.current_club_template_id = v_club.club_template_id AND pt.is_active = TRUE;

        IF v_club_player_count < 18 OR v_club_player_count > 30 THEN
            RAISE EXCEPTION 'INVALID_SQUAD_SIZE' USING ERRCODE = 'P0001';
        END IF;

        -- Check goalkeeper count (must be >= 2)
        SELECT COUNT(*) INTO v_club_gk_count
        FROM public.player_templates pt
        JOIN public.player_template_positions ptp ON pt.id = ptp.player_template_id
        WHERE pt.current_club_template_id = v_club.club_template_id 
          AND pt.is_active = TRUE 
          AND ptp.position_code = 'GK';

        IF v_club_gk_count < 2 THEN
            RAISE EXCEPTION 'INSUFFICIENT_GOALKEEPERS' USING ERRCODE = 'P0001';
        END IF;

        -- Copy players for this club
        FOR v_player_rec IN
            SELECT 
                pt.id AS player_template_id,
                pt.full_name,
                pt.date_of_birth,
                pt.nationality,
                ptv.id AS player_template_version_id,
                ptv.market_value_eur,
                ptv.overall_rating,
                ptv.outfield_attributes,
                ptv.goalkeeper_attributes
            FROM public.player_templates pt
            JOIN public.player_template_versions ptv ON pt.id = ptv.player_template_id AND ptv.is_current = TRUE
            WHERE pt.current_club_template_id = v_club.club_template_id AND pt.is_active = TRUE
        LOOP
            INSERT INTO public.league_players (
                league_club_id,
                player_template_id,
                player_template_version_id,
                full_name,
                date_of_birth,
                nationality,
                market_value_eur,
                overall_rating,
                outfield_attributes,
                goalkeeper_attributes,
                is_loan,
                availability_status
            ) VALUES (
                v_club.league_club_id,
                v_player_rec.player_template_id,
                v_player_rec.player_template_version_id,
                v_player_rec.full_name,
                v_player_rec.date_of_birth,
                v_player_rec.nationality,
                v_player_rec.market_value_eur,
                v_player_rec.overall_rating,
                v_player_rec.outfield_attributes,
                v_player_rec.goalkeeper_attributes,
                FALSE,
                'AVAILABLE'
            ) RETURNING id INTO v_new_league_player_id;

            -- Copy player position mappings
            INSERT INTO public.league_player_positions (league_player_id, position_code, is_primary)
            SELECT v_new_league_player_id, position_code, is_primary
            FROM public.player_template_positions
            WHERE player_template_id = v_player_rec.player_template_id;

            v_inserted_count := v_inserted_count + 1;
        END LOOP;
    END LOOP;

    RETURN v_inserted_count;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;


-- 2. Legend Market Status Enum Type
CREATE TYPE public.enum_legend_market_status AS ENUM (
    'AVAILABLE',
    'OWNED',
    'LOCKED',
    'SOLD'
);


-- 3. Table: legend_templates (Global Dictionary of Legendary Players)
CREATE TABLE public.legend_templates (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    slug VARCHAR(50) NOT NULL UNIQUE CHECK (slug ~ '^[a-z0-9-]+$' AND slug = lower(slug)),
    canonical_key VARCHAR(100) NOT NULL UNIQUE CHECK (canonical_key ~ '^[a-z0-9-]+$' AND canonical_key = lower(canonical_key)),
    full_name VARCHAR(100) NOT NULL CHECK (char_length(trim(full_name)) > 0),
    nationality VARCHAR(100) NOT NULL CHECK (char_length(trim(nationality)) > 0),
    date_of_birth DATE NOT NULL,
    primary_position public.enum_player_position NOT NULL,
    secondary_positions public.enum_player_position[] NOT NULL DEFAULT '{}',
    peak_club VARCHAR(100) NOT NULL CHECK (char_length(trim(peak_club)) > 0),
    peak_period VARCHAR(50) NOT NULL CHECK (char_length(trim(peak_period)) > 0),
    overall_rating INT NOT NULL CHECK (overall_rating BETWEEN 1 AND 99),
    default_price_eur NUMERIC(15, 2) NOT NULL DEFAULT 0.00 CHECK (default_price_eur >= 0),
    is_retired BOOLEAN NOT NULL DEFAULT TRUE,
    source_id VARCHAR(50) NOT NULL,
    rating_methodology TEXT NULL,
    historical_stats JSONB NULL,
    outfield_attributes JSONB NULL,
    goalkeeper_attributes JSONB NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT check_legend_attributes_by_position CHECK (
        (primary_position = 'GK' AND goalkeeper_attributes IS NOT NULL AND outfield_attributes IS NULL)
        OR
        (primary_position <> 'GK' AND outfield_attributes IS NOT NULL AND goalkeeper_attributes IS NULL)
    )
);

CREATE INDEX idx_legend_templates_slug ON public.legend_templates(slug);
CREATE INDEX idx_legend_templates_canonical_key ON public.legend_templates(canonical_key);
CREATE INDEX idx_legend_templates_primary_position ON public.legend_templates(primary_position);
CREATE INDEX idx_legend_templates_is_active ON public.legend_templates(is_active);

CREATE TRIGGER trg_legend_templates_updated_at
    BEFORE UPDATE ON public.legend_templates
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


-- 4. Table: league_legend_market (Per-League Legend Transfer Market)
CREATE TABLE public.league_legend_market (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    league_id UUID NOT NULL REFERENCES public.leagues(id) ON DELETE CASCADE,
    legend_template_id UUID NOT NULL REFERENCES public.legend_templates(id) ON DELETE RESTRICT,
    status public.enum_legend_market_status NOT NULL DEFAULT 'AVAILABLE',
    price_eur NUMERIC(15, 2) NOT NULL DEFAULT 0.00 CHECK (price_eur >= 0),
    purchased_by_league_club_id UUID NULL REFERENCES public.league_clubs(id) ON DELETE SET NULL,
    purchased_at TIMESTAMPTZ NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT uq_league_legend_identity UNIQUE (league_id, legend_template_id),
    CONSTRAINT check_legend_ownership_status CHECK (
        (status = 'OWNED' AND purchased_by_league_club_id IS NOT NULL AND purchased_at IS NOT NULL)
        OR
        (status <> 'OWNED' AND purchased_by_league_club_id IS NULL)
    )
);

CREATE INDEX idx_league_legend_market_league_id ON public.league_legend_market(league_id);
CREATE INDEX idx_league_legend_market_legend_template_id ON public.league_legend_market(legend_template_id);
CREATE INDEX idx_league_legend_market_purchased_club ON public.league_legend_market(purchased_by_league_club_id);
CREATE INDEX idx_league_legend_market_status ON public.league_legend_market(league_id, status);

CREATE TRIGGER trg_league_legend_market_updated_at
    BEFORE UPDATE ON public.league_legend_market
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


-- 5. RPC Function: Instantiate Legend Market for a League
CREATE OR REPLACE FUNCTION public.instantiate_league_legend_market(p_league_id UUID)
RETURNS INT AS $$
DECLARE
    v_inserted_count INT := 0;
    v_legend RECORD;
BEGIN
    FOR v_legend IN
        SELECT lt.id, lt.default_price_eur
        FROM public.legend_templates lt
        WHERE lt.is_active = TRUE
    LOOP
        INSERT INTO public.league_legend_market (
            league_id,
            legend_template_id,
            status,
            price_eur
        ) VALUES (
            p_league_id,
            v_legend.id,
            'AVAILABLE',
            v_legend.default_price_eur
        ) ON CONFLICT (league_id, legend_template_id) DO NOTHING;

        IF FOUND THEN
            v_inserted_count := v_inserted_count + 1;
        END IF;
    END LOOP;

    RETURN v_inserted_count;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;


-- 6. RPC Function: Transactional Purchase Legend
CREATE OR REPLACE FUNCTION public.purchase_league_legend(
    p_league_legend_id UUID,
    p_league_club_id UUID,
    p_user_id UUID
)
RETURNS JSONB AS $$
DECLARE
    v_market_rec RECORD;
    v_club_rec RECORD;
    v_finance_rec RECORD;
    v_legend_template RECORD;
    v_transaction_id UUID;
BEGIN
    -- Lock and retrieve market record
    SELECT lm.*
    INTO v_market_rec
    FROM public.league_legend_market lm
    WHERE lm.id = p_league_legend_id
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'LEGEND_NOT_FOUND' USING ERRCODE = 'P0001';
    END IF;

    IF v_market_rec.status <> 'AVAILABLE' THEN
        RAISE EXCEPTION 'LEGEND_NOT_AVAILABLE' USING ERRCODE = 'P0001';
    END IF;

    -- Verify purchasing club belongs to the same league
    SELECT lc.*
    INTO v_club_rec
    FROM public.league_clubs lc
    WHERE lc.id = p_league_club_id AND lc.league_id = v_market_rec.league_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'CLUB_LEAGUE_MISMATCH' USING ERRCODE = 'P0001';
    END IF;

    -- Verify requesting user owns/manages the club
    IF v_club_rec.user_id <> p_user_id THEN
        RAISE EXCEPTION 'UNAUTHORIZED_MANAGER' USING ERRCODE = 'P0001';
    END IF;

    -- Lock and check club finances
    SELECT cf.*
    INTO v_finance_rec
    FROM public.club_finances cf
    WHERE cf.league_club_id = p_league_club_id
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'CLUB_FINANCES_NOT_FOUND' USING ERRCODE = 'P0001';
    END IF;

    IF v_finance_rec.total_balance < v_market_rec.price_eur THEN
        RAISE EXCEPTION 'INSUFFICIENT_FUNDS' USING ERRCODE = 'P0001';
    END IF;

    -- Get template details for ledger description
    SELECT lt.* INTO v_legend_template
    FROM public.legend_templates lt
    WHERE lt.id = v_market_rec.legend_template_id;

    -- 1. Deduct balance from club finances
    UPDATE public.club_finances
    SET total_balance = total_balance - v_market_rec.price_eur,
        updated_at = NOW()
    WHERE league_club_id = p_league_club_id;

    -- 2. Mark market record as OWNED
    UPDATE public.league_legend_market
    SET status = 'OWNED',
        purchased_by_league_club_id = p_league_club_id,
        purchased_at = NOW(),
        updated_at = NOW()
    WHERE id = p_league_legend_id;

    -- 3. Record in financial ledger
    INSERT INTO public.financial_ledger (
        league_club_id,
        transaction_type,
        amount,
        balance_after,
        description
    ) VALUES (
        p_league_club_id,
        'TRANSFER_PURCHASE',
        -v_market_rec.price_eur,
        v_finance_rec.total_balance - v_market_rec.price_eur,
        'Legend Purchase: ' || v_legend_template.full_name
    ) RETURNING id INTO v_transaction_id;

    RETURN jsonb_build_object(
        'success', true,
        'league_legend_id', p_league_legend_id,
        'league_club_id', p_league_club_id,
        'price_eur', v_market_rec.price_eur,
        'new_balance', v_finance_rec.total_balance - v_market_rec.price_eur,
        'transaction_id', v_transaction_id
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;


-- 7. Row Level Security Policies
ALTER TABLE public.legend_templates ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.league_legend_market ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Legend templates are readable by authenticated users"
    ON public.legend_templates FOR SELECT
    TO authenticated
    USING (is_active = TRUE);

CREATE POLICY "League legend market readable by authenticated users"
    ON public.league_legend_market FOR SELECT
    TO authenticated
    USING (
        EXISTS (
            SELECT 1 FROM public.leagues l
            WHERE l.id = league_legend_market.league_id
        )
    );
