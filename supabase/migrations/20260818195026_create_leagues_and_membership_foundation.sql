-- Supabase Migration: Create Leagues and Membership Database Foundation
-- Target Schema: public
-- Security: RLS Enabled on all tables, Service Role Access Only

-- 1. Enums
CREATE TYPE public.enum_league_status AS ENUM (
    'LOBBY',
    'STARTING',
    'ACTIVE',
    'PAUSED',
    'COMPLETED',
    'CANCELLED'
);

CREATE TYPE public.enum_league_mode AS ENUM ('GIGANTS');

CREATE TYPE public.enum_league_member_role AS ENUM ('OWNER', 'MEMBER');

CREATE TYPE public.enum_round_status AS ENUM (
    'SCHEDULED',
    'IN_PROGRESS',
    'COMPLETED',
    'FAILED'
);

-- 2. Leagues Table
CREATE TABLE public.leagues (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(50) NOT NULL CONSTRAINT chk_leagues_name_length CHECK (length(trim(name)) BETWEEN 3 AND 50),
    code VARCHAR(6) UNIQUE NOT NULL CONSTRAINT chk_leagues_code_format CHECK (code ~ '^[A-HJ-NP-Z2-9]{6}$'),
    mode public.enum_league_mode NOT NULL DEFAULT 'GIGANTS',
    status public.enum_league_status NOT NULL DEFAULT 'LOBBY',
    owner_manager_id UUID NOT NULL REFERENCES public.managers(id) ON DELETE RESTRICT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    started_at TIMESTAMPTZ,
    completed_at TIMESTAMPTZ,
    cancelled_at TIMESTAMPTZ,
    CONSTRAINT chk_leagues_started_at_order CHECK (started_at IS NULL OR started_at >= created_at),
    CONSTRAINT chk_leagues_completed_at_valid CHECK (completed_at IS NULL OR (status = 'COMPLETED' AND completed_at >= started_at)),
    CONSTRAINT chk_leagues_cancelled_at_valid CHECK (cancelled_at IS NULL OR status = 'CANCELLED')
);

COMMENT ON TABLE public.leagues IS 'Primary league instances for multiplayer Football Manager competitions.';
COMMENT ON COLUMN public.leagues.code IS '6-character invitation code using approved non-confusing charset (excluding O, 0, I, L, 1).';

CREATE INDEX idx_leagues_owner_manager_id ON public.leagues (owner_manager_id);
CREATE INDEX idx_leagues_code ON public.leagues (code);
CREATE INDEX idx_leagues_status ON public.leagues (status);
CREATE INDEX idx_leagues_created_at ON public.leagues (created_at);

