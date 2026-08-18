-- Supabase Migration: Create Leagues and Membership Database Foundation (Hardened & Corrected)
-- Target Schema: public
-- Security: RLS Enabled on all tables, Service Role Access Restricted

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

-- Note: The approved invitation code alphabet is 'ABCDEFGHJKMNPQRSTUVWXYZ23456789' (exactly 31 characters).
-- It excludes O, 0, I, L, 1 to prevent user visual confusion.

-- 2. Leagues Table
CREATE TABLE public.leagues (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(50) NOT NULL CONSTRAINT chk_leagues_name_length CHECK (length(trim(name)) BETWEEN 3 AND 50),
    code VARCHAR(6) UNIQUE NOT NULL CONSTRAINT chk_leagues_code_format CHECK (code ~ '^[ABCDEFGHJKMNPQRSTUVWXYZ23456789]{6}$'),
    mode public.enum_league_mode NOT NULL DEFAULT 'GIGANTS',
    status public.enum_league_status NOT NULL DEFAULT 'LOBBY',
    owner_manager_id UUID NOT NULL REFERENCES public.managers(id) ON DELETE RESTRICT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    started_at TIMESTAMPTZ,
    completed_at TIMESTAMPTZ,
    cancelled_at TIMESTAMPTZ,
    CONSTRAINT chk_leagues_completed_status CHECK (status != 'COMPLETED' OR (completed_at IS NOT NULL AND started_at IS NOT NULL)),
    CONSTRAINT chk_leagues_completed_at_null CHECK (status = 'COMPLETED' OR completed_at IS NULL),
    CONSTRAINT chk_leagues_cancelled_status CHECK (status != 'CANCELLED' OR cancelled_at IS NOT NULL),
    CONSTRAINT chk_leagues_cancelled_at_null CHECK (status = 'CANCELLED' OR cancelled_at IS NULL),
    CONSTRAINT chk_leagues_started_status CHECK (status NOT IN ('STARTING', 'ACTIVE', 'PAUSED', 'COMPLETED') OR started_at IS NOT NULL),
    CONSTRAINT chk_leagues_started_at_order CHECK (started_at IS NULL OR started_at >= created_at),
    CONSTRAINT chk_leagues_completed_at_order CHECK (completed_at IS NULL OR completed_at >= started_at),
    CONSTRAINT chk_leagues_cancelled_at_order CHECK (cancelled_at IS NULL OR cancelled_at >= created_at)
);

COMMENT ON TABLE public.leagues IS 'Primary league instances for multiplayer Football Manager competitions.';
COMMENT ON COLUMN public.leagues.code IS '6-character invitation code using approved non-confusing 31-character charset ABCDEFGHJKMNPQRSTUVWXYZ23456789.';

CREATE INDEX idx_leagues_owner_manager_id ON public.leagues (owner_manager_id);
CREATE INDEX idx_leagues_code ON public.leagues (code);
CREATE INDEX idx_leagues_status ON public.leagues (status);
CREATE INDEX idx_leagues_created_at ON public.leagues (created_at);

CREATE TRIGGER trg_leagues_updated_at
    BEFORE UPDATE ON public.leagues
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- 3. Permanent League Code Registry Table
CREATE TABLE public.league_code_registry (
    code VARCHAR(6) PRIMARY KEY CONSTRAINT chk_league_code_registry_code_format CHECK (code ~ '^[ABCDEFGHJKMNPQRSTUVWXYZ23456789]{6}$'),
    league_id UUID UNIQUE REFERENCES public.leagues(id) ON DELETE RESTRICT,
    bound_at TIMESTAMPTZ,
    released_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT chk_league_code_registry_bound_before_released CHECK (released_at IS NULL OR (bound_at IS NOT NULL AND released_at >= bound_at))
);

COMMENT ON TABLE public.league_code_registry IS 'Permanent registry preserving created invitation codes to prevent reuse across deleted leagues.';

