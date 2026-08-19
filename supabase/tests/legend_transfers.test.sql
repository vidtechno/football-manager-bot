-- SQL Test Suite: Phase 4F Legend Transfers and Squad Limit Expansion (18-30)
-- All tests run inside a transaction and ROLLBACK at the end. Compatible with pgTAP / pg_prove.

BEGIN;
CREATE EXTENSION IF NOT EXISTS pgtap;
SELECT plan(10);

-- 1. Test Enum Types Exist
SELECT has_type('enum_legend_market_status', 'enum_legend_market_status exists');

-- 2. Test Tables Exist
SELECT has_table('legend_templates', 'legend_templates table exists');
SELECT has_table('league_legend_market', 'league_legend_market table exists');

-- 3. Test Function Existence
SELECT has_function('instantiate_league_players', ARRAY['uuid'], 'instantiate_league_players RPC function exists');
SELECT has_function('instantiate_league_legend_market', ARRAY['uuid'], 'instantiate_league_legend_market RPC function exists');
SELECT has_function('purchase_league_legend', ARRAY['uuid', 'uuid', 'uuid'], 'purchase_league_legend RPC function exists');

-- 4. Execute Transactional Behavior Verification
DO $$
DECLARE
    v_admin_id UUID;
    v_user_id UUID;
    v_other_user_id UUID;
    v_league_id UUID;
    v_club_template_id UUID;
    v_league_club_id UUID;
    v_legend_template_id UUID;
    v_market_id UUID;
    v_purchase_result JSONB;
    v_finance_balance NUMERIC;
    v_caught BOOLEAN := FALSE;
BEGIN
    -- Setup dummy admin and user
    INSERT INTO public.admin_users (telegram_user_id, role)
    VALUES (9990001, 'SUPER_ADMIN')
    RETURNING id INTO v_admin_id;

    INSERT INTO public.managers (telegram_user_id, manager_name)
    VALUES (8880001, 'legend_buyer')
    RETURNING id INTO v_user_id;

    INSERT INTO public.managers (telegram_user_id, manager_name)
    VALUES (8880002, 'other_user')
    RETURNING id INTO v_other_user_id;

    -- Setup dummy league
    INSERT INTO public.leagues (name, code, owner_manager_id)
    VALUES ('Legend Test League', 'MEG222', v_user_id)
    RETURNING id INTO v_league_id;

    INSERT INTO public.league_members (league_id, manager_id, role)
    VALUES (v_league_id, v_user_id, 'OWNER');

    -- Get a club template
    SELECT id INTO v_club_template_id FROM public.club_templates LIMIT 1;
    IF v_club_template_id IS NULL THEN
        INSERT INTO public.club_templates (slug, name, short_code, country)
        VALUES ('legend-fc', 'Legend FC', 'LFC', 'England')
        RETURNING id INTO v_club_template_id;
    END IF;

    -- Insert league club owned by v_user_id
    INSERT INTO public.league_clubs (league_id, club_template_id, display_name, short_code, human_manager_id)
    VALUES (v_league_id, v_club_template_id, 'Legend Club', 'LGC', v_user_id)
    RETURNING id INTO v_league_club_id;

    -- Setup club finances (€100,000,000)
    INSERT INTO public.club_finances (league_id, league_club_id, total_balance, reserved_balance)
    VALUES (v_league_id, v_league_club_id, 100000000.00, 0.00);

    -- Get or insert legend template
    SELECT id INTO v_legend_template_id
    FROM public.legend_templates
    WHERE slug = 'leg-cristiano-ronaldo-prime';

    IF v_legend_template_id IS NULL THEN
        INSERT INTO public.legend_templates (
            slug,
            canonical_key,
            full_name,
            nationality,
            date_of_birth,
            primary_position,
            secondary_positions,
            peak_club,
            peak_period,
            overall_rating,
            default_price_eur,
            is_retired,
            source_id,
            outfield_attributes
        ) VALUES (
            'dummy-legend-test-slug',
            'dummy-legend-test-key',
            'Cristiano Ronaldo',
            'Portugal',
            '1985-02-05',
            'LW',
            ARRAY['ST'::public.enum_player_position],
            'Real Madrid',
            '2011-2014',
            94,
            50000000.00,
            FALSE,
            'src-legend-test',
            '{"pace": 93, "shooting": 93, "passing": 82, "dribbling": 91, "defending": 33, "physical": 80}'::jsonb
        ) RETURNING id INTO v_legend_template_id;
    END IF;

    -- Instantiate legend market for the league
    PERFORM public.instantiate_league_legend_market(v_league_id);

    SELECT id INTO v_market_id
    FROM public.league_legend_market
    WHERE league_id = v_league_id AND legend_template_id = v_legend_template_id;

    IF v_market_id IS NULL THEN
        RAISE EXCEPTION 'Test Failed: Legend market record was not created.';
    END IF;

    -- Test 4A: Reject purchase by unauthorized user
    BEGIN
        PERFORM public.purchase_league_legend(v_market_id, v_league_club_id, v_other_user_id);
    EXCEPTION WHEN OTHERS THEN
        v_caught := TRUE;
    END;
    IF NOT v_caught THEN
        RAISE EXCEPTION 'Test Failed: Unauthorized user was able to purchase legend.';
    END IF;

    -- Test 4B: Successful purchase by legitimate owner
    v_purchase_result := public.purchase_league_legend(v_market_id, v_league_club_id, v_user_id);
    IF (v_purchase_result->>'success')::boolean IS NOT TRUE THEN
        RAISE EXCEPTION 'Test Failed: Legend purchase failed unexpectedly.';
    END IF;

    -- Verify updated balance (€100,000,000 - €50,000,000 = €50,000,000)
    SELECT total_balance INTO v_finance_balance
    FROM public.club_finances
    WHERE league_club_id = v_league_club_id;

    IF v_finance_balance <> 50000000.00 THEN
        RAISE EXCEPTION 'Test Failed: Balance not deducted properly, found %', v_finance_balance;
    END IF;

    -- Test 4C: Reject duplicate purchase of already OWNED legend
    v_caught := FALSE;
    BEGIN
        PERFORM public.purchase_league_legend(v_market_id, v_league_club_id, v_user_id);
    EXCEPTION WHEN OTHERS THEN
        v_caught := TRUE;
    END;
    IF NOT v_caught THEN
        RAISE EXCEPTION 'Test Failed: Duplicate purchase of owned legend was permitted.';
    END IF;

    RAISE NOTICE 'Legend Transfers database verification completed successfully.';
END;
$$;

SELECT pass('Legend Transfers table structures created and validated.');
SELECT pass('instantiate_league_legend_market RPC works transactionally.');
SELECT pass('purchase_league_legend RPC deducts balance and prevents duplicate purchase.');
SELECT pass('Phase 4F Legend Transfers pgTAP test suite completed successfully.');

ROLLBACK;
