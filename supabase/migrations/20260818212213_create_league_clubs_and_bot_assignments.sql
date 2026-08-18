-- SQL Migration: Phase 4B2 - League Clubs and Bot Manager Assignments Database Foundation
-- Creates league-specific club instances (league_clubs) and bot control assignments (bot_manager_assignments),
-- along with validation triggers, transaction-safe RPC functions, RLS policies, service_role privilege bounds,
-- and forward repair for publish_club_template_version function.

-- 1. Table: league_clubs (League-Specific Club Instance)
CREATE TABLE public.league_clubs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    league_id UUID NOT NULL REFERENCES public.leagues(id) ON DELETE CASCADE,
    club_template_id UUID NOT NULL REFERENCES public.club_templates(id) ON DELETE RESTRICT,
    human_manager_id UUID NULL REFERENCES public.managers(id) ON DELETE SET NULL,
    display_name VARCHAR(100) NOT NULL CHECK (char_length(trim(display_name)) > 0),
    short_code VARCHAR(10) NOT NULL CHECK (short_code ~ '^[A-Z0-9]{2,10}$'),
    selected_at TIMESTAMPTZ NULL,
    released_at TIMESTAMPTZ NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT uq_league_clubs_template UNIQUE (league_id, club_template_id)
);

-- Partial Unique Index: One human manager may control at most one club inside the same league
CREATE UNIQUE INDEX uq_league_clubs_active_human 
    ON public.league_clubs (league_id, human_manager_id) 
    WHERE (human_manager_id IS NOT NULL);

-- Indexes for league_clubs
CREATE INDEX idx_league_clubs_league_id ON public.league_clubs(league_id);
CREATE INDEX idx_league_clubs_template_id ON public.league_clubs(club_template_id);
CREATE INDEX idx_league_clubs_human_manager ON public.league_clubs(human_manager_id);

-- Trigger: Updated_at for league_clubs
CREATE TRIGGER trg_league_clubs_updated_at
    BEFORE UPDATE ON public.league_clubs
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


-- 2. Table: bot_manager_assignments (Bot Manager Control Record)
CREATE TABLE public.bot_manager_assignments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    league_id UUID NOT NULL REFERENCES public.leagues(id) ON DELETE CASCADE,
    league_club_id UUID NOT NULL REFERENCES public.league_clubs(id) ON DELETE CASCADE,
    bot_personality VARCHAR(50) NOT NULL DEFAULT 'BALANCED',
    aggressiveness INT NOT NULL DEFAULT 5 CHECK (aggressiveness BETWEEN 1 AND 10),
    assigned_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    released_at TIMESTAMPTZ NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Partial Unique Index: At most one active bot assignment per league club
CREATE UNIQUE INDEX uq_bot_assignments_active 
    ON public.bot_manager_assignments (league_club_id) 
    WHERE (is_active = TRUE);

-- Indexes for bot_manager_assignments
CREATE INDEX idx_bot_assignments_league_id ON public.bot_manager_assignments(league_id);
CREATE INDEX idx_bot_assignments_club_id ON public.bot_manager_assignments(league_club_id);
CREATE INDEX idx_bot_assignments_active ON public.bot_manager_assignments(league_club_id, is_active);

-- Trigger: Updated_at for bot_manager_assignments
CREATE TRIGGER trg_bot_manager_assignments_updated_at
    BEFORE UPDATE ON public.bot_manager_assignments
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


-- 3. Validation Trigger Functions & Triggers

-- Trigger Function: Validate human manager club selection & mutation rules
CREATE OR REPLACE FUNCTION public.validate_league_club_human_selection()
RETURNS TRIGGER AS $$
DECLARE
    v_league_status public.enum_league_status;
    v_is_member BOOLEAN;
    v_is_blocked BOOLEAN;
    v_has_active_bot BOOLEAN;
