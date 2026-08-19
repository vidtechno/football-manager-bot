-- SQL Test Suite: League Clubs and Bot Manager Assignments Foundation Validation
-- All tests run inside a transaction and ROLLBACK at the end. Compatible with pgTAP / pg_prove.

BEGIN;
CREATE EXTENSION IF NOT EXISTS pgtap;
SELECT plan(1);

-- 1. Test RLS Status on Both New Tables
DO $$
DECLARE
    v_rls_count INT;
BEGIN
    SELECT COUNT(*) INTO v_rls_count
    FROM pg_class c
    JOIN pg_namespace n ON n.oid = c.relnamespace
    WHERE n.nspname = 'public'
      AND c.relname IN ('league_clubs', 'bot_manager_assignments')
      AND c.relrowsecurity = TRUE;

    IF v_rls_count <> 2 THEN
        RAISE EXCEPTION 'Test Failed: RLS is not enabled on both league_clubs and bot_manager_assignments (found %).', v_rls_count;
    END IF;
END;
$$;

-- 2. Test Gigants League Clubs Initialization (Idempotency & Template Mapping)
DO $$
DECLARE
    v_owner_id UUID;
    v_league_id UUID;
    v_count INT;
    v_init_result INT;
    v_caught BOOLEAN;
BEGIN
    -- Create test manager & lobby league
    INSERT INTO public.managers (telegram_user_id, manager_name) VALUES (888880001, 'owner_4b2') RETURNING id INTO v_owner_id;
    INSERT INTO public.leagues (name, code, owner_manager_id, status) VALUES ('4B2 Test League', 'C4B299', v_owner_id, 'LOBBY') RETURNING id INTO v_league_id;

    -- Initialize 20 club slots
    v_init_result := public.initialize_gigants_league_clubs(v_league_id);
    IF v_init_result <> 20 THEN
        RAISE EXCEPTION 'Test Failed: Expected 20 initialized clubs, got %.', v_init_result;
    END IF;

    -- Idempotent repeat initialization
    v_init_result := public.initialize_gigants_league_clubs(v_league_id);
    IF v_init_result <> 20 THEN
        RAISE EXCEPTION 'Test Failed: Repeat initialization returned % instead of 20.', v_init_result;
    END IF;

    -- Verify exactly 20 unique template IDs in league_clubs
    SELECT COUNT(DISTINCT club_template_id) INTO v_count FROM public.league_clubs WHERE league_id = v_league_id;
    IF v_count <> 20 THEN
        RAISE EXCEPTION 'Test Failed: Expected 20 unique template IDs, got %.', v_count;
    END IF;

    -- Reject initialization for non-LOBBY league
    UPDATE public.leagues SET status = 'STARTING' WHERE id = v_league_id;


    v_caught := FALSE;
    BEGIN
        PERFORM public.initialize_gigants_league_clubs(v_league_id);
    EXCEPTION WHEN raise_exception THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Initialization on ACTIVE league was allowed.'; END IF;
END;
$$;

-- 3. Test Human Club Selection, Switching, Release & Constraints
DO $$
DECLARE
    v_owner_id UUID;
    v_member1_id UUID;
    v_member2_id UUID;
    v_non_member_id UUID;
    v_blocked_id UUID;
    v_league_id UUID;
    v_club1_id UUID;
    v_club2_id UUID;
    v_caught BOOLEAN;
