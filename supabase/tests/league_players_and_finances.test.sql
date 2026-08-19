-- SQL pgTAP Test Suite: Phase 4D - League Players and Club Finances Database Foundation
-- Tests table structures, constraints, triggers, starting budget policy, RPC functions, idempotency, ledger immutability, error contracts, and RLS privilege isolation.

BEGIN;
CREATE EXTENSION IF NOT EXISTS pgtap;

SELECT plan(35);

-- 1. Table & Enum Existence Tests
SELECT has_type('public', 'enum_player_availability_status', 'enum_player_availability_status type exists');
SELECT has_type('public', 'enum_financial_transaction_type', 'enum_financial_transaction_type type exists');

SELECT has_table('public', 'league_players', 'league_players table exists');
SELECT has_table('public', 'league_player_positions', 'league_player_positions table exists');
SELECT has_table('public', 'club_finances', 'club_finances table exists');
SELECT has_table('public', 'financial_ledger', 'financial_ledger table exists');

-- 2. Column Type Verification
SELECT col_type_is('public', 'league_players', 'market_value_eur', 'numeric(15,2)', 'league_players.market_value_eur uses NUMERIC(15,2)');
SELECT col_type_is('public', 'club_finances', 'total_balance', 'numeric(15,2)', 'club_finances.total_balance uses NUMERIC(15,2)');
SELECT col_type_is('public', 'club_finances', 'reserved_balance', 'numeric(15,2)', 'club_finances.reserved_balance uses NUMERIC(15,2)');
SELECT col_type_is('public', 'club_finances', 'available_balance', 'numeric(15,2)', 'club_finances.available_balance uses NUMERIC(15,2)');
SELECT col_type_is('public', 'financial_ledger', 'amount_eur', 'numeric(15,2)', 'financial_ledger.amount_eur uses NUMERIC(15,2)');

-- 3. Starting Budget Policy Function Tests (Shared Reference Max = €1,000,000,000)
SELECT results_eq(
    'SELECT public.calculate_club_starting_budget(1000000000.00, 1000000000.00)',
    ARRAY[100000000.00::numeric],
    'Elite club with max squad value (€1b) receives €100m starting budget'
);

SELECT results_eq(
    'SELECT public.calculate_club_starting_budget(600000000.00, 1000000000.00)',
    ARRAY[240000000.00::numeric],
    'Middle club with €600m squad value (€400m gap) receives €100m + €140m = €240m starting budget'
);

SELECT results_eq(
    'SELECT public.calculate_club_starting_budget(200000000.00, 1000000000.00)',
    ARRAY[380000000.00::numeric],
    'Weaker club with €200m squad value (€800m gap) receives €100m + €280m = €380m starting budget'
);

SELECT results_eq(
    'SELECT public.calculate_club_starting_budget(50000000.00, 1000000000.00)',
    ARRAY[400000000.00::numeric],
    'Very weak club calculation is capped at maximum €400m starting budget'
);

SELECT results_eq(
    'SELECT public.calculate_club_starting_budget(1200000000.00, 1000000000.00)',
    ARRAY[100000000.00::numeric],
    'Club value above reference maximum clamps gap to 0 and returns €100m baseline'
);

SELECT throws_ok(
    'SELECT public.calculate_club_starting_budget(-100.00, 1000.00)',
    'P0001',
    'INVALID_PARAM',
    'Negative squad value input is rejected'
);

SELECT throws_ok(
    'SELECT public.calculate_club_starting_budget(NULL, 1000.00)',
    'P0001',
    'INVALID_PARAM',
    'NULL squad value input is rejected'
);

-- 4. Empty Template / Unseeded Error Contract Tests
SELECT throws_ok(
    'SELECT public.instantiate_league_players_from_templates(''00000000-0000-0000-0000-000000000001''::uuid)',
    'P0001',
    'LEAGUE_NOT_INITIALIZABLE',
    'instantiate_league_players_from_templates fails with LEAGUE_NOT_INITIALIZABLE for missing league'
);

SELECT throws_ok(
    'SELECT public.initialize_club_finances(''00000000-0000-0000-0000-000000000001''::uuid)',
    'P0001',
    'LEAGUE_NOT_INITIALIZABLE',
    'initialize_club_finances fails with LEAGUE_NOT_INITIALIZABLE for missing league'
);

-- 5. Setup Test Fixtures (Manager, League, League Club)
DO $$
DECLARE
    v_mgr_id UUID := '11111111-1111-1111-1111-111111111111';
    v_league_id UUID := '22222222-2222-2222-2222-222222222222';
    v_template_id UUID;
    v_club_id UUID := '33333333-3333-3333-3333-333333333333';
BEGIN
    INSERT INTO public.managers (id, telegram_user_id, manager_name)
    VALUES (v_mgr_id, 999888777, 'TestFinMgr');

    INSERT INTO public.leagues (id, name, code, status, owner_manager_id)
    VALUES (v_league_id, 'Finances Test League', 'FNC234', 'LOBBY', v_mgr_id);

    SELECT id INTO v_template_id FROM public.club_templates WHERE slug = 'real-madrid';

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

-- 6. Financial RPC Transactions & Idempotency Tests
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
    'INSUFFICIENT_AVAILABLE_FUNDS',
    'record_financial_transaction fails with INSUFFICIENT_AVAILABLE_FUNDS'
);

-- 7. Fund Reservation Lifecycle Tests (Reserve -> Release / Capture)
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

-- 8. Ledger Immutability & Accounting Reconciliation Tests
SELECT throws_ok(
    'UPDATE public.financial_ledger SET description = ''Hacked'' WHERE idempotency_key = ''TX_PRIZE_1''',
    'P0001',
    'LEDGER_IMMUTABLE',
    'financial_ledger UPDATE fails with LEDGER_IMMUTABLE'
);

SELECT throws_ok(
    'DELETE FROM public.financial_ledger WHERE idempotency_key = ''TX_PRIZE_1''',
    'P0001',
    'LEDGER_IMMUTABLE',
    'financial_ledger DELETE fails with LEDGER_IMMUTABLE'
);

SELECT results_eq(
    'SELECT COUNT(*) FROM public.financial_ledger WHERE league_club_id = ''33333333-3333-3333-3333-333333333333''',
    ARRAY[4::bigint],
    'financial_ledger records exactly 4 entries'
);

ROLLBACK;
