-- SQL Migration: Phase 4D - League Players and Club Finances Database Foundation
-- Creates league_players, league_player_positions, club_finances, financial_ledger tables,
-- domain ENUMs, validation triggers, equalizing starting budget policy function, RPC functions,
-- RLS policies, and service_role privilege bounds with stable machine-readable error contracts.

-- 1. Domain ENUM Types

-- Enum: enum_player_availability_status
CREATE TYPE public.enum_player_availability_status AS ENUM (
    'AVAILABLE',
    'INJURED',
    'SUSPENDED'
);

-- Enum: enum_financial_transaction_type
-- Financial direction convention:
--   positive amount_eur (> 0) = credit (adds to club total_balance)
--   negative amount_eur (< 0) = debit (deducts from club total_balance)
--   zero amount_eur = strictly forbidden
CREATE TYPE public.enum_financial_transaction_type AS ENUM (
    'STARTING_BUDGET',
    'TRANSFER_PURCHASE',
    'TRANSFER_SALE',
    'TRANSFER_RESERVE',
    'TRANSFER_RESERVE_RELEASE',
    'TRANSFER_RESERVE_CAPTURE',
    'ADMIN_ADJUSTMENT',
    'FEE',
    'PRIZE',
    'COMPENSATION'
);


-- 2. Table: league_players (League-Specific Player Copy & Live State)
CREATE TABLE public.league_players (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    league_id UUID NOT NULL REFERENCES public.leagues(id) ON DELETE CASCADE,
    league_club_id UUID NOT NULL REFERENCES public.league_clubs(id) ON DELETE CASCADE,
    player_template_id UUID NOT NULL REFERENCES public.player_templates(id) ON DELETE RESTRICT,
    player_template_version_id UUID NOT NULL REFERENCES public.player_template_versions(id) ON DELETE RESTRICT,
    
    -- Immutable Player Identity Snapshots
    full_name VARCHAR(150) NOT NULL CHECK (char_length(trim(full_name)) > 0),
    date_of_birth DATE NOT NULL CHECK (date_of_birth <= CURRENT_DATE AND date_of_birth >= '1950-01-01'),
    nationality VARCHAR(100) NOT NULL CHECK (char_length(trim(nationality)) > 0),

    -- Financial & Rating Snapshots
    market_value_eur NUMERIC(15, 2) NOT NULL CHECK (market_value_eur >= 0),
    overall_rating INT NOT NULL CHECK (overall_rating BETWEEN 1 AND 99),
    potential_rating INT NULL CHECK (potential_rating IS NULL OR potential_rating BETWEEN 1 AND 99),

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

    -- Live Availability & Physical Condition States
    availability_status public.enum_player_availability_status NOT NULL DEFAULT 'AVAILABLE',
    injury_until TIMESTAMPTZ NULL,
    suspension_matches_remaining INT NOT NULL DEFAULT 0 CHECK (suspension_matches_remaining >= 0),
    fitness INT NOT NULL DEFAULT 100 CHECK (fitness BETWEEN 0 AND 100),
    form INT NOT NULL DEFAULT 7 CHECK (form BETWEEN 1 AND 10),
    morale INT NOT NULL DEFAULT 7 CHECK (morale BETWEEN 1 AND 10),
    last_transferred_round INT NOT NULL DEFAULT 0 CHECK (last_transferred_round >= 0),

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    -- Invariant: Each player template may exist at most once per league
    CONSTRAINT uq_league_players_template UNIQUE (league_id, player_template_id),
    CHECK (availability_status <> 'INJURED' OR injury_until IS NOT NULL),
    CHECK (availability_status <> 'SUSPENDED' OR suspension_matches_remaining > 0)
);

-- Indexes for league_players
CREATE INDEX idx_league_players_league ON public.league_players(league_id);
CREATE INDEX idx_league_players_club ON public.league_players(league_club_id);
CREATE INDEX idx_league_players_template ON public.league_players(player_template_id);
CREATE INDEX idx_league_players_version ON public.league_players(player_template_version_id);
CREATE INDEX idx_league_players_availability ON public.league_players(league_club_id, availability_status);

-- Trigger: Updated_at for league_players
CREATE TRIGGER trg_league_players_updated_at
    BEFORE UPDATE ON public.league_players
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- Validation Trigger: Check league_club_id belongs to league_id & validate player version attributes
CREATE OR REPLACE FUNCTION public.validate_league_player_consistency()
RETURNS TRIGGER AS $$
DECLARE
    v_club_league_id UUID;
    v_version_template_id UUID;
