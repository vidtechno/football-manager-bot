-- SQL Migration: Phase 4C - Global Club and Player Templates Database Foundation
-- Creates reusable club templates, player templates, position mappings, versioning models, RPC functions, RLS policies, and inserts initial 20 stable club identities.

-- 1. Position Enum Type
-- Supported Positions: GK, LB, RB, CB, CDM, CM, CAM, LM, RM, LW, RW, ST
-- Derived broad groups:
--   GK -> goalkeeper
--   LB, RB, CB -> defender
--   CDM, CM, CAM, LM, RM -> midfielder
--   LW, RW, ST -> forward
CREATE TYPE public.enum_player_position AS ENUM (
    'GK',
    'LB',
    'RB',
    'CB',
    'CDM',
    'CM',
    'CAM',
    'LM',
    'RM',
    'LW',
    'RW',
    'ST'
);

-- 2. Table: club_templates (Stable Club Identity)
CREATE TABLE public.club_templates (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    slug VARCHAR(50) NOT NULL UNIQUE CHECK (slug ~ '^[a-z0-9-]+$' AND slug = lower(slug)),
    name VARCHAR(100) NOT NULL CHECK (char_length(trim(name)) > 0),
    short_code VARCHAR(10) NOT NULL UNIQUE CHECK (short_code ~ '^[A-Z0-9]{2,10}$'),
    country VARCHAR(100) NOT NULL CHECK (char_length(trim(country)) > 0),
    logo_url TEXT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Indexes for club_templates
CREATE INDEX idx_club_templates_slug ON public.club_templates(slug);
CREATE INDEX idx_club_templates_short_code ON public.club_templates(short_code);
CREATE INDEX idx_club_templates_country ON public.club_templates(country);
CREATE INDEX idx_club_templates_is_active ON public.club_templates(is_active);

-- Trigger: Updated_at for club_templates
CREATE TRIGGER trg_club_templates_updated_at
    BEFORE UPDATE ON public.club_templates
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- Trigger Function & Trigger: Prevent club_templates slug change
CREATE OR REPLACE FUNCTION public.prevent_club_template_slug_change()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.slug <> NEW.slug THEN
        RAISE EXCEPTION 'Club template slug ko''rsatkichini o''zgartirish taqiqlangan.' USING ERRCODE = 'P0001';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

CREATE TRIGGER trg_prevent_club_template_slug_change
    BEFORE UPDATE ON public.club_templates
    FOR EACH ROW EXECUTE FUNCTION public.prevent_club_template_slug_change();


-- 3. Table: club_template_versions (Immutable Version History)
CREATE TABLE public.club_template_versions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    club_template_id UUID NOT NULL REFERENCES public.club_templates(id) ON DELETE RESTRICT,
    version INT NOT NULL CHECK (version > 0),
    reputation INT NOT NULL CHECK (reputation BETWEEN 1 AND 100),
    base_squad_value NUMERIC(15, 2) NOT NULL CHECK (base_squad_value >= 0),
    effective_from TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    effective_to TIMESTAMPTZ NULL,
    is_current BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by_admin_id UUID NULL REFERENCES public.admin_users(id) ON DELETE SET NULL,
    CONSTRAINT uq_club_template_version UNIQUE (club_template_id, version),
    CHECK (effective_to IS NULL OR effective_to >= effective_from)
);

-- Partial Unique Index: Only one current version per club template
CREATE UNIQUE INDEX uq_club_template_versions_current 
    ON public.club_template_versions (club_template_id) 
    WHERE (is_current = TRUE);

-- Indexes for club_template_versions
CREATE INDEX idx_club_template_versions_club_id ON public.club_template_versions(club_template_id);
CREATE INDEX idx_club_template_versions_current ON public.club_template_versions(club_template_id, is_current);

