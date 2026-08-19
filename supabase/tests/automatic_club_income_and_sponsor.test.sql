-- pgTAP SQL Test Suite: Automatic Club Income, Global Sponsor Channel & Idempotency
BEGIN;
SELECT plan(8);

-- 1. Test Schema & Types Exist
SELECT has_table('global_sponsor_settings', 'global_sponsor_settings table exists');
SELECT has_table('manager_sponsor_verifications', 'manager_sponsor_verifications table exists');
SELECT has_table('league_matches', 'league_matches table exists');

-- 2. Test Function Existence
SELECT has_function('set_active_global_sponsor_channel', ARRAY['bigint', 'varchar', 'varchar', 'varchar', 'uuid'], 'set_active_global_sponsor_channel RPC exists');
SELECT has_function('deactivate_global_sponsor_channel', ARRAY['uuid'], 'deactivate_global_sponsor_channel RPC exists');
SELECT has_function('process_round_settlement_income', ARRAY['uuid', 'int', 'uuid[]'], 'process_round_settlement_income RPC exists');

-- 3. Execute Transactional Behavior Verification
DO $$
DECLARE
    v_admin_id UUID := '00000000-0000-0000-0000-000000000001';
    v_human_mgr_id UUID;
    v_league_id UUID;
    v_human_club_id UUID;
    v_bot_club_id UUID;
    v_round_id UUID;
    v_tpl1_id UUID;
    v_tpl2_id UUID;
    v_res JSONB;
    v_human_bal NUMERIC;
    v_bot_bal NUMERIC;
    v_active_count INT;
    v_ledger_count INT;
BEGIN
    -- Setup test admin
    INSERT INTO public.admin_users (id, telegram_user_id, role)
    VALUES (v_admin_id, 9998001, 'SUPER_ADMIN')
    ON CONFLICT (id) DO NOTHING;

    -- Setup human manager
    INSERT INTO public.managers (telegram_user_id, manager_name)
    VALUES (9998002, 'income_mgr') RETURNING id INTO v_human_mgr_id;

    -- Setup league
    INSERT INTO public.leagues (name, code, owner_manager_id)
    VALUES ('Income Test League', 'ABCDEF', v_human_mgr_id) RETURNING id INTO v_league_id;

    INSERT INTO public.league_members (league_id, manager_id, role)
    VALUES (v_league_id, v_human_mgr_id, 'OWNER');

    -- Select existing club templates (do not insert new templates to preserve seed count = 20)
    SELECT id INTO v_tpl1_id FROM public.club_templates ORDER BY created_at ASC LIMIT 1;
    SELECT id INTO v_tpl2_id FROM public.club_templates ORDER BY created_at ASC LIMIT 1 OFFSET 1;

    -- Setup clubs
    INSERT INTO public.league_clubs (league_id, club_template_id, display_name, short_code, human_manager_id)
    VALUES (v_league_id, v_tpl1_id, 'Inc Human FC', 'IHF', v_human_mgr_id) RETURNING id INTO v_human_club_id;

    INSERT INTO public.league_clubs (league_id, club_template_id, display_name, short_code, human_manager_id)
    VALUES (v_league_id, v_tpl2_id, 'Inc Bot FC', 'IBF', NULL) RETURNING id INTO v_bot_club_id;

    -- Finances (€10M starting balance)
    INSERT INTO public.club_finances (league_id, league_club_id, total_balance, reserved_balance)
    VALUES (v_league_id, v_human_club_id, 10000000.00, 0.00);

    INSERT INTO public.club_finances (league_id, league_club_id, total_balance, reserved_balance)
    VALUES (v_league_id, v_bot_club_id, 10000000.00, 0.00);

    -- Setup rounds
    INSERT INTO public.league_rounds (league_id, round_number, status)
    VALUES (v_league_id, 1, 'SCHEDULED') RETURNING id INTO v_round_id;

    -- -------------------------------------------------------------
    -- Test A: Single Active Global Sponsor Channel Constraint & Switching
    -- -------------------------------------------------------------
    v_res := public.set_active_global_sponsor_channel(
        -100111111111, '@sponsor_chan_1', 'Sponsor Channel 1', 'https://t.me/sponsor_chan_1', v_admin_id
    );
    IF (v_res->>'success')::boolean IS NOT TRUE THEN
        RAISE EXCEPTION 'Test Failed: First sponsor channel activation failed.';
    END IF;

    -- Activate second channel
    v_res := public.set_active_global_sponsor_channel(
        -100222222222, '@sponsor_chan_2', 'Sponsor Channel 2', 'https://t.me/sponsor_chan_2', v_admin_id
    );
    IF (v_res->>'success')::boolean IS NOT TRUE THEN
        RAISE EXCEPTION 'Test Failed: Second sponsor channel activation failed.';
    END IF;

    -- Verify EXACTLY ONE active sponsor setting exists
    SELECT COUNT(*) INTO v_active_count FROM public.global_sponsor_settings WHERE is_active = TRUE;
    IF v_active_count <> 1 THEN
        RAISE EXCEPTION 'Test Failed: Expected 1 active sponsor setting, got %', v_active_count;
    END IF;

    -- -------------------------------------------------------------
    -- Test B: Process Round Settlement Income & Idempotency
    -- -------------------------------------------------------------
    -- Run settlement for Round 1 with human manager eligible for sponsorship
    v_res := public.process_round_settlement_income(
        v_league_id,
        1,
        ARRAY[v_human_mgr_id]
    );

    IF (v_res->>'success')::boolean IS NOT TRUE THEN
        RAISE EXCEPTION 'Test Failed: process_round_settlement_income failed.';
    END IF;

    -- Check balances (€10M + €2.5M = €12.5M)
    SELECT total_balance INTO v_human_bal FROM public.club_finances WHERE league_club_id = v_human_club_id;
    SELECT total_balance INTO v_bot_bal FROM public.club_finances WHERE league_club_id = v_bot_club_id;

    IF v_human_bal <> 12500000.00 THEN
        RAISE EXCEPTION 'Test Failed: Expected human balance 12.5M, got %', v_human_bal;
    END IF;

    IF v_bot_bal <> 12500000.00 THEN
        RAISE EXCEPTION 'Test Failed: Expected bot balance 12.5M, got %', v_bot_bal;
    END IF;

    -- Test Idempotency: Re-run settlement for Round 1 -> balances must NOT change
    v_res := public.process_round_settlement_income(
        v_league_id,
        1,
        ARRAY[v_human_mgr_id]
    );

    SELECT total_balance INTO v_human_bal FROM public.club_finances WHERE league_club_id = v_human_club_id;
    IF v_human_bal <> 12500000.00 THEN
        RAISE EXCEPTION 'Test Failed: Idempotency failed, human balance changed to %', v_human_bal;
    END IF;

    RAISE NOTICE 'Automatic club income and sponsor pgTAP tests completed successfully.';
END;
$$;

SELECT pass('Global sponsor single-channel constraint and switching verification passed.');
SELECT pass('Process round settlement income, sponsorship eligibility, and idempotency passed.');
COMMIT;