BEGIN
    -- 1. Validate league_club_id matches league_id
    SELECT league_id INTO v_club_league_id
    FROM public.league_clubs
    WHERE id = NEW.league_club_id;

    IF v_club_league_id IS NULL OR v_club_league_id <> NEW.league_id THEN
        RAISE EXCEPTION 'CONSISTENCY_MISMATCH' USING ERRCODE = 'P0001';
    END IF;

    -- 2. Validate player_template_version_id matches player_template_id
    SELECT player_template_id INTO v_version_template_id
    FROM public.player_template_versions
    WHERE id = NEW.player_template_version_id;

    IF v_version_template_id IS NULL OR v_version_template_id <> NEW.player_template_id THEN
        RAISE EXCEPTION 'CONSISTENCY_MISMATCH' USING ERRCODE = 'P0001';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

CREATE TRIGGER trg_validate_league_player_consistency
    BEFORE INSERT OR UPDATE ON public.league_players
    FOR EACH ROW EXECUTE FUNCTION public.validate_league_player_consistency();


-- 3. Table: league_player_positions (Position Mappings for Live League Players)
CREATE TABLE public.league_player_positions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    league_player_id UUID NOT NULL REFERENCES public.league_players(id) ON DELETE CASCADE,
    position_code public.enum_player_position NOT NULL,
    is_primary BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT uq_league_player_position UNIQUE (league_player_id, position_code)
);

-- Partial Unique Index: At most one primary position per league player
CREATE UNIQUE INDEX uq_league_player_positions_primary 
    ON public.league_player_positions (league_player_id) 
    WHERE (is_primary = TRUE);

-- Indexes for league_player_positions
CREATE INDEX idx_league_player_positions_player ON public.league_player_positions(league_player_id);
CREATE INDEX idx_league_player_positions_primary ON public.league_player_positions(league_player_id, is_primary);

-- Deferred Constraint Trigger: Enforce exactly one primary position per active league player on transaction commit
CREATE OR REPLACE FUNCTION public.check_league_player_has_primary_position()
RETURNS TRIGGER AS $$
DECLARE
    v_has_primary BOOLEAN;
    v_target_player_id UUID;
BEGIN
    IF TG_OP = 'DELETE' THEN
        v_target_player_id := OLD.league_player_id;
    ELSE
        v_target_player_id := NEW.league_player_id;
    END IF;

    -- Check if league player still exists (prevents error on cascading deletion of league/club/player)
    IF EXISTS (SELECT 1 FROM public.league_players WHERE id = v_target_player_id) THEN
        SELECT EXISTS (
            SELECT 1 FROM public.league_player_positions 
            WHERE league_player_id = v_target_player_id AND is_primary = TRUE
        ) INTO v_has_primary;

        IF NOT v_has_primary THEN
            RAISE EXCEPTION 'PRIMARY_POSITION_REQUIRED' USING ERRCODE = 'P0001';
        END IF;
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

CREATE CONSTRAINT TRIGGER trg_enforce_league_player_primary_position
    AFTER INSERT OR UPDATE OR DELETE ON public.league_player_positions
    DEFERRABLE INITIALLY DEFERRED
    FOR EACH ROW EXECUTE FUNCTION public.check_league_player_has_primary_position();


-- 4. Table: club_finances (Club Finance Accounts & Balances)
CREATE TABLE public.club_finances (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    league_id UUID NOT NULL REFERENCES public.leagues(id) ON DELETE CASCADE,
    league_club_id UUID NOT NULL REFERENCES public.league_clubs(id) ON DELETE CASCADE,
    total_balance NUMERIC(15, 2) NOT NULL CHECK (total_balance >= 0),
    reserved_balance NUMERIC(15, 2) NOT NULL DEFAULT 0.00 CHECK (reserved_balance >= 0),
    available_balance NUMERIC(15, 2) GENERATED ALWAYS AS (total_balance - reserved_balance) STORED,
    version INT NOT NULL DEFAULT 1 CHECK (version > 0),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT uq_club_finances_club UNIQUE (league_club_id),
    CONSTRAINT chk_club_finances_reserved_limit CHECK (reserved_balance <= total_balance)
);

-- Indexes for club_finances
CREATE INDEX idx_club_finances_league ON public.club_finances(league_id);
CREATE INDEX idx_club_finances_club ON public.club_finances(league_club_id);

-- Trigger: Updated_at for club_finances
CREATE TRIGGER trg_club_finances_updated_at
    BEFORE UPDATE ON public.club_finances
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- Validation Trigger: Check league_club_id belongs to league_id
CREATE OR REPLACE FUNCTION public.validate_club_finances_league_consistency()
RETURNS TRIGGER AS $$
DECLARE
    v_club_league_id UUID;
BEGIN
    SELECT league_id INTO v_club_league_id
    FROM public.league_clubs
    WHERE id = NEW.league_club_id;

    IF v_club_league_id IS NULL OR v_club_league_id <> NEW.league_id THEN
        RAISE EXCEPTION 'CONSISTENCY_MISMATCH' USING ERRCODE = 'P0001';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