BEGIN
    -- Setup Managers & League
    INSERT INTO public.managers (telegram_user_id, manager_name) VALUES (888880002, 'owner_m1') RETURNING id INTO v_owner_id;
    INSERT INTO public.managers (telegram_user_id, manager_name) VALUES (888880003, 'member_m1') RETURNING id INTO v_member1_id;
    INSERT INTO public.managers (telegram_user_id, manager_name) VALUES (888880004, 'member_m2') RETURNING id INTO v_member2_id;
    INSERT INTO public.managers (telegram_user_id, manager_name) VALUES (888880005, 'non_member') RETURNING id INTO v_non_member_id;
    INSERT INTO public.managers (telegram_user_id, manager_name) VALUES (888880006, 'blocked_m') RETURNING id INTO v_blocked_id;

    -- Create League & Members
    INSERT INTO public.leagues (name, code, owner_manager_id, status) VALUES ('Selection Test League', 'S4B299', v_owner_id, 'LOBBY') RETURNING id INTO v_league_id;
    INSERT INTO public.league_members (league_id, manager_id, role) VALUES (v_league_id, v_owner_id, 'OWNER');
    INSERT INTO public.league_members (league_id, manager_id, role) VALUES (v_league_id, v_member1_id, 'MEMBER');
    INSERT INTO public.league_members (league_id, manager_id, role) VALUES (v_league_id, v_member2_id, 'MEMBER');
    INSERT INTO public.league_members (league_id, manager_id, role) VALUES (v_league_id, v_blocked_id, 'MEMBER');

    -- Block manager after joining league
    INSERT INTO public.manager_blocks (manager_id, reason) VALUES (v_blocked_id, 'Violation');


    -- Initialize Clubs
    PERFORM public.initialize_gigants_league_clubs(v_league_id);

    SELECT id INTO v_club1_id FROM public.league_clubs WHERE league_id = v_league_id AND short_code = 'RMA';
    SELECT id INTO v_club2_id FROM public.league_clubs WHERE league_id = v_league_id AND short_code = 'BAR';

    -- Non-member selection -> Rejection
    v_caught := FALSE;
    BEGIN
        PERFORM public.select_league_club(v_non_member_id, v_league_id, v_club1_id);
    EXCEPTION WHEN raise_exception THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Non-member selection was allowed.'; END IF;

    -- Blocked manager selection -> Rejection
    v_caught := FALSE;
    BEGIN
        PERFORM public.select_league_club(v_blocked_id, v_league_id, v_club1_id);
    EXCEPTION WHEN raise_exception THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Blocked manager selection was allowed.'; END IF;

    -- Valid member selection
    PERFORM public.select_league_club(v_member1_id, v_league_id, v_club1_id);

    -- Second manager selecting occupied club -> Rejection
    v_caught := FALSE;
    BEGIN
        PERFORM public.select_league_club(v_member2_id, v_league_id, v_club1_id);
    EXCEPTION WHEN raise_exception THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Selecting occupied club was allowed.'; END IF;

    -- Member selecting second club without switching -> Rejection
    v_caught := FALSE;
    BEGIN
        PERFORM public.select_league_club(v_member1_id, v_league_id, v_club2_id);
    EXCEPTION WHEN unique_violation THEN v_caught := TRUE;
              WHEN raise_exception THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Member selecting two clubs was allowed.'; END IF;

    -- Atomic switching to v_club2
    PERFORM public.switch_league_club(v_member1_id, v_league_id, v_club2_id);

    -- Confirm v_club1 is now free and v_club2 is controlled by member1
    IF EXISTS (SELECT 1 FROM public.league_clubs WHERE id = v_club1_id AND human_manager_id IS NOT NULL) THEN
        RAISE EXCEPTION 'Test Failed: Club 1 was not released during switch.';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM public.league_clubs WHERE id = v_club2_id AND human_manager_id = v_member1_id) THEN
        RAISE EXCEPTION 'Test Failed: Club 2 was not acquired during switch.';
    END IF;

    -- Member 2 can now select released v_club1
    PERFORM public.select_league_club(v_member2_id, v_league_id, v_club1_id);

    -- Release club
    PERFORM public.release_league_club(v_member2_id, v_league_id);
    IF EXISTS (SELECT 1 FROM public.league_clubs WHERE id = v_club1_id AND human_manager_id IS NOT NULL) THEN
        RAISE EXCEPTION 'Test Failed: Club 1 was not released.';
    END IF;

    -- Lock league state (Status STARTING) -> Selection/Switch/Release must fail
    UPDATE public.leagues SET status = 'STARTING' WHERE id = v_league_id;


    v_caught := FALSE;
    BEGIN
        PERFORM public.select_league_club(v_member2_id, v_league_id, v_club1_id);
    EXCEPTION WHEN raise_exception THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Selection allowed on ACTIVE league.'; END IF;
END;
$$;

