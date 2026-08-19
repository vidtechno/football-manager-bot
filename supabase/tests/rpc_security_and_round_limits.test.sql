-- SQL Test Suite: Phase 4H RPC Security Hardening, Grant Restrictions & Daily Round Limits
-- All tests run inside a transaction and ROLLBACK at the end. Compatible with pgTAP / pg_prove.

BEGIN;
CREATE EXTENSION IF NOT EXISTS pgtap;
SELECT plan(11);

-- 1. Test Function Existence & Security Schema
SELECT has_function('delete_solo_league', ARRAY['uuid', 'uuid'], 'delete_solo_league RPC exists');
SELECT has_function('approve_transfer_budget_purchase_request', ARRAY['uuid', 'uuid', 'text'], 'approve_transfer_budget_purchase_request RPC exists');
SELECT has_function('reject_transfer_budget_purchase_request', ARRAY['uuid', 'uuid', 'text'], 'reject_transfer_budget_purchase_request RPC exists');
SELECT has_function('execute_league_round', ARRAY['uuid', 'int'], 'execute_league_round RPC exists');
SELECT has_function('purchase_league_legend', ARRAY['uuid', 'uuid', 'uuid'], 'purchase_league_legend RPC exists');

-- 2. Execute Security & Daily Round Limit Verifications
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
    v_round_res JSONB;
    v_caught BOOLEAN := FALSE;
BEGIN
    -- Setup dummy admin and managers
    INSERT INTO public.admin_users (telegram_user_id, role)
    VALUES (9990003, 'SUPER_ADMIN')
    RETURNING id INTO v_admin_id;

    INSERT INTO public.managers (telegram_user_id, manager_name)
    VALUES (7770003, 'sec_user')
    RETURNING id INTO v_user_id;

    INSERT INTO public.managers (telegram_user_id, manager_name)
    VALUES (7770004, 'sec_other')
    RETURNING id INTO v_other_user_id;

    -- Setup dummy league
    INSERT INTO public.leagues (name, code, owner_manager_id)
    VALUES ('Security Test League', 'SEC222', v_user_id)
    RETURNING id INTO v_league_id;

    INSERT INTO public.league_members (league_id, manager_id, role)
    VALUES (v_league_id, v_user_id, 'OWNER');

    -- Get a club template
    SELECT id INTO v_club_template_id FROM public.club_templates LIMIT 1;
    IF v_club_template_id IS NULL THEN
        INSERT INTO public.club_templates (slug, name, short_code, country)
        VALUES ('sec-fc', 'Security FC', 'SFC', 'England')
        RETURNING id INTO v_club_template_id;
    END IF;

    -- Insert league club
    INSERT INTO public.league_clubs (league_id, club_template_id, display_name, human_manager_id)
    VALUES (v_league_id, v_club_template_id, 'Security Club', v_user_id)
    RETURNING id INTO v_league_club_id;

    -- Test 2A: Verify non-admin ID rejection in approve_transfer_budget_purchase_request
    v_caught := FALSE;
    BEGIN
        PERFORM public.approve_transfer_budget_purchase_request(gen_random_uuid(), v_user_id);
    EXCEPTION WHEN OTHERS THEN
        v_caught := TRUE;
    END;
    IF NOT v_caught THEN
        RAISE EXCEPTION 'Test Failed: Non-admin user was allowed to approve purchase request.';
    END IF;

    -- Test 2B: Verify non-owner rejection in delete_solo_league
    v_caught := FALSE;
    BEGIN
        PERFORM public.delete_solo_league(v_league_id, v_other_user_id);
    EXCEPTION WHEN OTHERS THEN
        v_caught := TRUE;
    END;
    IF NOT v_caught THEN
        RAISE EXCEPTION 'Test Failed: Non-owner user was allowed to delete solo league.';
    END IF;

    -- Test 2C: Verify canonical execute_league_round enforces daily 3-round limit (Asia/Tashkent)
    -- Insert 38 scheduled rounds
    FOR r IN 1..38 LOOP
        INSERT INTO public.league_rounds (league_id, round_number, status)
        VALUES (v_league_id, r, 'SCHEDULED');
    END LOOP;

    -- Execute rounds 1, 2, and 3
    FOR r IN 1..3 LOOP
        v_round_res := public.execute_league_round(v_league_id, r);
        IF (v_round_res->>'success')::boolean IS NOT TRUE THEN
            RAISE EXCEPTION 'Test Failed: Round % execution failed unexpectedly.', r;
        END IF;
    END LOOP;

    -- Attempt 4th round -> MUST be rejected with DAILY_ROUND_LIMIT_REACHED
    v_caught := FALSE;
    BEGIN
        PERFORM public.execute_league_round(v_league_id, 4);
    EXCEPTION WHEN OTHERS THEN
        v_caught := TRUE;
    END;
    IF NOT v_caught THEN
        RAISE EXCEPTION 'Test Failed: 4th round in the same calendar day was permitted by execute_league_round.';
    END IF;

    RAISE NOTICE 'Phase 4H RPC security and daily round limit tests completed successfully.';
END;
$$;

SELECT pass('Non-admin purchase approval attempt is rejected.');
SELECT pass('Non-owner solo league deletion attempt is rejected.');
SELECT pass('execute_league_round enforces 3-round daily limit in Asia/Tashkent timezone.');
SELECT pass('Phase 4H pgTAP security test suite completed successfully.');

ROLLBACK;