CREATE TRIGGER trg_validate_club_finances_league_consistency
    BEFORE INSERT OR UPDATE ON public.club_finances
    FOR EACH ROW EXECUTE FUNCTION public.validate_club_finances_league_consistency();


-- 5. Table: financial_ledger (Immutable Financial Transaction Audit Log)
CREATE TABLE public.financial_ledger (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    league_id UUID NOT NULL REFERENCES public.leagues(id) ON DELETE CASCADE,
    league_club_id UUID NOT NULL REFERENCES public.league_clubs(id) ON DELETE CASCADE,
    transaction_type public.enum_financial_transaction_type NOT NULL,
    amount_eur NUMERIC(15, 2) NOT NULL CHECK (amount_eur <> 0),
    balance_before NUMERIC(15, 2) NOT NULL CHECK (balance_before >= 0),
    balance_after NUMERIC(15, 2) NOT NULL CHECK (balance_after >= 0),
    reserved_before NUMERIC(15, 2) NOT NULL CHECK (reserved_before >= 0),
    reserved_after NUMERIC(15, 2) NOT NULL CHECK (reserved_after >= 0),
    related_entity_type VARCHAR(50) NULL,
    related_entity_id UUID NULL,
    idempotency_key VARCHAR(100) NOT NULL CHECK (char_length(trim(idempotency_key)) > 0),
    description TEXT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT uq_financial_ledger_idempotency UNIQUE (league_club_id, idempotency_key)
);

-- Indexes for financial_ledger
CREATE INDEX idx_financial_ledger_league ON public.financial_ledger(league_id);
CREATE INDEX idx_financial_ledger_club ON public.financial_ledger(league_club_id);
CREATE INDEX idx_financial_ledger_type ON public.financial_ledger(transaction_type);
CREATE INDEX idx_financial_ledger_idempotency ON public.financial_ledger(league_club_id, idempotency_key);

-- Immutability Guard Trigger: Reject UPDATE and DELETE on financial_ledger
CREATE OR REPLACE FUNCTION public.prevent_financial_ledger_modification()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'DELETE' THEN
        RAISE EXCEPTION 'LEDGER_IMMUTABLE' USING ERRCODE = 'P0001';
    ELSIF TG_OP = 'UPDATE' THEN
        RAISE EXCEPTION 'LEDGER_IMMUTABLE' USING ERRCODE = 'P0001';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

CREATE TRIGGER trg_prevent_financial_ledger_modification
    BEFORE UPDATE OR DELETE ON public.financial_ledger
    FOR EACH ROW EXECUTE FUNCTION public.prevent_financial_ledger_modification();


-- 6. Starting Budget Balancing Policy Function
-- Formula: €100,000,000 + 35% * (p_max_squad_value - p_base_squad_value), clamped between €100m and €400m.
CREATE OR REPLACE FUNCTION public.calculate_club_starting_budget(
    p_base_squad_value NUMERIC,
    p_max_squad_value NUMERIC
)
RETURNS NUMERIC AS $$
DECLARE
    v_raw_budget NUMERIC;
    v_gap NUMERIC;
    v_floor NUMERIC := 100000000.00;
    v_cap NUMERIC := 400000000.00;
BEGIN
    IF p_base_squad_value IS NULL OR p_max_squad_value IS NULL THEN
        RAISE EXCEPTION 'INVALID_PARAM' USING ERRCODE = 'P0001';
    END IF;

    IF p_base_squad_value < 0 OR p_max_squad_value < 0 THEN
        RAISE EXCEPTION 'INVALID_PARAM' USING ERRCODE = 'P0001';
    END IF;

    v_gap := GREATEST(0.00, p_max_squad_value - p_base_squad_value);
    v_raw_budget := v_floor + (v_gap * 0.35);

    RETURN LEAST(v_cap, GREATEST(v_floor, ROUND(v_raw_budget, 2)));
END;
$$ LANGUAGE plpgsql IMMUTABLE SECURITY DEFINER SET search_path = public;


-- 7. Controlled RPC Functions

-- Function A: instantiate_league_players_from_templates
CREATE OR REPLACE FUNCTION public.instantiate_league_players_from_templates(
    p_league_id UUID
)
RETURNS INT AS $$
DECLARE
    v_league_status public.enum_league_status;
    v_existing_count INT;
    v_active_template_count INT;
    v_club RECORD;
    v_player_rec RECORD;
    v_pos_rec RECORD;
    v_inserted_players INT := 0;
    v_league_player_id UUID;
    v_club_player_count INT;
    v_club_gk_count INT;
