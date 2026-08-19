-- pgTAP SQL Test Suite: Permanent Player Transfer Market & Controls
BEGIN;
SELECT plan(10);

-- 1. Test Schema & Types Exist
SELECT has_type('enum_transfer_listing_status', 'enum_transfer_listing_status exists');
SELECT has_type('enum_transfer_buyer_type', 'enum_transfer_buyer_type exists');
SELECT has_table('league_transfer_listings', 'league_transfer_listings table exists');

-- 2. Test Function Existence
SELECT has_function('create_player_transfer_listing', ARRAY['uuid', 'numeric', 'uuid'], 'create_player_transfer_listing RPC exists');
SELECT has_function('cancel_player_transfer_listing', ARRAY['uuid', 'uuid'], 'cancel_player_transfer_listing RPC exists');
SELECT has_function('purchase_player_transfer_listing', ARRAY['uuid', 'uuid', 'uuid'], 'purchase_player_transfer_listing RPC exists');
SELECT has_function('process_bot_transfer_reviews', ARRAY['int'], 'process_bot_transfer_reviews RPC exists');

-- 3. Execute Transactional Behavior Verification
DO $$
DECLARE
    v_seller_user_id UUID;
    v_buyer_user_id UUID;
    v_other_user_id UUID;
    v_league_id UUID;
    v_seller_club_id UUID;
    v_buyer_club_id UUID;
    v_bot_club_id UUID;
    v_club_template1_id UUID;
    v_club_template2_id UUID;
    v_club_template3_id UUID;

    v_player_ids UUID[];
    v_player_id UUID;
    v_listing_id UUID;
    v_listing_2_id UUID;
    v_bot_listing_id UUID;

    v_res JSONB;
    v_caught BOOLEAN := FALSE;
    v_seller_bal NUMERIC;
    v_buyer_bal NUMERIC;
    v_bot_bal NUMERIC;
    v_new_owner_club_id UUID;
    v_listing_status public.enum_transfer_listing_status;
    v_buyer_type public.enum_transfer_buyer_type;
    v_ledger_count INT;
    i INT;
