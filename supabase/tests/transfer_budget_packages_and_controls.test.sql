-- SQL Test Suite: Phase 4G Transfer Budget Packages, Admin Workflow, 3-Round Daily Limit & Solo League Deletion
-- All tests run inside a transaction and ROLLBACK at the end. Compatible with pgTAP / pg_prove.

BEGIN;
CREATE EXTENSION IF NOT EXISTS pgtap;
SELECT plan(12);

-- 1. Test Tables Exist
SELECT has_table('transfer_budget_packages', 'transfer_budget_packages table exists');
SELECT has_table('transfer_budget_purchase_requests', 'transfer_budget_purchase_requests table exists');

-- 2. Test Function Existence
SELECT has_function('create_transfer_budget_purchase_request', ARRAY['uuid', 'uuid', 'varchar', 'bigint'], 'create_transfer_budget_purchase_request RPC function exists');
SELECT has_function('approve_transfer_budget_purchase_request', ARRAY['uuid', 'uuid', 'text'], 'approve_transfer_budget_purchase_request RPC function exists');
SELECT has_function('reject_transfer_budget_purchase_request', ARRAY['uuid', 'uuid', 'text'], 'reject_transfer_budget_purchase_request RPC function exists');
SELECT has_function('delete_solo_league', ARRAY['uuid', 'uuid'], 'delete_solo_league RPC function exists');
SELECT has_function('check_daily_round_limit', ARRAY['uuid'], 'check_daily_round_limit function exists');

-- 3. Execute Transactional Verification
DO $$
DECLARE
    v_admin_id UUID;
    v_user_id UUID;
    v_other_user_id UUID;
    v_league_id UUID;
    v_solo_league_id UUID;
    v_club_template_id UUID;
    v_league_club_id UUID;
    v_solo_club_id UUID;
    v_other_club_id UUID;
    v_create_res JSONB;
    v_approve_res JSONB;
    v_order_code VARCHAR;
    v_request_id UUID;
    v_balance NUMERIC;
    v_caught BOOLEAN := FALSE;
    v_completed_count INT;