BEGIN
    -- Verify league exists and is in LOBBY status
    SELECT status INTO v_league_status
    FROM public.leagues
    WHERE id = p_league_id;

    IF v_league_status IS NULL OR v_league_status <> 'LOBBY' THEN
        RAISE EXCEPTION 'LEAGUE_NOT_INITIALIZABLE' USING ERRCODE = 'P0001';
    END IF;

    -- Advisory lock on league_id
    PERFORM pg_advisory_xact_lock(hashtext(p_league_id::text));

    -- Idempotency check: if players already instantiated, return existing count
    SELECT COUNT(*) INTO v_existing_count
    FROM public.league_players
    WHERE league_id = p_league_id;

    IF v_existing_count > 0 THEN
        RETURN v_existing_count;
    END IF;

    -- Check if global player_templates has active records
    SELECT COUNT(*) INTO v_active_template_count
    FROM public.player_templates
    WHERE is_active = TRUE;

    IF v_active_template_count = 0 THEN
        RAISE EXCEPTION 'PLAYER_TEMPLATES_EMPTY' USING ERRCODE = 'P0001';
    END IF;

    -- Iterate through each league club in the league
    FOR v_club IN 
        SELECT lc.id AS league_club_id, lc.club_template_id
        FROM public.league_clubs lc
        WHERE lc.league_id = p_league_id
    LOOP
        -- Check per-club template player count (must be between 18 and 25)
        SELECT COUNT(*) INTO v_club_player_count
        FROM public.player_templates pt
        WHERE pt.current_club_template_id = v_club.club_template_id AND pt.is_active = TRUE;

        IF v_club_player_count < 18 OR v_club_player_count > 25 THEN
            RAISE EXCEPTION 'INVALID_SQUAD_SIZE' USING ERRCODE = 'P0001';
        END IF;

        -- Check goalkeeper count (must be >= 2)
        SELECT COUNT(*) INTO v_club_gk_count
        FROM public.player_templates pt
        JOIN public.player_template_positions ptp ON pt.id = ptp.player_template_id
        WHERE pt.current_club_template_id = v_club.club_template_id 
          AND pt.is_active = TRUE 
          AND ptp.position_code = 'GK';

        IF v_club_gk_count < 2 THEN
            RAISE EXCEPTION 'INSUFFICIENT_GOALKEEPERS' USING ERRCODE = 'P0001';
        END IF;

        -- Copy players for this club
        FOR v_player_rec IN
            SELECT 
                pt.id AS player_template_id,
                pt.full_name,
                pt.date_of_birth,
                pt.nationality,
                ptv.id AS player_template_version_id,
                ptv.market_value_eur,
                ptv.overall_rating,
                ptv.pace, ptv.shooting, ptv.passing, ptv.dribbling, ptv.defending, ptv.physical,
                ptv.reflexes, ptv.handling, ptv.positioning, ptv.aerial_ability, ptv.distribution, ptv.one_on_one
            FROM public.player_templates pt
            JOIN public.player_template_versions ptv ON pt.id = ptv.player_template_id AND ptv.is_current = TRUE
            WHERE pt.current_club_template_id = v_club.club_template_id AND pt.is_active = TRUE
        LOOP
            INSERT INTO public.league_players (
                league_id,
                league_club_id,
                player_template_id,
                player_template_version_id,
                full_name,
                date_of_birth,
                nationality,
                market_value_eur,
                overall_rating,
                pace, shooting, passing, dribbling, defending, physical,
                reflexes, handling, positioning, aerial_ability, distribution, one_on_one,
                availability_status,
                fitness,
                form,
                morale
            ) VALUES (
                p_league_id,
                v_club.league_club_id,
                v_player_rec.player_template_id,
                v_player_rec.player_template_version_id,
                v_player_rec.full_name,
                v_player_rec.date_of_birth,
                v_player_rec.nationality,
                v_player_rec.market_value_eur,
                v_player_rec.overall_rating,
                v_player_rec.pace, v_player_rec.shooting, v_player_rec.passing, v_player_rec.dribbling, v_player_rec.defending, v_player_rec.physical,
                v_player_rec.reflexes, v_player_rec.handling, v_player_rec.positioning, v_player_rec.aerial_ability, v_player_rec.distribution, v_player_rec.one_on_one,
                'AVAILABLE',
                100,
                7,
                7
            ) RETURNING id INTO v_league_player_id;

            v_inserted_players := v_inserted_players + 1;

            -- Copy positions for this player
            FOR v_pos_rec IN
                SELECT position_code, is_primary
                FROM public.player_template_positions
                WHERE player_template_id = v_player_rec.player_template_id
            LOOP
                INSERT INTO public.league_player_positions (
                    league_player_id,
                    position_code,
                    is_primary
                ) VALUES (
                    v_league_player_id,
                    v_pos_rec.position_code,
                    v_pos_rec.is_primary
                );
            END LOOP;
        END LOOP;
    END LOOP;

    RETURN v_inserted_players;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;