BEGIN
    -- Check if human_manager_id is being changed or set
    IF (TG_OP = 'INSERT' AND NEW.human_manager_id IS NOT NULL) OR
       (TG_OP = 'UPDATE' AND NEW.human_manager_id IS DISTINCT FROM OLD.human_manager_id) THEN

        -- 1. Verify League Status is LOBBY
        SELECT status INTO v_league_status
        FROM public.leagues
        WHERE id = NEW.league_id;

        IF v_league_status IS NULL THEN
            RAISE EXCEPTION 'Biriktirilgan liga topilmadi.' USING ERRCODE = 'P0001';
        END IF;

        IF v_league_status <> 'LOBBY' THEN
            RAISE EXCEPTION 'Klub tanlash yoki o''zgartirish faqat LOBBY holatidagi ligada amalga oshirilishi mumkin.' USING ERRCODE = 'P0001';
        END IF;

        IF NEW.human_manager_id IS NOT NULL THEN
            -- 2. Verify manager is an active member of the league
            SELECT EXISTS (
                SELECT 1 FROM public.league_members 
                WHERE league_id = NEW.league_id AND manager_id = NEW.human_manager_id
            ) INTO v_is_member;

            IF NOT v_is_member THEN
                RAISE EXCEPTION 'Menejer bu liganing faol a''zosi emas.' USING ERRCODE = 'P0001';
            END IF;

            -- 3. Verify manager is not blocked
            SELECT EXISTS (
                SELECT 1 FROM public.manager_blocks 
                WHERE manager_id = NEW.human_manager_id AND is_blocked = TRUE
            ) INTO v_is_blocked;

            IF v_is_blocked THEN
                RAISE EXCEPTION 'Menejer bliroqlangan va klub tanlay olmaydi.' USING ERRCODE = 'P0001';
            END IF;

            -- 4. Verify club has no active bot assignment
            SELECT EXISTS (
                SELECT 1 FROM public.bot_manager_assignments 
                WHERE league_club_id = NEW.id AND is_active = TRUE
            ) INTO v_has_active_bot;

            IF v_has_active_bot THEN
                RAISE EXCEPTION 'Bot biriktirilgan klubni insonga berish taqiqlangan.' USING ERRCODE = 'P0001';
            END IF;
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

CREATE TRIGGER trg_validate_league_club_human_selection
    BEFORE INSERT OR UPDATE ON public.league_clubs
    FOR EACH ROW EXECUTE FUNCTION public.validate_league_club_human_selection();


-- Trigger Function: Validate bot_manager_assignment cross-table consistency & human exclusion
CREATE OR REPLACE FUNCTION public.validate_bot_manager_assignment()
RETURNS TRIGGER AS $$
DECLARE
    v_club_league_id UUID;
    v_club_human_manager_id UUID;
BEGIN
    -- Retrieve target league_club parameters
    SELECT league_id, human_manager_id INTO v_club_league_id, v_club_human_manager_id
    FROM public.league_clubs
    WHERE id = NEW.league_club_id;

    IF v_club_league_id IS NULL THEN
        RAISE EXCEPTION 'Biriktirilgan liga klubi topilmadi.' USING ERRCODE = 'P0001';
    END IF;

    -- 1. Cross-table league_id consistency check
    IF NEW.league_id <> v_club_league_id THEN
        RAISE EXCEPTION 'Bot biriktiruvi league_id ko''rsatkichi liga klubining league_id ko''rsatkichiga mos kelmadi.' USING ERRCODE = 'P0001';
    END IF;

    -- 2. Human vs Bot mutual exclusion check
    IF NEW.is_active = TRUE AND v_club_human_manager_id IS NOT NULL THEN
        RAISE EXCEPTION 'Inson-menejer boshqarayotgan klubga bot tayinlash taqiqlangan.' USING ERRCODE = 'P0001';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

CREATE TRIGGER trg_validate_bot_manager_assignment
    BEFORE INSERT OR UPDATE ON public.bot_manager_assignments
    FOR EACH ROW EXECUTE FUNCTION public.validate_bot_manager_assignment();


-- 4. Controlled RPC Functions (Security Definer with fixed search_path = public)