-- Code Registry State Lifecycle & Immutability Trigger
CREATE OR REPLACE FUNCTION public.prevent_code_registry_modification()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'DELETE' THEN
        RAISE EXCEPTION 'league_code_registry dan kodlarni o''chirish taqiqlangan. Kodlar doimiy saqlanadi.' USING ERRCODE = 'P0001';
    ELSIF TG_OP = 'UPDATE' THEN
        -- Allow no-op updates
        IF NEW.code IS NOT DISTINCT FROM OLD.code
           AND NEW.league_id IS NOT DISTINCT FROM OLD.league_id
           AND NEW.bound_at IS NOT DISTINCT FROM OLD.bound_at
           AND NEW.released_at IS NOT DISTINCT FROM OLD.released_at THEN
            RETURN NEW;
        END IF;

        IF OLD.code <> NEW.code THEN
            RAISE EXCEPTION 'league_code_registry kodini o''zgartirish taqiqlangan.' USING ERRCODE = 'P0001';
        END IF;

        -- Transition A: Reserved -> Bound (OLD.league_id IS NULL -> NEW.league_id IS NOT NULL, NEW.bound_at IS NOT NULL, NEW.released_at IS NULL)
        IF OLD.league_id IS NULL AND OLD.bound_at IS NULL AND OLD.released_at IS NULL
           AND NEW.league_id IS NOT NULL AND NEW.bound_at IS NOT NULL AND NEW.released_at IS NULL THEN
            RETURN NEW;
        END IF;

        -- Transition B: Bound -> Released (OLD.league_id IS NOT NULL -> NEW.league_id IS NULL, NEW.released_at IS NOT NULL)
        IF OLD.league_id IS NOT NULL AND OLD.bound_at IS NOT NULL AND OLD.released_at IS NULL
           AND NEW.league_id IS NULL AND NEW.bound_at = OLD.bound_at AND NEW.released_at IS NOT NULL THEN
            RETURN NEW;
        END IF;

        RAISE EXCEPTION 'league_code_registry bo''yicha taqiqlangan holat o''tishi.' USING ERRCODE = 'P0001';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

CREATE TRIGGER trg_prevent_code_registry_modification
    BEFORE UPDATE OR DELETE ON public.league_code_registry
    FOR EACH ROW EXECUTE FUNCTION public.prevent_code_registry_modification();

-- 4. Cryptographic Unique Code Generator Function (Unbiased Rejection Sampling)
CREATE OR REPLACE FUNCTION public.generate_unique_league_code()
RETURNS VARCHAR(6) AS $$
DECLARE
    chars CONSTANT TEXT := 'ABCDEFGHJKMNPQRSTUVWXYZ23456789'; -- 31 characters
    bytes BYTEA;
    result VARCHAR(6) := '';
    i INT;
    byte_val INT;
    attempts INT := 0;
    max_attempts CONSTANT INT := 50;
    code_exists BOOLEAN;
BEGIN
    LOOP
        attempts := attempts + 1;
        IF attempts > max_attempts THEN
            RAISE EXCEPTION 'Noyob liga kodini generatsiya qilib bo''lmadi. Iltimos qaytadan urinib ko''ring.' USING ERRCODE = 'P0001';
        END IF;

        result := '';
        -- Generate batches of 16 random bytes and perform rejection sampling for 31-char alphabet (reject 248..255)
        WHILE length(result) < 6 LOOP
            bytes := extensions.gen_random_bytes(16);
            FOR i IN 0..15 LOOP
                byte_val := get_byte(bytes, i);
                IF byte_val < 248 THEN -- 248 = 31 * 8; rejects byte values 248..255 for uniform 1/31 sampling
                    result := result || substr(chars, (byte_val % 31) + 1, 1);
                    IF length(result) = 6 THEN
                        EXIT;
                    END IF;
                END IF;
            END LOOP;
        END LOOP;

        IF length(result) <> 6 THEN
            RAISE EXCEPTION 'Generatsiya qilingan kod uzunligi 6 emas.' USING ERRCODE = 'P0001';
        END IF;

        SELECT EXISTS (
            SELECT 1 FROM public.league_code_registry WHERE code = result
        ) INTO code_exists;

        IF NOT code_exists THEN
            RETURN result;
        END IF;
    END LOOP;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public, extensions;

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

-- Direct DML Enforcement Trigger for League Members
CREATE OR REPLACE FUNCTION public.enforce_league_members_rules()
RETURNS TRIGGER AS $$
DECLARE
    v_manager_status public.enum_manager_status;
    v_is_blocked BOOLEAN;
    v_league_status public.enum_league_status;
    v_league_owner_id UUID;
    v_active_leagues_count INT;
    v_active_members_count INT;
