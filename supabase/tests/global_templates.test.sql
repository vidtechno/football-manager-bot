-- SQL Test Suite: Global Club and Player Templates Foundation Schema Validation
-- All tests run inside a transaction and ROLLBACK at the end. Compatible with pgTAP / pg_prove.

BEGIN;
CREATE EXTENSION IF NOT EXISTS pgtap;
SELECT plan(1);

-- 1. Test Initial 20 Club Identities Count & Attributes
DO $$
DECLARE
    v_count INT;
BEGIN
    SELECT COUNT(*) INTO v_count FROM public.club_templates;
    IF v_count <> 20 THEN
        RAISE EXCEPTION 'Test Failed: Expected exactly 20 initial club templates, found %.', v_count;
    END IF;
END;
$$;

-- 2. Test Club Canonical Key & Short Code Uniqueness & Format Constraints
DO $$
DECLARE
    v_caught BOOLEAN;
BEGIN
    -- Duplicate slug
    v_caught := FALSE;
    BEGIN
        INSERT INTO public.club_templates (slug, name, short_code, country)
        VALUES ('real-madrid', 'Real Madrid Duplicate', 'RMD', 'Spain');
    EXCEPTION WHEN unique_violation THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Duplicate slug was allowed.'; END IF;

    -- Uppercase slug (rejected by format constraint)
    v_caught := FALSE;
    BEGIN
        INSERT INTO public.club_templates (slug, name, short_code, country)
        VALUES ('Real-Madrid-2', 'Real Madrid 2', 'RM2', 'Spain');
    EXCEPTION WHEN check_violation THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Uppercase slug was allowed.'; END IF;

    -- Duplicate short_code
    v_caught := FALSE;
    BEGIN
        INSERT INTO public.club_templates (slug, name, short_code, country)
        VALUES ('real-madrid-2', 'Real Madrid 2', 'RMA', 'Spain');
    EXCEPTION WHEN unique_violation THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Duplicate short_code was allowed.'; END IF;

    -- Lowercase short_code
    v_caught := FALSE;
    BEGIN
        INSERT INTO public.club_templates (slug, name, short_code, country)
        VALUES ('real-madrid-2', 'Real Madrid 2', 'rma', 'Spain');
    EXCEPTION WHEN check_violation THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Lowercase short_code was allowed.'; END IF;

    -- Empty name
    v_caught := FALSE;
    BEGIN
        INSERT INTO public.club_templates (slug, name, short_code, country)
        VALUES ('empty-name-club', '   ', 'ENC', 'Spain');
    EXCEPTION WHEN check_violation THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Empty name was allowed.'; END IF;

    -- Empty country
    v_caught := FALSE;
    BEGIN
        INSERT INTO public.club_templates (slug, name, short_code, country)
        VALUES ('empty-country-club', 'Empty Country FC', 'ECC', '  ');
    EXCEPTION WHEN check_violation THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Empty country was allowed.'; END IF;
END;
$$;

-- 3. Test Immutable Club Template Slug
DO $$
DECLARE
    v_caught BOOLEAN := FALSE;
    v_club_id UUID;
BEGIN
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'real-madrid';
    BEGIN
        UPDATE public.club_templates SET slug = 'real-madrid-new' WHERE id = v_club_id;
    EXCEPTION WHEN raise_exception THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Changing club_template slug succeeded.'; END IF;
END;
$$;

-- 4. Test Club Template Versioning, Reputation & Squad Value Constraints
DO $$
DECLARE
    v_club_id UUID;
    v_caught BOOLEAN;
BEGIN
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'real-madrid';

    -- Insert valid version 1
    INSERT INTO public.club_template_versions (club_template_id, version, reputation, base_squad_value)
    VALUES (v_club_id, 1, 95, 1000000000.00);

    -- Reject second current version
    v_caught := FALSE;
    BEGIN
        INSERT INTO public.club_template_versions (club_template_id, version, reputation, base_squad_value)
        VALUES (v_club_id, 2, 96, 1100000000.00);
    EXCEPTION WHEN unique_violation THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Second current version was allowed.'; END IF;

    -- Reject negative squad value
    v_caught := FALSE;
    BEGIN
        INSERT INTO public.club_template_versions (club_template_id, version, reputation, base_squad_value, is_current)
        VALUES (v_club_id, 3, 90, -500.00, FALSE);
    EXCEPTION WHEN check_violation THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Negative base_squad_value was allowed.'; END IF;

    -- Reject invalid reputation (>100)
    v_caught := FALSE;
    BEGIN
        INSERT INTO public.club_template_versions (club_template_id, version, reputation, base_squad_value, is_current)
        VALUES (v_club_id, 3, 105, 5000.00, FALSE);
    EXCEPTION WHEN check_violation THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Reputation > 100 was allowed.'; END IF;

    -- Modify historical version -> Rejection
    UPDATE public.club_template_versions SET is_current = FALSE, effective_to = NOW() WHERE club_template_id = v_club_id AND version = 1;
    v_caught := FALSE;
    BEGIN
        UPDATE public.club_template_versions SET reputation = 50 WHERE club_template_id = v_club_id AND version = 1;
    EXCEPTION WHEN raise_exception THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Modifying historical version succeeded.'; END IF;