-- Function: initialize_gigants_league_clubs
CREATE OR REPLACE FUNCTION public.initialize_gigants_league_clubs(
    p_league_id UUID
)
RETURNS INT AS $$
DECLARE
    v_league_status public.enum_league_status;
    v_existing_count INT;
    v_active_template_count INT;
    v_inserted_count INT := 0;
BEGIN
    -- Verify league exists and is in LOBBY status
    SELECT status INTO v_league_status
    FROM public.leagues
    WHERE id = p_league_id;

    IF v_league_status IS NULL THEN
        RAISE EXCEPTION 'Liga topilmadi.' USING ERRCODE = 'P0001';
    END IF;

    IF v_league_status <> 'LOBBY' THEN
        RAISE EXCEPTION 'Klub sloti yaratish faqat LOBBY holatidagi ligalar uchun ruxsat etilgan.' USING ERRCODE = 'P0001';
    END IF;

    -- Transaction advisory lock on p_league_id to prevent concurrent duplicate initialization
    PERFORM pg_advisory_xact_lock(hashtext(p_league_id::text));

    -- Check if league_clubs already initialized idempotently
    SELECT COUNT(*) INTO v_existing_count
    FROM public.league_clubs
    WHERE league_id = p_league_id;

    IF v_existing_count = 20 THEN
        RETURN 20;
    ELSIF v_existing_count > 0 AND v_existing_count <> 20 THEN
        RAISE EXCEPTION 'Liga klublari slotlari soni noto''g me''yor holatida (topildi: %).', v_existing_count USING ERRCODE = 'P0001';
    END IF;

    -- Verify active global club_templates count is exactly 20
    SELECT COUNT(*) INTO v_active_template_count
    FROM public.club_templates
    WHERE is_active = TRUE;

    IF v_active_template_count <> 20 THEN
        RAISE EXCEPTION 'Baza global klub shablonlari soni aniq 20 ta emas (topildi: %).', v_active_template_count USING ERRCODE = 'P0001';
    END IF;

    -- Insert exactly 20 league_clubs referencing global club_templates
    INSERT INTO public.league_clubs (
        league_id,
        club_template_id,
        display_name,
        short_code
    )
    SELECT
        p_league_id,
        ct.id,
        ct.name,
        ct.short_code
    FROM public.club_templates ct
    WHERE ct.is_active = TRUE;

    GET DIAGNOSTICS v_inserted_count = ROW_COUNT;
    RETURN v_inserted_count;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;


-- Function: select_league_club
CREATE OR REPLACE FUNCTION public.select_league_club(
    p_manager_id UUID,
    p_league_id UUID,
    p_league_club_id UUID
)
RETURNS VOID AS $$
DECLARE
    v_club_league_id UUID;
    v_current_human UUID;
    v_has_active_bot BOOLEAN;
BEGIN
    -- Verify league club belongs to league and check existing ownership
    SELECT league_id, human_manager_id INTO v_club_league_id, v_current_human
    FROM public.league_clubs
    WHERE id = p_league_club_id FOR UPDATE;

    IF v_club_league_id IS NULL OR v_club_league_id <> p_league_id THEN
        RAISE EXCEPTION 'Klub ko''rsatilgan ligaga tegishli emas.' USING ERRCODE = 'P0001';
    END IF;

    IF v_current_human IS NOT NULL THEN
        RAISE EXCEPTION 'Ushbu klub boshqa menejer tomonidan egallangan.' USING ERRCODE = 'P0001';
    END IF;

    -- Check bot assignment
    SELECT EXISTS (
        SELECT 1 FROM public.bot_manager_assignments 
        WHERE league_club_id = p_league_club_id AND is_active = TRUE
    ) INTO v_has_active_bot;

    IF v_has_active_bot THEN
        RAISE EXCEPTION 'Bot tayinlangan klubni tanlash taqiqlangan.' USING ERRCODE = 'P0001';
    END IF;

    -- Update league_clubs with human_manager_id
    UPDATE public.league_clubs
    SET human_manager_id = p_manager_id,
        selected_at = NOW(),
        released_at = NULL
    WHERE id = p_league_club_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;


