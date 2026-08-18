-- SQL Test Suite: Leagues and Membership Foundation Schema Validation
-- All tests run inside a transaction and ROLLBACK at the end.

BEGIN;

-- Setup Test Managers
INSERT INTO public.managers (id, telegram_user_id, manager_name)
VALUES 
  ('11111111-1111-1111-1111-111111111111', 200001, 'TestOwner1'),
  ('22222222-2222-2222-2222-222222222222', 200002, 'TestMember1'),
  ('33333333-3333-3333-3333-333333333333', 200003, 'TestMember2');

-- 1. Test Code Generation & Format Constraints
DO $$
DECLARE
    v_code VARCHAR(6);
BEGIN
    v_code := public.generate_unique_league_code();
    IF v_code !~ '^[A-HJ-NP-Z2-9]{6}$' THEN
        RAISE EXCEPTION 'Test Failed: Generated code % contains invalid characters.', v_code;
    END IF;
END;
$$;

-- Test code format check rejection (e.g., containing 'O' or '0')
DO $$
BEGIN
    BEGIN
        INSERT INTO public.leagues (name, code, owner_manager_id)
        VALUES ('Invalid Code League', 'ABCDEO', '11111111-1111-1111-1111-111111111111');
        RAISE EXCEPTION 'Test Failed: Invalid code containing O was allowed.';
    EXCEPTION WHEN check_violation THEN
        -- Expected
    END;
END;
$$;

-- 2. Test create_league_with_owner function
DO $$
DECLARE
    v_res JSONB;
    v_league_id UUID;
    v_owner_count INT;
BEGIN
    v_res := public.create_league_with_owner(
        '11111111-1111-1111-1111-111111111111',
        'Super League 1',
        2
    );

    v_league_id := (v_res->>'league_id')::UUID;

    -- Verify owner membership created
    SELECT COUNT(*) INTO v_owner_count
    FROM public.league_members
    WHERE league_id = v_league_id AND manager_id = '11111111-1111-1111-1111-111111111111' AND role = 'OWNER';

    IF v_owner_count <> 1 THEN
        RAISE EXCEPTION 'Test Failed: Owner membership was not created automatically.';
    END IF;
END;
$$;

-- 3. Test 2 Active Leagues Limit
DO $$
DECLARE
    v_res2 JSONB;
BEGIN
    -- Create second league for same owner
    v_res2 := public.create_league_with_owner(
        '11111111-1111-1111-1111-111111111111',
        'Super League 2',
        1
    );

    -- Attempt to create a 3rd active league -> Must Fail
    BEGIN
        PERFORM public.create_league_with_owner(
            '11111111-1111-1111-1111-111111111111',
            'Super League 3',
            1
        );
        RAISE EXCEPTION 'Test Failed: Creating 3rd active league was allowed for one manager.';
    EXCEPTION WHEN raise_exception THEN
        -- Expected behavior
    END;
END;
$$;

-- 4. Test Code Registry Immutability (UPDATE code and DELETE rejection)
DO $$
DECLARE
    v_reg_code VARCHAR(6);
BEGIN
    SELECT code INTO v_reg_code FROM public.league_code_registry LIMIT 1;

    -- Expect failure on UPDATE code
    BEGIN
        UPDATE public.league_code_registry SET code = 'XXXXXX' WHERE code = v_reg_code;
        RAISE EXCEPTION 'Test Failed: UPDATE on league_code_registry.code was allowed.';
    EXCEPTION WHEN raise_exception THEN
        -- Expected
    END;

    -- Expect failure on DELETE from registry
    BEGIN
        DELETE FROM public.league_code_registry WHERE code = v_reg_code;
        RAISE EXCEPTION 'Test Failed: DELETE from league_code_registry was allowed.';
    EXCEPTION WHEN raise_exception THEN
        -- Expected
    END;
END;
$$;

-- 5. Test Round Speed Constraints & Status Transition Protection
DO $$
DECLARE
    v_league_id UUID;
BEGIN
    SELECT id INTO v_league_id FROM public.leagues LIMIT 1;

    -- Invalid round speed (>4) -> Must Fail
    BEGIN
        UPDATE public.league_settings SET round_speed = 5 WHERE league_id = v_league_id;
        RAISE EXCEPTION 'Test Failed: round_speed > 4 was allowed.';
    EXCEPTION WHEN check_violation THEN
        -- Expected
    END;

    -- Transition LOBBY -> ACTIVE (skipping STARTING) -> Must Fail
    BEGIN
        UPDATE public.leagues SET status = 'ACTIVE' WHERE id = v_league_id;
        RAISE EXCEPTION 'Test Failed: Direct LOBBY -> ACTIVE status transition was allowed.';
    EXCEPTION WHEN raise_exception THEN
        -- Expected
    END;

    -- Valid Transition LOBBY -> STARTING -> Should succeed and lock speed
    UPDATE public.leagues SET status = 'STARTING' WHERE id = v_league_id;

    -- Changing round_speed after LOBBY -> Must Fail
    BEGIN
        UPDATE public.league_settings SET round_speed = 3 WHERE league_id = v_league_id;
        RAISE EXCEPTION 'Test Failed: Changing round_speed after LOBBY was allowed.';
    EXCEPTION WHEN raise_exception THEN
        -- Expected
    END;
END;
$$;

-- 6. Test Active League Deletion Guard
DO $$
DECLARE
    v_active_league_id UUID;
BEGIN
    SELECT id INTO v_active_league_id FROM public.leagues WHERE status = 'STARTING' LIMIT 1;

    BEGIN
        DELETE FROM public.leagues WHERE id = v_active_league_id;
        RAISE EXCEPTION 'Test Failed: Direct DELETE of STARTING league was allowed.';
    EXCEPTION WHEN raise_exception THEN
        -- Expected
    END;
END;
$$;

-- 7. Test RLS Status on all 5 new tables
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