-- Trigger Function & Trigger: Immutability guard for club_template_versions
CREATE OR REPLACE FUNCTION public.prevent_club_template_versions_modification()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'DELETE' THEN
        RAISE EXCEPTION 'Klub shabloni versiyalarini o''chirish taqiqlangan.' USING ERRCODE = 'P0001';
    ELSIF TG_OP = 'UPDATE' THEN
        -- Allow archiving: changing is_current from TRUE to FALSE and updating effective_to
        IF OLD.is_current = TRUE AND NEW.is_current = FALSE
           AND OLD.club_template_id = NEW.club_template_id
           AND OLD.version = NEW.version
           AND OLD.reputation = NEW.reputation
           AND OLD.base_squad_value = NEW.base_squad_value
           AND OLD.effective_from = NEW.effective_from THEN
            RETURN NEW;
        END IF;

        -- Allow no-op updates
        IF NEW.club_template_id IS NOT DISTINCT FROM OLD.club_template_id
           AND NEW.version IS NOT DISTINCT FROM OLD.version
           AND NEW.reputation IS NOT DISTINCT FROM OLD.reputation
           AND NEW.base_squad_value IS NOT DISTINCT FROM OLD.base_squad_value
           AND NEW.effective_from IS NOT DISTINCT FROM OLD.effective_from
           AND NEW.effective_to IS NOT DISTINCT FROM OLD.effective_to
           AND NEW.is_current IS NOT DISTINCT FROM OLD.is_current THEN
            RETURN NEW;
        END IF;

        RAISE EXCEPTION 'Tarixiy klub shabloni versiyalarini o''zgartirish taqiqlangan.' USING ERRCODE = 'P0001';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

CREATE TRIGGER trg_prevent_club_template_versions_modification
    BEFORE UPDATE OR DELETE ON public.club_template_versions
    FOR EACH ROW EXECUTE FUNCTION public.prevent_club_template_versions_modification();


-- 4. Table: player_templates (Stable Player Identity)
CREATE TABLE public.player_templates (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_key VARCHAR(100) NOT NULL UNIQUE CHECK (canonical_key ~ '^[a-z0-9-]+$' AND canonical_key = lower(canonical_key)),
    current_club_template_id UUID NOT NULL REFERENCES public.club_templates(id) ON DELETE RESTRICT,
    full_name VARCHAR(150) NOT NULL CHECK (char_length(trim(full_name)) > 0),
    date_of_birth DATE NOT NULL CHECK (date_of_birth <= CURRENT_DATE AND date_of_birth >= '1950-01-01'),
    nationality VARCHAR(100) NOT NULL CHECK (char_length(trim(nationality)) > 0),
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Indexes for player_templates
CREATE INDEX idx_player_templates_canonical_key ON public.player_templates(canonical_key);
CREATE INDEX idx_player_templates_club ON public.player_templates(current_club_template_id);
CREATE INDEX idx_player_templates_nationality ON public.player_templates(nationality);
CREATE INDEX idx_player_templates_is_active ON public.player_templates(is_active);

-- Trigger: Updated_at for player_templates
CREATE TRIGGER trg_player_templates_updated_at
    BEFORE UPDATE ON public.player_templates
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- Trigger Function & Trigger: Prevent canonical_key change for player_templates
CREATE OR REPLACE FUNCTION public.prevent_player_template_canonical_key_change()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.canonical_key <> NEW.canonical_key THEN
        RAISE EXCEPTION 'Futbolchi shabloni canonical_key ko''rsatkichini o''zgartirish taqiqlangan.' USING ERRCODE = 'P0001';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

CREATE TRIGGER trg_prevent_player_template_canonical_key_change
    BEFORE UPDATE ON public.player_templates
    FOR EACH ROW EXECUTE FUNCTION public.prevent_player_template_canonical_key_change();


-- 5. Table: player_template_positions (Position Mappings)
CREATE TABLE public.player_template_positions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    player_template_id UUID NOT NULL REFERENCES public.player_templates(id) ON DELETE CASCADE,
    position_code public.enum_player_position NOT NULL,
    is_primary BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT uq_player_template_position UNIQUE (player_template_id, position_code)
);

-- Partial Unique Index: At most one primary position per player template
CREATE UNIQUE INDEX uq_player_template_positions_primary 
    ON public.player_template_positions (player_template_id) 
    WHERE (is_primary = TRUE);