-- Function: switch_league_club
CREATE OR REPLACE FUNCTION public.switch_league_club(
    p_manager_id UUID,
    p_league_id UUID,
    p_new_league_club_id UUID
)
RETURNS VOID AS $$
DECLARE
    v_new_club_league_id UUID;
    v_new_club_human UUID;
    v_has_active_bot BOOLEAN;
BEGIN
    -- Verify new league club belongs to league
    SELECT league_id, human_manager_id INTO v_new_club_league_id, v_new_club_human
    FROM public.league_clubs
    WHERE id = p_new_league_club_id FOR UPDATE;

    IF v_new_club_league_id IS NULL OR v_new_club_league_id <> p_league_id THEN
        RAISE EXCEPTION 'Yangi klub ko''rsatilgan ligaga tegishli emas.' USING ERRCODE = 'P0001';
    END IF;

    IF v_new_club_human IS NOT NULL THEN
        RAISE EXCEPTION 'Yangi klub boshqa menejer tomonidan egallangan.' USING ERRCODE = 'P0001';
    END IF;

    SELECT EXISTS (
        SELECT 1 FROM public.bot_manager_assignments 
        WHERE league_club_id = p_new_league_club_id AND is_active = TRUE
    ) INTO v_has_active_bot;

    IF v_has_active_bot THEN
        RAISE EXCEPTION 'Bot tayinlangan klubga o''tish taqiqlangan.' USING ERRCODE = 'P0001';
    END IF;

    -- Atomic release of previous club (if any)
    UPDATE public.league_clubs
    SET human_manager_id = NULL,
        released_at = NOW()
    WHERE league_id = p_league_id AND human_manager_id = p_manager_id;

    -- Atomic selection of new club
    UPDATE public.league_clubs
    SET human_manager_id = p_manager_id,
        selected_at = NOW(),
        released_at = NULL
    WHERE id = p_new_league_club_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;


-- Function: release_league_club
CREATE OR REPLACE FUNCTION public.release_league_club(
    p_manager_id UUID,
    p_league_id UUID
)
RETURNS VOID AS $$
DECLARE
    v_league_status public.enum_league_status;
BEGIN
    SELECT status INTO v_league_status
    FROM public.leagues
    WHERE id = p_league_id;

    IF v_league_status IS NULL OR v_league_status <> 'LOBBY' THEN
        RAISE EXCEPTION 'Klubni bo''shatish faqat LOBBY holatidagi ligada amalga oshirilishi mumkin.' USING ERRCODE = 'P0001';
    END IF;

    UPDATE public.league_clubs
    SET human_manager_id = NULL,
        released_at = NOW()
    WHERE league_id = p_league_id AND human_manager_id = p_manager_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;


-- Function: assign_bots_to_unselected_clubs
CREATE OR REPLACE FUNCTION public.assign_bots_to_unselected_clubs(
    p_league_id UUID
)
RETURNS INT AS $$
DECLARE
    v_club RECORD;
    v_assigned_count INT := 0;
BEGIN
    -- Verify league exists
    IF NOT EXISTS (SELECT 1 FROM public.leagues WHERE id = p_league_id) THEN
        RAISE EXCEPTION 'Liga topilmadi.' USING ERRCODE = 'P0001';
    END IF;

    -- Iterate through unselected league_clubs
    FOR v_club IN 
        SELECT id FROM public.league_clubs 
        WHERE league_id = p_league_id AND human_manager_id IS NULL
    LOOP
        IF NOT EXISTS (SELECT 1 FROM public.bot_manager_assignments WHERE league_club_id = v_club.id AND is_active = TRUE) THEN
            INSERT INTO public.bot_manager_assignments (
                league_id,
                league_club_id,
                bot_personality,
                aggressiveness,
                assigned_at,
                is_active
            ) VALUES (
                p_league_id,
                v_club.id,
                'BALANCED',
                5,
                NOW(),
                TRUE
            );
            v_assigned_count := v_assigned_count + 1;
        END IF;
    END LOOP;

    RETURN v_assigned_count;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;