BEGIN
    IF TG_OP = 'INSERT' THEN
        -- Advisory locks in canonical order: manager lock, then league lock
        PERFORM pg_advisory_xact_lock(hashtext('manager_' || NEW.manager_id::text));
        PERFORM pg_advisory_xact_lock(hashtext('league_' || NEW.league_id::text));

        -- 1. Check Manager exists & ACTIVE
        SELECT status INTO v_manager_status FROM public.managers WHERE id = NEW.manager_id;
        IF v_manager_status IS NULL OR v_manager_status <> 'ACTIVE' THEN
            RAISE EXCEPTION 'Faol bo''lmagan menejer ligaga a''zo bo''la olmaydi.' USING ERRCODE = 'P0001';
        END IF;

        -- 2. Check Active Block
        SELECT EXISTS (
            SELECT 1 FROM public.manager_blocks WHERE manager_id = NEW.manager_id AND unblocked_at IS NULL
        ) INTO v_is_blocked;
        IF v_is_blocked THEN
            RAISE EXCEPTION 'Bloklangan menejer ligada harakat qila olmaydi.' USING ERRCODE = 'P0001';
        END IF;

        -- 3. Check League Status & Owner Match
        SELECT status, owner_manager_id INTO v_league_status, v_league_owner_id
        FROM public.leagues WHERE id = NEW.league_id;

        IF v_league_status IS NULL THEN
            RAISE EXCEPTION 'Liga topilmadi.' USING ERRCODE = 'P0001';
        ELSIF v_league_status <> 'LOBBY' THEN
            RAISE EXCEPTION 'Faqat LOBBY holatidagi ligaga qo''shilish mumkin.' USING ERRCODE = 'P0001';
        END IF;

        IF NEW.role = 'OWNER' AND NEW.manager_id <> v_league_owner_id THEN
            RAISE EXCEPTION 'A''zoning OWNER roli faqat liga egasiga mos kelishi shart.' USING ERRCODE = 'P0001';
        END IF;

        -- 4. Check Max 2 Active Counting Leagues per Manager
        SELECT COUNT(DISTINCT lm.league_id) INTO v_active_leagues_count
        FROM public.league_members lm
        JOIN public.leagues l ON l.id = lm.league_id
        WHERE lm.manager_id = NEW.manager_id
          AND lm.left_at IS NULL
          AND l.status IN ('LOBBY', 'STARTING', 'ACTIVE', 'PAUSED');

        IF v_active_leagues_count >= 2 THEN
            RAISE EXCEPTION 'Siz bir vaqtning o''zida ko''pi bilan 2 ta faol ligada qatnashishingiz mumkin.' USING ERRCODE = 'P0001';
        END IF;

        -- 5. Check Max 20 Active Human Members per League
        SELECT COUNT(*) INTO v_active_members_count
        FROM public.league_members
        WHERE league_id = NEW.league_id AND left_at IS NULL;

        IF v_active_members_count >= 20 THEN
            RAISE EXCEPTION 'Ushbu ligada maksimal (20 ta) odam-menejerlar o''rni to''lgan.' USING ERRCODE = 'P0001';
        END IF;

    ELSIF TG_OP = 'UPDATE' THEN
        -- Prevent changing core identifiers or roles
        IF OLD.manager_id <> NEW.manager_id OR OLD.league_id <> NEW.league_id OR OLD.role <> NEW.role THEN
            RAISE EXCEPTION 'league_members kalit ma''lumotlari va rolini o''zgartirish taqiqlangan.' USING ERRCODE = 'P0001';
        END IF;

        -- Check left_at modifications
        IF OLD.left_at IS NULL AND NEW.left_at IS NOT NULL THEN
            IF OLD.role = 'OWNER' THEN
                RAISE EXCEPTION 'Liga egasi (OWNER) a''zolikdan chiqa olmaydi. Ligani o''chirishi lozim.' USING ERRCODE = 'P0001';
            END IF;

            SELECT status INTO v_league_status FROM public.leagues WHERE id = NEW.league_id;
            IF v_league_status <> 'LOBBY' THEN
                RAISE EXCEPTION 'Liga LOBBY holatidan chiqqach, a''zolar tarkibdan chiqa olmaydi.' USING ERRCODE = 'P0001';
            END IF;
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