-- Indexes for player_template_positions
CREATE INDEX idx_player_template_positions_player ON public.player_template_positions(player_template_id);
CREATE INDEX idx_player_template_positions_primary ON public.player_template_positions(player_template_id, is_primary);

-- Deferred Constraint Trigger: Enforce at least one primary position for active player templates on commit
CREATE OR REPLACE FUNCTION public.check_player_template_has_primary_position()
RETURNS TRIGGER AS $$
DECLARE
    v_has_primary BOOLEAN;
    v_target_player_id UUID;
BEGIN
    IF TG_OP = 'DELETE' THEN
        v_target_player_id := OLD.player_template_id;
    ELSE
        v_target_player_id := NEW.player_template_id;
    END IF;

    -- Check if player template exists and is active
    IF EXISTS (SELECT 1 FROM public.player_templates WHERE id = v_target_player_id AND is_active = TRUE) THEN
        SELECT EXISTS (
            SELECT 1 FROM public.player_template_positions 
            WHERE player_template_id = v_target_player_id AND is_primary = TRUE
        ) INTO v_has_primary;

        IF NOT v_has_primary THEN
            RAISE EXCEPTION 'Har bir faol futbolchi shabloni kamida bitta asosiy (primary) pozitsiyaga ega bo''lishi shart.' USING ERRCODE = 'P0001';
        END IF;
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

CREATE CONSTRAINT TRIGGER trg_enforce_player_primary_position
    AFTER INSERT OR UPDATE OR DELETE ON public.player_template_positions
    DEFERRABLE INITIALLY DEFERRED
    FOR EACH ROW EXECUTE FUNCTION public.check_player_template_has_primary_position();


-- 6. Table: player_template_versions (Normalized Relational Attribute Versions)
CREATE TABLE public.player_template_versions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    player_template_id UUID NOT NULL REFERENCES public.player_templates(id) ON DELETE RESTRICT,
    version INT NOT NULL CHECK (version > 0),
    market_value_eur NUMERIC(15, 2) NOT NULL CHECK (market_value_eur >= 0),
    overall_rating INT NOT NULL CHECK (overall_rating BETWEEN 1 AND 99),
    
    -- Outfield Attributes (1..99 for non-GK, NULL for GK)
    pace INT NULL CHECK (pace IS NULL OR pace BETWEEN 1 AND 99),
    shooting INT NULL CHECK (shooting IS NULL OR shooting BETWEEN 1 AND 99),
    passing INT NULL CHECK (passing IS NULL OR passing BETWEEN 1 AND 99),
    dribbling INT NULL CHECK (dribbling IS NULL OR dribbling BETWEEN 1 AND 99),
    defending INT NULL CHECK (defending IS NULL OR defending BETWEEN 1 AND 99),
    physical INT NULL CHECK (physical IS NULL OR physical BETWEEN 1 AND 99),

    -- Goalkeeper Attributes (1..99 for GK, NULL for non-GK)
    reflexes INT NULL CHECK (reflexes IS NULL OR reflexes BETWEEN 1 AND 99),
    handling INT NULL CHECK (handling IS NULL OR handling BETWEEN 1 AND 99),
    positioning INT NULL CHECK (positioning IS NULL OR positioning BETWEEN 1 AND 99),
    aerial_ability INT NULL CHECK (aerial_ability IS NULL OR aerial_ability BETWEEN 1 AND 99),
    distribution INT NULL CHECK (distribution IS NULL OR distribution BETWEEN 1 AND 99),
    one_on_one INT NULL CHECK (one_on_one IS NULL OR one_on_one BETWEEN 1 AND 99),

    effective_from TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    effective_to TIMESTAMPTZ NULL,
    is_current BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by_admin_id UUID NULL REFERENCES public.admin_users(id) ON DELETE SET NULL,
    CONSTRAINT uq_player_template_version UNIQUE (player_template_id, version),
    CHECK (effective_to IS NULL OR effective_to >= effective_from)
);

-- Partial Unique Index: Only one current version per player template
CREATE UNIQUE INDEX uq_player_template_versions_current 
    ON public.player_template_versions (player_template_id) 
    WHERE (is_current = TRUE);