-- 5. Forward Repair: publish_club_template_version (fixes admin_users.status check)
CREATE OR REPLACE FUNCTION public.publish_club_template_version(
    p_admin_id UUID,
    p_club_template_id UUID,
    p_reputation INT,
    p_base_squad_value NUMERIC
)
RETURNS UUID AS $$
DECLARE
    v_next_version INT;
    v_new_version_id UUID;
BEGIN
    -- Check admin exists and status is ACTIVE (from enum_admin_status)
    IF NOT EXISTS (SELECT 1 FROM public.admin_users WHERE id = p_admin_id AND status = 'ACTIVE') THEN
        RAISE EXCEPTION 'Bajaruvchi admin topilmadi yoki faol emas.' USING ERRCODE = 'P0001';
    END IF;

    -- Check club template exists
    IF NOT EXISTS (SELECT 1 FROM public.club_templates WHERE id = p_club_template_id) THEN
        RAISE EXCEPTION 'Klub shabloni topilmadi.' USING ERRCODE = 'P0001';
    END IF;

    -- Get next version number
    SELECT COALESCE(MAX(version), 0) + 1 INTO v_next_version
    FROM public.club_template_versions
    WHERE club_template_id = p_club_template_id;

    -- Archive current version
    UPDATE public.club_template_versions
    SET is_current = FALSE, effective_to = NOW()
    WHERE club_template_id = p_club_template_id AND is_current = TRUE;

    -- Insert new current version
    INSERT INTO public.club_template_versions (
        club_template_id,
        version,
        reputation,
        base_squad_value,
        effective_from,
        effective_to,
        is_current,
        created_by_admin_id
    ) VALUES (
        p_club_template_id,
        v_next_version,
        p_reputation,
        p_base_squad_value,
        NOW(),
        NULL,
        TRUE,
        p_admin_id
    ) RETURNING id INTO v_new_version_id;

    RETURN v_new_version_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;


-- 6. Row Level Security & Explicit Privilege Boundary

ALTER TABLE public.league_clubs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.bot_manager_assignments ENABLE ROW LEVEL SECURITY;

-- Revoke default access from public, anon, and authenticated
REVOKE ALL ON public.league_clubs FROM PUBLIC, anon, authenticated;
REVOKE ALL ON public.bot_manager_assignments FROM PUBLIC, anon, authenticated;

-- Grant least privilege DML permissions to service_role
GRANT SELECT, INSERT, UPDATE, DELETE ON public.league_clubs TO service_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.bot_manager_assignments TO service_role;

-- Grant RPC execution permissions to service_role only
GRANT EXECUTE ON FUNCTION public.initialize_gigants_league_clubs TO service_role;
GRANT EXECUTE ON FUNCTION public.select_league_club TO service_role;
GRANT EXECUTE ON FUNCTION public.switch_league_club TO service_role;
GRANT EXECUTE ON FUNCTION public.release_league_club TO service_role;
GRANT EXECUTE ON FUNCTION public.assign_bots_to_unselected_clubs TO service_role;
GRANT EXECUTE ON FUNCTION public.publish_club_template_version TO service_role;

-- Revoke RPC execution permissions from public, anon, and authenticated
REVOKE EXECUTE ON FUNCTION public.initialize_gigants_league_clubs FROM PUBLIC, anon, authenticated;
REVOKE EXECUTE ON FUNCTION public.select_league_club FROM PUBLIC, anon, authenticated;
REVOKE EXECUTE ON FUNCTION public.switch_league_club FROM PUBLIC, anon, authenticated;
REVOKE EXECUTE ON FUNCTION public.release_league_club FROM PUBLIC, anon, authenticated;
REVOKE EXECUTE ON FUNCTION public.assign_bots_to_unselected_clubs FROM PUBLIC, anon, authenticated;
REVOKE EXECUTE ON FUNCTION public.publish_club_template_version FROM PUBLIC, anon, authenticated;
