-- SQL Test Suite: Leagues and Membership Foundation Schema Validation (Hardened & Comprehensive)
-- All tests run inside a transaction and ROLLBACK at the end.

BEGIN;

-- Setup Test Managers
INSERT INTO public.managers (id, telegram_user_id, manager_name)
VALUES 
  ('11111111-1111-1111-1111-111111111111', 200001, 'TestOwner1'),
  ('22222222-2222-2222-2222-222222222222', 200002, 'TestMember1'),
  ('33333333-3333-3333-3333-333333333333', 200003, 'TestMember2'),
  ('44444444-4444-4444-4444-444444444444', 200004, 'TestBlockedManager'),
  ('55555555-5555-5555-5555-555555555555', 200005, 'TestUnblockedManager');

-- Add Blocked Record for TestBlockedManager
INSERT INTO public.manager_blocks (manager_id, reason)
VALUES ('44444444-4444-4444-4444-444444444444', 'Violation');

-- Add Historical Unblocked Record for TestUnblockedManager
INSERT INTO public.manager_blocks (manager_id, reason, blocked_at, unblocked_at)
VALUES ('55555555-5555-5555-5555-555555555555', 'Resolved issue', NOW() - INTERVAL '2 days', NOW() - INTERVAL '1 day');

-- 1. Test Code Format Constraints (Positive and Negative)
DO $$
DECLARE
    v_caught BOOLEAN;
BEGIN
    -- Rejected: Contains 'O'
    v_caught := FALSE;
    BEGIN
        INSERT INTO public.leagues (name, code, owner_manager_id)
        VALUES ('Invalid O', 'ABCDEO', '11111111-1111-1111-1111-111111111111');
    EXCEPTION WHEN check_violation THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Code containing O was allowed.'; END IF;

    -- Rejected: Contains '0'
    v_caught := FALSE;
    BEGIN
        INSERT INTO public.leagues (name, code, owner_manager_id)
        VALUES ('Invalid 0', 'ABCD01', '11111111-1111-1111-1111-111111111111');
    EXCEPTION WHEN check_violation THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Code containing 0 was allowed.'; END IF;

    -- Rejected: Contains 'I'
    v_caught := FALSE;
    BEGIN
        INSERT INTO public.leagues (name, code, owner_manager_id)
        VALUES ('Invalid I', 'ABCDEI', '11111111-1111-1111-1111-111111111111');
    EXCEPTION WHEN check_violation THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Code containing I was allowed.'; END IF;

    -- Rejected: Contains 'L'
    v_caught := FALSE;
    BEGIN
        INSERT INTO public.leagues (name, code, owner_manager_id)
        VALUES ('Invalid L', 'ABCDEL', '11111111-1111-1111-1111-111111111111');
    EXCEPTION WHEN check_violation THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Code containing L was allowed.'; END IF;

    -- Rejected: Contains '1'
    v_caught := FALSE;
    BEGIN
        INSERT INTO public.leagues (name, code, owner_manager_id)
        VALUES ('Invalid 1', 'ABCDE1', '11111111-1111-1111-1111-111111111111');
    EXCEPTION WHEN check_violation THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Code containing 1 was allowed.'; END IF;

    -- Rejected: Lowercase
    v_caught := FALSE;
    BEGIN
        INSERT INTO public.leagues (name, code, owner_manager_id)
        VALUES ('Invalid Lower', 'abcdef', '11111111-1111-1111-1111-111111111111');
    EXCEPTION WHEN check_violation THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Lowercase code was allowed.'; END IF;

    -- Rejected: 5 chars
    v_caught := FALSE;
    BEGIN
        INSERT INTO public.leagues (name, code, owner_manager_id)
        VALUES ('Invalid 5', 'ABCDE', '11111111-1111-1111-1111-111111111111');
    EXCEPTION WHEN check_violation THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: 5-character code was allowed.'; END IF;

    -- Rejected: 7 chars
    v_caught := FALSE;
    BEGIN
        INSERT INTO public.leagues (name, code, owner_manager_id)
        VALUES ('Invalid 7', 'ABCDEFG', '11111111-1111-1111-1111-111111111111');
    EXCEPTION WHEN check_violation THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: 7-character code was allowed.'; END IF;
END;
$$;

-- 2. Test Cryptographic Code Generator Sample (500 iterations)
DO $$
DECLARE
    i INT;
    v_code VARCHAR(6);