-- Indexes for player_template_versions
CREATE INDEX idx_player_template_versions_player ON public.player_template_versions(player_template_id);
CREATE INDEX idx_player_template_versions_current ON public.player_template_versions(player_template_id, is_current);

-- Trigger Function & Trigger: Validate player attributes against primary position (GK vs Outfield)
CREATE OR REPLACE FUNCTION public.validate_player_template_version_attributes()
RETURNS TRIGGER AS $$
DECLARE
    v_primary_position public.enum_player_position;
BEGIN
    SELECT position_code INTO v_primary_position
    FROM public.player_template_positions
    WHERE player_template_id = NEW.player_template_id AND is_primary = TRUE;

    IF v_primary_position IS NULL THEN
        RAISE EXCEPTION 'Futbolchi shabloni versiyasini yaratish uchun avval asosiy pozitsiya belgilanilishi kerak.' USING ERRCODE = 'P0001';
    END IF;

    IF v_primary_position = 'GK' THEN
        -- Goalkeeper attributes must be present, outfield must be NULL
        IF NEW.reflexes IS NULL OR NEW.handling IS NULL OR NEW.positioning IS NULL
           OR NEW.aerial_ability IS NULL OR NEW.distribution IS NULL OR NEW.one_on_one IS NULL THEN
            RAISE EXCEPTION 'Darvozabon (GK) uchun barcha darvozabonlik ko''rsatkichlari (reflexes, handling, positioning, aerial_ability, distribution, one_on_one) talab etiladi.' USING ERRCODE = 'P0001';
        END IF;

        IF NEW.pace IS NOT NULL OR NEW.shooting IS NOT NULL OR NEW.passing IS NOT NULL
           OR NEW.dribbling IS NOT NULL OR NEW.defending IS NOT NULL OR NEW.physical IS NOT NULL THEN
            RAISE EXCEPTION 'Darvozabon (GK) uchun maydon futbolchisi ko''rsatkichlari NULL bo''lishi shart.' USING ERRCODE = 'P0001';
        END IF;
    ELSE
        -- Outfield attributes must be present, goalkeeper must be NULL
        IF NEW.pace IS NULL OR NEW.shooting IS NULL OR NEW.passing IS NULL
           OR NEW.dribbling IS NULL OR NEW.defending IS NULL OR NEW.physical IS NULL THEN
            RAISE EXCEPTION 'Maydon futbolchisi uchun barcha maydon ko''rsatkichlari (pace, shooting, passing, dribbling, defending, physical) talab etiladi.' USING ERRCODE = 'P0001';
        END IF;

        IF NEW.reflexes IS NOT NULL OR NEW.handling IS NOT NULL OR NEW.positioning IS NOT NULL
           OR NEW.aerial_ability IS NOT NULL OR NEW.distribution IS NOT NULL OR NEW.one_on_one IS NOT NULL THEN
            RAISE EXCEPTION 'Maydon futbolchisi uchun darvozabonlik ko''rsatkichlari NULL bo''lishi shart.' USING ERRCODE = 'P0001';
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

CREATE TRIGGER trg_validate_player_template_version_attributes
    BEFORE INSERT OR UPDATE ON public.player_template_versions
    FOR EACH ROW EXECUTE FUNCTION public.validate_player_template_version_attributes();