-- Function B: initialize_club_finances
CREATE OR REPLACE FUNCTION public.initialize_club_finances(
    p_league_id UUID
)
RETURNS INT AS $$
DECLARE
    v_league_status public.enum_league_status;
    v_existing_count INT;
    v_club_count INT;
    v_versions_count INT;
    v_max_squad_value NUMERIC;
    v_club RECORD;
    v_starting_budget NUMERIC;
    v_inserted_count INT := 0;
BEGIN
    -- Verify league exists and is in LOBBY status
    SELECT status INTO v_league_status
    FROM public.leagues
    WHERE id = p_league_id;

    IF v_league_status IS NULL OR v_league_status <> 'LOBBY' THEN
        RAISE EXCEPTION 'LEAGUE_NOT_INITIALIZABLE' USING ERRCODE = 'P0001';
    END IF;

    -- Advisory lock on league_id
    PERFORM pg_advisory_xact_lock(hashtext(p_league_id::text));

    -- Idempotency check: if all 20 club finances exist, return 20
    SELECT COUNT(*) INTO v_existing_count
    FROM public.club_finances
    WHERE league_id = p_league_id;

    IF v_existing_count = 20 THEN
        RETURN 20;
    ELSIF v_existing_count > 0 THEN
        RAISE EXCEPTION 'FINANCES_ALREADY_INITIALIZED' USING ERRCODE = 'P0001';
    END IF;

    -- Verify league has exactly 20 clubs
    SELECT COUNT(*) INTO v_club_count
    FROM public.league_clubs
    WHERE league_id = p_league_id;

    IF v_club_count <> 20 THEN
        RAISE EXCEPTION 'LEAGUE_NOT_INITIALIZABLE' USING ERRCODE = 'P0001';
    END IF;

    -- Verify active club_template_versions exist for all 20 club templates
    SELECT COUNT(ctv.id) INTO v_versions_count
    FROM public.league_clubs lc
    JOIN public.club_template_versions ctv ON lc.club_template_id = ctv.club_template_id AND ctv.is_current = TRUE
    WHERE lc.league_id = p_league_id;

    IF v_versions_count <> 20 THEN
        RAISE EXCEPTION 'CLUB_TEMPLATE_VERSIONS_INCOMPLETE' USING ERRCODE = 'P0001';
    END IF;

    -- Calculate maximum base_squad_value among the 20 clubs in the league
    SELECT MAX(ctv.base_squad_value) INTO v_max_squad_value
    FROM public.league_clubs lc
    JOIN public.club_template_versions ctv ON lc.club_template_id = ctv.club_template_id AND ctv.is_current = TRUE
    WHERE lc.league_id = p_league_id;

    -- Loop through 20 league clubs and initialize finance accounts
    FOR v_club IN
        SELECT lc.id AS league_club_id, ctv.base_squad_value
        FROM public.league_clubs lc
        JOIN public.club_template_versions ctv ON lc.club_template_id = ctv.club_template_id AND ctv.is_current = TRUE
        WHERE lc.league_id = p_league_id
    LOOP
        v_starting_budget := public.calculate_club_starting_budget(v_club.base_squad_value, v_max_squad_value);

        -- Insert club_finances account
        INSERT INTO public.club_finances (
            league_id,
            league_club_id,
            total_balance,
            reserved_balance
        ) VALUES (
            p_league_id,
            v_club.league_club_id,
            v_starting_budget,
            0.00
        );

        -- Insert STARTING_BUDGET financial_ledger audit entry
        INSERT INTO public.financial_ledger (
            league_id,
            league_club_id,
            transaction_type,
            amount_eur,
            balance_before,
            balance_after,
            reserved_before,
            reserved_after,
            idempotency_key,
            description
        ) VALUES (
            p_league_id,
            v_club.league_club_id,
            'STARTING_BUDGET',
            v_starting_budget,
            0.00,
            v_starting_budget,
            0.00,
            0.00,
            'STARTING_BUDGET_' || v_club.league_club_id::text,
            'Boshlang''ich klub byudjeti balansi'
        );

        v_inserted_count := v_inserted_count + 1;
    END LOOP;

    RETURN v_inserted_count;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;


-- Function C: record_financial_transaction
CREATE OR REPLACE FUNCTION public.record_financial_transaction(
    p_club_id UUID,
    p_league_id UUID,
    p_amount_eur NUMERIC,
    p_type public.enum_financial_transaction_type,
    p_idempotency_key VARCHAR,
    p_related_entity_type VARCHAR DEFAULT NULL,
    p_related_entity_id UUID DEFAULT NULL,
    p_description TEXT DEFAULT NULL
)
RETURNS UUID AS $$
DECLARE
    v_existing_ledger_id UUID;
    v_fin_id UUID;
    v_current_total NUMERIC;
    v_current_reserved NUMERIC;
    v_current_available NUMERIC;
    v_new_total NUMERIC;
    v_new_ledger_id UUID;
