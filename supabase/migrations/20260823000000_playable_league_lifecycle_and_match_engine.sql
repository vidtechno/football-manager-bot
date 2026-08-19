-- Complete playable league lifecycle and lightweight match simulation.

CREATE OR REPLACE FUNCTION public.start_playable_league(
    p_league_id UUID,
    p_owner_manager_id UUID
) RETURNS JSONB AS $$
DECLARE
    v_league public.leagues%ROWTYPE;
    v_player_count INT;
BEGIN
    SELECT * INTO v_league FROM public.leagues WHERE id = p_league_id FOR UPDATE;
    IF NOT FOUND THEN RAISE EXCEPTION 'LEAGUE_NOT_FOUND' USING ERRCODE='P0001'; END IF;
    IF v_league.owner_manager_id <> p_owner_manager_id THEN RAISE EXCEPTION 'OWNER_REQUIRED' USING ERRCODE='P0001'; END IF;
    IF v_league.status <> 'LOBBY' THEN RAISE EXCEPTION 'LEAGUE_ALREADY_STARTED' USING ERRCODE='P0001'; END IF;
    IF NOT EXISTS (SELECT 1 FROM public.league_clubs WHERE league_id=p_league_id AND human_manager_id=p_owner_manager_id) THEN
        RAISE EXCEPTION 'OWNER_MUST_SELECT_CLUB' USING ERRCODE='P0001';
    END IF;

    PERFORM public.assign_bots_to_unselected_clubs(p_league_id);
    v_player_count := public.instantiate_league_players(p_league_id);
    PERFORM public.initialize_club_finances(p_league_id);
    PERFORM public.instantiate_league_legend_market(p_league_id);

    INSERT INTO public.league_rounds(league_id,round_number,status,scheduled_at)
    SELECT p_league_id, n, 'SCHEDULED', NOW() FROM generate_series(1,38) n
    ON CONFLICT (league_id,round_number) DO NOTHING;

    UPDATE public.leagues SET status='STARTING',started_at=NOW() WHERE id=p_league_id;
    UPDATE public.leagues SET status='ACTIVE' WHERE id=p_league_id;
    UPDATE public.league_settings SET is_speed_locked=TRUE WHERE league_id=p_league_id;
    RETURN jsonb_build_object('success',TRUE,'players',v_player_count,'status','ACTIVE');
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path=public;

CREATE OR REPLACE FUNCTION public.execute_league_round(
    p_league_id UUID,
    p_round_number INT DEFAULT NULL
) RETURNS JSONB AS $$
DECLARE
    v_league public.leagues%ROWTYPE;
    v_target_round INT;
    v_round public.league_rounds%ROWTYPE;
    v_clubs UUID[];
    v_count INT;
    v_shift INT;
    v_home UUID;
    v_away UUID;
    v_home_rating NUMERIC;
    v_away_rating NUMERIC;
    v_home_score INT;
    v_away_score INT;
    i INT;
BEGIN
    SELECT * INTO v_league FROM public.leagues WHERE id=p_league_id FOR UPDATE;
    IF NOT FOUND THEN RAISE EXCEPTION 'LEAGUE_NOT_FOUND' USING ERRCODE='P0001'; END IF;
    IF v_league.status <> 'ACTIVE' THEN RAISE EXCEPTION 'LEAGUE_NOT_ACTIVE' USING ERRCODE='P0001'; END IF;
    PERFORM public.check_daily_round_limit(p_league_id);
    SELECT COALESCE(p_round_number,MIN(round_number)) INTO v_target_round
      FROM public.league_rounds WHERE league_id=p_league_id AND status='SCHEDULED';
    IF v_target_round IS NULL THEN RAISE EXCEPTION 'NO_SCHEDULED_ROUNDS_REMAINING' USING ERRCODE='P0001'; END IF;
    SELECT * INTO v_round FROM public.league_rounds WHERE league_id=p_league_id AND round_number=v_target_round FOR UPDATE;
    IF NOT FOUND OR v_round.status <> 'SCHEDULED' THEN RAISE EXCEPTION 'ROUND_NOT_AVAILABLE' USING ERRCODE='P0001'; END IF;

    SELECT array_agg(id ORDER BY id) INTO v_clubs FROM public.league_clubs WHERE league_id=p_league_id;
    v_count := array_length(v_clubs,1);
    IF v_count <> 20 THEN RAISE EXCEPTION 'LEAGUE_CLUB_COUNT_INVALID' USING ERRCODE='P0001'; END IF;
    v_shift := ((v_target_round-1) % 19);

    FOR i IN 1..10 LOOP
      v_home := v_clubs[CASE WHEN i=1 THEN 1 ELSE 2 + ((i-2+v_shift) % 19) END];
      v_away := v_clubs[2 + ((19-i+v_shift) % 19)];
      IF v_target_round > 19 THEN v_home := v_away; v_away := v_clubs[CASE WHEN i=1 THEN 1 ELSE 2 + ((i-2+v_shift) % 19) END]; END IF;
      IF v_home = v_away THEN CONTINUE; END IF;
      SELECT COALESCE(AVG(overall_rating),70) INTO v_home_rating FROM public.league_players WHERE league_club_id=v_home;
      SELECT COALESCE(AVG(overall_rating),70) INTO v_away_rating FROM public.league_players WHERE league_club_id=v_away;
      v_home_score := GREATEST(0, LEAST(6, floor(random()*3 + GREATEST(-0.5,LEAST(1.5,(v_home_rating-v_away_rating)/10)))::INT));
      v_away_score := GREATEST(0, LEAST(6, floor(random()*3 + GREATEST(-0.5,LEAST(1.5,(v_away_rating-v_home_rating)/10)))::INT));
      INSERT INTO public.league_matches(league_id,league_round_id,round_number,home_club_id,away_club_id,home_score,away_score,status)
      VALUES(p_league_id,v_round.id,v_target_round,v_home,v_away,v_home_score,v_away_score,'COMPLETED');
    END LOOP;

    UPDATE public.league_rounds SET status='COMPLETED',started_at=COALESCE(started_at,NOW()),completed_at=NOW(),updated_at=NOW() WHERE id=v_round.id;
    IF v_target_round=38 THEN UPDATE public.leagues SET status='COMPLETED',completed_at=NOW() WHERE id=p_league_id; END IF;
    RETURN jsonb_build_object('success',TRUE,'league_id',p_league_id,'completed_round_number',v_target_round,'completed_at',NOW());
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path=public;

REVOKE ALL ON FUNCTION public.start_playable_league(UUID,UUID) FROM PUBLIC,anon,authenticated;
GRANT EXECUTE ON FUNCTION public.start_playable_league(UUID,UUID) TO service_role;
REVOKE ALL ON FUNCTION public.execute_league_round(UUID,INT) FROM PUBLIC,anon,authenticated;
GRANT EXECUTE ON FUNCTION public.execute_league_round(UUID,INT) TO service_role;