CREATE TRIGGER trg_enforce_league_members_rules
    BEFORE INSERT OR UPDATE ON public.league_members
    FOR EACH ROW EXECUTE FUNCTION public.enforce_league_members_rules();

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

    -- Prevent unlocking speed settings
    IF OLD.is_speed_locked AND NOT NEW.is_speed_locked THEN
        RAISE EXCEPTION 'Qulflangan o''yin sozlamalarini (is_speed_locked) qayta ochish taqiqlangan.' USING ERRCODE = 'P0001';
    END IF;

    -- Protect fields if league is no longer LOBBY or settings are locked
    IF OLD.is_speed_locked OR v_league_status <> 'LOBBY' THEN
        IF OLD.round_speed <> NEW.round_speed THEN
            RAISE EXCEPTION 'O''yin tezligini (round_speed) faqat LOBBY holatida o''zgartirish mumkin.' USING ERRCODE = 'P0001';
        END IF;
        IF OLD.first_round_delay_minutes <> NEW.first_round_delay_minutes THEN
            RAISE EXCEPTION 'Birinchi tur kechikish vaqtini faqat LOBBY holatida o''zgartirish mumkin.' USING ERRCODE = 'P0001';
        END IF;
        IF OLD.max_human_managers <> NEW.max_human_managers THEN
            RAISE EXCEPTION 'Maksimal menejerlar sonini o''zgartirish taqiqlangan.' USING ERRCODE = 'P0001';
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
    CONSTRAINT chk_league_rounds_completed_status CHECK (status <> 'COMPLETED' OR (started_at IS NOT NULL AND completed_at IS NOT NULL AND completed_at >= started_at)),
    CONSTRAINT chk_league_rounds_completed_at_req CHECK (completed_at IS NULL OR started_at IS NOT NULL),
    CONSTRAINT chk_league_rounds_in_progress CHECK (status <> 'IN_PROGRESS' OR (scheduled_at IS NOT NULL AND started_at IS NOT NULL)),
    CONSTRAINT chk_league_rounds_failed CHECK (status <> 'FAILED' OR (failure_reason IS NOT NULL AND length(trim(failure_reason)) > 0)),
    CONSTRAINT chk_league_rounds_scheduled CHECK (status <> 'SCHEDULED' OR completed_at IS NULL)
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
        UPDATE public.league_settings SET is_speed_locked = TRUE WHERE league_id = NEW.id;
        IF NEW.status = 'STARTING' THEN
            NEW.started_at := COALESCE(NEW.started_at, NOW());
        ELSIF NEW.status = 'CANCELLED' THEN
            NEW.cancelled_at := COALESCE(NEW.cancelled_at, NOW());
        END IF;
        RETURN NEW;
    ELSIF OLD.status = 'STARTING' AND NEW.status IN ('ACTIVE', 'CANCELLED') THEN
        IF NEW.status = 'CANCELLED' THEN
            NEW.cancelled_at := COALESCE(NEW.cancelled_at, NOW());
        END IF;
        RETURN NEW;
    ELSIF OLD.status = 'ACTIVE' AND NEW.status IN ('PAUSED', 'COMPLETED') THEN
        IF NEW.status = 'COMPLETED' THEN
            NEW.completed_at := COALESCE(NEW.completed_at, NOW());
        END IF;
        RETURN NEW;
    ELSIF OLD.status = 'PAUSED' AND NEW.status IN ('ACTIVE', 'CANCELLED') THEN
        IF NEW.status = 'CANCELLED' THEN
            NEW.cancelled_at := COALESCE(NEW.cancelled_at, NOW());
        END IF;
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'Liganing % holatidan % holatiga o''tishi taqiqlangan.', OLD.status, NEW.status USING ERRCODE = 'P0001';
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
        RAISE EXCEPTION 'Boshlangan, faol yoki yakunlangan ligalarni bazadan to''g''ridan-to''g''ri o''chirish taqiqlangan.' USING ERRCODE = 'P0001';
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
    v_is_blocked BOOLEAN;
    v_code VARCHAR(6);
    v_league_id UUID;
    v_attempts INT := 0;
    v_result JSONB;