BEGIN
    -- Input validations
    IF p_amount_eur IS NULL OR p_amount_eur = 0 THEN
        RAISE EXCEPTION 'INVALID_PARAM' USING ERRCODE = 'P0001';
    END IF;

    IF p_idempotency_key IS NULL OR char_length(trim(p_idempotency_key)) = 0 THEN
        RAISE EXCEPTION 'INVALID_PARAM' USING ERRCODE = 'P0001';
    END IF;

    -- Check idempotency: if already processed, return existing ledger id
    SELECT id INTO v_existing_ledger_id
    FROM public.financial_ledger
    WHERE league_club_id = p_club_id AND idempotency_key = p_idempotency_key;

    IF v_existing_ledger_id IS NOT NULL THEN
        RETURN v_existing_ledger_id;
    END IF;

    -- Lock club_finances account row FOR UPDATE
    SELECT id, total_balance, reserved_balance, available_balance
    INTO v_fin_id, v_current_total, v_current_reserved, v_current_available
    FROM public.club_finances
    WHERE league_club_id = p_club_id AND league_id = p_league_id FOR UPDATE;

    IF v_fin_id IS NULL THEN
        RAISE EXCEPTION 'INVALID_PARAM' USING ERRCODE = 'P0001';
    END IF;

    -- Validate funds for debit operations (p_amount_eur < 0)
    IF p_amount_eur < 0 AND (v_current_available + p_amount_eur < 0) THEN
        RAISE EXCEPTION 'INSUFFICIENT_AVAILABLE_FUNDS' USING ERRCODE = 'P0001';
    END IF;

    v_new_total := v_current_total + p_amount_eur;

    IF v_new_total < 0 THEN
        RAISE EXCEPTION 'INSUFFICIENT_AVAILABLE_FUNDS' USING ERRCODE = 'P0001';
    END IF;

    -- Update total_balance in club_finances
    UPDATE public.club_finances
    SET total_balance = v_new_total,
        version = version + 1,
        updated_at = NOW()
    WHERE id = v_fin_id;

    -- Append audit row to financial_ledger
    INSERT INTO public.financial_ledger (
        league_id,
        league_club_id,
        transaction_type,
        amount_eur,
        balance_before,
        balance_after,
        reserved_before,
        reserved_after,
        related_entity_type,
        related_entity_id,
        idempotency_key,
        description
    ) VALUES (
        p_league_id,
        p_club_id,
        p_type,
        p_amount_eur,
        v_current_total,
        v_new_total,
        v_current_reserved,
        v_current_reserved,
        p_related_entity_type,
        p_related_entity_id,
        p_idempotency_key,
        p_description
    ) RETURNING id INTO v_new_ledger_id;

    RETURN v_new_ledger_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;


-- Function D: reserve_club_funds
CREATE OR REPLACE FUNCTION public.reserve_club_funds(
    p_club_id UUID,
    p_league_id UUID,
    p_amount_eur NUMERIC,
    p_idempotency_key VARCHAR,
    p_related_entity_type VARCHAR DEFAULT NULL,
    p_related_entity_id UUID DEFAULT NULL,
    p_description TEXT DEFAULT NULL
)
RETURNS UUID AS $$
DECLARE
    v_existing_ledger_id UUID;
    v_fin_id UUID;
    v_current_total NUMERIC;
    v_current_reserved NUMERIC;
    v_current_available NUMERIC;
    v_new_reserved NUMERIC;
    v_new_ledger_id UUID;
BEGIN
    IF p_amount_eur IS NULL OR p_amount_eur <= 0 THEN
        RAISE EXCEPTION 'INVALID_RESERVATION_OPERATION' USING ERRCODE = 'P0001';
    END IF;

    -- Check idempotency
    SELECT id INTO v_existing_ledger_id
    FROM public.financial_ledger
    WHERE league_club_id = p_club_id AND idempotency_key = p_idempotency_key;

    IF v_existing_ledger_id IS NOT NULL THEN
        RETURN v_existing_ledger_id;
    END IF;

    -- Lock club_finances row FOR UPDATE
    SELECT id, total_balance, reserved_balance, available_balance
    INTO v_fin_id, v_current_total, v_current_reserved, v_current_available
    FROM public.club_finances
    WHERE league_club_id = p_club_id AND league_id = p_league_id FOR UPDATE;

    IF v_fin_id IS NULL THEN
        RAISE EXCEPTION 'INVALID_PARAM' USING ERRCODE = 'P0001';
    END IF;

    IF v_current_available < p_amount_eur THEN
        RAISE EXCEPTION 'INSUFFICIENT_AVAILABLE_FUNDS' USING ERRCODE = 'P0001';
    END IF;

    v_new_reserved := v_current_reserved + p_amount_eur;

    -- Update reserved_balance
    UPDATE public.club_finances
    SET reserved_balance = v_new_reserved,
        version = version + 1,
        updated_at = NOW()
    WHERE id = v_fin_id;

    -- Append audit row to financial_ledger (signed amount_eur = -p_amount_eur to reflect available balance reduction)
    INSERT INTO public.financial_ledger (
        league_id,
        league_club_id,
        transaction_type,
        amount_eur,
        balance_before,
        balance_after,
        reserved_before,
        reserved_after,
        related_entity_type,
        related_entity_id,
        idempotency_key,
        description
    ) VALUES (
        p_league_id,
        p_club_id,
        'TRANSFER_RESERVE',
        -p_amount_eur,
        v_current_total,
        v_current_total,
        v_current_reserved,
        v_new_reserved,
        p_related_entity_type,
        p_related_entity_id,
        p_idempotency_key,
        p_description
    ) RETURNING id INTO v_new_ledger_id;

    RETURN v_new_ledger_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;