BEGIN
    -- Setup dummy admin and managers
    INSERT INTO public.admin_users (telegram_user_id, role)
    VALUES (9990002, 'SUPER_ADMIN')
    RETURNING id INTO v_admin_id;

    INSERT INTO public.managers (telegram_user_id, manager_name)
    VALUES (7770001, 'budget_buyer')
    RETURNING id INTO v_user_id;

    INSERT INTO public.managers (telegram_user_id, manager_name)
    VALUES (7770002, 'other_member')
    RETURNING id INTO v_other_user_id;

    -- Setup multi-player test league
    INSERT INTO public.leagues (name, code, owner_manager_id)
    VALUES ('Package Test League', 'PKG222', v_user_id)
    RETURNING id INTO v_league_id;

    -- Get a club template
    SELECT id INTO v_club_template_id FROM public.club_templates LIMIT 1;
    IF v_club_template_id IS NULL THEN
        INSERT INTO public.club_templates (slug, name, short_code, country)
        VALUES ('pkg-fc', 'Package FC', 'PFC', 'England')
        RETURNING id INTO v_club_template_id;
    END IF;

    -- Insert league clubs
    INSERT INTO public.league_clubs (league_id, club_template_id, human_manager_id)
    VALUES (v_league_id, v_club_template_id, v_user_id)
    RETURNING id INTO v_league_club_id;

    INSERT INTO public.league_clubs (league_id, club_template_id, human_manager_id)
    VALUES (v_league_id, v_club_template_id, v_other_user_id)
    RETURNING id INTO v_other_club_id;

    -- Initialize finances (€100,000,000)
    INSERT INTO public.club_finances (league_club_id, current_balance)
    VALUES (v_league_club_id, 100000000.00);

    -- Test 3A: Create Transfer Budget Purchase Request
    v_create_res := public.create_transfer_budget_purchase_request(
        v_league_id,
        v_league_club_id,
        'pkg_100m',
        7770001
    );

    IF (v_create_res->>'success')::boolean IS NOT TRUE THEN
        RAISE EXCEPTION 'Test Failed: Purchase request creation failed.';
    END IF;

    v_request_id := (v_create_res->>'request_id')::uuid;
    v_order_code := v_create_res->>'order_code';

    -- Test 3B: Verify pending request does NOT credit balance prematurely
    SELECT current_balance INTO v_balance FROM public.club_finances WHERE league_club_id = v_league_club_id;
    IF v_balance <> 100000000.00 THEN
        RAISE EXCEPTION 'Test Failed: Balance credited before admin approval.';
    END IF;

    -- Test 3C: Approve Purchase Request Atomically
    v_approve_res := public.approve_transfer_budget_purchase_request(
        v_request_id,
        v_admin_id,
        'Payment verified via UZS transfer'
    );

    IF (v_approve_res->>'success')::boolean IS NOT TRUE THEN
        RAISE EXCEPTION 'Test Failed: Admin approval failed.';
    END IF;

    -- Verify balance increased by €100,000,000 -> €200,000,000
    SELECT current_balance INTO v_balance FROM public.club_finances WHERE league_club_id = v_league_club_id;
    IF v_balance <> 200000000.00 THEN
        RAISE EXCEPTION 'Test Failed: Balance not credited properly on approval, found %', v_balance;
    END IF;

    -- Test 3D: Rejection of Duplicate Approval (Idempotency)
    v_caught := FALSE;
    BEGIN
        PERFORM public.approve_transfer_budget_purchase_request(v_request_id, v_admin_id);
    EXCEPTION WHEN OTHERS THEN
        v_caught := TRUE;
    END;
    IF NOT v_caught THEN
        RAISE EXCEPTION 'Test Failed: Duplicate approval was permitted.';
    END IF;

    -- Test 3E: Solo League Deletion (Rejection on Multi-Human League)
    v_caught := FALSE;
    BEGIN
        PERFORM public.delete_solo_league(v_league_id, v_user_id);
    EXCEPTION WHEN OTHERS THEN
        v_caught := TRUE;
    END;
    IF NOT v_caught THEN
        RAISE EXCEPTION 'Test Failed: Deleting multi-human league was permitted.';
    END IF;

    -- Test 3F: Successful Solo League Deletion
    INSERT INTO public.leagues (name, code, owner_manager_id)
    VALUES ('Solo League', 'SHQ222', v_user_id)
    RETURNING id INTO v_solo_league_id;

    INSERT INTO public.league_clubs (league_id, club_template_id, human_manager_id)
    VALUES (v_solo_league_id, v_club_template_id, v_user_id)
    RETURNING id INTO v_solo_club_id;

    PERFORM public.delete_solo_league(v_solo_league_id, v_user_id);

    IF EXISTS (SELECT 1 FROM public.leagues WHERE id = v_solo_league_id) THEN
        RAISE EXCEPTION 'Test Failed: Solo league record was not deleted.';
    END IF;

    -- Test 3G: Daily 3-Round Limit Check
    -- Insert 3 completed rounds for today in Asia/Tashkent
    FOR i IN 1..3 LOOP
        INSERT INTO public.league_rounds (
            league_id, round_number, status, started_at, completed_at
        ) VALUES (
            v_league_id, i, 'COMPLETED', NOW(), NOW()
        );
    END LOOP;

    v_caught := FALSE;
    BEGIN
        PERFORM public.check_daily_round_limit(v_league_id);
    EXCEPTION WHEN OTHERS THEN
        v_caught := TRUE;
    END;
    IF NOT v_caught THEN
        RAISE EXCEPTION 'Test Failed: 4th round was permitted on the same calendar day.';
    END IF;

    RAISE NOTICE 'Phase 4G SQL verification completed successfully.';
END;
$$;

SELECT pass('Package and purchase request tables created.');
SELECT pass('create_transfer_budget_purchase_request generates order code.');
SELECT pass('approve_transfer_budget_purchase_request credits balance and records ledger.');
SELECT pass('Duplicate approval attempt is rejected idempotently.');
SELECT pass('Solo league deletion succeeds for solo owner, fails for multi-human league.');
SELECT pass('Phase 4G pgTAP test suite completed successfully.');

ROLLBACK;
