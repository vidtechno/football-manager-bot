-- SQL pgTAP Test Suite: Phase 4D - League Players and Club Finances Database Foundation
-- Tests table structures, constraints, triggers, starting budget policy, RPC functions, idempotency, ledger immutability, and RLS privilege isolation.

BEGIN;

SELECT plan(38);

-- 1. Table & Enum Existence Tests
SELECT has_enum('public', 'enum_player_availability_status', ARRAY['AVAILABLE', 'INJURED', 'SUSPENDED'], 'enum_player_availability_status exists');
SELECT has_enum('public', 'enum_financial_transaction_type', ARRAY['STARTING_BUDGET', 'TRANSFER_PURCHASE', 'TRANSFER_SALE', 'TRANSFER_RESERVE', 'TRANSFER_RESERVE_RELEASE', 'TRANSFER_RESERVE_CAPTURE', 'ADMIN_ADJUSTMENT', 'FEE', 'PRIZE', 'COMPENSATION'], 'enum_financial_transaction_type exists');

SELECT has_table('public', 'league_players', 'league_players table exists');
SELECT has_table('public', 'league_player_positions', 'league_player_positions table exists');
SELECT has_table('public', 'club_finances', 'club_finances table exists');
SELECT has_table('public', 'financial_ledger', 'financial_ledger table exists');

-- 2. RLS Status Tests
SELECT acls_are('public', 'league_players', 'service_role', ARRAY['SELECT', 'INSERT', 'UPDATE', 'DELETE'], 'league_players restricted to service_role');
SELECT acls_are('public', 'league_player_positions', 'service_role', ARRAY['SELECT', 'INSERT', 'UPDATE', 'DELETE'], 'league_player_positions restricted to service_role');
SELECT acls_are('public', 'club_finances', 'service_role', ARRAY['SELECT', 'INSERT', 'UPDATE', 'DELETE'], 'club_finances restricted to service_role');
SELECT acls_are('public', 'financial_ledger', 'service_role', ARRAY['SELECT', 'INSERT'], 'financial_ledger restricted to service_role (append-only)');

-- 3. Column Type Verification
SELECT col_type_is('public', 'league_players', 'market_value_eur', 'numeric(15,2)', 'league_players.market_value_eur uses NUMERIC(15,2)');
SELECT col_type_is('public', 'club_finances', 'total_balance', 'numeric(15,2)', 'club_finances.total_balance uses NUMERIC(15,2)');
SELECT col_type_is('public', 'club_finances', 'reserved_balance', 'numeric(15,2)', 'club_finances.reserved_balance uses NUMERIC(15,2)');
SELECT col_type_is('public', 'club_finances', 'available_balance', 'numeric(15,2)', 'club_finances.available_balance uses NUMERIC(15,2)');
SELECT col_is_generated('public', 'club_finances', 'available_balance', 'club_finances.available_balance is generated stored column');
SELECT col_type_is('public', 'financial_ledger', 'amount_eur', 'numeric(15,2)', 'financial_ledger.amount_eur uses NUMERIC(15,2)');

-- 4. Starting Budget Policy Function Tests
SELECT results_eq(
    'SELECT public.calculate_club_starting_budget(500000000.00, 500000000.00)',
    ARRAY[100000000.00::numeric],
    'Elite club with max squad value receives €100m starting budget'
);

SELECT results_eq(
    'SELECT public.calculate_club_starting_budget(300000000.00, 500000000.00)',
    ARRAY[170000000.00::numeric],
    'Middle club with €200m gap receives €100m + €70m = €170m starting budget'
);

SELECT results_eq(
    'SELECT public.calculate_club_starting_budget(50000000.00, 1000000000.00)',
    ARRAY[400000000.00::numeric],
    'Weaker club calculation is capped at maximum €400m starting budget'
);

-- 5. Empty Template / Unseeded Fixture Safety Tests
SELECT throws_ok(
    'SELECT public.instantiate_league_players_from_templates(''00000000-0000-0000-0000-000000000001''::uuid)',
    'P0001',
    'Liga topilmadi.',
    'instantiate_league_players_from_templates rejects non-existent league'
);

SELECT throws_ok(
    'SELECT public.initialize_club_finances(''00000000-0000-0000-0000-000000000001''::uuid)',
    'P0001',
    'Liga topilmadi.',
    'initialize_club_finances rejects non-existent league'
);

-- 6. Setup Test Fixtures (Manager, League, League Club)
DO $$
DECLARE
    v_mgr_id UUID := '11111111-1111-1111-1111-111111111111';
    v_league_id UUID := '22222222-2222-2222-2222-222222222222';
    v_template_id UUID;
    v_club_id UUID := '33333333-3333-3333-3333-333333333333';
BEGIN
    -- Create test manager
    INSERT INTO public.managers (id, telegram_id, username)
    VALUES (v_mgr_id, 999888777, 'test_fin_mgr');

    -- Create test league
    INSERT INTO public.leagues (id, name, code, status, owner_manager_id)
    VALUES (v_league_id, 'Finances Test League', 'FIN123', 'LOBBY', v_mgr_id);

    -- Get a real club template
    SELECT id INTO v_template_id FROM public.club_templates WHERE slug = 'real-madrid';

    -- Create test league club
    INSERT INTO public.league_clubs (id, league_id, club_template_id, display_name, short_code)
    VALUES (v_club_id, v_league_id, v_template_id, 'Real Madrid FT', 'RMA');
END;
$$;

-- Test Club Finances Manual Setup & Checks
DO $$
DECLARE
    v_league_id UUID := '22222222-2222-2222-2222-222222222222';
    v_club_id UUID := '33333333-3333-3333-3333-333333333333';
