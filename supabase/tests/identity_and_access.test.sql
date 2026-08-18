-- SQL Test Suite: Identity & Access Domain Schema Validation
-- All tests run inside a transaction and ROLLBACK at the end.

BEGIN;

-- 1. Test managers.telegram_user_id uniqueness & positive constraint
INSERT INTO public.managers (telegram_user_id, manager_name)
VALUES (100001, 'TestManager1');

-- Expect failure on duplicate telegram_user_id
DO $$
DECLARE
    v_caught BOOLEAN := FALSE;
BEGIN
    BEGIN
        INSERT INTO public.managers (telegram_user_id, manager_name)
        VALUES (100001, 'TestManager2');
    EXCEPTION WHEN unique_violation THEN
        v_caught := TRUE;
    END;

    IF NOT v_caught THEN
        RAISE EXCEPTION 'Test Failed: Duplicate telegram_user_id was unexpectedly allowed.';
    END IF;
END;
$$;

-- Expect failure on non-positive telegram_user_id
DO $$
DECLARE
    v_caught BOOLEAN := FALSE;
BEGIN
    BEGIN
        INSERT INTO public.managers (telegram_user_id, manager_name)
        VALUES (-5, 'TestManagerInvalid');
    EXCEPTION WHEN check_violation THEN
        v_caught := TRUE;
    END;

    IF NOT v_caught THEN
        RAISE EXCEPTION 'Test Failed: Non-positive telegram_user_id was unexpectedly allowed.';
    END IF;
END;
$$;

-- 2. Test manager_name length constraint (3 to 24 chars)
DO $$
DECLARE
    v_caught BOOLEAN := FALSE;
BEGIN
    BEGIN
        INSERT INTO public.managers (telegram_user_id, manager_name)
        VALUES (100002, 'AB');
    EXCEPTION WHEN check_violation THEN
        v_caught := TRUE;
    END;

    IF NOT v_caught THEN
        RAISE EXCEPTION 'Test Failed: Short manager_name (<3 chars) was unexpectedly allowed.';
    END IF;
END;
$$;

-- 3. Test manager_profiles one-to-one relationship & non-negative counters
DO $$
DECLARE
    m_id UUID;
    v_caught_dup BOOLEAN := FALSE;
    v_caught_rep BOOLEAN := FALSE;
BEGIN
    SELECT id INTO m_id FROM public.managers WHERE telegram_user_id = 100001;
    
    INSERT INTO public.manager_profiles (manager_id, display_name)
    VALUES (m_id, 'TestManager1');

    -- Expect failure on duplicate manager_id in profile
    BEGIN
        INSERT INTO public.manager_profiles (manager_id, display_name)
        VALUES (m_id, 'DuplicateProfile');
    EXCEPTION WHEN unique_violation THEN
        v_caught_dup := TRUE;
    END;

    IF NOT v_caught_dup THEN
        RAISE EXCEPTION 'Test Failed: Duplicate manager_id in manager_profiles was unexpectedly allowed.';
    END IF;

    -- Expect failure on negative reputation_score
    BEGIN
        INSERT INTO public.manager_profiles (manager_id, display_name, reputation_score)
        VALUES (gen_random_uuid(), 'InvalidRep', -50);
    EXCEPTION WHEN foreign_key_violation OR check_violation THEN
        v_caught_rep := TRUE;
    END;

    IF NOT v_caught_rep THEN
        RAISE EXCEPTION 'Test Failed: Negative reputation_score was unexpectedly allowed.';
    END IF;
END;
$$;

-- 4. Test manager_blocks: one active block per manager & unblock timestamp check
DO $$
DECLARE
    m_id UUID;
    v_caught_dup BOOLEAN := FALSE;
    v_caught_ts BOOLEAN := FALSE;
BEGIN
    SELECT id INTO m_id FROM public.managers WHERE telegram_user_id = 100001;

    INSERT INTO public.manager_blocks (manager_id, reason)
    VALUES (m_id, 'First Active Block');

    -- Expect failure when inserting a second active block for the same manager
    BEGIN
        INSERT INTO public.manager_blocks (manager_id, reason)
        VALUES (m_id, 'Second Active Block');
    EXCEPTION WHEN unique_violation THEN
        v_caught_dup := TRUE;
    END;

    IF NOT v_caught_dup THEN
        RAISE EXCEPTION 'Test Failed: Multiple active blocks for one manager were unexpectedly allowed.';
    END IF;

    -- Expect failure when unblocked_at is before blocked_at
    BEGIN
        INSERT INTO public.manager_blocks (manager_id, reason, blocked_at, unblocked_at)
        VALUES (m_id, 'Invalid Timestamps', NOW(), NOW() - INTERVAL '1 hour');
    EXCEPTION WHEN check_violation OR unique_violation THEN
        v_caught_ts := TRUE;
    END;

    IF NOT v_caught_ts THEN
        RAISE EXCEPTION 'Test Failed: unblocked_at earlier than blocked_at was unexpectedly allowed.';
    END IF;
END;
$$;

-- 5. Test admin_audit_logs append-only protection (UPDATE & DELETE rejection)
DO $$
DECLARE
    log_id UUID;
    v_caught_upd BOOLEAN := FALSE;
    v_caught_del BOOLEAN := FALSE;
BEGIN
    INSERT INTO public.admin_audit_logs (action_category, action_name, target_type, reason)
    VALUES ('SECURITY', 'TEST_ACTION', 'MANAGER', 'Test Audit Entry')
    RETURNING id INTO log_id;

    -- Expect failure on UPDATE
    BEGIN
        UPDATE public.admin_audit_logs SET reason = 'Modified Reason' WHERE id = log_id;
    EXCEPTION WHEN P0001 THEN
        v_caught_upd := TRUE;
    END;

    IF NOT v_caught_upd THEN
        RAISE EXCEPTION 'Test Failed: UPDATE on admin_audit_logs was unexpectedly allowed.';
    END IF;

    -- Expect failure on DELETE
    BEGIN
        DELETE FROM public.admin_audit_logs WHERE id = log_id;
    EXCEPTION WHEN P0001 THEN
        v_caught_del := TRUE;
    END;

    IF NOT v_caught_del THEN
        RAISE EXCEPTION 'Test Failed: DELETE on admin_audit_logs was unexpectedly allowed.';
    END IF;
END;
$$;

-- 6. Test RLS status on all five tables
DO $$
DECLARE
    rls_count INT;
BEGIN
    SELECT COUNT(*) INTO rls_count
    FROM pg_class c
    JOIN pg_namespace n ON n.oid = c.relnamespace
    WHERE n.nspname = 'public'
      AND c.relname IN ('managers', 'manager_profiles', 'admin_users', 'manager_blocks', 'admin_audit_logs')
      AND c.relrowsecurity = TRUE;

    IF rls_count <> 5 THEN
        RAISE EXCEPTION 'Test Failed: Not all 5 tables have RLS enabled (found %).', rls_count;
    END IF;
END;
$$;

ROLLBACK;
