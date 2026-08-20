-- Fix the playable league initializer to match the normalized attribute columns
-- used by player_template_versions and league_players.

CREATE OR REPLACE FUNCTION public.instantiate_league_players(p_league_id UUID)
RETURNS INT AS $$
DECLARE
    v_existing_count INT;
    v_active_template_count INT;
    v_club RECORD;
    v_club_player_count INT;
    v_club_gk_count INT;
    v_inserted_count INT := 0;
    v_player_rec RECORD;
    v_new_league_player_id UUID;
BEGIN
    PERFORM pg_advisory_xact_lock(hashtext(p_league_id::text));

    SELECT COUNT(*) INTO v_existing_count
    FROM public.league_players
    WHERE league_id = p_league_id;

    IF v_existing_count > 0 THEN
        RETURN v_existing_count;
    END IF;

    SELECT COUNT(*) INTO v_active_template_count
    FROM public.player_templates
    WHERE is_active = TRUE;

    IF v_active_template_count = 0 THEN
        RAISE EXCEPTION 'PLAYER_TEMPLATES_EMPTY' USING ERRCODE = 'P0001';
    END IF;

    FOR v_club IN
        SELECT lc.id AS league_club_id, lc.club_template_id
        FROM public.league_clubs lc
        WHERE lc.league_id = p_league_id
    LOOP
        SELECT COUNT(*) INTO v_club_player_count
        FROM public.player_templates pt
        WHERE pt.current_club_template_id = v_club.club_template_id
          AND pt.is_active = TRUE;

        IF v_club_player_count < 18 OR v_club_player_count > 30 THEN
            RAISE EXCEPTION 'INVALID_SQUAD_SIZE' USING ERRCODE = 'P0001';
        END IF;

        SELECT COUNT(*) INTO v_club_gk_count
        FROM public.player_templates pt
        JOIN public.player_template_positions ptp
          ON pt.id = ptp.player_template_id
        WHERE pt.current_club_template_id = v_club.club_template_id
          AND pt.is_active = TRUE
          AND ptp.position_code = 'GK';

        IF v_club_gk_count < 2 THEN
            RAISE EXCEPTION 'INSUFFICIENT_GOALKEEPERS' USING ERRCODE = 'P0001';
        END IF;

        FOR v_player_rec IN
            SELECT
                pt.id AS player_template_id,
                pt.full_name,
                pt.date_of_birth,
                pt.nationality,
                ptv.id AS player_template_version_id,
                ptv.market_value_eur,
                ptv.overall_rating,
                ptv.pace,
                ptv.shooting,
                ptv.passing,
                ptv.dribbling,
                ptv.defending,
                ptv.physical,
                ptv.reflexes,
                ptv.handling,
                ptv.positioning,
                ptv.aerial_ability,
                ptv.distribution,
                ptv.one_on_one
            FROM public.player_templates pt
            JOIN public.player_template_versions ptv
              ON pt.id = ptv.player_template_id
             AND ptv.is_current = TRUE
            WHERE pt.current_club_template_id = v_club.club_template_id
              AND pt.is_active = TRUE
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
                pace,
                shooting,
                passing,
                dribbling,
                defending,
                physical,
                reflexes,
                handling,
                positioning,
                aerial_ability,
                distribution,
                one_on_one,
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
                v_player_rec.pace,
                v_player_rec.shooting,
                v_player_rec.passing,
                v_player_rec.dribbling,
                v_player_rec.defending,
                v_player_rec.physical,
                v_player_rec.reflexes,
                v_player_rec.handling,
                v_player_rec.positioning,
                v_player_rec.aerial_ability,
                v_player_rec.distribution,
                v_player_rec.one_on_one,
                'AVAILABLE',
                100,
                7,
                7
            ) RETURNING id INTO v_new_league_player_id;

            INSERT INTO public.league_player_positions (
                league_player_id,
                position_code,
                is_primary
            )
            SELECT
                v_new_league_player_id,
                position_code,
                is_primary
            FROM public.player_template_positions
            WHERE player_template_id = v_player_rec.player_template_id;

            v_inserted_count := v_inserted_count + 1;
        END LOOP;
    END LOOP;

    RETURN v_inserted_count;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

REVOKE ALL ON FUNCTION public.instantiate_league_players(UUID) FROM PUBLIC, anon, authenticated;
GRANT EXECUTE ON FUNCTION public.instantiate_league_players(UUID) TO service_role;