BEGIN
    INSERT INTO public.club_finances (league_id, league_club_id, total_balance, reserved_balance)
    VALUES (v_league_id, v_club_id, 100000000.00, 0.00);
END;
$$;

SELECT results_eq(
    'SELECT total_balance, reserved_balance, available_balance FROM public.club_finances WHERE league_club_id = ''33333333-3333-3333-3333-333333333333''',
    'VALUES (100000000.00::numeric, 0.00::numeric, 100000000.00::numeric)',
    'club_finances initializes correctly with total 100m and available 100m'
);

-- 7. Financial RPC Transactions & Idempotency Tests
SELECT lives_ok(
    'SELECT public.record_financial_transaction(''33333333-3333-3333-3333-333333333333''::uuid, ''22222222-2222-2222-2222-222222222222''::uuid, 20000000.00, ''PRIZE''::public.enum_financial_transaction_type, ''TX_PRIZE_1'', NULL, NULL, ''Prize money'')',
    'record_financial_transaction processes credit transaction successfully'
);

SELECT results_eq(
    'SELECT total_balance, available_balance FROM public.club_finances WHERE league_club_id = ''33333333-3333-3333-3333-333333333333''',
    'VALUES (120000000.00::numeric, 120000000.00::numeric)',
    'total_balance and available_balance updated to 120m'
);

-- Idempotency Test: Repeat same idempotency key
SELECT lives_ok(
    'SELECT public.record_financial_transaction(''33333333-3333-3333-3333-333333333333''::uuid, ''22222222-2222-2222-2222-222222222222''::uuid, 20000000.00, ''PRIZE''::public.enum_financial_transaction_type, ''TX_PRIZE_1'', NULL, NULL, ''Prize money'')',
    'record_financial_transaction handles idempotency key gracefully'
);

SELECT results_eq(
    'SELECT total_balance FROM public.club_finances WHERE league_club_id = ''33333333-3333-3333-3333-333333333333''',
    'VALUES (120000000.00::numeric)',
    'total_balance remains 120m after duplicate idempotency key'
);

-- Insufficient Funds Test
SELECT throws_ok(
    'SELECT public.record_financial_transaction(''33333333-3333-3333-3333-333333333333''::uuid, ''22222222-2222-2222-2222-222222222222''::uuid, -200000000.00, ''FEE''::public.enum_financial_transaction_type, ''TX_OVERDRAW_1'', NULL, NULL, ''Excessive fee'')',
    'P0001',
    'Klubda tranzaksiya uchun mavjud mablag'' yetarli emas.',
    'record_financial_transaction rejects debit exceeding available balance'
);

-- 8. Fund Reservation Lifecycle Tests (Reserve -> Release / Capture)
SELECT lives_ok(
    'SELECT public.reserve_club_funds(''33333333-3333-3333-3333-333333333333''::uuid, ''22222222-2222-2222-2222-222222222222''::uuid, 30000000.00, ''RES_OFFER_1'', NULL, NULL, ''Transfer offer reserve'')',
    'reserve_club_funds reserves 30m'
);

SELECT results_eq(
    'SELECT total_balance, reserved_balance, available_balance FROM public.club_finances WHERE league_club_id = ''33333333-3333-3333-3333-333333333333''',
    'VALUES (120000000.00::numeric, 30000000.00::numeric, 90000000.00::numeric)',
    'total_balance is 120m, reserved is 30m, available is 90m'
);

SELECT lives_ok(
    'SELECT public.release_club_reserved_funds(''33333333-3333-3333-3333-333333333333''::uuid, ''22222222-2222-2222-2222-222222222222''::uuid, 10000000.00, ''REL_OFFER_1'', NULL, NULL, ''Partial release'')',
    'release_club_reserved_funds releases 10m'
);

SELECT results_eq(
    'SELECT total_balance, reserved_balance, available_balance FROM public.club_finances WHERE league_club_id = ''33333333-3333-3333-3333-333333333333''',
    'VALUES (120000000.00::numeric, 20000000.00::numeric, 100000000.00::numeric)',
    'total_balance is 120m, reserved is 20m, available is 100m'
);

SELECT lives_ok(
    'SELECT public.capture_club_reserved_funds(''33333333-3333-3333-3333-333333333333''::uuid, ''22222222-2222-2222-2222-222222222222''::uuid, 20000000.00, ''CAP_OFFER_1'', NULL, NULL, ''Transfer purchase capture'')',
    'capture_club_reserved_funds captures 20m'
);

SELECT results_eq(
    'SELECT total_balance, reserved_balance, available_balance FROM public.club_finances WHERE league_club_id = ''33333333-3333-3333-3333-333333333333''',
    'VALUES (100000000.00::numeric, 0.00::numeric, 100000000.00::numeric)',
    'total_balance is 100m, reserved is 0m, available is 100m'
);

-- 9. Ledger Immutability Tests
SELECT throws_ok(
    'UPDATE public.financial_ledger SET description = ''Hacked'' WHERE idempotency_key = ''TX_PRIZE_1''',
    'P0001',
    'Moliyaviy tranzaksiyalar jurnalini o''zgartirish taqiqlangan.',
    'financial_ledger UPDATE is blocked by trigger'
);

SELECT throws_ok(
    'DELETE FROM public.financial_ledger WHERE idempotency_key = ''TX_PRIZE_1''',
    'P0001',
    'Moliyaviy tranzaksiyalar jurnalini o''chirish taqiqlangan.',
    'financial_ledger DELETE is blocked by trigger'
);

-- 10. Ledger Balance Reconciliation Test
SELECT results_eq(
    'SELECT COUNT(*) FROM public.financial_ledger WHERE league_club_id = ''33333333-3333-3333-3333-333333333333''',
    ARRAY[4::bigint],
    'financial_ledger records exactly 4 entries'
);

SELECT ROLLBACK();