-- 4. Test Bot Manager Assignments (Mutual Exclusion & Cross-Table Consistency)
DO $$
DECLARE
    v_owner_id UUID;
    v_member_id UUID;
    v_league_id UUID;
    v_club1_id UUID;
    v_club2_id UUID;
    v_assigned_count INT;
    v_caught BOOLEAN;
BEGIN
    INSERT INTO public.managers (telegram_user_id, manager_name) VALUES (888880007, 'bot_owner') RETURNING id INTO v_owner_id;
    INSERT INTO public.managers (telegram_user_id, manager_name) VALUES (888880008, 'bot_member') RETURNING id INTO v_member_id;

    INSERT INTO public.leagues (name, code, owner_manager_id, status) VALUES ('Bot Test League', 'B4B299', v_owner_id, 'LOBBY') RETURNING id INTO v_league_id;
    INSERT INTO public.league_members (league_id, manager_id, role) VALUES (v_league_id, v_owner_id, 'OWNER');
    INSERT INTO public.league_members (league_id, manager_id, role) VALUES (v_league_id, v_member_id, 'MEMBER');

    PERFORM public.initialize_gigants_league_clubs(v_league_id);

    SELECT id INTO v_club1_id FROM public.league_clubs WHERE league_id = v_league_id AND short_code = 'RMA';
    SELECT id INTO v_club2_id FROM public.league_clubs WHERE league_id = v_league_id AND short_code = 'BAR';

    -- Member selects club 1
    PERFORM public.select_league_club(v_member_id, v_league_id, v_club1_id);

    -- Assign bots to remaining 19 unselected clubs
    v_assigned_count := public.assign_bots_to_unselected_clubs(v_league_id);
    IF v_assigned_count <> 19 THEN
        RAISE EXCEPTION 'Test Failed: Expected 19 bot assignments, got %.', v_assigned_count;
    END IF;

    -- Human-controlled club 1 must NOT have a bot assignment
    IF EXISTS (SELECT 1 FROM public.bot_manager_assignments WHERE league_club_id = v_club1_id AND is_active = TRUE) THEN
        RAISE EXCEPTION 'Test Failed: Human controlled club received bot assignment.';
    END IF;

    -- Repeat bot assignment is idempotent (returns 0)
    v_assigned_count := public.assign_bots_to_unselected_clubs(v_league_id);
    IF v_assigned_count <> 0 THEN
        RAISE EXCEPTION 'Test Failed: Repeat bot assignment created % new assignments instead of 0.', v_assigned_count;
    END IF;

    -- Attempt to assign bot to human-controlled club 1 directly -> Trigger Rejection
    v_caught := FALSE;
    BEGIN
        INSERT INTO public.bot_manager_assignments (league_id, league_club_id, is_active)
        VALUES (v_league_id, v_club1_id, TRUE);
    EXCEPTION WHEN raise_exception THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Direct bot assignment to human club was allowed.'; END IF;

    -- Attempt to select bot-assigned club 2 -> Rejection
    v_caught := FALSE;
    BEGIN
        PERFORM public.select_league_club(v_member_id, v_league_id, v_club2_id);
    EXCEPTION WHEN raise_exception THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Human selection of bot-assigned club was allowed.'; END IF;
END;
$$;

-- 5. Test Forward Repair Regression for publish_club_template_version
DO $$
DECLARE
    v_admin_id UUID;
    v_club_template_id UUID;
    v_version_id UUID;
BEGIN
    INSERT INTO public.admin_users (email, role, status)
    VALUES ('admin_repair_test@example.com', 'SUPER_ADMIN', 'ACTIVE')
    RETURNING id INTO v_admin_id;

    SELECT id INTO v_club_template_id FROM public.club_templates WHERE slug = 'real-madrid';

    v_version_id := public.publish_club_template_version(
        v_admin_id,
        v_club_template_id,
        98,
        1200000000.00
    );

    IF v_version_id IS NULL THEN
        RAISE EXCEPTION 'Test Failed: Forward repaired publish_club_template_version returned NULL.';
    END IF;
END;
$$;

SELECT pass('League clubs and bot manager assignments tests completed successfully.');
SELECT * FROM finish();

ROLLBACK;
