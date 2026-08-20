-- SQL Migration: Phase 4G - Transfer Budget Purchase Packages, Admin Workflow, 3-Round Daily Limit & Solo League Deletion
-- Enforces legend price range (€100m-€500m), creates purchase package tables, atomic approval RPC, daily 3-round limit check (Asia/Tashkent), and solo league deletion RPC.

-- 1. Legend Templates Price Range Constraint Update (€100m - €500m)
ALTER TABLE public.legend_templates 
    DROP CONSTRAINT IF EXISTS legend_templates_default_price_eur_check,
    DROP CONSTRAINT IF EXISTS chk_legend_default_price_eur;

ALTER TABLE public.legend_templates
    ADD CONSTRAINT chk_legend_default_price_eur CHECK (default_price_eur BETWEEN 100000000 AND 500000000);


-- 2. Table: transfer_budget_packages (Configurable Source of Truth)
CREATE TABLE public.transfer_budget_packages (
    id VARCHAR(50) PRIMARY KEY,
    slug VARCHAR(50) NOT NULL UNIQUE CHECK (slug ~ '^[a-z0-9-]+$' AND slug = lower(slug)),
    display_name VARCHAR(100) NOT NULL CHECK (char_length(trim(display_name)) > 0),
    eur_amount BIGINT NOT NULL CHECK (eur_amount > 0),
    uzs_price BIGINT NOT NULL CHECK (uzs_price > 0),
    sort_order INT NOT NULL DEFAULT 1 CHECK (sort_order >= 1),
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_transfer_budget_packages_active ON public.transfer_budget_packages(is_active, sort_order);

CREATE TRIGGER trg_transfer_budget_packages_updated_at
    BEFORE UPDATE ON public.transfer_budget_packages
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- Insert 5 default packages
INSERT INTO public.transfer_budget_packages (id, slug, display_name, eur_amount, uzs_price, sort_order, is_active)
VALUES
    ('pkg_10m',  'pkg-10m',  '€10 million',  10000000,  5000,   1, TRUE),
    ('pkg_50m',  'pkg-50m',  '€50 million',  50000000,  20000,  2, TRUE),
    ('pkg_100m', 'pkg-100m', '€100 million', 100000000, 35000,  3, TRUE),
    ('pkg_250m', 'pkg-250m', '€250 million', 250000000, 75000,  4, TRUE),
    ('pkg_500m', 'pkg-500m', '€500 million', 500000000, 125000, 5, TRUE)
ON CONFLICT (id) DO UPDATE SET
    display_name = EXCLUDED.display_name,
    eur_amount = EXCLUDED.eur_amount,
    uzs_price = EXCLUDED.uzs_price,
    sort_order = EXCLUDED.sort_order;


-- 3. Status Enum & Table: transfer_budget_purchase_requests
CREATE TYPE public.enum_purchase_request_status AS ENUM (
    'PENDING',
    'APPROVED',
    'REJECTED',
    'CANCELLED'
);

CREATE TABLE public.transfer_budget_purchase_requests (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_code VARCHAR(30) NOT NULL UNIQUE CHECK (order_code ~ '^[A-Z0-9-]{6,30}$'),
    telegram_user_id BIGINT NOT NULL,
    user_id UUID NULL REFERENCES auth.users(id) ON DELETE SET NULL,
    league_id UUID NOT NULL REFERENCES public.leagues(id) ON DELETE CASCADE,
    league_club_id UUID NOT NULL REFERENCES public.league_clubs(id) ON DELETE CASCADE,
    package_id VARCHAR(50) NOT NULL REFERENCES public.transfer_budget_packages(id) ON DELETE RESTRICT,
    requested_eur_amount BIGINT NOT NULL CHECK (requested_eur_amount > 0),
    uzs_price BIGINT NOT NULL CHECK (uzs_price > 0),
    status public.enum_purchase_request_status NOT NULL DEFAULT 'PENDING',
    admin_note TEXT NULL,
    approved_by_admin_id UUID NULL REFERENCES public.admin_users(id) ON DELETE SET NULL,
    approved_at TIMESTAMPTZ NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_tbp_requests_order_code ON public.transfer_budget_purchase_requests(order_code);
CREATE INDEX idx_tbp_requests_telegram_user ON public.transfer_budget_purchase_requests(telegram_user_id);
CREATE INDEX idx_tbp_requests_league_club ON public.transfer_budget_purchase_requests(league_club_id);
CREATE INDEX idx_tbp_requests_status ON public.transfer_budget_purchase_requests(status);

CREATE TRIGGER trg_tbp_requests_updated_at
    BEFORE UPDATE ON public.transfer_budget_purchase_requests
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


-- 4. RPC Function: Create Purchase Request
CREATE OR REPLACE FUNCTION public.create_transfer_budget_purchase_request(
    p_league_id UUID,
    p_league_club_id UUID,
    p_package_id VARCHAR,
    p_telegram_user_id BIGINT
)
RETURNS JSONB AS $$
DECLARE
    v_pkg RECORD;
    v_club RECORD;
    v_order_code VARCHAR(30);
    v_request_id UUID;
    v_user_id UUID;
BEGIN
    -- Validate package
    SELECT * INTO v_pkg FROM public.transfer_budget_packages WHERE id = p_package_id AND is_active = TRUE;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'PACKAGE_NOT_FOUND' USING ERRCODE = 'P0001';
    END IF;

    -- Validate club belongs to league
    SELECT * INTO v_club FROM public.league_clubs WHERE id = p_league_club_id AND league_id = p_league_id;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'CLUB_LEAGUE_MISMATCH' USING ERRCODE = 'P0001';
    END IF;

    -- Set v_user_id to NULL (telegram_user_id is primary)
    v_user_id := NULL;

    -- Generate human-readable order code (e.g. TBP-8F3K9A)
    v_order_code := 'TBP-' || upper(substring(md5(random()::text || clock_timestamp()::text) from 1 for 8));

    INSERT INTO public.transfer_budget_purchase_requests (
        order_code,
        telegram_user_id,
        user_id,
        league_id,
        league_club_id,
        package_id,
        requested_eur_amount,
        uzs_price,
        status
    ) VALUES (
        v_order_code,
        p_telegram_user_id,
        v_user_id,
        p_league_id,
        p_league_club_id,
        v_pkg.id,
        v_pkg.eur_amount,
        v_pkg.uzs_price,
        'PENDING'
    ) RETURNING id INTO v_request_id;

    RETURN jsonb_build_object(
        'success', true,
        'request_id', v_request_id,
        'order_code', v_order_code,
        'requested_eur_amount', v_pkg.eur_amount,
        'uzs_price', v_pkg.uzs_price
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;


-- 5. RPC Function: Approve Purchase Request (Atomic & Idempotent)
CREATE OR REPLACE FUNCTION public.approve_transfer_budget_purchase_request(
    p_request_id UUID,
    p_admin_id UUID,
    p_admin_note TEXT DEFAULT NULL
)
RETURNS JSONB AS $$
DECLARE
    v_req RECORD;
    v_finance RECORD;
    v_ledger_id UUID;
BEGIN
    -- Lock purchase request row FOR UPDATE
    SELECT * INTO v_req
    FROM public.transfer_budget_purchase_requests
    WHERE id = p_request_id
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'PURCHASE_REQUEST_NOT_FOUND' USING ERRCODE = 'P0001';
    END IF;

    IF v_req.status <> 'PENDING' THEN
        RAISE EXCEPTION 'REQUEST_ALREADY_PROCESSED' USING ERRCODE = 'P0001';
    END IF;

    -- Lock club finances FOR UPDATE
    SELECT * INTO v_finance
    FROM public.club_finances
    WHERE league_club_id = v_req.league_club_id
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'CLUB_FINANCES_NOT_FOUND' USING ERRCODE = 'P0001';
    END IF;

    -- 1. Increase total balance
    UPDATE public.club_finances
    SET total_balance = total_balance + v_req.requested_eur_amount,
        updated_at = NOW()
    WHERE league_club_id = v_req.league_club_id;

    -- 2. Insert financial ledger entry (TRANSFER_PURCHASE)
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
        v_finance.league_id,
        v_req.league_club_id,
        'TRANSFER_PURCHASE',
        v_req.requested_eur_amount,
        v_finance.total_balance,
        v_finance.total_balance + v_req.requested_eur_amount,
        v_finance.reserved_balance,
        v_finance.reserved_balance,
        'PKG_APPROVE_' || p_request_id::text,
        'Transfer Budget Purchase [' || v_req.order_code || ']: +' || v_req.requested_eur_amount::text || ' EUR (' || v_req.uzs_price::text || ' UZS)'
    ) RETURNING id INTO v_ledger_id;

    -- 3. Update request status to APPROVED
    UPDATE public.transfer_budget_purchase_requests
    SET status = 'APPROVED',
        approved_by_admin_id = p_admin_id,
        approved_at = NOW(),
        admin_note = p_admin_note,
        updated_at = NOW()
    WHERE id = p_request_id;

    RETURN jsonb_build_object(
        'success', true,
        'request_id', p_request_id,
        'order_code', v_req.order_code,
        'added_eur_amount', v_req.requested_eur_amount,
        'new_balance', v_finance.total_balance + v_req.requested_eur_amount,
        'ledger_id', v_ledger_id
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;


-- 6. RPC Function: Reject Purchase Request
CREATE OR REPLACE FUNCTION public.reject_transfer_budget_purchase_request(
    p_request_id UUID,
    p_admin_id UUID,
    p_admin_note TEXT DEFAULT NULL
)
RETURNS JSONB AS $$
DECLARE
    v_req RECORD;
BEGIN
    SELECT * INTO v_req
    FROM public.transfer_budget_purchase_requests
    WHERE id = p_request_id
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'PURCHASE_REQUEST_NOT_FOUND' USING ERRCODE = 'P0001';
    END IF;

    IF v_req.status <> 'PENDING' THEN
        RAISE EXCEPTION 'REQUEST_ALREADY_PROCESSED' USING ERRCODE = 'P0001';
    END IF;

    UPDATE public.transfer_budget_purchase_requests
    SET status = 'REJECTED',
        approved_by_admin_id = p_admin_id,
        approved_at = NOW(),
        admin_note = p_admin_note,
        updated_at = NOW()
    WHERE id = p_request_id;

    RETURN jsonb_build_object(
        'success', true,
        'request_id', p_request_id,
        'status', 'REJECTED'
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;


-- 7. RPC Function: Delete Solo League
CREATE OR REPLACE FUNCTION public.delete_solo_league(
    p_league_id UUID,
    p_user_id UUID
)
RETURNS JSONB AS $$
DECLARE
    v_league RECORD;
    v_human_count INT;
    v_effective_user_id UUID;
    v_requesting_manager_id UUID;
BEGIN
    v_effective_user_id := COALESCE(auth.uid(), p_user_id);
    IF v_effective_user_id IS NULL THEN
        RAISE EXCEPTION 'UNAUTHENTICATED' USING ERRCODE = 'P0001';
    END IF;

    SELECT * INTO v_league FROM public.leagues WHERE id = p_league_id FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'LEAGUE_NOT_FOUND' USING ERRCODE = 'P0001';
    END IF;

    -- Resolve manager ID for effective user identity if applicable
    SELECT id INTO v_requesting_manager_id
    FROM public.managers
    WHERE id = v_effective_user_id;

    IF v_requesting_manager_id IS NULL THEN
        v_requesting_manager_id := v_effective_user_id;
    END IF;

    -- Verify requesting user is the league owner
    IF v_league.owner_manager_id <> v_requesting_manager_id THEN
        RAISE EXCEPTION 'UNAUTHORIZED_LEAGUE_OWNER' USING ERRCODE = 'P0001';
    END IF;

    -- Verify human count is EXACTLY 1 (the owner)
    SELECT COUNT(DISTINCT human_manager_id) INTO v_human_count
    FROM public.league_clubs
    WHERE league_id = p_league_id AND human_manager_id IS NOT NULL;

    IF v_human_count > 1 THEN
        RAISE EXCEPTION 'CANNOT_DELETE_MULTI_PLAYER_LEAGUE' USING ERRCODE = 'P0001';
    END IF;

    -- Delete league record (ON DELETE CASCADE removes all related records)
    DELETE FROM public.leagues WHERE id = p_league_id;

    RETURN jsonb_build_object(
        'success', true,
        'deleted_league_id', p_league_id,
        'message', 'Solo league deleted successfully.'
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;


-- 8. Daily Round Limit (3 Rounds / Calendar Day in Asia/Tashkent)
ALTER TABLE public.league_settings
    DROP CONSTRAINT IF EXISTS chk_league_settings_round_speed;

ALTER TABLE public.league_settings
    ADD CONSTRAINT chk_league_settings_round_speed CHECK (round_speed BETWEEN 1 AND 3);

CREATE OR REPLACE FUNCTION public.check_daily_round_limit(p_league_id UUID)
RETURNS BOOLEAN AS $$
DECLARE
    v_completed_today INT;
BEGIN
    SELECT COUNT(*) INTO v_completed_today
    FROM public.league_rounds
    WHERE league_id = p_league_id
      AND status = 'COMPLETED'
      AND date_trunc('day', completed_at AT TIME ZONE 'Asia/Tashkent') = date_trunc('day', NOW() AT TIME ZONE 'Asia/Tashkent');

    IF v_completed_today >= 3 THEN
        RAISE EXCEPTION 'DAILY_ROUND_LIMIT_REACHED'
            USING MESSAGE = 'Kunlik 3 ta o''yin turi limiti bajarildi. Keyingi tur ertaga 00:00 (Toshkent vaqti) dan so''ng mavjud bo''ladi.',
                  ERRCODE = 'P0001';
    END IF;

    RETURN TRUE;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;


-- 9. Row Level Security Policies
ALTER TABLE public.transfer_budget_packages ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.transfer_budget_purchase_requests ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Transfer budget packages readable by authenticated users"
    ON public.transfer_budget_packages FOR SELECT
    TO authenticated
    USING (is_active = TRUE);

CREATE POLICY "Users can read own purchase requests"
    ON public.transfer_budget_purchase_requests FOR SELECT
    TO authenticated
    USING (user_id = auth.uid());