END;
$$;

-- 5. Test Player Templates Identity, DOB & Position Mechanics
DO $$
DECLARE
    v_club_id UUID;
    v_player_id UUID;
    v_caught BOOLEAN;
BEGIN
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'real-madrid';

    -- Create player with primary and secondary position using atomic RPC function
    v_player_id := public.create_player_template_with_positions(
        'kylian-mbappe',
        v_club_id,
        'Kylian Mbappé',
        '1998-12-20'::DATE,
        'France',
        'ST'::public.enum_player_position,
        ARRAY['LW'::public.enum_player_position, 'RW'::public.enum_player_position]
    );

    IF v_player_id IS NULL THEN
        RAISE EXCEPTION 'Test Failed: Player template creation failed.';
    END IF;

    -- Reject duplicate canonical_key
    v_caught := FALSE;
    BEGIN
        PERFORM public.create_player_template_with_positions(
            'kylian-mbappe',
            v_club_id,
            'Kylian Mbappé Duplicate',
            '1998-12-20'::DATE,
            'France',
            'ST'::public.enum_player_position
        );
    EXCEPTION WHEN unique_violation THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Duplicate player canonical_key was allowed.'; END IF;

    -- Reject future date of birth
    v_caught := FALSE;
    BEGIN
        INSERT INTO public.player_templates (canonical_key, current_club_template_id, full_name, date_of_birth, nationality)
        VALUES ('future-player', v_club_id, 'Future Player', CURRENT_DATE + INTERVAL '1 day', 'Spain');
    EXCEPTION WHEN check_violation THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Future birth date was allowed.'; END IF;

    -- Reject duplicate position code for same player
    v_caught := FALSE;
    BEGIN
        INSERT INTO public.player_template_positions (player_template_id, position_code, is_primary)
        VALUES (v_player_id, 'ST'::public.enum_player_position, FALSE);
    EXCEPTION WHEN unique_violation THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Duplicate position code was allowed.'; END IF;

    -- Replace primary position safely
    PERFORM public.replace_player_primary_position(v_player_id, 'LW'::public.enum_player_position);
END;
$$;

-- 6. Test Player Template Versions Attribute Validation (GK vs Outfield)
DO $$
DECLARE
    v_club_id UUID;
    v_outfield_player_id UUID;
    v_gk_player_id UUID;
    v_caught BOOLEAN;
BEGIN
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'real-madrid';

    -- Create Outfield Player (ST)
    v_outfield_player_id := public.create_player_template_with_positions(
        'vinicius-junior',
        v_club_id,
        'Vinícius Júnior',
        '2000-07-12'::DATE,
        'Brazil',
        'LW'::public.enum_player_position
    );

    -- Create GK Player (GK)
    v_gk_player_id := public.create_player_template_with_positions(
        'thibaut-courtois',
        v_club_id,
        'Thibaut Courtois',
        '1992-05-11'::DATE,
        'Belgium',
        'GK'::public.enum_player_position
    );

    -- Outfield Version: Valid
    INSERT INTO public.player_template_versions (
        player_template_id, version, market_value_eur, overall_rating,
        pace, shooting, passing, dribbling, defending, physical
    ) VALUES (
        v_outfield_player_id, 1, 150000000.00, 90,
        95, 84, 81, 92, 34, 75
    );

    -- Outfield Version with GK attributes -> Rejection
    v_caught := FALSE;
    BEGIN
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, reflexes
        ) VALUES (
            v_outfield_player_id, 2, 150000000.00, 90,
            95, 84, 81, 92, 34, 75, 88
        );
    EXCEPTION WHEN raise_exception THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: Outfield version with GK attributes was allowed.'; END IF;

    -- GK Version: Valid
    INSERT INTO public.player_template_versions (
        player_template_id, version, market_value_eur, overall_rating,
        reflexes, handling, positioning, aerial_ability, distribution, one_on_one
    ) VALUES (
        v_gk_player_id, 1, 45000000.00, 89,
        90, 89, 88, 87, 76, 91
    );

    -- GK Version with Outfield attributes -> Rejection
    v_caught := FALSE;
    BEGIN
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, pace
        ) VALUES (
            v_gk_player_id, 2, 45000000.00, 89,
            90, 89, 88, 87, 76, 91, 70
        );
    EXCEPTION WHEN raise_exception THEN v_caught := TRUE;
    END;
    IF NOT v_caught THEN RAISE EXCEPTION 'Test Failed: GK version with pace attribute was allowed.'; END IF;
END;
$$;

-- 7. Test RLS Status on All Five Tables
DO $$
DECLARE
    v_rls_count INT;
BEGIN
    SELECT COUNT(*) INTO v_rls_count
    FROM pg_class c
    JOIN pg_namespace n ON n.oid = c.relnamespace
    WHERE n.nspname = 'public'
      AND c.relname IN ('club_templates', 'club_template_versions', 'player_templates', 'player_template_positions', 'player_template_versions')
      AND c.relrowsecurity = TRUE;

    IF v_rls_count <> 5 THEN
        RAISE EXCEPTION 'Test Failed: Not all 5 global template tables have RLS enabled (found %).', v_rls_count;
    END IF;
END;
$$;

SELECT pass('Global club and player templates tests completed successfully.');

ROLLBACK;
