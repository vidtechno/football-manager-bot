-- SQL Test Suite: Leagues and Membership Foundation Schema Validation (Hardened & Fully Corrected)
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

-- 1. Assert Alphabet Exact Length is 31
DO $$
DECLARE
    v_len INT;
BEGIN
    v_len := char_length('ABCDEFGHJKMNPQRSTUVWXYZ23456789');
    IF v_len <> 31 THEN
        RAISE EXCEPTION 'Test Failed: Approved alphabet length is %, expected 31.', v_len;
    END IF;
END;
$$;

-- 2. Test Code Format Constraints (Positive and Negative)
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
        VALUES ('Invalid 0', 'ABCD02', '11111111-1111-1111-1111-111111111111');
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

-- 3. Test Cryptographic Code Generator Sample (1,000 iterations)
DO $$
DECLARE
    i INT;
    v_code VARCHAR(6);
BEGIN
    FOR i IN 1..1000 LOOP
        v_code := public.generate_unique_league_code();
        IF length(v_code) <> 6 THEN
            RAISE EXCEPTION 'Test Failed: Generated code length is not 6.';
        END IF;
        IF v_code !~ '^[ABCDEFGHJKMNPQRSTUVWXYZ23456789]{6}$' THEN
            RAISE EXCEPTION 'Test Failed: Generated code % contains invalid characters.', v_code;
        END IF;
    END FOR;
END;
$$;

-- 4. Test Blocked vs Unblocked Manager Participation
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

-- 5. Test Code Registry State Lifecycle & Strict Transitions
DO $$
DECLARE
    v_res JSONB;
    v_code VARCHAR(6);
    v_league_id UUID;
    v_bound_at TIMESTAMPTZ;
    v_rel_at TIMESTAMPTZ;
    v_caught BOOLEAN;
BEGIN
    v_res := public.create_league_with_owner('11111111-1111-1111-1111-111111111111', 'Lifecycle League');
    v_league_id := (v_res->>'league_id')::UUID;
    v_code := v_res->>'code';

    -- Verify Bound state
    SELECT bound_at, released_at INTO v_bound_at, v_rel_at
    FROM public.league_code_registry WHERE code = v_code;

    IF v_bound_at IS NULL OR v_rel_at IS NOT NULL THEN
        RAISE EXCEPTION 'Test Failed: Initial binding state invalid for code %.', v_code;
    END IF;

    -- Code UPDATE -> Rejection
    v_caught := FALSE;
    BEGIN
        UPDATE public.league_code_registry SET code = 'XXXXXX' WHERE code = v_code;
    EXCEPTION WHEN P0001 THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: UPDATE on registry code succeeded.'; END IF;

    -- Rebind to another live league -> Rejection
    v_caught := FALSE;
    BEGIN
        UPDATE public.league_code_registry SET league_id = gen_random_uuid() WHERE code = v_code;
    EXCEPTION WHEN P0001 THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Rebinding live registry row succeeded.'; END IF;

    -- Direct DELETE -> Rejection
    v_caught := FALSE;
    BEGIN
        DELETE FROM public.league_code_registry WHERE code = v_code;
    EXCEPTION WHEN P0001 THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Direct DELETE from registry succeeded.'; END IF;
END;
$$;

-- 6. Test Controlled Lobby Deletion & Cascade
DO $$
DECLARE
    v_res JSONB;
    v_league_id UUID;
    v_code VARCHAR(6);
    v_rel_at TIMESTAMPTZ;
    v_member_count INT;
    v_caught BOOLEAN;
