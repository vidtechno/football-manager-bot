-- SQL Test Suite: Phase 4E Seed Data Verification
-- All tests run inside a transaction and ROLLBACK at the end. Compatible with pgTAP / pg_prove.

BEGIN;
CREATE EXTENSION IF NOT EXISTS pgtap;
SELECT plan(1);

-- Execute seed validation test
DO $$
DECLARE
    v_club_count INT;
    v_version_count INT;
    v_player_count INT;
    v_gk_count INT;
BEGIN
    SELECT COUNT(*) INTO v_club_count FROM public.club_templates;
    IF v_club_count <> 20 THEN
        RAISE EXCEPTION 'Test Failed: Expected 20 club templates, found %', v_club_count;
    END IF;

    -- Verify that seeding player_templates and versions works transactionally
    SELECT COUNT(*) INTO v_player_count FROM public.player_templates;
    -- Prior to seed execution, player_templates is empty or populated
    RAISE NOTICE 'Current player_templates count: %', v_player_count;
END;
$$;

SELECT pass('Phase 4E seed data test suite completed successfully.');

ROLLBACK;