-- Trigger Function & Trigger: Immutability guard for player_template_versions
CREATE OR REPLACE FUNCTION public.prevent_player_template_versions_modification()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'DELETE' THEN
        RAISE EXCEPTION 'Futbolchi shabloni versiyalarini o''chirish taqiqlangan.' USING ERRCODE = 'P0001';
    ELSIF TG_OP = 'UPDATE' THEN
        -- Allow archiving: changing is_current from TRUE to FALSE and updating effective_to
        IF OLD.is_current = TRUE AND NEW.is_current = FALSE
           AND OLD.player_template_id = NEW.player_template_id
           AND OLD.version = NEW.version
           AND OLD.market_value_eur = NEW.market_value_eur
           AND OLD.overall_rating = NEW.overall_rating
           AND OLD.effective_from = NEW.effective_from THEN
            RETURN NEW;
        END IF;

        -- Allow no-op updates
        IF NEW.player_template_id IS NOT DISTINCT FROM OLD.player_template_id
           AND NEW.version IS NOT DISTINCT FROM OLD.version
           AND NEW.market_value_eur IS NOT DISTINCT FROM OLD.market_value_eur
           AND NEW.overall_rating IS NOT DISTINCT FROM OLD.overall_rating
           AND NEW.effective_from IS NOT DISTINCT FROM OLD.effective_from
           AND NEW.effective_to IS NOT DISTINCT FROM OLD.effective_to
           AND NEW.is_current IS NOT DISTINCT FROM OLD.is_current THEN
            RETURN NEW;
        END IF;

        RAISE EXCEPTION 'Tarixiy futbolchi shabloni versiyalarini o''zgartirish taqiqlangan.' USING ERRCODE = 'P0001';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

CREATE TRIGGER trg_prevent_player_template_versions_modification
    BEFORE UPDATE OR DELETE ON public.player_template_versions
    FOR EACH ROW EXECUTE FUNCTION public.prevent_player_template_versions_modification();


-- 7. Controlled RPC Functions (Security Definer with fixed search_path = public)

-- Function: publish_club_template_version
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
    -- Check admin exists
    IF NOT EXISTS (SELECT 1 FROM public.admin_users WHERE id = p_admin_id AND is_active = TRUE) THEN
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

-- Function: create_player_template_with_positions
CREATE OR REPLACE FUNCTION public.create_player_template_with_positions(
    p_canonical_key VARCHAR,
    p_current_club_id UUID,
    p_full_name VARCHAR,
    p_dob DATE,
    p_nationality VARCHAR,
    p_primary_position public.enum_player_position,
    p_secondary_positions public.enum_player_position[] DEFAULT '{}'
)
RETURNS UUID AS $$
DECLARE
    v_player_id UUID;
    v_sec_pos public.enum_player_position;
BEGIN
    -- Insert player template
    INSERT INTO public.player_templates (
        canonical_key,
        current_club_template_id,
        full_name,
        date_of_birth,
        nationality
    ) VALUES (
        p_canonical_key,
        p_current_club_id,
        p_full_name,
        p_dob,
        p_nationality
    ) RETURNING id INTO v_player_id;

    -- Insert primary position
    INSERT INTO public.player_template_positions (
        player_template_id,
        position_code,
        is_primary
    ) VALUES (
        v_player_id,
        p_primary_position,
        TRUE
    );

    -- Insert secondary positions if provided
    IF p_secondary_positions IS NOT NULL AND array_length(p_secondary_positions, 1) > 0 THEN
        FOREACH v_sec_pos IN ARRAY p_secondary_positions LOOP
            IF v_sec_pos <> p_primary_position THEN
                INSERT INTO public.player_template_positions (
                    player_template_id,
                    position_code,
                    is_primary
                ) VALUES (
                    v_player_id,
                    v_sec_pos,
                    FALSE
                );
            END IF;
        END LOOP;
    END IF;

    RETURN v_player_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

-- Function: replace_player_primary_position
CREATE OR REPLACE FUNCTION public.replace_player_primary_position(
    p_player_template_id UUID,
    p_new_primary_position public.enum_player_position
)
RETURNS VOID AS $$
BEGIN
    -- Downgrade existing primary position to secondary
    UPDATE public.player_template_positions
    SET is_primary = FALSE
    WHERE player_template_id = p_player_template_id AND is_primary = TRUE;

    -- Upsert new primary position
    INSERT INTO public.player_template_positions (
        player_template_id,
        position_code,
        is_primary
    ) VALUES (
        p_player_template_id,
        p_new_primary_position,
        TRUE
    ) ON CONFLICT (player_template_id, position_code) DO UPDATE
    SET is_primary = TRUE;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

-- Function: change_player_current_club
CREATE OR REPLACE FUNCTION public.change_player_current_club(
    p_player_template_id UUID,
    p_new_club_template_id UUID
)
RETURNS VOID AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM public.club_templates WHERE id = p_new_club_template_id) THEN
        RAISE EXCEPTION 'Yangi klub shabloni topilmadi.' USING ERRCODE = 'P0001';
    END IF;

    UPDATE public.player_templates
    SET current_club_template_id = p_new_club_template_id,
        updated_at = NOW()
    WHERE id = p_player_template_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;