-- Function E: release_club_reserved_funds
CREATE OR REPLACE FUNCTION public.release_club_reserved_funds(
    p_club_id UUID,
    p_league_id UUID,
    p_amount_eur NUMERIC,
    p_idempotency_key VARCHAR,
    p_related_entity_type VARCHAR DEFAULT NULL,
    p_related_entity_id UUID DEFAULT NULL,
    p_description TEXT DEFAULT NULL
)
RETURNS UUID AS $$
DECLARE
    v_existing_ledger_id UUID;
    v_fin_id UUID;
    v_current_total NUMERIC;
    v_current_reserved NUMERIC;
    v_new_reserved NUMERIC;
    v_new_ledger_id UUID;
BEGIN
    IF p_amount_eur IS NULL OR p_amount_eur <= 0 THEN
        RAISE EXCEPTION 'INVALID_RESERVATION_OPERATION' USING ERRCODE = 'P0001';
    END IF;

    -- Check idempotency
    SELECT id INTO v_existing_ledger_id
    FROM public.financial_ledger
    WHERE league_club_id = p_club_id AND idempotency_key = p_idempotency_key;

    IF v_existing_ledger_id IS NOT NULL THEN
        RETURN v_existing_ledger_id;
    END IF;

    -- Lock club_finances row FOR UPDATE
    SELECT id, total_balance, reserved_balance
    INTO v_fin_id, v_current_total, v_current_reserved
    FROM public.club_finances
    WHERE league_club_id = p_club_id AND league_id = p_league_id FOR UPDATE;

    IF v_fin_id IS NULL THEN
        RAISE EXCEPTION 'INVALID_PARAM' USING ERRCODE = 'P0001';
    END IF;

    IF v_current_reserved < p_amount_eur THEN
        RAISE EXCEPTION 'INVALID_RESERVATION_OPERATION' USING ERRCODE = 'P0001';
    END IF;

    v_new_reserved := v_current_reserved - p_amount_eur;

    -- Update reserved_balance
    UPDATE public.club_finances
    SET reserved_balance = v_new_reserved,
        version = version + 1,
        updated_at = NOW()
    WHERE id = v_fin_id;

    -- Append audit row to financial_ledger (signed amount_eur = +p_amount_eur to reflect available balance increase)
    INSERT INTO public.financial_ledger (
        league_id,
        league_club_id,
        transaction_type,
        amount_eur,
        balance_before,
        balance_after,
        reserved_before,
        reserved_after,
        related_entity_type,
        related_entity_id,
        idempotency_key,
        description
    ) VALUES (
        p_league_id,
        p_club_id,
        'TRANSFER_RESERVE_RELEASE',
        p_amount_eur,
        v_current_total,
        v_current_total,
        v_current_reserved,
        v_new_reserved,
        p_related_entity_type,
        p_related_entity_id,
        p_idempotency_key,
        p_description
    ) RETURNING id INTO v_new_ledger_id;

    RETURN v_new_ledger_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;


-- Function F: capture_club_reserved_funds
CREATE OR REPLACE FUNCTION public.capture_club_reserved_funds(
    p_club_id UUID,
    p_league_id UUID,
    p_amount_eur NUMERIC,
    p_idempotency_key VARCHAR,
    p_related_entity_type VARCHAR DEFAULT NULL,
    p_related_entity_id UUID DEFAULT NULL,
    p_description TEXT DEFAULT NULL
)
RETURNS UUID AS $$
DECLARE
    v_existing_ledger_id UUID;
    v_fin_id UUID;
    v_current_total NUMERIC;
    v_current_reserved NUMERIC;
    v_new_total NUMERIC;
    v_new_reserved NUMERIC;
    v_new_ledger_id UUID;
