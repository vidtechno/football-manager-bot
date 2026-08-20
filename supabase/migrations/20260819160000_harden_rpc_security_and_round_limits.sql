-- SQL Migration: Phase 4H - RPC Security Hardening, Grant Restrictions & Canonical Round Advancement Integration
-- Sets fixed search_path = public, restricts sensitive RPC execution to service_role, hardens admin and user identity checks, and integrates check_daily_round_limit into execute_league_round.

-- 1. Harden delete_solo_league Function
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
    -- Derive effective user identity
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

    -- Verify requesting user is the league creator/owner
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

    -- Delete league record (ON DELETE CASCADE removes all related gameplay records)
    DELETE FROM public.leagues WHERE id = p_league_id;

    RETURN jsonb_build_object(
        'success', true,
        'deleted_league_id', p_league_id,
        'message', 'Solo league deleted successfully.'
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;


-- 2. Harden approve_transfer_budget_purchase_request Admin Check
CREATE OR REPLACE FUNCTION public.approve_transfer_budget_purchase_request(
    p_request_id UUID,
    p_admin_id UUID,
    p_admin_note TEXT DEFAULT NULL
)
RETURNS JSONB AS $$
DECLARE
    v_admin RECORD;
    v_req RECORD;
    v_finance RECORD;
    v_ledger_id UUID;
BEGIN
    -- Verify approving admin exists and has valid role
    SELECT * INTO v_admin FROM public.admin_users WHERE id = p_admin_id AND role IN ('SUPER_ADMIN', 'SYSTEM_ADMIN');
    IF NOT FOUND THEN
        RAISE EXCEPTION 'UNAUTHORIZED_ADMIN' USING ERRCODE = 'P0001';
    END IF;

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


-- 3. Harden reject_transfer_budget_purchase_request Admin Check
CREATE OR REPLACE FUNCTION public.reject_transfer_budget_purchase_request(
    p_request_id UUID,
    p_admin_id UUID,
    p_admin_note TEXT DEFAULT NULL
)
RETURNS JSONB AS $$
DECLARE
    v_admin RECORD;
    v_req RECORD;
BEGIN
    SELECT * INTO v_admin FROM public.admin_users WHERE id = p_admin_id AND role IN ('SUPER_ADMIN', 'SYSTEM_ADMIN');
    IF NOT FOUND THEN
        RAISE EXCEPTION 'UNAUTHORIZED_ADMIN' USING ERRCODE = 'P0001';
    END IF;

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


-- 4. Canonical Round Advancement RPC (With Asia/Tashkent 3-Round Limit Check)
CREATE OR REPLACE FUNCTION public.execute_league_round(
    p_league_id UUID,
    p_round_number INT DEFAULT NULL
)
RETURNS JSONB AS $$
DECLARE
    v_league RECORD;
    v_target_round INT;
    v_round RECORD;
BEGIN
    -- 1. Lock league FOR UPDATE
    SELECT * INTO v_league FROM public.leagues WHERE id = p_league_id FOR UPDATE;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'LEAGUE_NOT_FOUND' USING ERRCODE = 'P0001';
    END IF;

    -- 2. FIRST: Check daily round limit (Asia/Tashkent calendar day)
    PERFORM public.check_daily_round_limit(p_league_id);

    -- 3. Determine target round number
    IF p_round_number IS NOT NULL THEN
        v_target_round := p_round_number;
    ELSE
        SELECT MIN(round_number) INTO v_target_round
        FROM public.league_rounds
        WHERE league_id = p_league_id AND status = 'SCHEDULED';
    END IF;

    IF v_target_round IS NULL THEN
        RAISE EXCEPTION 'NO_SCHEDULED_ROUNDS_REMAINING' USING ERRCODE = 'P0001';
    END IF;

    -- 4. Lock round record FOR UPDATE
    SELECT * INTO v_round
    FROM public.league_rounds
    WHERE league_id = p_league_id AND round_number = v_target_round
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'ROUND_NOT_FOUND' USING ERRCODE = 'P0001';
    END IF;

    IF v_round.status = 'COMPLETED' THEN
        RAISE EXCEPTION 'ROUND_ALREADY_COMPLETED' USING ERRCODE = 'P0001';
    END IF;

    -- 5. Mark round COMPLETED inside the transaction
    UPDATE public.league_rounds
    SET status = 'COMPLETED',
        started_at = COALESCE(started_at, NOW()),
        completed_at = NOW(),
        updated_at = NOW()
    WHERE league_id = p_league_id AND round_number = v_target_round;

    RETURN jsonb_build_object(
        'success', true,
        'league_id', p_league_id,
        'completed_round_number', v_target_round,
        'completed_at', NOW()
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;


-- 5. Restrict RPC Grants (Least-Privilege Security)
REVOKE ALL ON FUNCTION public.delete_solo_league(UUID, UUID) FROM anon, authenticated;
REVOKE ALL ON FUNCTION public.approve_transfer_budget_purchase_request(UUID, UUID, TEXT) FROM anon, authenticated;
REVOKE ALL ON FUNCTION public.reject_transfer_budget_purchase_request(UUID, UUID, TEXT) FROM anon, authenticated;
REVOKE ALL ON FUNCTION public.create_transfer_budget_purchase_request(UUID, UUID, VARCHAR, BIGINT) FROM anon, authenticated;
REVOKE ALL ON FUNCTION public.purchase_league_legend(UUID, UUID, UUID) FROM anon, authenticated;
REVOKE ALL ON FUNCTION public.execute_league_round(UUID, INT) FROM anon, authenticated;

GRANT EXECUTE ON FUNCTION public.delete_solo_league(UUID, UUID) TO service_role;
GRANT EXECUTE ON FUNCTION public.approve_transfer_budget_purchase_request(UUID, UUID, TEXT) TO service_role;
GRANT EXECUTE ON FUNCTION public.reject_transfer_budget_purchase_request(UUID, UUID, TEXT) TO service_role;
GRANT EXECUTE ON FUNCTION public.create_transfer_budget_purchase_request(UUID, UUID, VARCHAR, BIGINT) TO service_role;
GRANT EXECUTE ON FUNCTION public.purchase_league_legend(UUID, UUID, UUID) TO service_role;
GRANT EXECUTE ON FUNCTION public.execute_league_round(UUID, INT) TO service_role;