BEGIN
    -- 1. Advisory lock on manager
    PERFORM pg_advisory_xact_lock(hashtext('manager_' || p_owner_manager_id::text));

    -- 2. Verify manager exists and is ACTIVE
    SELECT status INTO v_manager_status FROM public.managers WHERE id = p_owner_manager_id;
    IF v_manager_status IS NULL THEN
        RAISE EXCEPTION 'Menejer topilmadi.' USING ERRCODE = 'P0001';
    ELSIF v_manager_status <> 'ACTIVE' THEN
        RAISE EXCEPTION 'Bloklangan yoki faol bo''lmagan menejer liga yarata olmaydi.' USING ERRCODE = 'P0001';
    END IF;

    -- Check active block
    SELECT EXISTS (
        SELECT 1 FROM public.manager_blocks WHERE manager_id = p_owner_manager_id AND unblocked_at IS NULL
    ) INTO v_is_blocked;
    IF v_is_blocked THEN
        RAISE EXCEPTION 'Bloklangan menejer ligada harakat qila olmaydi.' USING ERRCODE = 'P0001';
    END IF;

    -- 3. Atomic Code Reservation Loop (INSERT candidate into registry with league_id NULL first)
    LOOP
        v_attempts := v_attempts + 1;
        IF v_attempts > 50 THEN
            RAISE EXCEPTION 'Noyob liga kodini rezerv qilib bo''lmadi. Iltimos qaytadan urinib ko''ring.' USING ERRCODE = 'P0001';
        END IF;

        v_code := public.generate_unique_league_code();

        BEGIN
            INSERT INTO public.league_code_registry (code, league_id)
            VALUES (v_code, NULL);
            EXIT;
        EXCEPTION WHEN unique_violation THEN
            -- Collision retry
        END;
    END LOOP;

    -- 4. Create League
    INSERT INTO public.leagues (name, code, mode, status, owner_manager_id)
    VALUES (trim(p_league_name), v_code, 'GIGANTS', 'LOBBY', p_owner_manager_id)
    RETURNING id INTO v_league_id;

    -- 5. Bind reserved code in registry
    UPDATE public.league_code_registry
    SET league_id = v_league_id, bound_at = NOW()
    WHERE code = v_code;

    -- 6. Create League Settings
    INSERT INTO public.league_settings (league_id, round_speed, is_speed_locked, max_human_managers)
    VALUES (v_league_id, p_round_speed, FALSE, 20);

    -- 7. Add Owner Membership (triggers enforce rules and active limits)
    INSERT INTO public.league_members (league_id, manager_id, role)
    VALUES (v_league_id, p_owner_manager_id, 'OWNER');

    -- 8. Return outcome
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
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public, extensions;

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
    v_is_blocked BOOLEAN;
    v_result JSONB;
BEGIN
    v_clean_code := upper(trim(p_code));

    -- 1. Lock manager
    PERFORM pg_advisory_xact_lock(hashtext('manager_' || p_manager_id::text));

    -- 2. Locate league
    SELECT * INTO v_league FROM public.leagues WHERE code = v_clean_code;
    IF v_league.id IS NULL THEN
        RAISE EXCEPTION 'Ushbu taklif kodi bo''yicha liga topilmadi.' USING ERRCODE = 'P0001';
    END IF;

    IF v_league.status <> 'LOBBY' THEN
        RAISE EXCEPTION 'Ushbu liga allaqachon boshlangan yoki yakunlangan. Qo''shilish imkonsiz.' USING ERRCODE = 'P0001';
    END IF;

    -- 3. Lock league
    PERFORM pg_advisory_xact_lock(hashtext('league_' || v_league.id::text));

    -- 4. Check manager status and block
    SELECT status INTO v_manager_status FROM public.managers WHERE id = p_manager_id;
    IF v_manager_status IS NULL OR v_manager_status <> 'ACTIVE' THEN
        RAISE EXCEPTION 'Bloklangan yoki faol bo''lmagan menejer ligaga qo''shila olmaydi.' USING ERRCODE = 'P0001';
    END IF;

    SELECT EXISTS (
        SELECT 1 FROM public.manager_blocks WHERE manager_id = p_manager_id AND unblocked_at IS NULL
    ) INTO v_is_blocked;
    IF v_is_blocked THEN
        RAISE EXCEPTION 'Bloklangan menejer ligada harakat qila olmaydi.' USING ERRCODE = 'P0001';
    END IF;

    -- 5. Add Member (triggers enforce active leagues and max 20 limits)
    INSERT INTO public.league_members (league_id, manager_id, role)
    VALUES (v_league.id, p_manager_id, 'MEMBER');

    -- 6. Return JSON outcome
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
    v_league RECORD;