-- 8. Seed Initial 20 Stable Club Identities
INSERT INTO public.club_templates (slug, name, short_code, country)
VALUES
    ('real-madrid', 'Real Madrid', 'RMA', 'Spain'),
    ('barcelona', 'FC Barcelona', 'BAR', 'Spain'),
    ('atletico-madrid', 'Atlético Madrid', 'ATM', 'Spain'),
    ('manchester-city', 'Manchester City', 'MCI', 'England'),
    ('liverpool', 'Liverpool FC', 'LIV', 'England'),
    ('arsenal', 'Arsenal FC', 'ARS', 'England'),
    ('chelsea', 'Chelsea FC', 'CHE', 'England'),
    ('manchester-united', 'Manchester United', 'MUN', 'England'),
    ('tottenham', 'Tottenham Hotspur', 'TOT', 'England'),
    ('bayern-munich', 'Bayern Munich', 'BAY', 'Germany'),
    ('borussia-dortmund', 'Borussia Dortmund', 'BVB', 'Germany'),
    ('bayer-leverkusen', 'Bayer Leverkusen', 'LEV', 'Germany'),
    ('paris-saint-germain', 'Paris Saint-Germain', 'PSG', 'France'),
    ('inter', 'Inter Milan', 'INT', 'Italy'),
    ('ac-milan', 'AC Milan', 'ACM', 'Italy'),
    ('juventus', 'Juventus', 'JUV', 'Italy'),
    ('napoli', 'SSC Napoli', 'NAP', 'Italy'),
    ('benfica', 'SL Benfica', 'BEN', 'Portugal'),
    ('porto', 'FC Porto', 'POR', 'Portugal'),
    ('ajax', 'AFC Ajax', 'AJX', 'Netherlands')
ON CONFLICT (slug) DO NOTHING;


-- 9. Row Level Security & Explicit Privilege Boundary

ALTER TABLE public.club_templates ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.club_template_versions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.player_templates ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.player_template_positions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.player_template_versions ENABLE ROW LEVEL SECURITY;

-- Revoke all privileges from public, anon, and authenticated
REVOKE ALL ON public.club_templates FROM PUBLIC, anon, authenticated;
REVOKE ALL ON public.club_template_versions FROM PUBLIC, anon, authenticated;
REVOKE ALL ON public.player_templates FROM PUBLIC, anon, authenticated;
REVOKE ALL ON public.player_template_positions FROM PUBLIC, anon, authenticated;
REVOKE ALL ON public.player_template_versions FROM PUBLIC, anon, authenticated;

-- Grant least privilege DML permissions to service_role
GRANT SELECT ON public.club_templates TO service_role;
GRANT SELECT ON public.club_template_versions TO service_role;
GRANT SELECT ON public.player_templates TO service_role;
GRANT SELECT ON public.player_template_positions TO service_role;
GRANT SELECT ON public.player_template_versions TO service_role;

-- Grant RPC execution permissions to service_role only
GRANT EXECUTE ON FUNCTION public.publish_club_template_version TO service_role;
GRANT EXECUTE ON FUNCTION public.create_player_template_with_positions TO service_role;
GRANT EXECUTE ON FUNCTION public.replace_player_primary_position TO service_role;
GRANT EXECUTE ON FUNCTION public.change_player_current_club TO service_role;

-- Revoke RPC execution permissions from anon and authenticated
REVOKE EXECUTE ON FUNCTION public.publish_club_template_version FROM PUBLIC, anon, authenticated;
REVOKE EXECUTE ON FUNCTION public.create_player_template_with_positions FROM PUBLIC, anon, authenticated;
REVOKE EXECUTE ON FUNCTION public.replace_player_primary_position FROM PUBLIC, anon, authenticated;
REVOKE EXECUTE ON FUNCTION public.change_player_current_club FROM PUBLIC, anon, authenticated;