BEGIN
    IF p_amount_eur IS NULL OR p_amount_eur <= 0 THEN
        RAISE EXCEPTION 'INVALID_RESERVATION_OPERATION' USING ERRCODE = 'P0001';
    END IF;

    -- Check idempotency
    SELECT id INTO v_existing_ledger_id
    FROM public.financial_ledger
    WHERE league_club_id = p_club_id AND idempotency_key = p_idempotency_key;

    IF v_existing_ledger_id IS NOT NULL THEN
        RETURN v_existing_ledger_id;
    END IF;

    -- Lock club_finances row FOR UPDATE
    SELECT id, total_balance, reserved_balance
    INTO v_fin_id, v_current_total, v_current_reserved
    FROM public.club_finances
    WHERE league_club_id = p_club_id AND league_id = p_league_id FOR UPDATE;

    IF v_fin_id IS NULL THEN
        RAISE EXCEPTION 'INVALID_PARAM' USING ERRCODE = 'P0001';
    END IF;

    IF v_current_reserved < p_amount_eur OR v_current_total < p_amount_eur THEN
        RAISE EXCEPTION 'INVALID_RESERVATION_OPERATION' USING ERRCODE = 'P0001';
    END IF;

    v_new_total := v_current_total - p_amount_eur;
    v_new_reserved := v_current_reserved - p_amount_eur;

    -- Update total_balance and reserved_balance
    UPDATE public.club_finances
    SET total_balance = v_new_total,
        reserved_balance = v_new_reserved,
        version = version + 1,
        updated_at = NOW()
    WHERE id = v_fin_id;

    -- Append audit row to financial_ledger
    INSERT INTO public.financial_ledger (
        league_id,
        league_club_id,
        transaction_type,
        amount_eur,
        balance_before,
        balance_after,
        reserved_before,
        reserved_after,
        related_entity_type,
        related_entity_id,
        idempotency_key,
        description
    ) VALUES (
        p_league_id,
        p_club_id,
        'TRANSFER_PURCHASE',
        -p_amount_eur,
        v_current_total,
        v_new_total,
        v_current_reserved,
        v_new_reserved,
        p_related_entity_type,
        p_related_entity_id,
        p_idempotency_key,
        p_description
    ) RETURNING id INTO v_new_ledger_id;

    RETURN v_new_ledger_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;


-- 8. Row Level Security & Explicit Privilege Boundary

ALTER TABLE public.league_players ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.league_player_positions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.club_finances ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.financial_ledger ENABLE ROW LEVEL SECURITY;

-- Revoke all default access from PUBLIC, anon, and authenticated
REVOKE ALL ON public.league_players FROM PUBLIC, anon, authenticated;
REVOKE ALL ON public.league_player_positions FROM PUBLIC, anon, authenticated;
REVOKE ALL ON public.club_finances FROM PUBLIC, anon, authenticated;
REVOKE ALL ON public.financial_ledger FROM PUBLIC, anon, authenticated;

-- Grant least privilege DML permissions to service_role
GRANT SELECT, INSERT, UPDATE, DELETE ON public.league_players TO service_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.league_player_positions TO service_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.club_finances TO service_role;
GRANT SELECT, INSERT ON public.financial_ledger TO service_role;

-- Grant RPC execution permissions to service_role only
GRANT EXECUTE ON FUNCTION public.calculate_club_starting_budget TO service_role;
GRANT EXECUTE ON FUNCTION public.instantiate_league_players_from_templates TO service_role;
GRANT EXECUTE ON FUNCTION public.initialize_club_finances TO service_role;
GRANT EXECUTE ON FUNCTION public.record_financial_transaction TO service_role;
GRANT EXECUTE ON FUNCTION public.reserve_club_funds TO service_role;
GRANT EXECUTE ON FUNCTION public.release_club_reserved_funds TO service_role;
GRANT EXECUTE ON FUNCTION public.capture_club_reserved_funds TO service_role;

-- Revoke RPC execution permissions from PUBLIC, anon, and authenticated
REVOKE EXECUTE ON FUNCTION public.calculate_club_starting_budget FROM PUBLIC, anon, authenticated;
REVOKE EXECUTE ON FUNCTION public.instantiate_league_players_from_templates FROM PUBLIC, anon, authenticated;
REVOKE EXECUTE ON FUNCTION public.initialize_club_finances FROM PUBLIC, anon, authenticated;
REVOKE EXECUTE ON FUNCTION public.record_financial_transaction FROM PUBLIC, anon, authenticated;
REVOKE EXECUTE ON FUNCTION public.reserve_club_funds FROM PUBLIC, anon, authenticated;
REVOKE EXECUTE ON FUNCTION public.release_club_reserved_funds FROM PUBLIC, anon, authenticated;
REVOKE EXECUTE ON FUNCTION public.capture_club_reserved_funds FROM PUBLIC, anon, authenticated;