BEGIN
    FOR i IN 1..500 LOOP
        v_code := public.generate_unique_league_code();
        IF length(v_code) <> 6 THEN
            RAISE EXCEPTION 'Test Failed: Generated code length is not 6.';
        END IF;
        IF v_code !~ '^[A-HJKMNP-Z2-9]{6}$' THEN
            RAISE EXCEPTION 'Test Failed: Generated code % contains invalid characters.', v_code;
        END IF;
    END FOR;
END;
$$;

-- 3. Test Blocked and Unblocked Manager Participation
DO $$
DECLARE
    v_caught BOOLEAN;
    v_res JSONB;
BEGIN
    -- Blocked manager cannot create league
    v_caught := FALSE;
    BEGIN
        PERFORM public.create_league_with_owner('44444444-4444-4444-4444-444444444444', 'Blocked League');
    EXCEPTION WHEN P0001 THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Blocked manager created a league.'; END IF;

    -- Unblocked manager CAN create league
    v_res := public.create_league_with_owner('55555555-5555-5555-5555-555555555555', 'Unblocked League');
    IF v_res->>'league_id' IS NULL THEN
        RAISE EXCEPTION 'Test Failed: Unblocked manager could not create a league.';
    END IF;

    -- Blocked manager cannot join league
    v_caught := FALSE;
    BEGIN
        PERFORM public.join_league_by_code('44444444-4444-4444-4444-444444444444', v_res->>'code');
    EXCEPTION WHEN P0001 THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Blocked manager joined a league.'; END IF;
END;
$$;

-- 4. Test Atomic Creation & Membership Limits (2 Active Leagues)
DO $$
DECLARE
    v_res1 JSONB;
    v_res2 JSONB;
    v_caught BOOLEAN;
BEGIN
    v_res1 := public.create_league_with_owner('11111111-1111-1111-1111-111111111111', 'Owner League 1');
    v_res2 := public.create_league_with_owner('11111111-1111-1111-1111-111111111111', 'Owner League 2');

    -- Attempt 3rd league via function -> Must Fail
    v_caught := FALSE;
    BEGIN
        PERFORM public.create_league_with_owner('11111111-1111-1111-1111-111111111111', 'Owner League 3');
    EXCEPTION WHEN P0001 THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Creating 3rd active league succeeded.'; END IF;

    -- Direct DML INSERT into league_members for 3rd league -> Must Fail
    v_caught := FALSE;
    BEGIN
        INSERT INTO public.league_members (league_id, manager_id, role)
        VALUES ((v_res2->>'league_id')::UUID, '55555555-5555-5555-5555-555555555555', 'MEMBER');
        -- Now TestUnblockedManager has 2 active leagues. Trying to join 3rd direct DML:
        INSERT INTO public.league_members (league_id, manager_id, role)
        VALUES ((v_res1->>'league_id')::UUID, '55555555-5555-5555-5555-555555555555', 'MEMBER');
    EXCEPTION WHEN P0001 THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Direct DML 3rd active league insertion succeeded.'; END IF;
END;
$$;

-- 5. Test Code Registry Immutability & Lifecycle
DO $$
DECLARE
    v_code VARCHAR(6);
    v_league_id UUID;
    v_caught BOOLEAN;
BEGIN
    SELECT code, league_id INTO v_code, v_league_id FROM public.league_code_registry WHERE league_id IS NOT NULL LIMIT 1;

    -- Code UPDATE -> Rejection
    v_caught := FALSE;
    BEGIN
        UPDATE public.league_code_registry SET code = 'XXXXXX' WHERE code = v_code;
    EXCEPTION WHEN P0001 THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: UPDATE on registry code succeeded.'; END IF;

    -- Rebind to another league -> Rejection
    v_caught := FALSE;
    BEGIN
        UPDATE public.league_code_registry SET league_id = gen_random_uuid() WHERE code = v_code;
    EXCEPTION WHEN P0001 THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Rebinding registry row succeeded.'; END IF;

    -- Direct DELETE -> Rejection
    v_caught := FALSE;
    BEGIN
        DELETE FROM public.league_code_registry WHERE code = v_code;
    EXCEPTION WHEN P0001 THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Direct DELETE from registry succeeded.'; END IF;
END;
$$;