BEGIN
    v_res := public.create_league_with_owner('22222222-2222-2222-2222-222222222222', 'Test Delete League');
    v_league_id := (v_res->>'league_id')::UUID;
    v_code := v_res->>'code';

    -- Join Member
    PERFORM public.join_league_by_code('33333333-3333-3333-3333-333333333333', v_code);

    -- Delete lobby league via RPC function
    PERFORM public.delete_lobby_league('22222222-2222-2222-2222-222222222222', v_league_id);

    -- Verify memberships were cascaded & deleted
    SELECT COUNT(*) INTO v_member_count FROM public.league_members WHERE league_id = v_league_id;
    IF v_member_count <> 0 THEN
        RAISE EXCEPTION 'Test Failed: Memberships were not cascaded upon lobby deletion.';
    END IF;

    -- Verify registry row transitioned to Released
    SELECT released_at INTO v_rel_at FROM public.league_code_registry WHERE code = v_code;
    IF v_rel_at IS NULL THEN
        RAISE EXCEPTION 'Test Failed: Code registry released_at was not set upon lobby deletion.';
    END IF;

    -- Rebind released code -> Rejection
    v_caught := FALSE;
    BEGIN
        UPDATE public.league_code_registry SET league_id = gen_random_uuid(), bound_at = NOW(), released_at = NULL WHERE code = v_code;
    EXCEPTION WHEN P0001 THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Rebinding released code succeeded.'; END IF;
END;
$$;

-- 7. Test Settings Locking Parameters
DO $$
DECLARE
    v_res JSONB;
    v_league_id UUID;
    v_caught BOOLEAN;
BEGIN
    v_res := public.create_league_with_owner('22222222-2222-2222-2222-222222222222', 'Settings Test League');
    v_league_id := (v_res->>'league_id')::UUID;

    -- Update round_speed while LOBBY -> Success
    UPDATE public.league_settings SET round_speed = 3 WHERE league_id = v_league_id;

    -- Lock speed settings and transition to STARTING
    UPDATE public.leagues SET status = 'STARTING' WHERE id = v_league_id;

    -- Attempt to unlock speed settings -> Rejection
    v_caught := FALSE;
    BEGIN
        UPDATE public.league_settings SET is_speed_locked = FALSE WHERE league_id = v_league_id;
    EXCEPTION WHEN P0001 THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Unlocking is_speed_locked succeeded.'; END IF;

    -- Attempt to change round_speed after lock -> Rejection
    v_caught := FALSE;
    BEGIN
        UPDATE public.league_settings SET round_speed = 4 WHERE league_id = v_league_id;
    EXCEPTION WHEN P0001 THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Changing round_speed when locked succeeded.'; END IF;

    -- Attempt to change first_round_delay_minutes after lock -> Rejection
    v_caught := FALSE;
    BEGIN
        UPDATE public.league_settings SET first_round_delay_minutes = 60 WHERE league_id = v_league_id;
    EXCEPTION WHEN P0001 THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Changing delay when locked succeeded.'; END IF;
END;
$$;

-- 8. Test Status Transition & Timestamps Matrix
DO $$
DECLARE
    v_res JSONB;
    v_league_id UUID;
    v_league RECORD;
    v_caught BOOLEAN;
BEGIN
    v_res := public.create_league_with_owner('22222222-2222-2222-2222-222222222222', 'Status Matrix League');
    v_league_id := (v_res->>'league_id')::UUID;

    -- LOBBY -> ACTIVE (skipping STARTING) -> Rejection
    v_caught := FALSE;
    BEGIN
        UPDATE public.leagues SET status = 'ACTIVE' WHERE id = v_league_id;
    EXCEPTION WHEN P0001 THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Direct LOBBY -> ACTIVE succeeded.'; END IF;

    -- LOBBY -> STARTING -> Success
    UPDATE public.leagues SET status = 'STARTING' WHERE id = v_league_id;
    SELECT * INTO v_league FROM public.leagues WHERE id = v_league_id;
    IF v_league.started_at IS NULL THEN RAISE EXCEPTION 'Test Failed: started_at not set on STARTING.'; END IF;

    -- STARTING -> ACTIVE -> Success
    UPDATE public.leagues SET status = 'ACTIVE' WHERE id = v_league_id;

    -- ACTIVE -> COMPLETED -> Success
    UPDATE public.leagues SET status = 'COMPLETED' WHERE id = v_league_id;
    SELECT * INTO v_league FROM public.leagues WHERE id = v_league_id;
    IF v_league.completed_at IS NULL THEN RAISE EXCEPTION 'Test Failed: completed_at not set on COMPLETED.'; END IF;
END;
$$;

-- 9. Test RLS Status on all 5 new tables
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