BEGIN
    PERFORM pg_advisory_xact_lock(hashtext('manager_' || p_manager_id::text));
    PERFORM pg_advisory_xact_lock(hashtext('league_' || p_league_id::text));

    SELECT * INTO v_league FROM public.leagues WHERE id = p_league_id FOR UPDATE;
    IF v_league.id IS NULL THEN
        RAISE EXCEPTION 'Liga topilmadi.' USING ERRCODE = 'P0001';
    ELSIF v_league.status <> 'LOBBY' THEN
        RAISE EXCEPTION 'Liga boshlangandan so''ng undan chiqish imkonsiz.' USING ERRCODE = 'P0001';
    END IF;

    -- Trigger trg_enforce_league_members_rules will validate OWNER role and status
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
    PERFORM pg_advisory_xact_lock(hashtext('manager_' || p_owner_manager_id::text));
    PERFORM pg_advisory_xact_lock(hashtext('league_' || p_league_id::text));

    SELECT * INTO v_league FROM public.leagues WHERE id = p_league_id FOR UPDATE;
    IF v_league.id IS NULL THEN
        RAISE EXCEPTION 'Liga topilmadi.' USING ERRCODE = 'P0001';
    END IF;

    IF v_league.owner_manager_id <> p_owner_manager_id THEN
        RAISE EXCEPTION 'Faqat liga egasi ligani o''chirish huquqiga ega.' USING ERRCODE = 'P0001';
    END IF;

    IF v_league.status <> 'LOBBY' THEN
        RAISE EXCEPTION 'Faqat LOBBY holatidagi ligalarni o''chirish mumkin.' USING ERRCODE = 'P0001';
    END IF;

    -- Unbind code in registry to mark as permanently released (Transition B)
    UPDATE public.league_code_registry
    SET league_id = NULL, released_at = NOW()
    WHERE league_id = p_league_id;

    -- Delete league (cascades to members, settings, rounds)
    DELETE FROM public.leagues WHERE id = p_league_id;

    RETURN jsonb_build_object('success', true, 'message', 'Liga muvaffaqiyatli o''chirildi. Taklif kodi bazada saqlandi.');
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

-- 10. Row Level Security (RLS) & Strict Least Privilege Grants
ALTER TABLE public.leagues ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.league_code_registry ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.league_members ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.league_settings ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.league_rounds ENABLE ROW LEVEL SECURITY;

-- Revoke all permissions from untrusted API roles (anon, authenticated)
REVOKE ALL ON TABLE public.leagues FROM anon, authenticated;
REVOKE ALL ON TABLE public.league_code_registry FROM anon, authenticated;
REVOKE ALL ON TABLE public.league_members FROM anon, authenticated;
REVOKE ALL ON TABLE public.league_settings FROM anon, authenticated;
REVOKE ALL ON TABLE public.league_rounds FROM anon, authenticated;

-- Revoke execution of functions from PUBLIC, anon, authenticated
REVOKE EXECUTE ON FUNCTION public.generate_unique_league_code() FROM PUBLIC, anon, authenticated, service_role;
REVOKE EXECUTE ON FUNCTION public.create_league_with_owner(UUID, VARCHAR, INT) FROM PUBLIC, anon, authenticated;
REVOKE EXECUTE ON FUNCTION public.join_league_by_code(UUID, VARCHAR) FROM PUBLIC, anon, authenticated;
REVOKE EXECUTE ON FUNCTION public.leave_lobby_league(UUID, UUID) FROM PUBLIC, anon, authenticated;
REVOKE EXECUTE ON FUNCTION public.delete_lobby_league(UUID, UUID) FROM PUBLIC, anon, authenticated;

-- Grant minimal necessary table permissions to service_role (mutations boundary enforced via RPC functions)
GRANT SELECT, UPDATE ON TABLE public.leagues TO service_role;
GRANT SELECT ON TABLE public.league_code_registry TO service_role;
GRANT SELECT ON TABLE public.league_members TO service_role;
GRANT SELECT, UPDATE ON TABLE public.league_settings TO service_role;
GRANT SELECT, INSERT, UPDATE ON TABLE public.league_rounds TO service_role;

-- Grant RPC function execution ONLY to service_role
GRANT EXECUTE ON FUNCTION public.create_league_with_owner(UUID, VARCHAR, INT) TO service_role;
GRANT EXECUTE ON FUNCTION public.join_league_by_code(UUID, VARCHAR) TO service_role;
GRANT EXECUTE ON FUNCTION public.leave_lobby_league(UUID, UUID) TO service_role;
GRANT EXECUTE ON FUNCTION public.delete_lobby_league(UUID, UUID) TO service_role;