-- 6. Test Member Leave & Lobby League Deletion Lifecycle
DO $$
DECLARE
    v_res JSONB;
    v_league_id UUID;
    v_code VARCHAR(6);
    v_caught BOOLEAN;
    v_rel_at TIMESTAMPTZ;
BEGIN
    v_res := public.create_league_with_owner('22222222-2222-2222-2222-222222222222', 'Test Delete League');
    v_league_id := (v_res->>'league_id')::UUID;
    v_code := v_res->>'code';

    -- Join TestMember2
    PERFORM public.join_league_by_code('33333333-3333-3333-3333-333333333333', v_code);

    -- Member leave succeeds
    PERFORM public.leave_lobby_league('33333333-3333-3333-3333-333333333333', v_league_id);

    -- Owner leave fails
    v_caught := FALSE;
    BEGIN
        PERFORM public.leave_lobby_league('22222222-2222-2222-2222-222222222222', v_league_id);
    EXCEPTION WHEN P0001 THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Owner leave succeeded.'; END IF;

    -- Delete lobby league
    PERFORM public.delete_lobby_league('22222222-2222-2222-2222-222222222222', v_league_id);

    -- Verify code registry row has league_id NULL and released_at NOT NULL
    SELECT released_at INTO v_rel_at FROM public.league_code_registry WHERE code = v_code;
    IF v_rel_at IS NULL THEN
        RAISE EXCEPTION 'Test Failed: Code registry released_at was not populated upon lobby deletion.';
    END IF;

    -- Attempt to rebind released code -> Rejection
    v_caught := FALSE;
    BEGIN
        UPDATE public.league_code_registry SET league_id = gen_random_uuid() WHERE code = v_code;
    EXCEPTION WHEN P0001 THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Rebinding released code succeeded.'; END IF;
END;
$$;

-- 7. Test Status Transitions & Timestamps Matrix
DO $$
DECLARE
    v_res JSONB;
    v_league_id UUID;
    v_league RECORD;
    v_caught BOOLEAN;
BEGIN
    v_res := public.create_league_with_owner('22222222-2222-2222-2222-222222222222', 'Status Test League');
    v_league_id := (v_res->>'league_id')::UUID;

    -- Transition LOBBY -> STARTING
    UPDATE public.leagues SET status = 'STARTING' WHERE id = v_league_id;
    SELECT * INTO v_league FROM public.leagues WHERE id = v_league_id;
    IF v_league.started_at IS NULL THEN RAISE EXCEPTION 'Test Failed: started_at not set on STARTING.'; END IF;

    -- Changing round_speed after LOBBY -> Rejection
    v_caught := FALSE;
    BEGIN
        UPDATE public.league_settings SET round_speed = 3 WHERE league_id = v_league_id;
    EXCEPTION WHEN P0001 THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: round_speed updated after STARTING.'; END IF;

    -- Transition STARTING -> ACTIVE
    UPDATE public.leagues SET status = 'ACTIVE' WHERE id = v_league_id;

    -- Transition ACTIVE -> COMPLETED
    UPDATE public.leagues SET status = 'COMPLETED' WHERE id = v_league_id;
    SELECT * INTO v_league FROM public.leagues WHERE id = v_league_id;
    IF v_league.completed_at IS NULL THEN RAISE EXCEPTION 'Test Failed: completed_at not set on COMPLETED.'; END IF;

    -- Invalid transition COMPLETED -> ACTIVE -> Rejection
    v_caught := FALSE;
    BEGIN
        UPDATE public.leagues SET status = 'ACTIVE' WHERE id = v_league_id;
    EXCEPTION WHEN P0001 THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: COMPLETED -> ACTIVE transition succeeded.'; END IF;
END;
$$;

-- 8. Test RLS Status on all 5 new tables
DO $$
DECLARE
    v_rls_count INT;
BEGIN
    SELECT COUNT(*) INTO v_rls_count
    FROM pg_class c
    JOIN pg_namespace n ON n.oid = c.relnamespace
    WHERE n.nspname = 'public'
      AND c.relname IN ('leagues', 'league_code_registry', 'league_members', 'league_settings', 'league_rounds')
      AND c.relrowsecurity = TRUE;

    IF v_rls_count <> 5 THEN
        RAISE EXCEPTION 'Test Failed: Not all 5 new tables have RLS enabled (found %).', v_rls_count;
    END IF;
END;
$$;

ROLLBACK;