CREATE TRIGGER trg_leagues_updated_at
    BEFORE UPDATE ON public.leagues
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- 3. Permanent League Code Registry Table
CREATE TABLE public.league_code_registry (
    code VARCHAR(6) PRIMARY KEY CONSTRAINT chk_league_code_registry_code_format CHECK (code ~ '^[A-HJ-NP-Z2-9]{6}$'),
    league_id UUID UNIQUE REFERENCES public.leagues(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE public.league_code_registry IS 'Permanent registry preserving created invitation codes to prevent reuse across deleted leagues.';

-- Code Registry Immutability Trigger
CREATE OR REPLACE FUNCTION public.prevent_code_registry_modification()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'DELETE' THEN
        RAISE EXCEPTION 'league_code_registry dan kodlarni o''chirish taqiqlangan. Kodlar doimiy saqlanadi.';
    ELSIF TG_OP = 'UPDATE' THEN
        IF OLD.code <> NEW.code THEN
            RAISE EXCEPTION 'league_code_registry kodini o''zgartirish taqiqlangan.';
        END IF;
        IF OLD.league_id IS NOT NULL AND NEW.league_id IS NOT NULL AND OLD.league_id <> NEW.league_id THEN
            RAISE EXCEPTION 'league_code_registry vaqtinchalik liga ID si qayta bog''lanishi taqiqlangan.';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

CREATE TRIGGER trg_prevent_code_registry_modification
    BEFORE UPDATE OR DELETE ON public.league_code_registry
    FOR EACH ROW EXECUTE FUNCTION public.prevent_code_registry_modification();

-- 4. Unique Code Generator Function
CREATE OR REPLACE FUNCTION public.generate_unique_league_code()
RETURNS VARCHAR(6) AS $$
DECLARE
    chars TEXT := 'ABCDEFGHJKMNPQRSTUVWXYZ23456789';
    result VARCHAR(6) := '';
    i INT;
    rand_val INT;
    attempts INT := 0;
    max_attempts CONSTANT INT := 50;
    code_exists BOOLEAN;
BEGIN
    LOOP
        attempts := attempts + 1;
        IF attempts > max_attempts THEN
            RAISE EXCEPTION 'Noyob liga kodini generatsiya qilib bo''lmadi. Iltimos qaytadan urinib ko''ring.';
        END IF;

        result := '';
        FOR i IN 1..6 LOOP
            rand_val := floor(random() * 32)::INT + 1;
            result := result || substr(chars, rand_val, 1);
        END FOR;

        SELECT EXISTS (
            SELECT 1 FROM public.league_code_registry WHERE code = result
        ) INTO code_exists;

        IF NOT code_exists THEN
            RETURN result;
        END IF;
    END LOOP;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

-- 5. League Members Table
CREATE TABLE public.league_members (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    league_id UUID NOT NULL REFERENCES public.leagues(id) ON DELETE CASCADE,
    manager_id UUID NOT NULL REFERENCES public.managers(id) ON DELETE RESTRICT,
    role public.enum_league_member_role NOT NULL DEFAULT 'MEMBER',
    joined_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    left_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT chk_league_members_left_after_joined CHECK (left_at IS NULL OR left_at >= joined_at)
);

COMMENT ON TABLE public.league_members IS 'Membership records linking managers to leagues.';

CREATE UNIQUE INDEX idx_league_members_active_membership ON public.league_members (league_id, manager_id) WHERE (left_at IS NULL);
CREATE UNIQUE INDEX idx_league_members_single_owner ON public.league_members (league_id) WHERE (role = 'OWNER' AND left_at IS NULL);
CREATE INDEX idx_league_members_league_id ON public.league_members (league_id);
CREATE INDEX idx_league_members_manager_id ON public.league_members (manager_id);

CREATE TRIGGER trg_league_members_updated_at
    BEFORE UPDATE ON public.league_members
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- 6. League Settings Table
CREATE TABLE public.league_settings (
    league_id UUID PRIMARY KEY REFERENCES public.leagues(id) ON DELETE CASCADE,
    round_speed INT NOT NULL DEFAULT 1 CONSTRAINT chk_league_settings_round_speed CHECK (round_speed BETWEEN 1 AND 4),
    is_speed_locked BOOLEAN NOT NULL DEFAULT FALSE,
    max_human_managers INT NOT NULL DEFAULT 20 CONSTRAINT chk_league_settings_max_human_managers CHECK (max_human_managers = 20),
    first_round_delay_minutes INT NOT NULL DEFAULT 30 CONSTRAINT chk_league_settings_delay CHECK (first_round_delay_minutes >= 0),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE public.league_settings IS 'Configuration parameters for a league (round speed, max human managers).';

CREATE TRIGGER trg_league_settings_updated_at
    BEFORE UPDATE ON public.league_settings
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- Locked Settings Protection Trigger
CREATE OR REPLACE FUNCTION public.prevent_locked_league_settings_change()
RETURNS TRIGGER AS $$
DECLARE
    v_league_status public.enum_league_status;
BEGIN
    SELECT status INTO v_league_status FROM public.leagues WHERE id = NEW.league_id;
    
    IF OLD.round_speed <> NEW.round_speed THEN
        IF OLD.is_speed_locked OR v_league_status <> 'LOBBY' THEN
            RAISE EXCEPTION 'O''yin tezligini (round_speed) faqat LOBBY holatida va sozlama qulflanmagan bo''lsa o''zgartirish mumkin.';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

CREATE TRIGGER trg_prevent_locked_league_settings_change
    BEFORE UPDATE ON public.league_settings
    FOR EACH ROW EXECUTE FUNCTION public.prevent_locked_league_settings_change();

-- 7. League Rounds Table
CREATE TABLE public.league_rounds (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    league_id UUID NOT NULL REFERENCES public.leagues(id) ON DELETE CASCADE,
    round_number INT NOT NULL CONSTRAINT chk_league_rounds_number CHECK (round_number BETWEEN 1 AND 38),
    status public.enum_round_status NOT NULL DEFAULT 'SCHEDULED',
    scheduled_at TIMESTAMPTZ,
    started_at TIMESTAMPTZ,
    completed_at TIMESTAMPTZ,
    failure_reason TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT unq_league_rounds_number UNIQUE (league_id, round_number),
    CONSTRAINT chk_league_rounds_completed_at CHECK (completed_at IS NULL OR completed_at >= started_at),
    CONSTRAINT chk_league_rounds_status_completed CHECK (status <> 'COMPLETED' OR completed_at IS NOT NULL),
    CONSTRAINT chk_league_rounds_status_failed CHECK (status <> 'FAILED' OR failure_reason IS NOT NULL),
    CONSTRAINT chk_league_rounds_status_in_progress CHECK (status <> 'IN_PROGRESS' OR scheduled_at IS NOT NULL)
);

COMMENT ON TABLE public.league_rounds IS 'Round schedule and status entries (38 rounds per season in Gigants mode).';

CREATE INDEX idx_league_rounds_league_number ON public.league_rounds (league_id, round_number);
CREATE INDEX idx_league_rounds_scheduled ON public.league_rounds (status, scheduled_at);

CREATE TRIGGER trg_league_rounds_updated_at
    BEFORE UPDATE ON public.league_rounds
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- 8. Status Transition Protection & Deletion Guard Triggers
CREATE OR REPLACE FUNCTION public.enforce_league_status_transition()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.status = NEW.status THEN
        RETURN NEW;
    END IF;

    -- Valid Transitions Matrix
    IF OLD.status = 'LOBBY' AND NEW.status IN ('STARTING', 'CANCELLED') THEN
        -- When moving away from LOBBY, lock speed settings
        UPDATE public.league_settings SET is_speed_locked = TRUE WHERE league_id = NEW.id;
        IF NEW.status = 'STARTING' AND NEW.started_at IS NULL THEN
            NEW.started_at := NOW();
        END IF;
        RETURN NEW;
    ELSIF OLD.status = 'STARTING' AND NEW.status IN ('ACTIVE', 'CANCELLED') THEN
        RETURN NEW;
    ELSIF OLD.status = 'ACTIVE' AND NEW.status IN ('PAUSED', 'COMPLETED') THEN
        IF NEW.status = 'COMPLETED' AND NEW.completed_at IS NULL THEN
            NEW.completed_at := NOW();
        END IF;
        RETURN NEW;
    ELSIF OLD.status = 'PAUSED' AND NEW.status IN ('ACTIVE', 'CANCELLED') THEN
        IF NEW.status = 'CANCELLED' AND NEW.cancelled_at IS NULL THEN
            NEW.cancelled_at := NOW();
        END IF;
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'Liganing % holatidan % holatiga o''tishi taqiqlangan.', OLD.status, NEW.status;
    END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

CREATE TRIGGER trg_enforce_league_status_transition
    BEFORE UPDATE ON public.leagues
    FOR EACH ROW EXECUTE FUNCTION public.enforce_league_status_transition();

-- Deletion Guard for Leagues
CREATE OR REPLACE FUNCTION public.enforce_league_deletion_guard()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.status <> 'LOBBY' THEN
        RAISE EXCEPTION 'Boshlangan, faol yoki yakunlangan ligalarni bazadan to''g'’ridan-to''g'’ri o''chirish taqiqlangan.';
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

CREATE TRIGGER trg_enforce_league_deletion_guard
    BEFORE DELETE ON public.leagues
    FOR EACH ROW EXECUTE FUNCTION public.enforce_league_deletion_guard();

-- 9. Atomic Stored Functions

-- A. Create League with Owner
CREATE OR REPLACE FUNCTION public.create_league_with_owner(
    p_owner_manager_id UUID,
    p_league_name VARCHAR(50),
    p_round_speed INT DEFAULT 1
)
RETURNS JSONB AS $$
DECLARE
    v_manager_status public.enum_manager_status;
    v_active_leagues_count INT;
    v_code VARCHAR(6);
    v_league_id UUID;
    v_result JSONB;
BEGIN
    -- 1. Advisory lock on manager to prevent race conditions
    PERFORM pg_advisory_xact_lock(hashtext('manager_' || p_owner_manager_id::text));

    -- 2. Verify manager exists and is ACTIVE
    SELECT status INTO v_manager_status FROM public.managers WHERE id = p_owner_manager_id;
    IF v_manager_status IS NULL THEN
        RAISE EXCEPTION 'Menejer topilmadi.';
    ELSIF v_manager_status <> 'ACTIVE' THEN
        RAISE EXCEPTION 'Bloklangan yoki faol bo''lmagan menejer liga yarata olmaydi.';
    END IF;

    -- 3. Verify manager active counting leagues < 2
    SELECT COUNT(DISTINCT lm.league_id) INTO v_active_leagues_count
    FROM public.league_members lm
    JOIN public.leagues l ON l.id = lm.league_id
    WHERE lm.manager_id = p_owner_manager_id
      AND lm.left_at IS NULL
      AND l.status IN ('LOBBY', 'STARTING', 'ACTIVE', 'PAUSED');

    IF v_active_leagues_count >= 2 THEN
        RAISE EXCEPTION 'Siz bir vaqtning o''zida ko''pi bilan 2 ta faol ligada qatnashishingiz mumkin.';
    END IF;

    -- 4. Generate unique 6-character code
    v_code := public.generate_unique_league_code();

    -- 5. Create League
    INSERT INTO public.leagues (name, code, mode, status, owner_manager_id)
    VALUES (trim(p_league_name), v_code, 'GIGANTS', 'LOBBY', p_owner_manager_id)
    RETURNING id INTO v_league_id;

    -- 6. Reserve code permanently in registry
    INSERT INTO public.league_code_registry (code, league_id)
    VALUES (v_code, v_league_id);

    -- 7. Create League Settings
    INSERT INTO public.league_settings (league_id, round_speed, is_speed_locked, max_human_managers)
    VALUES (v_league_id, p_round_speed, FALSE, 20);

    -- 8. Add Owner Membership
    INSERT INTO public.league_members (league_id, manager_id, role)
    VALUES (v_league_id, p_owner_manager_id, 'OWNER');

    -- 9. Return outcome
    SELECT jsonb_build_object(
        'league_id', l.id,
        'name', l.name,
        'code', l.code,
        'status', l.status,
        'round_speed', ls.round_speed,
        'created_at', l.created_at
    ) INTO v_result
    FROM public.leagues l
    JOIN public.league_settings ls ON ls.league_id = l.id
    WHERE l.id = v_league_id;

    RETURN v_result;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

-- B. Join League by Code
CREATE OR REPLACE FUNCTION public.join_league_by_code(
    p_manager_id UUID,
    p_code VARCHAR(6)
)
RETURNS JSONB AS $$
DECLARE
    v_clean_code VARCHAR(6);
    v_league RECORD;
    v_manager_status public.enum_manager_status;
    v_active_leagues_count INT;
    v_active_members_count INT;
    v_already_member BOOLEAN;
    v_result JSONB;
BEGIN
    v_clean_code := upper(trim(p_code));

    -- 1. Advisory lock on manager
    PERFORM pg_advisory_xact_lock(hashtext('manager_' || p_manager_id::text));

    -- 2. Locate league
    SELECT * INTO v_league FROM public.leagues WHERE code = v_clean_code;
    IF v_league.id IS NULL THEN
        RAISE EXCEPTION 'Ushbu taklif kodi bo''yicha liga topilmadi.';
    END IF;

    IF v_league.status <> 'LOBBY' THEN
        RAISE EXCEPTION 'Ushbu liga allaqachon boshlangan yoki yakunlangan. Qo''shilish imkonsiz.';
    END IF;

    -- 3. Advisory lock on league
    PERFORM pg_advisory_xact_lock(hashtext('league_' || v_league.id::text));

    -- 4. Verify manager status
    SELECT status INTO v_manager_status FROM public.managers WHERE id = p_manager_id;
    IF v_manager_status IS NULL THEN
        RAISE EXCEPTION 'Menejer topilmadi.';
    ELSIF v_manager_status <> 'ACTIVE' THEN
        RAISE EXCEPTION 'Bloklangan yoki faol bo''lmagan menejer ligaga qo''shila olmaydi.';
    END IF;

    -- 5. Verify manager active counting leagues < 2
    SELECT COUNT(DISTINCT lm.league_id) INTO v_active_leagues_count
    FROM public.league_members lm
    JOIN public.leagues l ON l.id = lm.league_id
    WHERE lm.manager_id = p_manager_id
      AND lm.left_at IS NULL
      AND l.status IN ('LOBBY', 'STARTING', 'ACTIVE', 'PAUSED');

    IF v_active_leagues_count >= 2 THEN
        RAISE EXCEPTION 'Siz bir vaqtning o''zida ko''pi bilan 2 ta faol ligada qatnashishingiz mumkin.';
    END IF;

    -- 6. Check active human members < 20
    SELECT COUNT(*) INTO v_active_members_count
    FROM public.league_members
    WHERE league_id = v_league.id AND left_at IS NULL;

    IF v_active_members_count >= 20 THEN
        RAISE EXCEPTION 'Ushbu ligada maksimal (20 ta) odam-menejerlar o me me''yori to'’lgan.';
    END IF;

    -- 7. Check manager not already in league
    SELECT EXISTS (
        SELECT 1 FROM public.league_members
        WHERE league_id = v_league.id AND manager_id = p_manager_id AND left_at IS NULL
    ) INTO v_already_member;

    IF v_already_member THEN
        RAISE EXCEPTION 'Siz allaqachon ushbu liganing a''zosisiz.';
    END IF;

    -- 8. Add Member
    INSERT INTO public.league_members (league_id, manager_id, role)
    VALUES (v_league.id, p_manager_id, 'MEMBER');

    -- 9. Return JSON outcome
    SELECT jsonb_build_object(
        'league_id', l.id,
        'name', l.name,
        'code', l.code,
        'status', l.status,
        'member_role', 'MEMBER',
        'joined_at', NOW()
    ) INTO v_result
    FROM public.leagues l
    WHERE l.id = v_league.id;

    RETURN v_result;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

-- C. Leave Lobby League
CREATE OR REPLACE FUNCTION public.leave_lobby_league(
    p_manager_id UUID,
    p_league_id UUID
)
RETURNS JSONB AS $$
DECLARE
    v_league_status public.enum_league_status;
    v_member_role public.enum_league_member_role;
BEGIN
    SELECT status INTO v_league_status FROM public.leagues WHERE id = p_league_id;
    IF v_league_status IS NULL THEN
        RAISE EXCEPTION 'Liga topilmadi.';
    ELSIF v_league_status <> 'LOBBY' THEN
        RAISE EXCEPTION 'Liga boshlangandan so''ng undan chiqish imkonsiz.';
    END IF;

    SELECT role INTO v_member_role
    FROM public.league_members
    WHERE league_id = p_league_id AND manager_id = p_manager_id AND left_at IS NULL;

    IF v_member_role IS NULL THEN
        RAISE EXCEPTION 'Siz ushbu liganing faol a''zosi emassiz.';
    ELSIF v_member_role = 'OWNER' THEN
        RAISE EXCEPTION 'Liga egasi (OWNER) ligadan chiqa olmaydi. Liga egasi ligani to''liq o''chirishi mumkin.';
    END IF;

    UPDATE public.league_members
    SET left_at = NOW()
    WHERE league_id = p_league_id AND manager_id = p_manager_id AND left_at IS NULL;

    RETURN jsonb_build_object('success', true, 'message', 'Ligadan muvaffaqiyatli chiqdingiz.');
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

-- D. Delete Lobby League
CREATE OR REPLACE FUNCTION public.delete_lobby_league(
    p_owner_manager_id UUID,
    p_league_id UUID
)
RETURNS JSONB AS $$
DECLARE
    v_league RECORD;
BEGIN
    SELECT * INTO v_league FROM public.leagues WHERE id = p_league_id;
    IF v_league.id IS NULL THEN
        RAISE EXCEPTION 'Liga topilmadi.';
    END IF;

    IF v_league.owner_manager_id <> p_owner_manager_id THEN
        RAISE EXCEPTION 'Faqat liga egasi ligani o''chirish huquqiga ega.';
    END IF;

    IF v_league.status <> 'LOBBY' THEN
        RAISE EXCEPTION 'Faqat LOBBY holatidagi ligalarni o''chirish mumkin.';
    END IF;

    -- Unbind code in registry so code is preserved permanently without deletion
    UPDATE public.league_code_registry SET league_id = NULL WHERE league_id = p_league_id;

    -- Delete league (cascades to members, settings, rounds)
    DELETE FROM public.leagues WHERE id = p_league_id;

    RETURN jsonb_build_object('success', true, 'message', 'Liga muvaffaqiyatli o''chirildi. Taklif kodi bazada saqlandi.');
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

-- 10. Row Level Security (RLS) & Default Grants
ALTER TABLE public.leagues ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.league_code_registry ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.league_members ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.league_settings ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.league_rounds ENABLE ROW LEVEL SECURITY;

-- Revoke permissions from public API roles (anon, authenticated)
REVOKE ALL ON TABLE public.leagues FROM anon, authenticated;
REVOKE ALL ON TABLE public.league_code_registry FROM anon, authenticated;
REVOKE ALL ON TABLE public.league_members FROM anon, authenticated;
REVOKE ALL ON TABLE public.league_settings FROM anon, authenticated;
REVOKE ALL ON TABLE public.league_rounds FROM anon, authenticated;

REVOKE EXECUTE ON FUNCTION public.generate_unique_league_code() FROM PUBLIC, anon, authenticated;
REVOKE EXECUTE ON FUNCTION public.create_league_with_owner(UUID, VARCHAR, INT) FROM PUBLIC, anon, authenticated;
REVOKE EXECUTE ON FUNCTION public.join_league_by_code(UUID, VARCHAR) FROM PUBLIC, anon, authenticated;
REVOKE EXECUTE ON FUNCTION public.leave_lobby_league(UUID, UUID) FROM PUBLIC, anon, authenticated;
REVOKE EXECUTE ON FUNCTION public.delete_lobby_league(UUID, UUID) FROM PUBLIC, anon, authenticated;

-- Grant permissions to backend service_role only
GRANT ALL ON TABLE public.leagues TO service_role;
GRANT ALL ON TABLE public.league_code_registry TO service_role;
GRANT ALL ON TABLE public.league_members TO service_role;
GRANT ALL ON TABLE public.league_settings TO service_role;
GRANT ALL ON TABLE public.league_rounds TO service_role;

GRANT EXECUTE ON FUNCTION public.generate_unique_league_code() TO service_role;
GRANT EXECUTE ON FUNCTION public.create_league_with_owner(UUID, VARCHAR, INT) TO service_role;
GRANT EXECUTE ON FUNCTION public.join_league_by_code(UUID, VARCHAR) TO service_role;
GRANT EXECUTE ON FUNCTION public.leave_lobby_league(UUID, UUID) TO service_role;
GRANT EXECUTE ON FUNCTION public.delete_lobby_league(UUID, UUID) TO service_role;
