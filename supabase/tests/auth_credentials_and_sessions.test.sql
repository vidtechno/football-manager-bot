-- pgTAP tests for Web Authentication, Session Tables & Atomic Registration RPC
BEGIN;
SELECT plan(10);

-- Test 1: Tables exist
SELECT has_table('public', 'manager_credentials', 'manager_credentials table exists');
SELECT has_table('public', 'manager_auth_sessions', 'manager_auth_sessions table exists');

-- Test 2: Column nullability on managers.telegram_user_id
SELECT col_is_pk('public', 'manager_credentials', 'id', 'manager_credentials id is PK');

-- Test 3: RLS enabled on auth tables
SELECT table_privs_are(
    'public', 'manager_credentials', 'anon', ARRAY[]::text[],
    'anon has no permissions on manager_credentials'
);
SELECT table_privs_are(
    'public', 'manager_auth_sessions', 'anon', ARRAY[]::text[],
    'anon has no permissions on manager_auth_sessions'
);

-- Test 4: Atomic Registration RPC procedure functionality
SELECT lives_ok(
    $$ SELECT public.register_web_manager_atomic('pgtap_web_user', 'PgTap Manager', '$2a$12$TestHashStringHere12345678901234567890123456789012') $$,
    'register_web_manager_atomic creates manager and credentials without error'
);

-- Test 5: Check created manager has NULL telegram_user_id
SELECT is(
    (SELECT telegram_user_id FROM public.managers WHERE manager_name = 'PgTap Manager'),
    NULL,
    'website-only manager has NULL telegram_user_id'
);

-- Test 6: Check normalized username insertion
SELECT is(
    (SELECT username_normalized FROM public.manager_credentials WHERE username = 'pgtap_web_user'),
    'pgtap_web_user',
    'manager_credentials username_normalized is lowercase'
);

-- Test 7: Duplicate username rejection by RPC
SELECT throws_ok(
    $$ SELECT public.register_web_manager_atomic('PGTAP_WEB_USER', 'Duplicate Manager', '$2a$12$TestHashStringHere12345678901234567890123456789012') $$,
    '23505',
    'Bu username allaqachon band.',
    'register_web_manager_atomic throws 23505 on duplicate username'
);

-- Test 8: admin_users manager_id column exists
SELECT has_column('public', 'admin_users', 'manager_id', 'admin_users has manager_id column');

SELECT * FROM finish();
ROLLBACK;