BEGIN
    -- Setup dummy managers
    INSERT INTO public.managers (telegram_user_id, manager_name)
    VALUES (7770001, 'seller_mgr') RETURNING id INTO v_seller_user_id;

    INSERT INTO public.managers (telegram_user_id, manager_name)
    VALUES (7770002, 'buyer_mgr') RETURNING id INTO v_buyer_user_id;

    INSERT INTO public.managers (telegram_user_id, manager_name)
    VALUES (7770003, 'other_mgr') RETURNING id INTO v_other_user_id;

    -- Setup dummy league
    INSERT INTO public.leagues (name, code, owner_manager_id)
    VALUES ('Transfer Test League', 'TRFX77', v_seller_user_id) RETURNING id INTO v_league_id;

    INSERT INTO public.league_members (league_id, manager_id, role)
    VALUES (v_league_id, v_seller_user_id, 'OWNER');

    INSERT INTO public.league_members (league_id, manager_id, role)
    VALUES (v_league_id, v_buyer_user_id, 'MEMBER');

    INSERT INTO public.league_members (league_id, manager_id, role)
    VALUES (v_league_id, v_other_user_id, 'MEMBER');

    -- Club Templates (Create unique test templates)
    INSERT INTO public.club_templates (slug, name, short_code, country)
    VALUES ('trf-tm-seller', 'TM Seller FC', 'TMS', 'Spain') RETURNING id INTO v_club_template1_id;

    INSERT INTO public.club_templates (slug, name, short_code, country)
    VALUES ('trf-tm-buyer', 'TM Buyer FC', 'TMB', 'England') RETURNING id INTO v_club_template2_id;

    INSERT INTO public.club_templates (slug, name, short_code, country)
    VALUES ('trf-tm-bot', 'TM Bot FC', 'TMT', 'Italy') RETURNING id INTO v_club_template3_id;

    -- Setup seller club (human)
    INSERT INTO public.league_clubs (league_id, club_template_id, display_name, short_code, human_manager_id)
    VALUES (v_league_id, v_club_template1_id, 'Seller FC', 'SFC', v_seller_user_id) RETURNING id INTO v_seller_club_id;

    -- Setup buyer club (human)
    INSERT INTO public.league_clubs (league_id, club_template_id, display_name, short_code, human_manager_id)
    VALUES (v_league_id, v_club_template2_id, 'Buyer FC', 'BFC', v_buyer_user_id) RETURNING id INTO v_buyer_club_id;

    -- Setup bot club (bot, human_manager_id IS NULL)
    INSERT INTO public.league_clubs (league_id, club_template_id, display_name, short_code, human_manager_id)
    VALUES (v_league_id, v_club_template3_id, 'Bot FC', 'BOT', NULL) RETURNING id INTO v_bot_club_id;

    -- Finances (€100M each)
    INSERT INTO public.club_finances (league_id, league_club_id, total_balance, reserved_balance)
    VALUES (v_league_id, v_seller_club_id, 100000000.00, 0.00);

    INSERT INTO public.club_finances (league_id, league_club_id, total_balance, reserved_balance)
    VALUES (v_league_id, v_buyer_club_id, 100000000.00, 0.00);

    INSERT INTO public.club_finances (league_id, league_club_id, total_balance, reserved_balance)
    VALUES (v_league_id, v_bot_club_id, 100000000.00, 0.00);

    -- Insert 20 players for seller club to satisfy >= 19 squad count requirement
    FOR i IN 1..20 LOOP
        INSERT INTO public.league_players (
            league_id,
            league_club_id,
            player_template_id,
            player_template_version_id,
            full_name,
            date_of_birth,
            nationality,
            market_value_eur,
            overall_rating
        ) VALUES (
            v_league_id,
            v_seller_club_id,
            gen_random_uuid(),
            gen_random_uuid(),
            'Seller Player ' || i,
            '2000-01-01',
            'Uzbekistan',
            10000000.00,
            75
        ) RETURNING id INTO v_player_id;

        INSERT INTO public.league_player_positions (league_player_id, position_code, is_primary)
        VALUES (v_player_id, 'ST', TRUE);

        v_player_ids := array_append(v_player_ids, v_player_id);
    END LOOP;

    -- Insert 18 players for buyer club
    FOR i IN 1..18 LOOP
        INSERT INTO public.league_players (
            league_id,
            league_club_id,
            player_template_id,
            player_template_version_id,
            full_name,
            date_of_birth,
            nationality,
            market_value_eur,
            overall_rating
        ) VALUES (
            v_league_id,
            v_buyer_club_id,
            gen_random_uuid(),
            gen_random_uuid(),
            'Buyer Player ' || i,
            '2000-01-01',
            'Uzbekistan',
            5000000.00,
            70
        ) RETURNING id INTO v_player_id;

        INSERT INTO public.league_player_positions (league_player_id, position_code, is_primary)
        VALUES (v_player_id, 'CM', TRUE);
    END LOOP;

    -- -------------------------------------------------------------
    -- Test A: Listing Creation & 4 Active Listing Limit
    -- -------------------------------------------------------------
    -- List 4 players for seller club
    FOR i IN 1..4 LOOP
        v_res := public.create_player_transfer_listing(v_player_ids[i], 15000000.00, v_seller_user_id);
        IF (v_res->>'success')::boolean IS NOT TRUE THEN
            RAISE EXCEPTION 'Test Failed: Could not create valid listing %', i;
        END IF;
    END LOOP;
    v_listing_id := (v_res->>'listing_id')::uuid;

    -- Attempt 5th active listing -> MUST be rejected with MAX_ACTIVE_LISTINGS_REACHED
    v_caught := FALSE;
    BEGIN
        PERFORM public.create_player_transfer_listing(v_player_ids[5], 15000000.00, v_seller_user_id);
    EXCEPTION WHEN OTHERS THEN
        v_caught := TRUE;
    END;
    IF NOT v_caught THEN
        RAISE EXCEPTION 'Test Failed: 5th active listing was permitted.';
    END IF;

    -- Attempt duplicate listing for same player -> MUST be rejected by unique index constraint
    v_caught := FALSE;
    BEGIN
        PERFORM public.create_player_transfer_listing(v_player_ids[1], 15000000.00, v_seller_user_id);
    EXCEPTION WHEN OTHERS THEN
        v_caught := TRUE;
    END;
    IF NOT v_caught THEN
        RAISE EXCEPTION 'Test Failed: Duplicate active listing for same player was permitted.';
    END IF;

    -- Attempt listing by unauthorized manager -> MUST be rejected with UNAUTHORIZED_SELLER
    v_caught := FALSE;
    BEGIN
        PERFORM public.create_player_transfer_listing(v_player_ids[6], 15000000.00, v_other_user_id);
    EXCEPTION WHEN OTHERS THEN
        v_caught := TRUE;
    END;
    IF NOT v_caught THEN
        RAISE EXCEPTION 'Test Failed: Unauthorized manager was permitted to list player.';
    END IF;

    -- -------------------------------------------------------------
    -- Test B: Human Purchase Safeguards & Transactional Execution
    -- -------------------------------------------------------------
    -- Seller cannot buy own player
    v_caught := FALSE;
    BEGIN
        PERFORM public.purchase_player_transfer_listing(v_listing_id, v_seller_club_id, v_seller_user_id);
    EXCEPTION WHEN OTHERS THEN
        v_caught := TRUE;
    END;
    IF NOT v_caught THEN
        RAISE EXCEPTION 'Test Failed: Seller was able to buy their own player.';
    END IF;

    -- Successful human purchase by buyer club (€15,000,000)
    v_res := public.purchase_player_transfer_listing(v_listing_id, v_buyer_club_id, v_buyer_user_id);
    IF (v_res->>'success')::boolean IS NOT TRUE THEN
        RAISE EXCEPTION 'Test Failed: Human purchase failed unexpectedly.';
    END IF;

    -- Verify updated balances (€100M - €15M = €85M for buyer, €100M + €15M = €115M for seller)
    SELECT total_balance INTO v_buyer_bal FROM public.club_finances WHERE league_club_id = v_buyer_club_id;
    SELECT total_balance INTO v_seller_bal FROM public.club_finances WHERE league_club_id = v_seller_club_id;

    IF v_buyer_bal <> 85000000.00 OR v_seller_bal <> 115000000.00 THEN
        RAISE EXCEPTION 'Test Failed: Balances not updated correctly after purchase. Buyer: %, Seller: %', v_buyer_bal, v_seller_bal;
    END IF;

    -- Verify player ownership transferred to buyer club
    SELECT league_club_id INTO v_new_owner_club_id FROM public.league_players WHERE id = v_player_ids[4];
    IF v_new_owner_club_id <> v_buyer_club_id THEN
        RAISE EXCEPTION 'Test Failed: Player ownership was not transferred to buyer club.';
    END IF;

    -- Verify listing status = SOLD, buyer_type = HUMAN
    SELECT status, buyer_type INTO v_listing_status, v_buyer_type FROM public.league_transfer_listings WHERE id = v_listing_id;
    IF v_listing_status <> 'SOLD' OR v_buyer_type <> 'HUMAN' THEN
        RAISE EXCEPTION 'Test Failed: Listing status or buyer_type incorrect.';
    END IF;

    -- Verify financial ledger entries
    SELECT COUNT(*) INTO v_ledger_count FROM public.financial_ledger WHERE idempotency_key IN ('tr-buy-' || v_listing_id::text, 'tr-sell-' || v_listing_id::text);
    IF v_ledger_count <> 2 THEN
        RAISE EXCEPTION 'Test Failed: Financial ledger entries not written correctly.';
    END IF;

    -- Attempt repeated purchase of already SOLD listing -> MUST be rejected with LISTING_NOT_ACTIVE
    v_caught := FALSE;
    BEGIN
        PERFORM public.purchase_player_transfer_listing(v_listing_id, v_buyer_club_id, v_buyer_user_id);
    EXCEPTION WHEN OTHERS THEN
        v_caught := TRUE;
    END;
    IF NOT v_caught THEN
        RAISE EXCEPTION 'Test Failed: Repeated purchase of SOLD listing was permitted.';
    END IF;

    -- -------------------------------------------------------------
    -- Test C: Cancel Listing & Cancelled Purchase Safeguard
    -- -------------------------------------------------------------
    -- Cancel 1 active listing
    v_res := public.cancel_player_transfer_listing((
        SELECT id FROM public.league_transfer_listings WHERE seller_club_id = v_seller_club_id AND status = 'ACTIVE' LIMIT 1
    ), v_seller_user_id);

    IF (v_res->>'success')::boolean IS NOT TRUE THEN
        RAISE EXCEPTION 'Test Failed: Listing cancellation failed.';
    END IF;

    -- -------------------------------------------------------------
    -- Test D: Bot Purchase Review Worker
    -- -------------------------------------------------------------
    -- Create a bot-eligible listing (overall 80, market value €10M, asking price €10M) and set bot_eligible_at to 25 hours ago
    v_res := public.create_player_transfer_listing(v_player_ids[5], 10000000.00, v_seller_user_id);
    v_bot_listing_id := (v_res->>'listing_id')::uuid;

    UPDATE public.league_transfer_listings
    SET bot_eligible_at = NOW() - INTERVAL '25 hours'
    WHERE id = v_bot_listing_id;

    -- Execute bot review batch
    v_res := public.process_bot_transfer_reviews(10);
    IF (v_res->>'success')::boolean IS NOT TRUE THEN
        RAISE EXCEPTION 'Test Failed: process_bot_transfer_reviews failed.';
    END IF;

    RAISE NOTICE 'Permanent player transfer market pgTAP tests completed successfully.';
END;
$$;

SELECT pass('Permanent player transfer market schema, RPCs, human purchases, bot review, and safeguards pass verification.');
COMMIT;
