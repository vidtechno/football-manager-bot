-- Reprodusibl Phase 4E Seed Data generated on 2026-08-19T01:54:35.682Z
-- Snapshot Date: 2026-08-19
-- Total Clubs: 20, Total Players: 363, Total Value: €13,311,750,000

BEGIN;

-- 1. Seed Initial Club Template Versions (v1)
INSERT INTO public.club_template_versions (
    club_template_id,
    version,
    reputation,
    base_squad_value,
    is_current
) VALUES (
    (SELECT id FROM public.club_templates WHERE slug = 'real-madrid'),
    1,
    95,
    1352000000.00,
    TRUE
) ON CONFLICT (club_template_id, version) DO NOTHING;

INSERT INTO public.club_template_versions (
    club_template_id,
    version,
    reputation,
    base_squad_value,
    is_current
) VALUES (
    (SELECT id FROM public.club_templates WHERE slug = 'barcelona'),
    1,
    93,
    865000000.00,
    TRUE
) ON CONFLICT (club_template_id, version) DO NOTHING;

INSERT INTO public.club_template_versions (
    club_template_id,
    version,
    reputation,
    base_squad_value,
    is_current
) VALUES (
    (SELECT id FROM public.club_templates WHERE slug = 'atletico-madrid'),
    1,
    87,
    483000000.00,
    TRUE
) ON CONFLICT (club_template_id, version) DO NOTHING;

INSERT INTO public.club_template_versions (
    club_template_id,
    version,
    reputation,
    base_squad_value,
    is_current
) VALUES (
    (SELECT id FROM public.club_templates WHERE slug = 'manchester-city'),
    1,
    94,
    1147000000.00,
    TRUE
) ON CONFLICT (club_template_id, version) DO NOTHING;

INSERT INTO public.club_template_versions (
    club_template_id,
    version,
    reputation,
    base_squad_value,
    is_current
) VALUES (
    (SELECT id FROM public.club_templates WHERE slug = 'liverpool'),
    1,
    91,
    801000000.00,
    TRUE
) ON CONFLICT (club_template_id, version) DO NOTHING;

INSERT INTO public.club_template_versions (
    club_template_id,
    version,
    reputation,
    base_squad_value,
    is_current
) VALUES (
    (SELECT id FROM public.club_templates WHERE slug = 'arsenal'),
    1,
    89,
    1037500000.00,
    TRUE
) ON CONFLICT (club_template_id, version) DO NOTHING;

INSERT INTO public.club_template_versions (
    club_template_id,
    version,
    reputation,
    base_squad_value,
    is_current
) VALUES (
    (SELECT id FROM public.club_templates WHERE slug = 'chelsea'),
    1,
    86,
    810000000.00,
    TRUE
) ON CONFLICT (club_template_id, version) DO NOTHING;

INSERT INTO public.club_template_versions (
    club_template_id,
    version,
    reputation,
    base_squad_value,
    is_current
) VALUES (
    (SELECT id FROM public.club_templates WHERE slug = 'manchester-united'),
    1,
    88,
    719000000.00,
    TRUE
) ON CONFLICT (club_template_id, version) DO NOTHING;

INSERT INTO public.club_template_versions (
    club_template_id,
    version,
    reputation,
    base_squad_value,
    is_current
) VALUES (
    (SELECT id FROM public.club_templates WHERE slug = 'tottenham'),
    1,
    84,
    729500000.00,
    TRUE
) ON CONFLICT (club_template_id, version) DO NOTHING;

INSERT INTO public.club_template_versions (
    club_template_id,
    version,
    reputation,
    base_squad_value,
    is_current
) VALUES (
    (SELECT id FROM public.club_templates WHERE slug = 'bayern-munich'),
    1,
    92,
    768000000.00,
    TRUE
) ON CONFLICT (club_template_id, version) DO NOTHING;

INSERT INTO public.club_template_versions (
    club_template_id,
    version,
    reputation,
    base_squad_value,
    is_current
) VALUES (
    (SELECT id FROM public.club_templates WHERE slug = 'borussia-dortmund'),
    1,
    85,
    444000000.00,
    TRUE
) ON CONFLICT (club_template_id, version) DO NOTHING;

INSERT INTO public.club_template_versions (
    club_template_id,
    version,
    reputation,
    base_squad_value,
    is_current
) VALUES (
    (SELECT id FROM public.club_templates WHERE slug = 'bayer-leverkusen'),
    1,
    86,
    580500000.00,
    TRUE
) ON CONFLICT (club_template_id, version) DO NOTHING;

INSERT INTO public.club_template_versions (
    club_template_id,
    version,
    reputation,
    base_squad_value,
    is_current
) VALUES (
    (SELECT id FROM public.club_templates WHERE slug = 'paris-saint-germain'),
    1,
    90,
    792000000.00,
    TRUE
) ON CONFLICT (club_template_id, version) DO NOTHING;

INSERT INTO public.club_template_versions (
    club_template_id,
    version,
    reputation,
    base_squad_value,
    is_current
) VALUES (
    (SELECT id FROM public.club_templates WHERE slug = 'inter'),
    1,
    88,
    623500000.00,
    TRUE
) ON CONFLICT (club_template_id, version) DO NOTHING;

INSERT INTO public.club_template_versions (
    club_template_id,
    version,
    reputation,
    base_squad_value,
    is_current
) VALUES (
    (SELECT id FROM public.club_templates WHERE slug = 'ac-milan'),
    1,
    86,
    502500000.00,
    TRUE
) ON CONFLICT (club_template_id, version) DO NOTHING;

INSERT INTO public.club_template_versions (
    club_template_id,
    version,
    reputation,
    base_squad_value,
    is_current
) VALUES (
    (SELECT id FROM public.club_templates WHERE slug = 'juventus'),
    1,
    87,
    531000000.00,
    TRUE
) ON CONFLICT (club_template_id, version) DO NOTHING;

INSERT INTO public.club_template_versions (
    club_template_id,
    version,
    reputation,
    base_squad_value,
    is_current
) VALUES (
    (SELECT id FROM public.club_templates WHERE slug = 'napoli'),
    1,
    84,
    382500000.00,
    TRUE
) ON CONFLICT (club_template_id, version) DO NOTHING;

INSERT INTO public.club_template_versions (
    club_template_id,
    version,
    reputation,
    base_squad_value,
    is_current
) VALUES (
    (SELECT id FROM public.club_templates WHERE slug = 'benfica'),
    1,
    82,
    293000000.00,
    TRUE
) ON CONFLICT (club_template_id, version) DO NOTHING;

INSERT INTO public.club_template_versions (
    club_template_id,
    version,
    reputation,
    base_squad_value,
    is_current
) VALUES (
    (SELECT id FROM public.club_templates WHERE slug = 'porto'),
    1,
    81,
    280500000.00,
    TRUE
) ON CONFLICT (club_template_id, version) DO NOTHING;

INSERT INTO public.club_template_versions (
    club_template_id,
    version,
    reputation,
    base_squad_value,
    is_current
) VALUES (
    (SELECT id FROM public.club_templates WHERE slug = 'ajax'),
    1,
    80,
    170250000.00,
    TRUE
) ON CONFLICT (club_template_id, version) DO NOTHING;

-- 2. Seed Player Templates, Positions, and Relational Attribute Versions (v1)
DO $$
DECLARE
    v_club_id UUID;
    v_player_id UUID;
BEGIN
    -- Player: Thibaut Courtois (thibaut-courtois)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'real-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'thibaut-courtois') THEN
        v_player_id := public.create_player_template_with_positions(
            'thibaut-courtois',
            v_club_id,
            'Thibaut Courtois',
            '1992-05-11',
            'Belgium',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 28000000.00, 89,
            90, 88, 89, 88, 75, 89, TRUE
        );
    END IF;

    -- Player: Andriy Lunin (andriy-lunin)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'real-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'andriy-lunin') THEN
        v_player_id := public.create_player_template_with_positions(
            'andriy-lunin',
            v_club_id,
            'Andriy Lunin',
            '1999-02-11',
            'Ukraine',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 25000000.00, 81,
            82, 79, 80, 78, 74, 81, TRUE
        );
    END IF;

    -- Player: Antonio Rüdiger (antonio-rudiger)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'real-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'antonio-rudiger') THEN
        v_player_id := public.create_player_template_with_positions(
            'antonio-rudiger',
            v_club_id,
            'Antonio Rüdiger',
            '1993-03-03',
            'Germany',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 25000000.00, 87,
            82, 54, 71, 66, 86, 86, TRUE
        );
    END IF;

    -- Player: Éder Militão (eder-militao)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'real-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'eder-militao') THEN
        v_player_id := public.create_player_template_with_positions(
            'eder-militao',
            v_club_id,
            'Éder Militão',
            '1998-01-18',
            'Brazil',
            'CB'::public.enum_player_position,
            ARRAY['RB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 60000000.00, 85,
            83, 50, 70, 71, 85, 82, TRUE
        );
    END IF;

    -- Player: David Alaba (david-alaba)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'real-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'david-alaba') THEN
        v_player_id := public.create_player_template_with_positions(
            'david-alaba',
            v_club_id,
            'David Alaba',
            '1992-06-24',
            'Austria',
            'CB'::public.enum_player_position,
            ARRAY['LB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 15000000.00, 84,
            75, 70, 81, 79, 84, 74, TRUE
        );
    END IF;

    -- Player: Dani Carvajal (dani-carvajal)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'real-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'dani-carvajal') THEN
        v_player_id := public.create_player_template_with_positions(
            'dani-carvajal',
            v_club_id,
            'Dani Carvajal',
            '1992-01-11',
            'Spain',
            'RB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 12000000.00, 86,
            80, 56, 77, 79, 82, 81, TRUE
        );
    END IF;

    -- Player: Ferland Mendy (ferland-mendy)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'real-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'ferland-mendy') THEN
        v_player_id := public.create_player_template_with_positions(
            'ferland-mendy',
            v_club_id,
            'Ferland Mendy',
            '1995-06-08',
            'France',
            'LB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 22000000.00, 83,
            88, 63, 75, 78, 81, 84, TRUE
        );
    END IF;

    -- Player: Jude Bellingham (jude-bellingham)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'real-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jude-bellingham') THEN
        v_player_id := public.create_player_template_with_positions(
            'jude-bellingham',
            v_club_id,
            'Jude Bellingham',
            '2003-06-29',
            'England',
            'CAM'::public.enum_player_position,
            ARRAY['CM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 180000000.00, 90,
            80, 87, 83, 88, 78, 84, TRUE
        );
    END IF;

    -- Player: Federico Valverde (federico-valverde)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'real-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'federico-valverde') THEN
        v_player_id := public.create_player_template_with_positions(
            'federico-valverde',
            v_club_id,
            'Federico Valverde',
            '1998-07-22',
            'Uruguay',
            'CM'::public.enum_player_position,
            ARRAY['RM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 130000000.00, 88,
            88, 82, 84, 84, 80, 84, TRUE
        );
    END IF;

    -- Player: Aurélien Tchouaméni (aurelien-tchouameni)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'real-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'aurelien-tchouameni') THEN
        v_player_id := public.create_player_template_with_positions(
            'aurelien-tchouameni',
            v_club_id,
            'Aurélien Tchouaméni',
            '2000-01-27',
            'France',
            'CDM'::public.enum_player_position,
            ARRAY['CB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 100000000.00, 86,
            76, 70, 80, 78, 84, 84, TRUE
        );
    END IF;

    -- Player: Eduardo Camavinga (eduardo-camavinga)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'real-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'eduardo-camavinga') THEN
        v_player_id := public.create_player_template_with_positions(
            'eduardo-camavinga',
            v_club_id,
            'Eduardo Camavinga',
            '2002-11-10',
            'France',
            'CM'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position, 'LB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 100000000.00, 84,
            81, 67, 80, 83, 80, 80, TRUE
        );
    END IF;

    -- Player: Luka Modrić (luka-modric)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'real-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'luka-modric') THEN
        v_player_id := public.create_player_template_with_positions(
            'luka-modric',
            v_club_id,
            'Luka Modrić',
            '1985-09-09',
            'Croatia',
            'CM'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 6000000.00, 86,
            71, 75, 89, 87, 72, 65, TRUE
        );
    END IF;

    -- Player: Dani Ceballos (dani-ceballos)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'real-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'dani-ceballos') THEN
        v_player_id := public.create_player_template_with_positions(
            'dani-ceballos',
            v_club_id,
            'Dani Ceballos',
            '1996-08-07',
            'Spain',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 14000000.00, 79,
            68, 69, 80, 82, 70, 68, TRUE
        );
    END IF;

    -- Player: Arda Güler (arda-guler)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'real-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'arda-guler') THEN
        v_player_id := public.create_player_template_with_positions(
            'arda-guler',
            v_club_id,
            'Arda Güler',
            '2005-02-25',
            'Turkey',
            'CAM'::public.enum_player_position,
            ARRAY['RW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 45000000.00, 78,
            74, 74, 80, 82, 52, 60, TRUE
        );
    END IF;

    -- Player: Vinícius Júnior (vinicius-junior)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'real-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'vinicius-junior') THEN
        v_player_id := public.create_player_template_with_positions(
            'vinicius-junior',
            v_club_id,
            'Vinícius Júnior',
            '2000-07-12',
            'Brazil',
            'LW'::public.enum_player_position,
            ARRAY['ST'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 200000000.00, 90,
            95, 84, 81, 91, 29, 69, TRUE
        );
    END IF;

    -- Player: Kylian Mbappé (kylian-mbappe)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'real-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'kylian-mbappe') THEN
        v_player_id := public.create_player_template_with_positions(
            'kylian-mbappe',
            v_club_id,
            'Kylian Mbappé',
            '1998-12-20',
            'France',
            'ST'::public.enum_player_position,
            ARRAY['LW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 180000000.00, 91,
            97, 90, 80, 92, 36, 78, TRUE
        );
    END IF;

    -- Player: Rodrygo (rodrygo)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'real-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'rodrygo') THEN
        v_player_id := public.create_player_template_with_positions(
            'rodrygo',
            v_club_id,
            'Rodrygo',
            '2001-01-09',
            'Brazil',
            'RW'::public.enum_player_position,
            ARRAY['LW'::public.enum_player_position, 'ST'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 110000000.00, 86,
            88, 81, 79, 87, 32, 62, TRUE
        );
    END IF;

    -- Player: Endrick (endrick)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'real-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'endrick') THEN
        v_player_id := public.create_player_template_with_positions(
            'endrick',
            v_club_id,
            'Endrick',
            '2006-07-21',
            'Brazil',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 60000000.00, 77,
            86, 77, 62, 79, 30, 76, TRUE
        );
    END IF;

    -- Player: Brahim Díaz (brahim-diaz)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'real-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'brahim-diaz') THEN
        v_player_id := public.create_player_template_with_positions(
            'brahim-diaz',
            v_club_id,
            'Brahim Díaz',
            '1999-08-03',
            'Morocco',
            'CAM'::public.enum_player_position,
            ARRAY['RW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 40000000.00, 82,
            82, 75, 78, 85, 31, 54, TRUE
        );
    END IF;

    -- Player: Marc-André ter Stegen (marc-andre-ter-stegen)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'barcelona';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'marc-andre-ter-stegen') THEN
        v_player_id := public.create_player_template_with_positions(
            'marc-andre-ter-stegen',
            v_club_id,
            'Marc-André ter Stegen',
            '1992-04-30',
            'Germany',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 89,
            89, 86, 88, 85, 90, 88, TRUE
        );
    END IF;

    -- Player: Iñaki Peña (inaki-pena)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'barcelona';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'inaki-pena') THEN
        v_player_id := public.create_player_template_with_positions(
            'inaki-pena',
            v_club_id,
            'Iñaki Peña',
            '1999-03-02',
            'Spain',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 10000000.00, 77,
            78, 75, 76, 74, 77, 76, TRUE
        );
    END IF;

    -- Player: Ronald Araújo (ronald-araujo)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'barcelona';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'ronald-araujo') THEN
        v_player_id := public.create_player_template_with_positions(
            'ronald-araujo',
            v_club_id,
            'Ronald Araújo',
            '1999-03-07',
            'Uruguay',
            'CB'::public.enum_player_position,
            ARRAY['RB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 70000000.00, 86,
            80, 46, 65, 64, 86, 84, TRUE
        );
    END IF;

    -- Player: Pau Cubarsí (pau-cubarsi)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'barcelona';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'pau-cubarsi') THEN
        v_player_id := public.create_player_template_with_positions(
            'pau-cubarsi',
            v_club_id,
            'Pau Cubarsí',
            '2007-01-22',
            'Spain',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 40000000.00, 79,
            71, 40, 78, 72, 80, 72, TRUE
        );
    END IF;

    -- Player: Jules Koundé (jules-kounde)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'barcelona';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jules-kounde') THEN
        v_player_id := public.create_player_template_with_positions(
            'jules-kounde',
            v_club_id,
            'Jules Koundé',
            '1998-11-12',
            'France',
            'RB'::public.enum_player_position,
            ARRAY['CB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 55000000.00, 85,
            82, 45, 74, 76, 85, 78, TRUE
        );
    END IF;

    -- Player: Alejandro Balde (alejandro-balde)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'barcelona';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'alejandro-balde') THEN
        v_player_id := public.create_player_template_with_positions(
            'alejandro-balde',
            v_club_id,
            'Alejandro Balde',
            '2003-10-18',
            'Spain',
            'LB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 40000000.00, 81,
            91, 51, 73, 79, 76, 68, TRUE
        );
    END IF;

    -- Player: Iñigo Martínez (inigo-martinez)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'barcelona';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'inigo-martinez') THEN
        v_player_id := public.create_player_template_with_positions(
            'inigo-martinez',
            v_club_id,
            'Iñigo Martínez',
            '1991-05-17',
            'Spain',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 5000000.00, 81,
            68, 52, 72, 66, 82, 79, TRUE
        );
    END IF;

    -- Player: Pedri (pedri)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'barcelona';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'pedri') THEN
        v_player_id := public.create_player_template_with_positions(
            'pedri',
            v_club_id,
            'Pedri',
            '2002-11-25',
            'Spain',
            'CM'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 80000000.00, 86,
            78, 68, 86, 88, 68, 64, TRUE
        );
    END IF;

    -- Player: Gavi (gavi)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'barcelona';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'gavi') THEN
        v_player_id := public.create_player_template_with_positions(
            'gavi',
            v_club_id,
            'Gavi',
            '2004-08-05',
            'Spain',
            'CM'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 90000000.00, 83,
            76, 66, 79, 84, 75, 78, TRUE
        );
    END IF;

    -- Player: Frenkie de Jong (frenkie-de-jong)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'barcelona';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'frenkie-de-jong') THEN
        v_player_id := public.create_player_template_with_positions(
            'frenkie-de-jong',
            v_club_id,
            'Frenkie de Jong',
            '1997-05-12',
            'Netherlands',
            'CM'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 60000000.00, 87,
            82, 69, 86, 87, 77, 78, TRUE
        );
    END IF;

    -- Player: Dani Olmo (dani-olmo)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'barcelona';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'dani-olmo') THEN
        v_player_id := public.create_player_template_with_positions(
            'dani-olmo',
            v_club_id,
            'Dani Olmo',
            '1998-05-07',
            'Spain',
            'CAM'::public.enum_player_position,
            ARRAY['LW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 60000000.00, 84,
            77, 78, 82, 85, 50, 64, TRUE
        );
    END IF;

    -- Player: Fermín López (fermin-lopez)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'barcelona';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'fermin-lopez') THEN
        v_player_id := public.create_player_template_with_positions(
            'fermin-lopez',
            v_club_id,
            'Fermín López',
            '2003-05-11',
            'Spain',
            'CM'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 50000000.00, 79,
            78, 76, 78, 80, 64, 70, TRUE
        );
    END IF;

    -- Player: Marc Casadó (marc-casado)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'barcelona';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'marc-casado') THEN
        v_player_id := public.create_player_template_with_positions(
            'marc-casado',
            v_club_id,
            'Marc Casadó',
            '2003-09-14',
            'Spain',
            'CDM'::public.enum_player_position,
            ARRAY['CM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 15000000.00, 75,
            72, 58, 75, 74, 75, 73, TRUE
        );
    END IF;

    -- Player: Lamine Yamal (lamine-yamal)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'barcelona';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'lamine-yamal') THEN
        v_player_id := public.create_player_template_with_positions(
            'lamine-yamal',
            v_club_id,
            'Lamine Yamal',
            '2007-07-13',
            'Spain',
            'RW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 150000000.00, 83,
            88, 77, 81, 88, 26, 52, TRUE
        );
    END IF;

    -- Player: Robert Lewandowski (robert-lewandowski)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'barcelona';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'robert-lewandowski') THEN
        v_player_id := public.create_player_template_with_positions(
            'robert-lewandowski',
            v_club_id,
            'Robert Lewandowski',
            '1988-08-21',
            'Poland',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 15000000.00, 88,
            75, 88, 79, 82, 44, 82, TRUE
        );
    END IF;

    -- Player: Raphinha (raphinha)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'barcelona';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'raphinha') THEN
        v_player_id := public.create_player_template_with_positions(
            'raphinha',
            v_club_id,
            'Raphinha',
            '1996-12-14',
            'Brazil',
            'RW'::public.enum_player_position,
            ARRAY['LW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 60000000.00, 84,
            91, 80, 80, 85, 50, 73, TRUE
        );
    END IF;

    -- Player: Ferran Torres (ferran-torres)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'barcelona';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'ferran-torres') THEN
        v_player_id := public.create_player_template_with_positions(
            'ferran-torres',
            v_club_id,
            'Ferran Torres',
            '2000-02-29',
            'Spain',
            'LW'::public.enum_player_position,
            ARRAY['ST'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 30000000.00, 80,
            82, 78, 76, 81, 35, 66, TRUE
        );
    END IF;

    -- Player: Ansu Fati (ansu-fati)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'barcelona';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'ansu-fati') THEN
        v_player_id := public.create_player_template_with_positions(
            'ansu-fati',
            v_club_id,
            'Ansu Fati',
            '2002-10-31',
            'Spain',
            'LW'::public.enum_player_position,
            ARRAY['ST'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 15000000.00, 77,
            84, 75, 71, 79, 29, 54, TRUE
        );
    END IF;

    -- Player: Jan Oblak (jan-oblak)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'atletico-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jan-oblak') THEN
        v_player_id := public.create_player_template_with_positions(
            'jan-oblak',
            v_club_id,
            'Jan Oblak',
            '1993-01-07',
            'Slovenia',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 28000000.00, 88,
            89, 87, 89, 86, 78, 88, TRUE
        );
    END IF;

    -- Player: Juan Musso (juan-musso)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'atletico-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'juan-musso') THEN
        v_player_id := public.create_player_template_with_positions(
            'juan-musso',
            v_club_id,
            'Juan Musso',
            '1994-05-06',
            'Argentina',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 5000000.00, 76,
            78, 74, 76, 75, 71, 77, TRUE
        );
    END IF;

    -- Player: José María Giménez (jose-maria-gimenez)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'atletico-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jose-maria-gimenez') THEN
        v_player_id := public.create_player_template_with_positions(
            'jose-maria-gimenez',
            v_club_id,
            'José María Giménez',
            '1995-01-20',
            'Uruguay',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 22000000.00, 83,
            72, 45, 58, 60, 84, 83, TRUE
        );
    END IF;

    -- Player: Robin Le Normand (robin-le-normand)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'atletico-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'robin-le-normand') THEN
        v_player_id := public.create_player_template_with_positions(
            'robin-le-normand',
            v_club_id,
            'Robin Le Normand',
            '1996-11-11',
            'Spain',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 40000000.00, 82,
            70, 40, 62, 64, 83, 81, TRUE
        );
    END IF;

    -- Player: Axel Witsel (axel-witsel)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'atletico-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'axel-witsel') THEN
        v_player_id := public.create_player_template_with_positions(
            'axel-witsel',
            v_club_id,
            'Axel Witsel',
            '1989-01-12',
            'Belgium',
            'CB'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 4000000.00, 80,
            55, 64, 76, 74, 81, 78, TRUE
        );
    END IF;

    -- Player: Nahuel Molina (nahuel-molina)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'atletico-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'nahuel-molina') THEN
        v_player_id := public.create_player_template_with_positions(
            'nahuel-molina',
            v_club_id,
            'Nahuel Molina',
            '1998-04-06',
            'Argentina',
            'RB'::public.enum_player_position,
            ARRAY['RWB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 28000000.00, 79,
            83, 66, 75, 77, 76, 74, TRUE
        );
    END IF;

    -- Player: Marcos Llorente (marcos-llorente)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'atletico-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'marcos-llorente') THEN
        v_player_id := public.create_player_template_with_positions(
            'marcos-llorente',
            v_club_id,
            'Marcos Llorente',
            '1995-01-30',
            'Spain',
            'RM'::public.enum_player_position,
            ARRAY['RB'::public.enum_player_position, 'CM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 30000000.00, 84,
            89, 78, 79, 81, 78, 82, TRUE
        );
    END IF;

    -- Player: Koke (koke)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'atletico-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'koke') THEN
        v_player_id := public.create_player_template_with_positions(
            'koke',
            v_club_id,
            'Koke',
            '1992-01-08',
            'Spain',
            'CM'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 12000000.00, 82,
            64, 72, 84, 78, 77, 76, TRUE
        );
    END IF;

    -- Player: Rodrigo De Paul (rodrigo-de-paul)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'atletico-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'rodrigo-de-paul') THEN
        v_player_id := public.create_player_template_with_positions(
            'rodrigo-de-paul',
            v_club_id,
            'Rodrigo De Paul',
            '1994-05-24',
            'Argentina',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 30000000.00, 84,
            78, 77, 83, 82, 76, 82, TRUE
        );
    END IF;

    -- Player: Conor Gallagher (conor-gallagher)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'atletico-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'conor-gallagher') THEN
        v_player_id := public.create_player_template_with_positions(
            'conor-gallagher',
            v_club_id,
            'Conor Gallagher',
            '2000-02-06',
            'England',
            'CM'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 50000000.00, 81,
            78, 74, 77, 79, 78, 83, TRUE
        );
    END IF;

    -- Player: Pablo Barrios (pablo-barrios)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'atletico-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'pablo-barrios') THEN
        v_player_id := public.create_player_template_with_positions(
            'pablo-barrios',
            v_club_id,
            'Pablo Barrios',
            '2003-06-15',
            'Spain',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 30000000.00, 77,
            75, 67, 77, 78, 72, 73, TRUE
        );
    END IF;

    -- Player: Samuel Lino (samuel-lino)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'atletico-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'samuel-lino') THEN
        v_player_id := public.create_player_template_with_positions(
            'samuel-lino',
            v_club_id,
            'Samuel Lino',
            '1999-12-23',
            'Brazil',
            'LM'::public.enum_player_position,
            ARRAY['LWB'::public.enum_player_position, 'LW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 30000000.00, 80,
            86, 74, 75, 82, 60, 68, TRUE
        );
    END IF;

    -- Player: Rodrigo Riquelme (rodrigo-riquelme)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'atletico-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'rodrigo-riquelme') THEN
        v_player_id := public.create_player_template_with_positions(
            'rodrigo-riquelme',
            v_club_id,
            'Rodrigo Riquelme',
            '2000-04-02',
            'Spain',
            'LM'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 22000000.00, 78,
            82, 73, 76, 81, 52, 64, TRUE
        );
    END IF;

    -- Player: Antoine Griezmann (antoine-griezmann)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'atletico-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'antoine-griezmann') THEN
        v_player_id := public.create_player_template_with_positions(
            'antoine-griezmann',
            v_club_id,
            'Antoine Griezmann',
            '1991-03-21',
            'France',
            'CF'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position, 'ST'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 25000000.00, 88,
            78, 88, 88, 88, 58, 72, TRUE
        );
    END IF;

    -- Player: Julián Alvarez (julian-alvarez)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'atletico-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'julian-alvarez') THEN
        v_player_id := public.create_player_template_with_positions(
            'julian-alvarez',
            v_club_id,
            'Julián Alvarez',
            '2000-01-31',
            'Argentina',
            'ST'::public.enum_player_position,
            ARRAY['CF'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 75000000.00, 84,
            84, 85, 78, 83, 50, 77, TRUE
        );
    END IF;

    -- Player: Alexander Sørloth (alexander-sorloth)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'atletico-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'alexander-sorloth') THEN
        v_player_id := public.create_player_template_with_positions(
            'alexander-sorloth',
            v_club_id,
            'Alexander Sørloth',
            '1995-12-05',
            'Norway',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 25000000.00, 81,
            76, 82, 68, 73, 38, 85, TRUE
        );
    END IF;

    -- Player: Ángel Correa (angel-correa)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'atletico-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'angel-correa') THEN
        v_player_id := public.create_player_template_with_positions(
            'angel-correa',
            v_club_id,
            'Ángel Correa',
            '1995-03-09',
            'Argentina',
            'ST'::public.enum_player_position,
            ARRAY['RM'::public.enum_player_position, 'RW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 18000000.00, 82,
            82, 79, 75, 85, 48, 74, TRUE
        );
    END IF;

    -- Player: Reinildo Mandava (reinildo-mandava)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'atletico-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'reinildo-mandava') THEN
        v_player_id := public.create_player_template_with_positions(
            'reinildo-mandava',
            v_club_id,
            'Reinildo Mandava',
            '1994-01-21',
            'Mozambique',
            'LB'::public.enum_player_position,
            ARRAY['CB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 9000000.00, 78,
            77, 42, 64, 68, 80, 79, TRUE
        );
    END IF;

    -- Player: Ederson (ederson)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'ederson') THEN
        v_player_id := public.create_player_template_with_positions(
            'ederson',
            v_club_id,
            'Ederson',
            '1993-08-17',
            'Brazil',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 88,
            86, 82, 86, 81, 93, 85, TRUE
        );
    END IF;

    -- Player: Stefan Ortega (stefan-ortega)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'stefan-ortega') THEN
        v_player_id := public.create_player_template_with_positions(
            'stefan-ortega',
            v_club_id,
            'Stefan Ortega',
            '1992-11-06',
            'Germany',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 9000000.00, 79,
            81, 78, 79, 76, 82, 79, TRUE
        );
    END IF;

    -- Player: Rúben Dias (ruben-dias)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'ruben-dias') THEN
        v_player_id := public.create_player_template_with_positions(
            'ruben-dias',
            v_club_id,
            'Rúben Dias',
            '1997-05-14',
            'Portugal',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 80000000.00, 88,
            64, 39, 70, 69, 89, 87, TRUE
        );
    END IF;

    -- Player: Joško Gvardiol (josko-gvardiol)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'josko-gvardiol') THEN
        v_player_id := public.create_player_template_with_positions(
            'josko-gvardiol',
            v_club_id,
            'Joško Gvardiol',
            '2002-01-23',
            'Croatia',
            'LB'::public.enum_player_position,
            ARRAY['CB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 75000000.00, 83,
            78, 60, 74, 77, 84, 83, TRUE
        );
    END IF;

    -- Player: Manuel Akanji (manuel-akanji)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'manuel-akanji') THEN
        v_player_id := public.create_player_template_with_positions(
            'manuel-akanji',
            v_club_id,
            'Manuel Akanji',
            '1995-07-19',
            'Switzerland',
            'CB'::public.enum_player_position,
            ARRAY['RB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 45000000.00, 84,
            78, 48, 74, 73, 84, 80, TRUE
        );
    END IF;

    -- Player: Nathan Aké (nathan-ake)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'nathan-ake') THEN
        v_player_id := public.create_player_template_with_positions(
            'nathan-ake',
            v_club_id,
            'Nathan Aké',
            '1995-02-18',
            'Netherlands',
            'CB'::public.enum_player_position,
            ARRAY['LB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 40000000.00, 82,
            75, 52, 73, 72, 83, 78, TRUE
        );
    END IF;

    -- Player: John Stones (john-stones)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'john-stones') THEN
        v_player_id := public.create_player_template_with_positions(
            'john-stones',
            v_club_id,
            'John Stones',
            '1994-05-28',
            'England',
            'CB'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 38000000.00, 85,
            72, 51, 79, 78, 85, 77, TRUE
        );
    END IF;

    -- Player: Kyle Walker (kyle-walker)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'kyle-walker') THEN
        v_player_id := public.create_player_template_with_positions(
            'kyle-walker',
            v_club_id,
            'Kyle Walker',
            '1990-05-28',
            'England',
            'RB'::public.enum_player_position,
            ARRAY['CB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 13000000.00, 84,
            87, 63, 76, 77, 80, 81, TRUE
        );
    END IF;

    -- Player: Rodri (rodri)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'rodri') THEN
        v_player_id := public.create_player_template_with_positions(
            'rodri',
            v_club_id,
            'Rodri',
            '1996-06-22',
            'Spain',
            'CDM'::public.enum_player_position,
            ARRAY['CM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 130000000.00, 91,
            66, 75, 86, 81, 87, 85, TRUE
        );
    END IF;

    -- Player: Kevin De Bruyne (kevin-de-bruyne)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'kevin-de-bruyne') THEN
        v_player_id := public.create_player_template_with_positions(
            'kevin-de-bruyne',
            v_club_id,
            'Kevin De Bruyne',
            '1991-06-28',
            'Belgium',
            'CM'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 45000000.00, 90,
            72, 88, 94, 87, 65, 75, TRUE
        );
    END IF;

    -- Player: Bernardo Silva (bernardo-silva)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'bernardo-silva') THEN
        v_player_id := public.create_player_template_with_positions(
            'bernardo-silva',
            v_club_id,
            'Bernardo Silva',
            '1994-08-10',
            'Portugal',
            'CM'::public.enum_player_position,
            ARRAY['RW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 70000000.00, 88,
            76, 78, 86, 92, 69, 70, TRUE
        );
    END IF;

    -- Player: İlkay Gündoğan (ilkay-gundogan)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'ilkay-gundogan') THEN
        v_player_id := public.create_player_template_with_positions(
            'ilkay-gundogan',
            v_club_id,
            'İlkay Gündoğan',
            '1990-10-24',
            'Germany',
            'CM'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 12000000.00, 85,
            65, 80, 86, 84, 74, 72, TRUE
        );
    END IF;

    -- Player: Mateo Kovačić (mateo-kovacic)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'mateo-kovacic') THEN
        v_player_id := public.create_player_template_with_positions(
            'mateo-kovacic',
            v_club_id,
            'Mateo Kovačić',
            '1994-05-06',
            'Croatia',
            'CM'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 30000000.00, 82,
            74, 69, 83, 86, 73, 71, TRUE
        );
    END IF;

    -- Player: Matheus Nunes (matheus-nunes)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'matheus-nunes') THEN
        v_player_id := public.create_player_template_with_positions(
            'matheus-nunes',
            v_club_id,
            'Matheus Nunes',
            '1998-08-27',
            'Portugal',
            'CM'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 78,
            82, 68, 77, 82, 68, 76, TRUE
        );
    END IF;

    -- Player: Rico Lewis (rico-lewis)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'rico-lewis') THEN
        v_player_id := public.create_player_template_with_positions(
            'rico-lewis',
            v_club_id,
            'Rico Lewis',
            '2004-11-21',
            'England',
            'RB'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 40000000.00, 77,
            78, 58, 77, 79, 74, 62, TRUE
        );
    END IF;

    -- Player: Phil Foden (phil-foden)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'phil-foden') THEN
        v_player_id := public.create_player_template_with_positions(
            'phil-foden',
            v_club_id,
            'Phil Foden',
            '2000-05-28',
            'England',
            'CAM'::public.enum_player_position,
            ARRAY['RW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 150000000.00, 88,
            85, 85, 86, 89, 56, 63, TRUE
        );
    END IF;

    -- Player: Erling Haaland (erling-haaland)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'erling-haaland') THEN
        v_player_id := public.create_player_template_with_positions(
            'erling-haaland',
            v_club_id,
            'Erling Haaland',
            '2000-07-21',
            'Norway',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 200000000.00, 91,
            89, 93, 70, 80, 45, 88, TRUE
        );
    END IF;

    -- Player: Jérémy Doku (jeremy-doku)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jeremy-doku') THEN
        v_player_id := public.create_player_template_with_positions(
            'jeremy-doku',
            v_club_id,
            'Jérémy Doku',
            '2002-05-27',
            'Belgium',
            'LW'::public.enum_player_position,
            ARRAY['RW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 50000000.00, 81,
            92, 69, 74, 87, 31, 64, TRUE
        );
    END IF;

    -- Player: Savinho (savinho)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'savinho') THEN
        v_player_id := public.create_player_template_with_positions(
            'savinho',
            v_club_id,
            'Savinho',
            '2004-04-10',
            'Brazil',
            'RW'::public.enum_player_position,
            ARRAY['LW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 50000000.00, 80,
            88, 72, 75, 85, 32, 58, TRUE
        );
    END IF;

    -- Player: Alisson Becker (alisson-becker)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'alisson-becker') THEN
        v_player_id := public.create_player_template_with_positions(
            'alisson-becker',
            v_club_id,
            'Alisson Becker',
            '1992-10-02',
            'Brazil',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 28000000.00, 89,
            89, 86, 90, 88, 85, 89, TRUE
        );
    END IF;

    -- Player: Caoimhín Kelleher (caoimhin-kelleher)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'caoimhin-kelleher') THEN
        v_player_id := public.create_player_template_with_positions(
            'caoimhin-kelleher',
            v_club_id,
            'Caoimhín Kelleher',
            '1998-11-23',
            'Ireland',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 77,
            79, 76, 77, 74, 76, 78, TRUE
        );
    END IF;

    -- Player: Virgil van Dijk (virgil-van-dijk)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'virgil-van-dijk') THEN
        v_player_id := public.create_player_template_with_positions(
            'virgil-van-dijk',
            v_club_id,
            'Virgil van Dijk',
            '1991-07-08',
            'Netherlands',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 30000000.00, 89,
            78, 60, 71, 72, 89, 86, TRUE
        );
    END IF;

    -- Player: Ibrahima Konaté (ibrahima-konate)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'ibrahima-konate') THEN
        v_player_id := public.create_player_template_with_positions(
            'ibrahima-konate',
            v_club_id,
            'Ibrahima Konaté',
            '1999-05-25',
            'France',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 45000000.00, 83,
            77, 34, 62, 67, 84, 85, TRUE
        );
    END IF;

    -- Player: Trent Alexander-Arnold (trent-alexander-arnold)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'trent-alexander-arnold') THEN
        v_player_id := public.create_player_template_with_positions(
            'trent-alexander-arnold',
            v_club_id,
            'Trent Alexander-Arnold',
            '1998-10-07',
            'England',
            'RB'::public.enum_player_position,
            ARRAY['CM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 70000000.00, 86,
            76, 71, 90, 80, 80, 73, TRUE
        );
    END IF;

    -- Player: Andy Robertson (andy-robertson)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'andy-robertson') THEN
        v_player_id := public.create_player_template_with_positions(
            'andy-robertson',
            v_club_id,
            'Andy Robertson',
            '1994-03-11',
            'Scotland',
            'LB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 30000000.00, 85,
            80, 62, 81, 79, 81, 76, TRUE
        );
    END IF;

    -- Player: Joe Gomez (joe-gomez)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'joe-gomez') THEN
        v_player_id := public.create_player_template_with_positions(
            'joe-gomez',
            v_club_id,
            'Joe Gomez',
            '1997-05-23',
            'England',
            'CB'::public.enum_player_position,
            ARRAY['LB'::public.enum_player_position, 'RB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 28000000.00, 79,
            81, 30, 68, 72, 80, 77, TRUE
        );
    END IF;

    -- Player: Jarell Quansah (jarell-quansah)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jarell-quansah') THEN
        v_player_id := public.create_player_template_with_positions(
            'jarell-quansah',
            v_club_id,
            'Jarell Quansah',
            '2003-01-29',
            'England',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 22000000.00, 75,
            68, 35, 62, 64, 76, 75, TRUE
        );
    END IF;

    -- Player: Alexis Mac Allister (alexis-mac-allister)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'alexis-mac-allister') THEN
        v_player_id := public.create_player_template_with_positions(
            'alexis-mac-allister',
            v_club_id,
            'Alexis Mac Allister',
            '1998-12-24',
            'Argentina',
            'CM'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 75000000.00, 86,
            72, 79, 84, 84, 77, 76, TRUE
        );
    END IF;

    -- Player: Dominik Szoboszlai (dominik-szoboszlai)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'dominik-szoboszlai') THEN
        v_player_id := public.create_player_template_with_positions(
            'dominik-szoboszlai',
            v_club_id,
            'Dominik Szoboszlai',
            '2000-10-25',
            'Hungary',
            'CM'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 75000000.00, 82,
            82, 82, 83, 82, 64, 76, TRUE
        );
    END IF;

    -- Player: Ryan Gravenberch (ryan-gravenberch)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'ryan-gravenberch') THEN
        v_player_id := public.create_player_template_with_positions(
            'ryan-gravenberch',
            v_club_id,
            'Ryan Gravenberch',
            '2002-05-16',
            'Netherlands',
            'CM'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 40000000.00, 79,
            78, 68, 78, 82, 72, 77, TRUE
        );
    END IF;

    -- Player: Wataru Endo (wataru-endo)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'wataru-endo') THEN
        v_player_id := public.create_player_template_with_positions(
            'wataru-endo',
            v_club_id,
            'Wataru Endo',
            '1993-02-09',
            'Japan',
            'CDM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 13000000.00, 80,
            64, 61, 73, 73, 81, 80, TRUE
        );
    END IF;

    -- Player: Curtis Jones (curtis-jones)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'curtis-jones') THEN
        v_player_id := public.create_player_template_with_positions(
            'curtis-jones',
            v_club_id,
            'Curtis Jones',
            '2001-01-30',
            'England',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 79,
            74, 71, 78, 81, 70, 71, TRUE
        );
    END IF;

    -- Player: Harvey Elliott (harvey-elliott)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'harvey-elliott') THEN
        v_player_id := public.create_player_template_with_positions(
            'harvey-elliott',
            v_club_id,
            'Harvey Elliott',
            '2003-04-04',
            'England',
            'CAM'::public.enum_player_position,
            ARRAY['RW'::public.enum_player_position, 'CM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 78,
            76, 72, 80, 82, 48, 58, TRUE
        );
    END IF;

    -- Player: Mohamed Salah (mohamed-salah)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'mohamed-salah') THEN
        v_player_id := public.create_player_template_with_positions(
            'mohamed-salah',
            v_club_id,
            'Mohamed Salah',
            '1992-06-15',
            'Egypt',
            'RW'::public.enum_player_position,
            ARRAY['ST'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 55000000.00, 89,
            89, 87, 82, 88, 45, 76, TRUE
        );
    END IF;

    -- Player: Luis Díaz (luis-diaz)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'luis-diaz') THEN
        v_player_id := public.create_player_template_with_positions(
            'luis-diaz',
            v_club_id,
            'Luis Díaz',
            '1997-01-13',
            'Colombia',
            'LW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 80000000.00, 84,
            90, 76, 75, 86, 40, 73, TRUE
        );
    END IF;

    -- Player: Darwin Núñez (darwin-nunez)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'darwin-nunez') THEN
        v_player_id := public.create_player_template_with_positions(
            'darwin-nunez',
            v_club_id,
            'Darwin Núñez',
            '1999-06-24',
            'Uruguay',
            'ST'::public.enum_player_position,
            ARRAY['LW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 65000000.00, 82,
            90, 81, 71, 77, 42, 86, TRUE
        );
    END IF;

    -- Player: Cody Gakpo (cody-gakpo)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'cody-gakpo') THEN
        v_player_id := public.create_player_template_with_positions(
            'cody-gakpo',
            v_club_id,
            'Cody Gakpo',
            '1999-05-07',
            'Netherlands',
            'LW'::public.enum_player_position,
            ARRAY['ST'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 55000000.00, 83,
            84, 80, 78, 83, 44, 76, TRUE
        );
    END IF;

    -- Player: David Raya (david-raya)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'arsenal';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'david-raya') THEN
        v_player_id := public.create_player_template_with_positions(
            'david-raya',
            v_club_id,
            'David Raya',
            '1995-09-15',
            'Spain',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 83,
            84, 82, 83, 79, 87, 83, TRUE
        );
    END IF;

    -- Player: Neto (neto-norberto)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'arsenal';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'neto-norberto') THEN
        v_player_id := public.create_player_template_with_positions(
            'neto-norberto',
            v_club_id,
            'Neto',
            '1989-07-19',
            'Brazil',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 2500000.00, 77,
            78, 75, 76, 74, 73, 76, TRUE
        );
    END IF;

    -- Player: William Saliba (william-saliba)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'arsenal';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'william-saliba') THEN
        v_player_id := public.create_player_template_with_positions(
            'william-saliba',
            v_club_id,
            'William Saliba',
            '2001-03-24',
            'France',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 80000000.00, 87,
            82, 40, 69, 72, 87, 82, TRUE
        );
    END IF;

    -- Player: Gabriel Magalhães (gabriel-magalhaes)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'arsenal';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'gabriel-magalhaes') THEN
        v_player_id := public.create_player_template_with_positions(
            'gabriel-magalhaes',
            v_club_id,
            'Gabriel Magalhães',
            '1997-12-19',
            'Brazil',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 75000000.00, 86,
            71, 48, 64, 65, 87, 84, TRUE
        );
    END IF;

    -- Player: Ben White (ben-white)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'arsenal';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'ben-white') THEN
        v_player_id := public.create_player_template_with_positions(
            'ben-white',
            v_club_id,
            'Ben White',
            '1997-10-08',
            'England',
            'RB'::public.enum_player_position,
            ARRAY['CB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 55000000.00, 84,
            77, 52, 76, 77, 83, 77, TRUE
        );
    END IF;

    -- Player: Jurriën Timber (jurrien-timber)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'arsenal';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jurrien-timber') THEN
        v_player_id := public.create_player_template_with_positions(
            'jurrien-timber',
            v_club_id,
            'Jurriën Timber',
            '2001-06-17',
            'Netherlands',
            'RB'::public.enum_player_position,
            ARRAY['LB'::public.enum_player_position, 'CB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 40000000.00, 79,
            81, 45, 75, 78, 80, 77, TRUE
        );
    END IF;

    -- Player: Riccardo Calafiori (riccardo-calafiori)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'arsenal';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'riccardo-calafiori') THEN
        v_player_id := public.create_player_template_with_positions(
            'riccardo-calafiori',
            v_club_id,
            'Riccardo Calafiori',
            '2002-05-19',
            'Italy',
            'LB'::public.enum_player_position,
            ARRAY['CB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 45000000.00, 79,
            76, 55, 74, 76, 80, 78, TRUE
        );
    END IF;

    -- Player: Oleksandr Zinchenko (oleksandr-zinchenko)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'arsenal';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'oleksandr-zinchenko') THEN
        v_player_id := public.create_player_template_with_positions(
            'oleksandr-zinchenko',
            v_club_id,
            'Oleksandr Zinchenko',
            '1996-12-15',
            'Ukraine',
            'LB'::public.enum_player_position,
            ARRAY['CM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 80,
            72, 66, 84, 82, 74, 67, TRUE
        );
    END IF;

    -- Player: Takehiro Tomiyasu (takehiro-tomiyasu)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'arsenal';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'takehiro-tomiyasu') THEN
        v_player_id := public.create_player_template_with_positions(
            'takehiro-tomiyasu',
            v_club_id,
            'Takehiro Tomiyasu',
            '1998-11-05',
            'Japan',
            'RB'::public.enum_player_position,
            ARRAY['LB'::public.enum_player_position, 'CB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 30000000.00, 79,
            76, 48, 70, 72, 81, 77, TRUE
        );
    END IF;

    -- Player: Declan Rice (declan-rice)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'arsenal';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'declan-rice') THEN
        v_player_id := public.create_player_template_with_positions(
            'declan-rice',
            v_club_id,
            'Declan Rice',
            '1999-01-14',
            'England',
            'CDM'::public.enum_player_position,
            ARRAY['CM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 120000000.00, 87,
            74, 68, 80, 79, 85, 86, TRUE
        );
    END IF;

    -- Player: Martin Ødegaard (martin-odegaard)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'arsenal';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'martin-odegaard') THEN
        v_player_id := public.create_player_template_with_positions(
            'martin-odegaard',
            v_club_id,
            'Martin Ødegaard',
            '1998-12-17',
            'Norway',
            'CAM'::public.enum_player_position,
            ARRAY['CM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 110000000.00, 89,
            77, 82, 89, 89, 63, 67, TRUE
        );
    END IF;

    -- Player: Mikel Merino (mikel-merino)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'arsenal';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'mikel-merino') THEN
        v_player_id := public.create_player_template_with_positions(
            'mikel-merino',
            v_club_id,
            'Mikel Merino',
            '1996-06-22',
            'Spain',
            'CM'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 50000000.00, 83,
            68, 76, 80, 79, 82, 84, TRUE
        );
    END IF;

    -- Player: Thomas Partey (thomas-partey)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'arsenal';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'thomas-partey') THEN
        v_player_id := public.create_player_template_with_positions(
            'thomas-partey',
            v_club_id,
            'Thomas Partey',
            '1993-06-13',
            'Ghana',
            'CDM'::public.enum_player_position,
            ARRAY['CM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 18000000.00, 82,
            65, 71, 82, 81, 80, 80, TRUE
        );
    END IF;

    -- Player: Jorginho (jorginho)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'arsenal';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jorginho') THEN
        v_player_id := public.create_player_template_with_positions(
            'jorginho',
            v_club_id,
            'Jorginho',
            '1991-12-20',
            'Italy',
            'CDM'::public.enum_player_position,
            ARRAY['CM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 12000000.00, 82,
            52, 67, 85, 79, 74, 63, TRUE
        );
    END IF;

    -- Player: Bukayo Saka (bukayo-saka)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'arsenal';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'bukayo-saka') THEN
        v_player_id := public.create_player_template_with_positions(
            'bukayo-saka',
            v_club_id,
            'Bukayo Saka',
            '2001-09-05',
            'England',
            'RW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 140000000.00, 87,
            85, 82, 82, 87, 65, 75, TRUE
        );
    END IF;

    -- Player: Kai Havertz (kai-havertz)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'arsenal';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'kai-havertz') THEN
        v_player_id := public.create_player_template_with_positions(
            'kai-havertz',
            v_club_id,
            'Kai Havertz',
            '1999-06-11',
            'Germany',
            'ST'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 75000000.00, 84,
            80, 80, 79, 82, 52, 79, TRUE
        );
    END IF;

    -- Player: Gabriel Martinelli (gabriel-martinelli)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'arsenal';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'gabriel-martinelli') THEN
        v_player_id := public.create_player_template_with_positions(
            'gabriel-martinelli',
            v_club_id,
            'Gabriel Martinelli',
            '2001-06-18',
            'Brazil',
            'LW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 60000000.00, 83,
            89, 77, 76, 85, 42, 72, TRUE
        );
    END IF;

    -- Player: Gabriel Jesus (gabriel-jesus)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'arsenal';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'gabriel-jesus') THEN
        v_player_id := public.create_player_template_with_positions(
            'gabriel-jesus',
            v_club_id,
            'Gabriel Jesus',
            '1997-04-03',
            'Brazil',
            'ST'::public.enum_player_position,
            ARRAY['RW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 55000000.00, 82,
            82, 80, 76, 85, 40, 73, TRUE
        );
    END IF;

    -- Player: Robert Sánchez (robert-sanchez)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'robert-sanchez') THEN
        v_player_id := public.create_player_template_with_positions(
            'robert-sanchez',
            v_club_id,
            'Robert Sánchez',
            '1997-11-18',
            'Spain',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 78,
            80, 76, 77, 74, 76, 78, TRUE
        );
    END IF;

    -- Player: Filip Jörgensen (filip-jorgensen)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'filip-jorgensen') THEN
        v_player_id := public.create_player_template_with_positions(
            'filip-jorgensen',
            v_club_id,
            'Filip Jörgensen',
            '2002-04-16',
            'Denmark',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 75,
            77, 74, 74, 72, 75, 76, TRUE
        );
    END IF;

    -- Player: Levi Colwill (levi-colwill)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'levi-colwill') THEN
        v_player_id := public.create_player_template_with_positions(
            'levi-colwill',
            v_club_id,
            'Levi Colwill',
            '2003-02-26',
            'England',
            'CB'::public.enum_player_position,
            ARRAY['LB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 50000000.00, 79,
            74, 42, 72, 70, 80, 78, TRUE
        );
    END IF;

    -- Player: Wesley Fofana (wesley-fofana)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'wesley-fofana') THEN
        v_player_id := public.create_player_template_with_positions(
            'wesley-fofana',
            v_club_id,
            'Wesley Fofana',
            '2000-12-17',
            'France',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 25000000.00, 78,
            77, 36, 60, 64, 79, 76, TRUE
        );
    END IF;

    -- Player: Axel Disasi (axel-disasi)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'axel-disasi') THEN
        v_player_id := public.create_player_template_with_positions(
            'axel-disasi',
            v_club_id,
            'Axel Disasi',
            '1998-03-11',
            'France',
            'CB'::public.enum_player_position,
            ARRAY['RB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 30000000.00, 78,
            68, 38, 62, 60, 79, 83, TRUE
        );
    END IF;

    -- Player: Benoît Badiashile (marcus-bettinelli)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'marcus-bettinelli') THEN
        v_player_id := public.create_player_template_with_positions(
            'marcus-bettinelli',
            v_club_id,
            'Benoît Badiashile',
            '2001-03-26',
            'France',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 30000000.00, 77,
            68, 35, 66, 62, 78, 80, TRUE
        );
    END IF;

    -- Player: Reece James (reece-james)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'reece-james') THEN
        v_player_id := public.create_player_template_with_positions(
            'reece-james',
            v_club_id,
            'Reece James',
            '1999-12-08',
            'England',
            'RB'::public.enum_player_position,
            ARRAY['RWB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 82,
            80, 74, 82, 80, 80, 81, TRUE
        );
    END IF;

    -- Player: Malo Gusto (malo-gusto)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'malo-gusto') THEN
        v_player_id := public.create_player_template_with_positions(
            'malo-gusto',
            v_club_id,
            'Malo Gusto',
            '2003-05-19',
            'France',
            'RB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 78,
            84, 52, 74, 77, 76, 72, TRUE
        );
    END IF;

    -- Player: Marc Cucurella (marc-cucurella)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'marc-cucurella') THEN
        v_player_id := public.create_player_template_with_positions(
            'marc-cucurella',
            v_club_id,
            'Marc Cucurella',
            '1998-07-22',
            'Spain',
            'LB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 30000000.00, 80,
            78, 62, 75, 78, 78, 76, TRUE
        );
    END IF;

    -- Player: Moisés Caicedo (moises-caicedo)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'moises-caicedo') THEN
        v_player_id := public.create_player_template_with_positions(
            'moises-caicedo',
            v_club_id,
            'Moisés Caicedo',
            '2001-11-02',
            'Ecuador',
            'CDM'::public.enum_player_position,
            ARRAY['CM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 75000000.00, 82,
            78, 62, 75, 78, 81, 82, TRUE
        );
    END IF;

    -- Player: Enzo Fernández (enzo-fernandez)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'enzo-fernandez') THEN
        v_player_id := public.create_player_template_with_positions(
            'enzo-fernandez',
            v_club_id,
            'Enzo Fernández',
            '2001-01-17',
            'Argentina',
            'CM'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 75000000.00, 82,
            70, 74, 83, 81, 74, 76, TRUE
        );
    END IF;

    -- Player: Cole Palmer (cole-palmer)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'cole-palmer') THEN
        v_player_id := public.create_player_template_with_positions(
            'cole-palmer',
            v_club_id,
            'Cole Palmer',
            '2002-05-06',
            'England',
            'CAM'::public.enum_player_position,
            ARRAY['RW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 90000000.00, 85,
            80, 82, 83, 86, 45, 64, TRUE
        );
    END IF;

    -- Player: Romeo Lavia (conor-gallagher-duplicate-safe)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'conor-gallagher-duplicate-safe') THEN
        v_player_id := public.create_player_template_with_positions(
            'conor-gallagher-duplicate-safe',
            v_club_id,
            'Romeo Lavia',
            '2004-01-06',
            'Belgium',
            'CDM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 75,
            72, 56, 73, 76, 75, 74, TRUE
        );
    END IF;

    -- Player: Kiernan Dewsbury-Hall (kiernan-dewsbury-hall)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'kiernan-dewsbury-hall') THEN
        v_player_id := public.create_player_template_with_positions(
            'kiernan-dewsbury-hall',
            v_club_id,
            'Kiernan Dewsbury-Hall',
            '1998-09-06',
            'England',
            'CM'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 30000000.00, 78,
            75, 74, 78, 79, 70, 74, TRUE
        );
    END IF;

    -- Player: Nicolas Jackson (nicolas-jackson)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'nicolas-jackson') THEN
        v_player_id := public.create_player_template_with_positions(
            'nicolas-jackson',
            v_club_id,
            'Nicolas Jackson',
            '2001-06-20',
            'Senegal',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 45000000.00, 79,
            85, 76, 68, 78, 38, 77, TRUE
        );
    END IF;

    -- Player: Noni Madueke (noni-madueke)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'noni-madueke') THEN
        v_player_id := public.create_player_template_with_positions(
            'noni-madueke',
            v_club_id,
            'Noni Madueke',
            '2002-03-10',
            'England',
            'RW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 78,
            86, 72, 71, 82, 28, 64, TRUE
        );
    END IF;

    -- Player: Pedro Neto (pedro-neto)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'pedro-neto') THEN
        v_player_id := public.create_player_template_with_positions(
            'pedro-neto',
            v_club_id,
            'Pedro Neto',
            '2000-03-09',
            'Portugal',
            'RW'::public.enum_player_position,
            ARRAY['LW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 55000000.00, 80,
            89, 74, 76, 84, 30, 62, TRUE
        );
    END IF;

    -- Player: Jadon Sancho (jadon-sancho)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jadon-sancho') THEN
        v_player_id := public.create_player_template_with_positions(
            'jadon-sancho',
            v_club_id,
            'Jadon Sancho',
            '2000-03-25',
            'England',
            'LW'::public.enum_player_position,
            ARRAY['RW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 30000000.00, 81,
            77, 73, 80, 85, 34, 60, TRUE
        );
    END IF;

    -- Player: Christopher Nkunku (christopher-nkunku)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'christopher-nkunku') THEN
        v_player_id := public.create_player_template_with_positions(
            'christopher-nkunku',
            v_club_id,
            'Christopher Nkunku',
            '1997-11-14',
            'France',
            'CF'::public.enum_player_position,
            ARRAY['ST'::public.enum_player_position, 'CAM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 65000000.00, 83,
            82, 82, 80, 86, 38, 67, TRUE
        );
    END IF;

    -- Player: André Onana (andre-onana)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-united';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'andre-onana') THEN
        v_player_id := public.create_player_template_with_positions(
            'andre-onana',
            v_club_id,
            'André Onana',
            '1996-04-02',
            'Cameroon',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 83,
            84, 80, 82, 78, 88, 84, TRUE
        );
    END IF;

    -- Player: Altay Bayındır (altay-bayindir)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-united';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'altay-bayindir') THEN
        v_player_id := public.create_player_template_with_positions(
            'altay-bayindir',
            v_club_id,
            'Altay Bayındır',
            '1998-04-14',
            'Turkey',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 10000000.00, 76,
            78, 74, 75, 73, 75, 76, TRUE
        );
    END IF;

    -- Player: Lisandro Martínez (lisandro-martinez)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-united';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'lisandro-martinez') THEN
        v_player_id := public.create_player_template_with_positions(
            'lisandro-martinez',
            v_club_id,
            'Lisandro Martínez',
            '1998-01-18',
            'Argentina',
            'CB'::public.enum_player_position,
            ARRAY['LB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 50000000.00, 84,
            75, 54, 75, 76, 85, 80, TRUE
        );
    END IF;

    -- Player: Matthijs de Ligt (matthijs-de-ligt)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-united';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'matthijs-de-ligt') THEN
        v_player_id := public.create_player_template_with_positions(
            'matthijs-de-ligt',
            v_club_id,
            'Matthijs de Ligt',
            '1999-08-12',
            'Netherlands',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 55000000.00, 84,
            68, 50, 66, 65, 85, 84, TRUE
        );
    END IF;

    -- Player: Leny Yoro (leny-yoro)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-united';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'leny-yoro') THEN
        v_player_id := public.create_player_template_with_positions(
            'leny-yoro',
            v_club_id,
            'Leny Yoro',
            '2005-11-13',
            'France',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 55000000.00, 78,
            78, 38, 66, 68, 79, 74, TRUE
        );
    END IF;

    -- Player: Harry Maguire (harry-maguire)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-united';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'harry-maguire') THEN
        v_player_id := public.create_player_template_with_positions(
            'harry-maguire',
            v_club_id,
            'Harry Maguire',
            '1993-03-05',
            'England',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 18000000.00, 80,
            48, 54, 68, 64, 81, 84, TRUE
        );
    END IF;

    -- Player: Diogo Dalot (diogo-dalot)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-united';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'diogo-dalot') THEN
        v_player_id := public.create_player_template_with_positions(
            'diogo-dalot',
            v_club_id,
            'Diogo Dalot',
            '1999-03-18',
            'Portugal',
            'RB'::public.enum_player_position,
            ARRAY['LB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 81,
            80, 64, 76, 78, 78, 76, TRUE
        );
    END IF;

    -- Player: Noussair Mazraoui (noussair-mazraoui)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-united';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'noussair-mazraoui') THEN
        v_player_id := public.create_player_template_with_positions(
            'noussair-mazraoui',
            v_club_id,
            'Noussair Mazraoui',
            '1997-11-14',
            'Morocco',
            'RB'::public.enum_player_position,
            ARRAY['LB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 30000000.00, 80,
            77, 62, 76, 80, 77, 70, TRUE
        );
    END IF;

    -- Player: Luke Shaw (luke-shaw)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-united';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'luke-shaw') THEN
        v_player_id := public.create_player_template_with_positions(
            'luke-shaw',
            v_club_id,
            'Luke Shaw',
            '1995-07-12',
            'England',
            'LB'::public.enum_player_position,
            ARRAY['CB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 28000000.00, 82,
            75, 58, 79, 78, 80, 76, TRUE
        );
    END IF;

    -- Player: Kobbie Mainoo (kobbie-mainoo)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-united';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'kobbie-mainoo') THEN
        v_player_id := public.create_player_template_with_positions(
            'kobbie-mainoo',
            v_club_id,
            'Kobbie Mainoo',
            '2005-04-19',
            'England',
            'CM'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 55000000.00, 79,
            74, 68, 78, 83, 74, 72, TRUE
        );
    END IF;

    -- Player: Casemiro (casemiro)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-united';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'casemiro') THEN
        v_player_id := public.create_player_template_with_positions(
            'casemiro',
            v_club_id,
            'Casemiro',
            '1992-02-23',
            'Brazil',
            'CDM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 15000000.00, 84,
            62, 72, 75, 72, 84, 86, TRUE
        );
    END IF;

    -- Player: Manuel Ugarte (manuel-ugarte)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-united';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'manuel-ugarte') THEN
        v_player_id := public.create_player_template_with_positions(
            'manuel-ugarte',
            v_club_id,
            'Manuel Ugarte',
            '2001-04-11',
            'Uruguay',
            'CDM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 50000000.00, 81,
            74, 58, 68, 70, 83, 82, TRUE
        );
    END IF;

    -- Player: Bruno Fernandes (bruno-fernandes)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-united';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'bruno-fernandes') THEN
        v_player_id := public.create_player_template_with_positions(
            'bruno-fernandes',
            v_club_id,
            'Bruno Fernandes',
            '1994-09-08',
            'Portugal',
            'CAM'::public.enum_player_position,
            ARRAY['CM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 65000000.00, 87,
            73, 85, 90, 83, 67, 76, TRUE
        );
    END IF;

    -- Player: Christian Eriksen (christian-eriksen)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-united';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'christian-eriksen') THEN
        v_player_id := public.create_player_template_with_positions(
            'christian-eriksen',
            v_club_id,
            'Christian Eriksen',
            '1992-02-14',
            'Denmark',
            'CM'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 8000000.00, 80,
            58, 76, 87, 80, 52, 60, TRUE
        );
    END IF;

    -- Player: Mason Mount (mason-mount)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-united';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'mason-mount') THEN
        v_player_id := public.create_player_template_with_positions(
            'mason-mount',
            v_club_id,
            'Mason Mount',
            '1999-01-10',
            'England',
            'CAM'::public.enum_player_position,
            ARRAY['CM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 80,
            74, 78, 80, 80, 62, 67, TRUE
        );
    END IF;

    -- Player: Marcus Rashford (marcus-rashford)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-united';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'marcus-rashford') THEN
        v_player_id := public.create_player_template_with_positions(
            'marcus-rashford',
            v_club_id,
            'Marcus Rashford',
            '1997-10-31',
            'England',
            'LW'::public.enum_player_position,
            ARRAY['ST'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 60000000.00, 81,
            87, 82, 74, 81, 40, 74, TRUE
        );
    END IF;

    -- Player: Alejandro Garnacho (alejandro-garnacho)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-united';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'alejandro-garnacho') THEN
        v_player_id := public.create_player_template_with_positions(
            'alejandro-garnacho',
            v_club_id,
            'Alejandro Garnacho',
            '2004-07-01',
            'Argentina',
            'LW'::public.enum_player_position,
            ARRAY['RW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 50000000.00, 79,
            86, 75, 72, 82, 35, 62, TRUE
        );
    END IF;

    -- Player: Rasmus Højlund (rasmus-hojlund)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-united';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'rasmus-hojlund') THEN
        v_player_id := public.create_player_template_with_positions(
            'rasmus-hojlund',
            v_club_id,
            'Rasmus Højlund',
            '2003-02-04',
            'Denmark',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 65000000.00, 80,
            85, 78, 65, 74, 34, 82, TRUE
        );
    END IF;

    -- Player: Guglielmo Vicario (guglielmo-vicario)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'guglielmo-vicario') THEN
        v_player_id := public.create_player_template_with_positions(
            'guglielmo-vicario',
            v_club_id,
            'Guglielmo Vicario',
            '1996-10-07',
            'Italy',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 83,
            84, 81, 82, 78, 76, 84, TRUE
        );
    END IF;

    -- Player: Fraser Forster (fraser-forster)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'fraser-forster') THEN
        v_player_id := public.create_player_template_with_positions(
            'fraser-forster',
            v_club_id,
            'Fraser Forster',
            '1988-03-17',
            'England',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 1500000.00, 74,
            72, 74, 75, 76, 68, 73, TRUE
        );
    END IF;

    -- Player: Cristian Romero (cristian-romero)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'cristian-romero') THEN
        v_player_id := public.create_player_template_with_positions(
            'cristian-romero',
            v_club_id,
            'Cristian Romero',
            '1998-04-27',
            'Argentina',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 65000000.00, 84,
            76, 46, 62, 65, 85, 84, TRUE
        );
    END IF;

    -- Player: Micky van de Ven (micky-van-de-ven)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'micky-van-de-ven') THEN
        v_player_id := public.create_player_template_with_positions(
            'micky-van-de-ven',
            v_club_id,
            'Micky van de Ven',
            '2001-04-19',
            'Netherlands',
            'CB'::public.enum_player_position,
            ARRAY['LB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 55000000.00, 82,
            91, 40, 66, 68, 83, 81, TRUE
        );
    END IF;

    -- Player: Radu Drăgușin (radu-dragusin)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'radu-dragusin') THEN
        v_player_id := public.create_player_template_with_positions(
            'radu-dragusin',
            v_club_id,
            'Radu Drăgușin',
            '2002-02-03',
            'Romania',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 25000000.00, 76,
            70, 32, 54, 55, 78, 80, TRUE
        );
    END IF;

    -- Player: Pedro Porro (pedro-porro)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'pedro-porro') THEN
        v_player_id := public.create_player_template_with_positions(
            'pedro-porro',
            v_club_id,
            'Pedro Porro',
            '1999-09-13',
            'Spain',
            'RB'::public.enum_player_position,
            ARRAY['RWB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 45000000.00, 82,
            82, 74, 80, 81, 75, 74, TRUE
        );
    END IF;

    -- Player: Destiny Udogie (destiny-udogie)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'destiny-udogie') THEN
        v_player_id := public.create_player_template_with_positions(
            'destiny-udogie',
            v_club_id,
            'Destiny Udogie',
            '2002-11-28',
            'Italy',
            'LB'::public.enum_player_position,
            ARRAY['LWB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 45000000.00, 82,
            84, 60, 74, 79, 78, 78, TRUE
        );
    END IF;

    -- Player: Yves Bissouma (yves-bissouma)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'yves-bissouma') THEN
        v_player_id := public.create_player_template_with_positions(
            'yves-bissouma',
            v_club_id,
            'Yves Bissouma',
            '1996-08-30',
            'Mali',
            'CDM'::public.enum_player_position,
            ARRAY['CM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 80,
            76, 64, 76, 81, 79, 78, TRUE
        );
    END IF;

    -- Player: Pape Matar Sarr (pape-matar-sarr)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'pape-matar-sarr') THEN
        v_player_id := public.create_player_template_with_positions(
            'pape-matar-sarr',
            v_club_id,
            'Pape Matar Sarr',
            '2002-09-14',
            'Senegal',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 45000000.00, 79,
            77, 70, 76, 78, 74, 77, TRUE
        );
    END IF;

    -- Player: Rodrigo Bentancur (rodrigo-bentancur)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'rodrigo-bentancur') THEN
        v_player_id := public.create_player_template_with_positions(
            'rodrigo-bentancur',
            v_club_id,
            'Rodrigo Bentancur',
            '1997-06-25',
            'Uruguay',
            'CM'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 81,
            72, 68, 79, 81, 78, 78, TRUE
        );
    END IF;

    -- Player: James Maddison (james-maddison)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'james-maddison') THEN
        v_player_id := public.create_player_template_with_positions(
            'james-maddison',
            v_club_id,
            'James Maddison',
            '1996-11-23',
            'England',
            'CAM'::public.enum_player_position,
            ARRAY['CM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 70000000.00, 85,
            73, 81, 86, 85, 52, 62, TRUE
        );
    END IF;

    -- Player: Lucas Bergvall (lucas-bergvall)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'lucas-bergvall') THEN
        v_player_id := public.create_player_template_with_positions(
            'lucas-bergvall',
            v_club_id,
            'Lucas Bergvall',
            '2006-02-02',
            'Sweden',
            'CM'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 74,
            74, 65, 74, 76, 64, 68, TRUE
        );
    END IF;

    -- Player: Archie Gray (archien-gray)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'archien-gray') THEN
        v_player_id := public.create_player_template_with_positions(
            'archien-gray',
            v_club_id,
            'Archie Gray',
            '2006-03-12',
            'England',
            'CM'::public.enum_player_position,
            ARRAY['RB'::public.enum_player_position, 'CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 25000000.00, 74,
            75, 58, 73, 75, 71, 70, TRUE
        );
    END IF;

    -- Player: Son Heung-min (son-heung-min)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'son-heung-min') THEN
        v_player_id := public.create_player_template_with_positions(
            'son-heung-min',
            v_club_id,
            'Son Heung-min',
            '1992-07-08',
            'South Korea',
            'LW'::public.enum_player_position,
            ARRAY['ST'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 45000000.00, 87,
            87, 88, 80, 84, 42, 70, TRUE
        );
    END IF;

    -- Player: Dominic Solanke (dominic-solanke)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'dominic-solanke') THEN
        v_player_id := public.create_player_template_with_positions(
            'dominic-solanke',
            v_club_id,
            'Dominic Solanke',
            '1997-09-14',
            'England',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 45000000.00, 81,
            77, 80, 72, 75, 42, 81, TRUE
        );
    END IF;

    -- Player: Richarlison (richarlison)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'richarlison') THEN
        v_player_id := public.create_player_template_with_positions(
            'richarlison',
            v_club_id,
            'Richarlison',
            '1997-05-10',
            'Brazil',
            'ST'::public.enum_player_position,
            ARRAY['LW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 80,
            78, 78, 70, 77, 48, 78, TRUE
        );
    END IF;

    -- Player: Brennan Johnson (brennan-johnson)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'brennan-johnson') THEN
        v_player_id := public.create_player_template_with_positions(
            'brennan-johnson',
            v_club_id,
            'Brennan Johnson',
            '2001-05-23',
            'Wales',
            'RW'::public.enum_player_position,
            ARRAY['ST'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 48000000.00, 80,
            91, 75, 73, 78, 38, 66, TRUE
        );
    END IF;

    -- Player: Dejan Kulusevski (dejan-kulusevski)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'dejan-kulusevski') THEN
        v_player_id := public.create_player_template_with_positions(
            'dejan-kulusevski',
            v_club_id,
            'Dejan Kulusevski',
            '2000-04-25',
            'Sweden',
            'RW'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 55000000.00, 82,
            78, 77, 81, 83, 56, 78, TRUE
        );
    END IF;

    -- Player: Manuel Neuer (manuel-neuer)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayern-munich';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'manuel-neuer') THEN
        v_player_id := public.create_player_template_with_positions(
            'manuel-neuer',
            v_club_id,
            'Manuel Neuer',
            '1986-03-27',
            'Germany',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 4000000.00, 87,
            86, 84, 86, 87, 89, 87, TRUE
        );
    END IF;

    -- Player: Sven Ulreich (sven-ulreich)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayern-munich';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'sven-ulreich') THEN
        v_player_id := public.create_player_template_with_positions(
            'sven-ulreich',
            v_club_id,
            'Sven Ulreich',
            '1988-08-03',
            'Germany',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 1000000.00, 74,
            75, 72, 74, 71, 72, 74, TRUE
        );
    END IF;

    -- Player: Dayot Upamecano (dayot-upamecano)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayern-munich';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'dayot-upamecano') THEN
        v_player_id := public.create_player_template_with_positions(
            'dayot-upamecano',
            v_club_id,
            'Dayot Upamecano',
            '1998-10-27',
            'France',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 45000000.00, 82,
            82, 42, 62, 65, 83, 84, TRUE
        );
    END IF;

    -- Player: Kim Min-jae (kim-min-jae)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayern-munich';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'kim-min-jae') THEN
        v_player_id := public.create_player_template_with_positions(
            'kim-min-jae',
            v_club_id,
            'Kim Min-jae',
            '1996-11-15',
            'South Korea',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 45000000.00, 83,
            80, 36, 61, 62, 84, 85, TRUE
        );
    END IF;

    -- Player: Eric Dier (eric-dier)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayern-munich';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'eric-dier') THEN
        v_player_id := public.create_player_template_with_positions(
            'eric-dier',
            v_club_id,
            'Eric Dier',
            '1994-01-15',
            'England',
            'CB'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 12000000.00, 78,
            54, 62, 72, 65, 80, 80, TRUE
        );
    END IF;

    -- Player: Alphonso Davies (alphonso-davies)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayern-munich';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'alphonso-davies') THEN
        v_player_id := public.create_player_template_with_positions(
            'alphonso-davies',
            v_club_id,
            'Alphonso Davies',
            '2000-11-02',
            'Canada',
            'LB'::public.enum_player_position,
            ARRAY['LM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 50000000.00, 82,
            95, 66, 77, 82, 75, 76, TRUE
        );
    END IF;

    -- Player: Sacha Boey (sacha-boey)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayern-munich';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'sacha-boey') THEN
        v_player_id := public.create_player_template_with_positions(
            'sacha-boey',
            v_club_id,
            'Sacha Boey',
            '2000-09-13',
            'France',
            'RB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 18000000.00, 76,
            84, 48, 68, 73, 75, 76, TRUE
        );
    END IF;

    -- Player: Josip Stanišić (josip-stanisic)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayern-munich';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'josip-stanisic') THEN
        v_player_id := public.create_player_template_with_positions(
            'josip-stanisic',
            v_club_id,
            'Josip Stanišić',
            '2000-04-02',
            'Croatia',
            'RB'::public.enum_player_position,
            ARRAY['CB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 28000000.00, 78,
            75, 48, 72, 72, 79, 75, TRUE
        );
    END IF;

    -- Player: Joshua Kimmich (joshua-kimmich)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayern-munich';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'joshua-kimmich') THEN
        v_player_id := public.create_player_template_with_positions(
            'joshua-kimmich',
            v_club_id,
            'Joshua Kimmich',
            '1995-02-08',
            'Germany',
            'CDM'::public.enum_player_position,
            ARRAY['RB'::public.enum_player_position, 'CM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 50000000.00, 86,
            68, 74, 88, 83, 81, 76, TRUE
        );
    END IF;

    -- Player: Leon Goretzka (leon-goretzka)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayern-munich';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'leon-goretzka') THEN
        v_player_id := public.create_player_template_with_positions(
            'leon-goretzka',
            v_club_id,
            'Leon Goretzka',
            '1995-02-06',
            'Germany',
            'CM'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 22000000.00, 83,
            76, 80, 81, 80, 79, 84, TRUE
        );
    END IF;

    -- Player: Aleksandar Pavlović (aleksandar-pavlovic)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayern-munich';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'aleksandar-pavlovic') THEN
        v_player_id := public.create_player_template_with_positions(
            'aleksandar-pavlovic',
            v_club_id,
            'Aleksandar Pavlović',
            '2004-05-03',
            'Germany',
            'CDM'::public.enum_player_position,
            ARRAY['CM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 50000000.00, 78,
            72, 68, 79, 78, 76, 75, TRUE
        );
    END IF;

    -- Player: João Palhinha (joao-palhinha)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayern-munich';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'joao-palhinha') THEN
        v_player_id := public.create_player_template_with_positions(
            'joao-palhinha',
            v_club_id,
            'João Palhinha',
            '1995-07-09',
            'Portugal',
            'CDM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 50000000.00, 83,
            62, 62, 70, 71, 85, 88, TRUE
        );
    END IF;

    -- Player: Jamal Musiala (jamal-musiala)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayern-munich';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jamal-musiala') THEN
        v_player_id := public.create_player_template_with_positions(
            'jamal-musiala',
            v_club_id,
            'Jamal Musiala',
            '2003-02-26',
            'Germany',
            'CAM'::public.enum_player_position,
            ARRAY['LM'::public.enum_player_position, 'RW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 130000000.00, 87,
            84, 78, 83, 90, 64, 65, TRUE
        );
    END IF;

    -- Player: Thomas Müller (thomas-muller)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayern-munich';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'thomas-muller') THEN
        v_player_id := public.create_player_template_with_positions(
            'thomas-muller',
            v_club_id,
            'Thomas Müller',
            '1989-09-13',
            'Germany',
            'CAM'::public.enum_player_position,
            ARRAY['CF'::public.enum_player_position, 'ST'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 8000000.00, 82,
            64, 80, 83, 80, 54, 68, TRUE
        );
    END IF;

    -- Player: Harry Kane (harry-kane)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayern-munich';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'harry-kane') THEN
        v_player_id := public.create_player_template_with_positions(
            'harry-kane',
            v_club_id,
            'Harry Kane',
            '1993-07-28',
            'England',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 90000000.00, 90,
            69, 93, 84, 83, 49, 82, TRUE
        );
    END IF;

    -- Player: Leroy Sané (leroy-sane)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayern-munich';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'leroy-sane') THEN
        v_player_id := public.create_player_template_with_positions(
            'leroy-sane',
            v_club_id,
            'Leroy Sané',
            '1996-01-11',
            'Germany',
            'RW'::public.enum_player_position,
            ARRAY['LW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 60000000.00, 85,
            89, 82, 79, 85, 38, 68, TRUE
        );
    END IF;

    -- Player: Serge Gnabry (serge-gnabry)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayern-munich';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'serge-gnabry') THEN
        v_player_id := public.create_player_template_with_positions(
            'serge-gnabry',
            v_club_id,
            'Serge Gnabry',
            '1995-07-14',
            'Germany',
            'LW'::public.enum_player_position,
            ARRAY['RW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 40000000.00, 82,
            82, 81, 77, 82, 42, 68, TRUE
        );
    END IF;

    -- Player: Michael Olise (michael-olise)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayern-munich';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'michael-olise') THEN
        v_player_id := public.create_player_template_with_positions(
            'michael-olise',
            v_club_id,
            'Michael Olise',
            '2001-12-12',
            'France',
            'RW'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 65000000.00, 82,
            80, 78, 83, 85, 50, 64, TRUE
        );
    END IF;

    -- Player: Gregor Kobel (gregor-kobel)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'borussia-dortmund';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'gregor-kobel') THEN
        v_player_id := public.create_player_template_with_positions(
            'gregor-kobel',
            v_club_id,
            'Gregor Kobel',
            '1997-12-06',
            'Switzerland',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 40000000.00, 88,
            88, 85, 87, 84, 76, 87, TRUE
        );
    END IF;

    -- Player: Alexander Meyer (alexander-meyer)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'borussia-dortmund';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'alexander-meyer') THEN
        v_player_id := public.create_player_template_with_positions(
            'alexander-meyer',
            v_club_id,
            'Alexander Meyer',
            '1991-04-13',
            'Germany',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 2000000.00, 74,
            74, 72, 75, 70, 74, 75, TRUE
        );
    END IF;

    -- Player: Nico Schlotterbeck (nico-schlotterbeck)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'borussia-dortmund';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'nico-schlotterbeck') THEN
        v_player_id := public.create_player_template_with_positions(
            'nico-schlotterbeck',
            v_club_id,
            'Nico Schlotterbeck',
            '1999-12-01',
            'Germany',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 40000000.00, 83,
            78, 55, 72, 74, 84, 82, TRUE
        );
    END IF;

    -- Player: Niklas Süle (niklas-sule)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'borussia-dortmund';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'niklas-sule') THEN
        v_player_id := public.create_player_template_with_positions(
            'niklas-sule',
            v_club_id,
            'Niklas Süle',
            '1995-09-03',
            'Germany',
            'CB'::public.enum_player_position,
            ARRAY['RB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 15000000.00, 80,
            72, 48, 64, 62, 81, 84, TRUE
        );
    END IF;

    -- Player: Waldemar Anton (waldemar-anton)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'borussia-dortmund';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'waldemar-anton') THEN
        v_player_id := public.create_player_template_with_positions(
            'waldemar-anton',
            v_club_id,
            'Waldemar Anton',
            '1996-07-20',
            'Germany',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 24000000.00, 80,
            70, 42, 65, 62, 81, 82, TRUE
        );
    END IF;

    -- Player: Julian Ryerson (julian-ryerson)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'borussia-dortmund';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'julian-ryerson') THEN
        v_player_id := public.create_player_template_with_positions(
            'julian-ryerson',
            v_club_id,
            'Julian Ryerson',
            '1997-11-17',
            'Norway',
            'RB'::public.enum_player_position,
            ARRAY['LB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 78,
            79, 58, 72, 73, 77, 80, TRUE
        );
    END IF;

    -- Player: Yan Couto (yan-couto)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'borussia-dortmund';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'yan-couto') THEN
        v_player_id := public.create_player_template_with_positions(
            'yan-couto',
            v_club_id,
            'Yan Couto',
            '2002-06-03',
            'Brazil',
            'RB'::public.enum_player_position,
            ARRAY['RWB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 25000000.00, 77,
            83, 56, 73, 79, 70, 62, TRUE
        );
    END IF;

    -- Player: Ramy Bensebaini (ramy-bensebaini)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'borussia-dortmund';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'ramy-bensebaini') THEN
        v_player_id := public.create_player_template_with_positions(
            'ramy-bensebaini',
            v_club_id,
            'Ramy Bensebaini',
            '1995-04-16',
            'Algeria',
            'LB'::public.enum_player_position,
            ARRAY['CB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 7000000.00, 77,
            72, 64, 72, 74, 78, 77, TRUE
        );
    END IF;

    -- Player: Emre Can (emre-can)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'borussia-dortmund';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'emre-can') THEN
        v_player_id := public.create_player_template_with_positions(
            'emre-can',
            v_club_id,
            'Emre Can',
            '1994-01-12',
            'Germany',
            'CDM'::public.enum_player_position,
            ARRAY['CB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 10000000.00, 80,
            70, 68, 74, 75, 80, 84, TRUE
        );
    END IF;

    -- Player: Pascal Groß (pascal-gros)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'borussia-dortmund';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'pascal-gros') THEN
        v_player_id := public.create_player_template_with_positions(
            'pascal-gros',
            v_club_id,
            'Pascal Groß',
            '1991-06-15',
            'Germany',
            'CM'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 8000000.00, 81,
            62, 74, 86, 80, 74, 72, TRUE
        );
    END IF;

    -- Player: Marcel Sabitzer (marcel-sabitzer)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'borussia-dortmund';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'marcel-sabitzer') THEN
        v_player_id := public.create_player_template_with_positions(
            'marcel-sabitzer',
            v_club_id,
            'Marcel Sabitzer',
            '1994-03-17',
            'Austria',
            'CM'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 81,
            74, 80, 80, 80, 75, 78, TRUE
        );
    END IF;

    -- Player: Julian Brandt (julian-brandt)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'borussia-dortmund';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'julian-brandt') THEN
        v_player_id := public.create_player_template_with_positions(
            'julian-brandt',
            v_club_id,
            'Julian Brandt',
            '1996-05-02',
            'Germany',
            'CAM'::public.enum_player_position,
            ARRAY['CM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 40000000.00, 84,
            77, 78, 85, 86, 54, 68, TRUE
        );
    END IF;

    -- Player: Felix Nmecha (felix-nmecha)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'borussia-dortmund';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'felix-nmecha') THEN
        v_player_id := public.create_player_template_with_positions(
            'felix-nmecha',
            v_club_id,
            'Felix Nmecha',
            '2000-10-10',
            'Germany',
            'CM'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 25000000.00, 77,
            74, 70, 75, 78, 72, 78, TRUE
        );
    END IF;

    -- Player: Jamie Gittens (jamie-gittens)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'borussia-dortmund';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jamie-gittens') THEN
        v_player_id := public.create_player_template_with_positions(
            'jamie-gittens',
            v_club_id,
            'Jamie Gittens',
            '2004-08-08',
            'England',
            'LW'::public.enum_player_position,
            ARRAY['RW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 77,
            88, 70, 68, 83, 30, 58, TRUE
        );
    END IF;

    -- Player: Donyell Malen (donyell-malen)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'borussia-dortmund';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'donyell-malen') THEN
        v_player_id := public.create_player_template_with_positions(
            'donyell-malen',
            v_club_id,
            'Donyell Malen',
            '1999-01-19',
            'Netherlands',
            'RM'::public.enum_player_position,
            ARRAY['RW'::public.enum_player_position, 'ST'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 28000000.00, 81,
            88, 80, 74, 82, 38, 72, TRUE
        );
    END IF;

    -- Player: Karim Adeyemi (karim-adeyemi)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'borussia-dortmund';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'karim-adeyemi') THEN
        v_player_id := public.create_player_template_with_positions(
            'karim-adeyemi',
            v_club_id,
            'Karim Adeyemi',
            '2002-01-18',
            'Germany',
            'LW'::public.enum_player_position,
            ARRAY['ST'::public.enum_player_position, 'RW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 79,
            94, 75, 68, 80, 36, 68, TRUE
        );
    END IF;

    -- Player: Serhou Guirassy (serhou-guirassy)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'borussia-dortmund';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'serhou-guirassy') THEN
        v_player_id := public.create_player_template_with_positions(
            'serhou-guirassy',
            v_club_id,
            'Serhou Guirassy',
            '1996-03-12',
            'Guinea',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 40000000.00, 82,
            78, 84, 70, 76, 38, 84, TRUE
        );
    END IF;

    -- Player: Maximilian Beier (maximilien-beier)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'borussia-dortmund';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'maximilien-beier') THEN
        v_player_id := public.create_player_template_with_positions(
            'maximilien-beier',
            v_club_id,
            'Maximilian Beier',
            '2002-10-17',
            'Germany',
            'ST'::public.enum_player_position,
            ARRAY['LW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 30000000.00, 78,
            88, 77, 68, 76, 34, 70, TRUE
        );
    END IF;

    -- Player: Lukas Hradecky (lukas-hradecky)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'lukas-hradecky') THEN
        v_player_id := public.create_player_template_with_positions(
            'lukas-hradecky',
            v_club_id,
            'Lukas Hradecky',
            '1989-11-24',
            'Finland',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 2500000.00, 81,
            82, 79, 81, 78, 72, 80, TRUE
        );
    END IF;

    -- Player: Matěj Kovář (matej-kovar)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'matej-kovar') THEN
        v_player_id := public.create_player_template_with_positions(
            'matej-kovar',
            v_club_id,
            'Matěj Kovář',
            '2000-05-17',
            'Czech Republic',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 7000000.00, 75,
            76, 73, 74, 71, 77, 75, TRUE
        );
    END IF;

    -- Player: Jonathan Tah (jonathan-tah)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jonathan-tah') THEN
        v_player_id := public.create_player_template_with_positions(
            'jonathan-tah',
            v_club_id,
            'Jonathan Tah',
            '1996-02-11',
            'Germany',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 30000000.00, 83,
            74, 35, 62, 60, 85, 87, TRUE
        );
    END IF;

    -- Player: Edmond Tapsoba (edmond-tapsoba)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'edmond-tapsoba') THEN
        v_player_id := public.create_player_template_with_positions(
            'edmond-tapsoba',
            v_club_id,
            'Edmond Tapsoba',
            '1999-02-02',
            'Burkina Faso',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 45000000.00, 82,
            76, 50, 72, 74, 83, 80, TRUE
        );
    END IF;

    -- Player: Piero Hincapié (piero-hincapie)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'piero-hincapie') THEN
        v_player_id := public.create_player_template_with_positions(
            'piero-hincapie',
            v_club_id,
            'Piero Hincapié',
            '2002-01-09',
            'Ecuador',
            'CB'::public.enum_player_position,
            ARRAY['LB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 40000000.00, 80,
            79, 42, 68, 70, 81, 80, TRUE
        );
    END IF;

    -- Player: Jeremie Frimpong (jeremie-frimpong)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jeremie-frimpong') THEN
        v_player_id := public.create_player_template_with_positions(
            'jeremie-frimpong',
            v_club_id,
            'Jeremie Frimpong',
            '2000-12-10',
            'Netherlands',
            'RWB'::public.enum_player_position,
            ARRAY['RM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 50000000.00, 84,
            94, 72, 78, 84, 72, 70, TRUE
        );
    END IF;

    -- Player: Alex Grimaldo (alex-grimaldo)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'alex-grimaldo') THEN
        v_player_id := public.create_player_template_with_positions(
            'alex-grimaldo',
            v_club_id,
            'Alex Grimaldo',
            '1995-09-20',
            'Spain',
            'LWB'::public.enum_player_position,
            ARRAY['LB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 45000000.00, 86,
            84, 78, 86, 84, 76, 70, TRUE
        );
    END IF;

    -- Player: Arthur (arthur-augusto)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'arthur-augusto') THEN
        v_player_id := public.create_player_template_with_positions(
            'arthur-augusto',
            v_club_id,
            'Arthur',
            '2003-03-17',
            'Brazil',
            'RB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 5000000.00, 72,
            78, 45, 65, 72, 68, 66, TRUE
        );
    END IF;

    -- Player: Granit Xhaka (granit-xhaka)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'granit-xhaka') THEN
        v_player_id := public.create_player_template_with_positions(
            'granit-xhaka',
            v_club_id,
            'Granit Xhaka',
            '1992-09-27',
            'Switzerland',
            'CDM'::public.enum_player_position,
            ARRAY['CM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 85,
            52, 74, 86, 78, 80, 83, TRUE
        );
    END IF;

    -- Player: Exequiel Palacios (exequiel-palacios)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'exequiel-palacios') THEN
        v_player_id := public.create_player_template_with_positions(
            'exequiel-palacios',
            v_club_id,
            'Exequiel Palacios',
            '1998-10-05',
            'Argentina',
            'CM'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 45000000.00, 82,
            74, 72, 80, 81, 80, 80, TRUE
        );
    END IF;

    -- Player: Robert Andrich (robert-andrich)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'robert-andrich') THEN
        v_player_id := public.create_player_template_with_positions(
            'robert-andrich',
            v_club_id,
            'Robert Andrich',
            '1994-09-25',
            'Germany',
            'CDM'::public.enum_player_position,
            ARRAY['CB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 17000000.00, 81,
            66, 72, 74, 72, 82, 85, TRUE
        );
    END IF;

    -- Player: Aleix García (aleix-garcia)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'aleix-garcia') THEN
        v_player_id := public.create_player_template_with_positions(
            'aleix-garcia',
            v_club_id,
            'Aleix García',
            '1997-06-28',
            'Spain',
            'CM'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 25000000.00, 81,
            68, 74, 84, 80, 74, 72, TRUE
        );
    END IF;

    -- Player: Florian Wirtz (florian-wirtz)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'florian-wirtz') THEN
        v_player_id := public.create_player_template_with_positions(
            'florian-wirtz',
            v_club_id,
            'Florian Wirtz',
            '2003-05-03',
            'Germany',
            'CAM'::public.enum_player_position,
            ARRAY['LW'::public.enum_player_position, 'RW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 130000000.00, 88,
            81, 81, 87, 89, 54, 66, TRUE
        );
    END IF;

    -- Player: Jonas Hofmann (jonas-hofmann)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jonas-hofmann') THEN
        v_player_id := public.create_player_template_with_positions(
            'jonas-hofmann',
            v_club_id,
            'Jonas Hofmann',
            '1992-07-14',
            'Germany',
            'CAM'::public.enum_player_position,
            ARRAY['RM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 12000000.00, 80,
            74, 78, 81, 80, 58, 66, TRUE
        );
    END IF;

    -- Player: Patrik Schick (patrik-schick)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'patrik-schick') THEN
        v_player_id := public.create_player_template_with_positions(
            'patrik-schick',
            v_club_id,
            'Patrik Schick',
            '1996-01-24',
            'Czech Republic',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 22000000.00, 81,
            74, 82, 72, 76, 36, 78, TRUE
        );
    END IF;

    -- Player: Victor Boniface (victor-boniface)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'victor-boniface') THEN
        v_player_id := public.create_player_template_with_positions(
            'victor-boniface',
            v_club_id,
            'Victor Boniface',
            '2000-12-23',
            'Nigeria',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 45000000.00, 82,
            83, 82, 69, 81, 35, 86, TRUE
        );
    END IF;

    -- Player: Martin Terrier (martin-terrier)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'martin-terrier') THEN
        v_player_id := public.create_player_template_with_positions(
            'martin-terrier',
            v_club_id,
            'Martin Terrier',
            '1997-03-04',
            'France',
            'LW'::public.enum_player_position,
            ARRAY['ST'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 79,
            78, 78, 74, 79, 44, 72, TRUE
        );
    END IF;

    -- Player: Nathan Tella (amane-romeo)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'amane-romeo') THEN
        v_player_id := public.create_player_template_with_positions(
            'amane-romeo',
            v_club_id,
            'Nathan Tella',
            '1999-07-05',
            'Nigeria',
            'RM'::public.enum_player_position,
            ARRAY['RW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 77,
            86, 70, 70, 77, 42, 64, TRUE
        );
    END IF;

    -- Player: Gianluigi Donnarumma (gianluigi-donnarumma)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'paris-saint-germain';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'gianluigi-donnarumma') THEN
        v_player_id := public.create_player_template_with_positions(
            'gianluigi-donnarumma',
            v_club_id,
            'Gianluigi Donnarumma',
            '1999-02-25',
            'Italy',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 89,
            90, 85, 88, 87, 76, 89, TRUE
        );
    END IF;

    -- Player: Matvey Safonov (matvey-safonov)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'paris-saint-germain';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'matvey-safonov') THEN
        v_player_id := public.create_player_template_with_positions(
            'matvey-safonov',
            v_club_id,
            'Matvey Safonov',
            '1999-02-25',
            'Russia',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 78,
            80, 76, 77, 75, 75, 78, TRUE
        );
    END IF;

    -- Player: Marquinhos (marquinhos)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'paris-saint-germain';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'marquinhos') THEN
        v_player_id := public.create_player_template_with_positions(
            'marquinhos',
            v_club_id,
            'Marquinhos',
            '1994-05-14',
            'Brazil',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 50000000.00, 87,
            78, 56, 75, 74, 88, 80, TRUE
        );
    END IF;

    -- Player: Willian Pacho (willian-pacho)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'paris-saint-germain';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'willian-pacho') THEN
        v_player_id := public.create_player_template_with_positions(
            'willian-pacho',
            v_club_id,
            'Willian Pacho',
            '2001-10-16',
            'Ecuador',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 45000000.00, 79,
            78, 36, 62, 64, 81, 82, TRUE
        );
    END IF;

    -- Player: Lucas Beraldo (lucas-beraldo)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'paris-saint-germain';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'lucas-beraldo') THEN
        v_player_id := public.create_player_template_with_positions(
            'lucas-beraldo',
            v_club_id,
            'Lucas Beraldo',
            '2003-11-24',
            'Brazil',
            'CB'::public.enum_player_position,
            ARRAY['LB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 30000000.00, 77,
            72, 40, 72, 72, 78, 74, TRUE
        );
    END IF;

    -- Player: Presnel Kimpembe (presnel-kimpembe)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'paris-saint-germain';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'presnel-kimpembe') THEN
        v_player_id := public.create_player_template_with_positions(
            'presnel-kimpembe',
            v_club_id,
            'Presnel Kimpembe',
            '1995-08-13',
            'France',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 12000000.00, 79,
            70, 42, 66, 64, 80, 82, TRUE
        );
    END IF;

    -- Player: Achraf Hakimi (achraf-hakimi)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'paris-saint-germain';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'achraf-hakimi') THEN
        v_player_id := public.create_player_template_with_positions(
            'achraf-hakimi',
            v_club_id,
            'Achraf Hakimi',
            '1998-11-04',
            'Morocco',
            'RB'::public.enum_player_position,
            ARRAY['RWB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 60000000.00, 84,
            92, 75, 80, 82, 76, 78, TRUE
        );
    END IF;

    -- Player: Nuno Mendes (nuno-mendes)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'paris-saint-germain';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'nuno-mendes') THEN
        v_player_id := public.create_player_template_with_positions(
            'nuno-mendes',
            v_club_id,
            'Nuno Mendes',
            '2002-06-19',
            'Portugal',
            'LB'::public.enum_player_position,
            ARRAY['LWB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 55000000.00, 83,
            89, 64, 76, 81, 79, 76, TRUE
        );
    END IF;

    -- Player: Lucas Hernández (lucas-hernandez)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'paris-saint-germain';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'lucas-hernandez') THEN
        v_player_id := public.create_player_template_with_positions(
            'lucas-hernandez',
            v_club_id,
            'Lucas Hernández',
            '1996-02-14',
            'France',
            'LB'::public.enum_player_position,
            ARRAY['CB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 83,
            76, 54, 72, 72, 84, 81, TRUE
        );
    END IF;

    -- Player: Vitinha (vitinha)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'paris-saint-germain';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'vitinha') THEN
        v_player_id := public.create_player_template_with_positions(
            'vitinha',
            v_club_id,
            'Vitinha',
            '2000-02-13',
            'Portugal',
            'CM'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 55000000.00, 85,
            78, 74, 84, 86, 74, 68, TRUE
        );
    END IF;

    -- Player: João Neves (joao-neves)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'paris-saint-germain';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'joao-neves') THEN
        v_player_id := public.create_player_template_with_positions(
            'joao-neves',
            v_club_id,
            'João Neves',
            '2004-09-27',
            'Portugal',
            'CM'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 60000000.00, 80,
            76, 66, 80, 82, 77, 76, TRUE
        );
    END IF;

    -- Player: Warren Zaïre-Emery (warren-zaire-emery)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'paris-saint-germain';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'warren-zaire-emery') THEN
        v_player_id := public.create_player_template_with_positions(
            'warren-zaire-emery',
            v_club_id,
            'Warren Zaïre-Emery',
            '2006-03-08',
            'France',
            'CM'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position, 'RB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 60000000.00, 80,
            78, 70, 78, 80, 76, 78, TRUE
        );
    END IF;

    -- Player: Fabián Ruiz (fabian-ruiz)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'paris-saint-germain';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'fabian-ruiz') THEN
        v_player_id := public.create_player_template_with_positions(
            'fabian-ruiz',
            v_club_id,
            'Fabián Ruiz',
            '1996-04-03',
            'Spain',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 82,
            66, 78, 83, 82, 74, 74, TRUE
        );
    END IF;

    -- Player: Lee Kang-in (lee-kang-in)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'paris-saint-germain';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'lee-kang-in') THEN
        v_player_id := public.create_player_template_with_positions(
            'lee-kang-in',
            v_club_id,
            'Lee Kang-in',
            '2001-02-19',
            'South Korea',
            'CAM'::public.enum_player_position,
            ARRAY['RW'::public.enum_player_position, 'CM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 25000000.00, 79,
            76, 74, 81, 84, 50, 60, TRUE
        );
    END IF;

    -- Player: Ousmane Dembélé (ousmane-dembele)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'paris-saint-germain';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'ousmane-dembele') THEN
        v_player_id := public.create_player_template_with_positions(
            'ousmane-dembele',
            v_club_id,
            'Ousmane Dembélé',
            '1997-05-15',
            'France',
            'RW'::public.enum_player_position,
            ARRAY['LW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 60000000.00, 86,
            91, 77, 81, 89, 36, 56, TRUE
        );
    END IF;

    -- Player: Bradley Barcola (bradley-barcola)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'paris-saint-germain';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'bradley-barcola') THEN
        v_player_id := public.create_player_template_with_positions(
            'bradley-barcola',
            v_club_id,
            'Bradley Barcola',
            '2002-09-02',
            'France',
            'LW'::public.enum_player_position,
            ARRAY['RW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 65000000.00, 80,
            89, 74, 76, 82, 34, 64, TRUE
        );
    END IF;

    -- Player: Désiré Doué (desire-doue)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'paris-saint-germain';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'desire-doue') THEN
        v_player_id := public.create_player_template_with_positions(
            'desire-doue',
            v_club_id,
            'Désiré Doué',
            '2005-06-03',
            'France',
            'LW'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 40000000.00, 77,
            82, 72, 76, 83, 45, 66, TRUE
        );
    END IF;

    -- Player: Gonçalo Ramos (goncalo-ramos)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'paris-saint-germain';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'goncalo-ramos') THEN
        v_player_id := public.create_player_template_with_positions(
            'goncalo-ramos',
            v_club_id,
            'Gonçalo Ramos',
            '2001-06-20',
            'Portugal',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 50000000.00, 80,
            77, 80, 68, 76, 40, 78, TRUE
        );
    END IF;

    -- Player: Yann Sommer (yann-sommer)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'inter';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'yann-sommer') THEN
        v_player_id := public.create_player_template_with_positions(
            'yann-sommer',
            v_club_id,
            'Yann Sommer',
            '1988-12-17',
            'Switzerland',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 5000000.00, 87,
            87, 85, 86, 84, 86, 86, TRUE
        );
    END IF;

    -- Player: Josep Martínez (josep-martinez)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'inter';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'josep-martinez') THEN
        v_player_id := public.create_player_template_with_positions(
            'josep-martinez',
            v_club_id,
            'Josep Martínez',
            '1998-05-27',
            'Spain',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 8000000.00, 76,
            76, 74, 75, 72, 76, 75, TRUE
        );
    END IF;

    -- Player: Alessandro Bastoni (alessandro-bastoni)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'inter';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'alessandro-bastoni') THEN
        v_player_id := public.create_player_template_with_positions(
            'alessandro-bastoni',
            v_club_id,
            'Alessandro Bastoni',
            '1999-04-13',
            'Italy',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 70000000.00, 87,
            72, 45, 78, 76, 87, 82, TRUE
        );
    END IF;

    -- Player: Benjamin Pavard (benjamin-pavard)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'inter';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'benjamin-pavard') THEN
        v_player_id := public.create_player_template_with_positions(
            'benjamin-pavard',
            v_club_id,
            'Benjamin Pavard',
            '1996-03-28',
            'France',
            'CB'::public.enum_player_position,
            ARRAY['RB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 45000000.00, 84,
            74, 52, 74, 72, 84, 78, TRUE
        );
    END IF;

    -- Player: Stefan de Vrij (stefan-de-vrij)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'inter';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'stefan-de-vrij') THEN
        v_player_id := public.create_player_template_with_positions(
            'stefan-de-vrij',
            v_club_id,
            'Stefan de Vrij',
            '1992-02-05',
            'Netherlands',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 8000000.00, 81,
            58, 42, 65, 64, 83, 76, TRUE
        );
    END IF;

    -- Player: Yann Bisseck (yann-bisseck)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'inter';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'yann-bisseck') THEN
        v_player_id := public.create_player_template_with_positions(
            'yann-bisseck',
            v_club_id,
            'Yann Bisseck',
            '2000-11-29',
            'Germany',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 25000000.00, 77,
            74, 38, 64, 65, 78, 84, TRUE
        );
    END IF;

    -- Player: Francesco Acerbi (francesco-acerbi)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'inter';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'francesco-acerbi') THEN
        v_player_id := public.create_player_template_with_positions(
            'francesco-acerbi',
            v_club_id,
            'Francesco Acerbi',
            '1988-02-10',
            'Italy',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 3500000.00, 82,
            54, 40, 64, 62, 84, 80, TRUE
        );
    END IF;

    -- Player: Denzel Dumfries (denzel-dumfries)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'inter';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'denzel-dumfries') THEN
        v_player_id := public.create_player_template_with_positions(
            'denzel-dumfries',
            v_club_id,
            'Denzel Dumfries',
            '1996-04-18',
            'Netherlands',
            'RWB'::public.enum_player_position,
            ARRAY['RM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 24000000.00, 82,
            83, 66, 74, 76, 78, 86, TRUE
        );
    END IF;

    -- Player: Federico Dimarco (federico-dimarco)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'inter';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'federico-dimarco') THEN
        v_player_id := public.create_player_template_with_positions(
            'federico-dimarco',
            v_club_id,
            'Federico Dimarco',
            '1997-11-10',
            'Italy',
            'LWB'::public.enum_player_position,
            ARRAY['LM'::public.enum_player_position, 'LB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 50000000.00, 84,
            80, 76, 85, 82, 76, 74, TRUE
        );
    END IF;

    -- Player: Matteo Darmian (matteo-darmian)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'inter';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'matteo-darmian') THEN
        v_player_id := public.create_player_template_with_positions(
            'matteo-darmian',
            v_club_id,
            'Matteo Darmian',
            '1989-12-02',
            'Italy',
            'RM'::public.enum_player_position,
            ARRAY['CB'::public.enum_player_position, 'RB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 4000000.00, 80,
            72, 55, 72, 74, 80, 74, TRUE
        );
    END IF;

    -- Player: Carlos Augusto (carlos-augusto)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'inter';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'carlos-augusto') THEN
        v_player_id := public.create_player_template_with_positions(
            'carlos-augusto',
            v_club_id,
            'Carlos Augusto',
            '1999-01-07',
            'Brazil',
            'LM'::public.enum_player_position,
            ARRAY['LWB'::public.enum_player_position, 'CB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 22000000.00, 79,
            82, 62, 74, 76, 76, 78, TRUE
        );
    END IF;

    -- Player: Nicolò Barella (nicololo-barella)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'inter';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'nicololo-barella') THEN
        v_player_id := public.create_player_template_with_positions(
            'nicololo-barella',
            v_club_id,
            'Nicolò Barella',
            '1997-02-07',
            'Italy',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 80000000.00, 87,
            80, 76, 84, 84, 79, 82, TRUE
        );
    END IF;

    -- Player: Hakan Çalhanoğlu (hakan-calhanoglu)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'inter';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'hakan-calhanoglu') THEN
        v_player_id := public.create_player_template_with_positions(
            'hakan-calhanoglu',
            v_club_id,
            'Hakan Çalhanoğlu',
            '1994-02-08',
            'Turkey',
            'CDM'::public.enum_player_position,
            ARRAY['CM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 45000000.00, 86,
            68, 80, 88, 84, 76, 72, TRUE
        );
    END IF;

    -- Player: Henrikh Mkhitaryan (henrikh-mkhitaryan)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'inter';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'henrikh-mkhitaryan') THEN
        v_player_id := public.create_player_template_with_positions(
            'henrikh-mkhitaryan',
            v_club_id,
            'Henrikh Mkhitaryan',
            '1989-01-21',
            'Armenia',
            'CM'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 6000000.00, 83,
            72, 78, 82, 83, 70, 68, TRUE
        );
    END IF;

    -- Player: Davide Frattesi (davide-frattesi)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'inter';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'davide-frattesi') THEN
        v_player_id := public.create_player_template_with_positions(
            'davide-frattesi',
            v_club_id,
            'Davide Frattesi',
            '1999-09-22',
            'Italy',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 81,
            79, 77, 76, 79, 74, 78, TRUE
        );
    END IF;

    -- Player: Kristjan Asllani (kristjan-asllani)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'inter';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'kristjan-asllani') THEN
        v_player_id := public.create_player_template_with_positions(
            'kristjan-asllani',
            v_club_id,
            'Kristjan Asllani',
            '2002-03-09',
            'Albania',
            'CDM'::public.enum_player_position,
            ARRAY['CM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 18000000.00, 76,
            68, 64, 78, 77, 72, 68, TRUE
        );
    END IF;

    -- Player: Lautaro Martínez (lautaro-martinez)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'inter';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'lautaro-martinez') THEN
        v_player_id := public.create_player_template_with_positions(
            'lautaro-martinez',
            v_club_id,
            'Lautaro Martínez',
            '1997-08-22',
            'Argentina',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 110000000.00, 89,
            80, 88, 76, 85, 48, 84, TRUE
        );
    END IF;

    -- Player: Marcus Thuram (marcus-thuram)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'inter';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'marcus-thuram') THEN
        v_player_id := public.create_player_template_with_positions(
            'marcus-thuram',
            v_club_id,
            'Marcus Thuram',
            '1997-08-06',
            'France',
            'ST'::public.enum_player_position,
            ARRAY['LW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 65000000.00, 83,
            86, 80, 75, 80, 42, 82, TRUE
        );
    END IF;

    -- Player: Mike Maignan (mike-maignan)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'mike-maignan') THEN
        v_player_id := public.create_player_template_with_positions(
            'mike-maignan',
            v_club_id,
            'Mike Maignan',
            '1995-07-03',
            'France',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 38000000.00, 87,
            87, 85, 86, 84, 88, 86, TRUE
        );
    END IF;

    -- Player: Marco Sportiello (marco-sportiello)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'marco-sportiello') THEN
        v_player_id := public.create_player_template_with_positions(
            'marco-sportiello',
            v_club_id,
            'Marco Sportiello',
            '1992-05-10',
            'Italy',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 2500000.00, 75,
            76, 74, 75, 72, 70, 75, TRUE
        );
    END IF;

    -- Player: Fikayo Tomori (fikayo-tomori)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'fikayo-tomori') THEN
        v_player_id := public.create_player_template_with_positions(
            'fikayo-tomori',
            v_club_id,
            'Fikayo Tomori',
            '1997-12-19',
            'England',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 32000000.00, 82,
            82, 40, 62, 64, 83, 80, TRUE
        );
    END IF;

    -- Player: Strahinja Pavlović (strahinja-pavlovic)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'strahinja-pavlovic') THEN
        v_player_id := public.create_player_template_with_positions(
            'strahinja-pavlovic',
            v_club_id,
            'Strahinja Pavlović',
            '2001-05-24',
            'Serbia',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 25000000.00, 78,
            76, 42, 60, 62, 79, 86, TRUE
        );
    END IF;

    -- Player: Malick Thiaw (malick-thiaw)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'malick-thiaw') THEN
        v_player_id := public.create_player_template_with_positions(
            'malick-thiaw',
            v_club_id,
            'Malick Thiaw',
            '2001-08-08',
            'Germany',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 77,
            74, 35, 62, 64, 78, 80, TRUE
        );
    END IF;

    -- Player: Matteo Gabbia (matteo-gabbia)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'matteo-gabbia') THEN
        v_player_id := public.create_player_template_with_positions(
            'matteo-gabbia',
            v_club_id,
            'Matteo Gabbia',
            '1999-10-21',
            'Italy',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 12000000.00, 77,
            65, 34, 60, 60, 79, 78, TRUE
        );
    END IF;

    -- Player: Emerson Royal (emerson-royal)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'emerson-royal') THEN
        v_player_id := public.create_player_template_with_positions(
            'emerson-royal',
            v_club_id,
            'Emerson Royal',
            '1999-01-14',
            'Brazil',
            'RB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 15000000.00, 76,
            77, 56, 70, 74, 76, 76, TRUE
        );
    END IF;

    -- Player: Davide Calabria (davide-calabria)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'davide-calabria') THEN
        v_player_id := public.create_player_template_with_positions(
            'davide-calabria',
            v_club_id,
            'Davide Calabria',
            '1996-12-06',
            'Italy',
            'RB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 10000000.00, 77,
            75, 54, 72, 74, 77, 73, TRUE
        );
    END IF;

    -- Player: Theo Hernández (theo-hernandez)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'theo-hernandez') THEN
        v_player_id := public.create_player_template_with_positions(
            'theo-hernandez',
            v_club_id,
            'Theo Hernández',
            '1997-10-06',
            'France',
            'LB'::public.enum_player_position,
            ARRAY['LWB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 60000000.00, 87,
            92, 72, 76, 81, 80, 84, TRUE
        );
    END IF;

    -- Player: Youssouf Fofana (youssouf-fofana)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'youssouf-fofana') THEN
        v_player_id := public.create_player_template_with_positions(
            'youssouf-fofana',
            v_club_id,
            'Youssouf Fofana',
            '1999-01-10',
            'France',
            'CDM'::public.enum_player_position,
            ARRAY['CM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 30000000.00, 80,
            74, 66, 76, 77, 79, 83, TRUE
        );
    END IF;

    -- Player: Tijjani Reijnders (tijjani-reijnders)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'tijjani-reijnders') THEN
        v_player_id := public.create_player_template_with_positions(
            'tijjani-reijnders',
            v_club_id,
            'Tijjani Reijnders',
            '1998-07-29',
            'Netherlands',
            'CM'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 30000000.00, 82,
            79, 74, 81, 83, 73, 76, TRUE
        );
    END IF;

    -- Player: Ruben Loftus-Cheek (ruben-loftus-cheek)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'ruben-loftus-cheek') THEN
        v_player_id := public.create_player_template_with_positions(
            'ruben-loftus-cheek',
            v_club_id,
            'Ruben Loftus-Cheek',
            '1996-01-23',
            'England',
            'CM'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 25000000.00, 80,
            75, 75, 78, 82, 74, 84, TRUE
        );
    END IF;

    -- Player: Yunus Musah (yunus-musah)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'yunus-musah') THEN
        v_player_id := public.create_player_template_with_positions(
            'yunus-musah',
            v_club_id,
            'Yunus Musah',
            '2002-11-29',
            'United States',
            'CM'::public.enum_player_position,
            ARRAY['RM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 22000000.00, 76,
            82, 62, 74, 79, 70, 76, TRUE
        );
    END IF;

    -- Player: Christian Pulisic (christian-pulisic)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'christian-pulisic') THEN
        v_player_id := public.create_player_template_with_positions(
            'christian-pulisic',
            v_club_id,
            'Christian Pulisic',
            '1998-09-18',
            'United States',
            'RW'::public.enum_player_position,
            ARRAY['LW'::public.enum_player_position, 'CAM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 50000000.00, 83,
            85, 80, 78, 85, 42, 66, TRUE
        );
    END IF;

    -- Player: Rafael Leão (rafael-leao)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'rafael-leao') THEN
        v_player_id := public.create_player_template_with_positions(
            'rafael-leao',
            v_club_id,
            'Rafael Leão',
            '1999-06-10',
            'Portugal',
            'LW'::public.enum_player_position,
            ARRAY['ST'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 75000000.00, 86,
            93, 79, 76, 87, 36, 77, TRUE
        );
    END IF;

    -- Player: Samuel Chukwueze (samuel-chukwueze)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'samuel-chukwueze') THEN
        v_player_id := public.create_player_template_with_positions(
            'samuel-chukwueze',
            v_club_id,
            'Samuel Chukwueze',
            '1999-05-22',
            'Nigeria',
            'RW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 78,
            86, 72, 73, 82, 34, 62, TRUE
        );
    END IF;

    -- Player: Álvaro Morata (alvaro-morata)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'alvaro-morata') THEN
        v_player_id := public.create_player_template_with_positions(
            'alvaro-morata',
            v_club_id,
            'Álvaro Morata',
            '1992-10-23',
            'Spain',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 16000000.00, 83,
            77, 82, 72, 76, 38, 76, TRUE
        );
    END IF;

    -- Player: Tammy Abraham (tammy-abraham)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'tammy-abraham') THEN
        v_player_id := public.create_player_template_with_positions(
            'tammy-abraham',
            v_club_id,
            'Tammy Abraham',
            '1997-10-02',
            'England',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 77,
            76, 76, 66, 73, 34, 76, TRUE
        );
    END IF;

    -- Player: Michele Di Gregorio (michele-di-gregorio)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'juventus';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'michele-di-gregorio') THEN
        v_player_id := public.create_player_template_with_positions(
            'michele-di-gregorio',
            v_club_id,
            'Michele Di Gregorio',
            '1997-07-27',
            'Italy',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 18000000.00, 82,
            83, 80, 82, 78, 77, 82, TRUE
        );
    END IF;

    -- Player: Mattia Perin (mattia-perin)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'juventus';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'mattia-perin') THEN
        v_player_id := public.create_player_template_with_positions(
            'mattia-perin',
            v_club_id,
            'Mattia Perin',
            '1992-11-10',
            'Italy',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 3000000.00, 78,
            79, 77, 78, 75, 72, 77, TRUE
        );
    END IF;

    -- Player: Gleison Bremer (gleison-bremer)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'juventus';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'gleison-bremer') THEN
        v_player_id := public.create_player_template_with_positions(
            'gleison-bremer',
            v_club_id,
            'Gleison Bremer',
            '1997-03-18',
            'Brazil',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 60000000.00, 86,
            81, 40, 58, 62, 87, 86, TRUE
        );
    END IF;

    -- Player: Federico Gatti (federico-gatti)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'juventus';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'federico-gatti') THEN
        v_player_id := public.create_player_template_with_positions(
            'federico-gatti',
            v_club_id,
            'Federico Gatti',
            '1998-06-24',
            'Italy',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 25000000.00, 78,
            72, 45, 60, 62, 80, 82, TRUE
        );
    END IF;

    -- Player: Pierre Kalulu (pierre-kalulu)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'juventus';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'pierre-kalulu') THEN
        v_player_id := public.create_player_template_with_positions(
            'pierre-kalulu',
            v_club_id,
            'Pierre Kalulu',
            '2000-06-05',
            'France',
            'CB'::public.enum_player_position,
            ARRAY['RB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 77,
            80, 38, 66, 68, 78, 74, TRUE
        );
    END IF;

    -- Player: Juan Cabal (juan-cabal)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'juventus';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'juan-cabal') THEN
        v_player_id := public.create_player_template_with_positions(
            'juan-cabal',
            v_club_id,
            'Juan Cabal',
            '2001-01-08',
            'Colombia',
            'LB'::public.enum_player_position,
            ARRAY['CB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 10000000.00, 74,
            75, 38, 64, 68, 74, 76, TRUE
        );
    END IF;

    -- Player: Andrea Cambiaso (andrea-cambiaso)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'juventus';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'andrea-cambiaso') THEN
        v_player_id := public.create_player_template_with_positions(
            'andrea-cambiaso',
            v_club_id,
            'Andrea Cambiaso',
            '2000-02-20',
            'Italy',
            'RB'::public.enum_player_position,
            ARRAY['LB'::public.enum_player_position, 'CM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 30000000.00, 81,
            80, 64, 78, 81, 77, 73, TRUE
        );
    END IF;

    -- Player: Danilo (danilo-da-silva)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'juventus';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'danilo-da-silva') THEN
        v_player_id := public.create_player_template_with_positions(
            'danilo-da-silva',
            v_club_id,
            'Danilo',
            '1991-07-15',
            'Brazil',
            'CB'::public.enum_player_position,
            ARRAY['RB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 7000000.00, 81,
            70, 58, 74, 74, 82, 78, TRUE
        );
    END IF;

    -- Player: Teun Koopmeiners (teun-koopmeiners)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'juventus';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'teun-koopmeiners') THEN
        v_player_id := public.create_player_template_with_positions(
            'teun-koopmeiners',
            v_club_id,
            'Teun Koopmeiners',
            '1998-02-28',
            'Netherlands',
            'CAM'::public.enum_player_position,
            ARRAY['CM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 55000000.00, 83,
            74, 81, 84, 82, 76, 78, TRUE
        );
    END IF;

    -- Player: Douglas Luiz (douglas-luiz)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'juventus';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'douglas-luiz') THEN
        v_player_id := public.create_player_template_with_positions(
            'douglas-luiz',
            v_club_id,
            'Douglas Luiz',
            '1998-05-09',
            'Brazil',
            'CM'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 55000000.00, 83,
            70, 77, 83, 83, 78, 77, TRUE
        );
    END IF;

    -- Player: Khéphren Thuram (khephren-thuram)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'juventus';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'khephren-thuram') THEN
        v_player_id := public.create_player_template_with_positions(
            'khephren-thuram',
            v_club_id,
            'Khéphren Thuram',
            '2001-03-26',
            'France',
            'CM'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 79,
            78, 66, 76, 80, 77, 82, TRUE
        );
    END IF;

    -- Player: Weston McKennie (weston-mckennie)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'juventus';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'weston-mckennie') THEN
        v_player_id := public.create_player_template_with_positions(
            'weston-mckennie',
            v_club_id,
            'Weston McKennie',
            '1998-08-28',
            'United States',
            'CM'::public.enum_player_position,
            ARRAY['RM'::public.enum_player_position, 'RB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 24000000.00, 80,
            76, 72, 76, 78, 76, 82, TRUE
        );
    END IF;

    -- Player: Nicolò Fagioli (nicololo-fagioli)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'juventus';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'nicololo-fagioli') THEN
        v_player_id := public.create_player_template_with_positions(
            'nicololo-fagioli',
            v_club_id,
            'Nicolò Fagioli',
            '2001-02-12',
            'Italy',
            'CM'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 77,
            72, 68, 80, 80, 70, 68, TRUE
        );
    END IF;

    -- Player: Kenan Yıldız (kenan-yildiz)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'juventus';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'kenan-yildiz') THEN
        v_player_id := public.create_player_template_with_positions(
            'kenan-yildiz',
            v_club_id,
            'Kenan Yıldız',
            '2005-05-04',
            'Turkey',
            'LW'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position, 'ST'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 40000000.00, 79,
            82, 76, 75, 83, 40, 68, TRUE
        );
    END IF;

    -- Player: Nicolò Savona (nicololo-savona)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'juventus';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'nicololo-savona') THEN
        v_player_id := public.create_player_template_with_positions(
            'nicololo-savona',
            v_club_id,
            'Nicolò Savona',
            '2003-03-19',
            'Italy',
            'RB'::public.enum_player_position,
            ARRAY['CB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 7000000.00, 73,
            74, 42, 66, 68, 73, 72, TRUE
        );
    END IF;

    -- Player: Dušan Vlahović (dusan-vlahovic)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'juventus';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'dusan-vlahovic') THEN
        v_player_id := public.create_player_template_with_positions(
            'dusan-vlahovic',
            v_club_id,
            'Dušan Vlahović',
            '2000-01-28',
            'Serbia',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 65000000.00, 84,
            80, 86, 68, 77, 38, 82, TRUE
        );
    END IF;

    -- Player: Nico González (nicolas-gonzalez)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'juventus';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'nicolas-gonzalez') THEN
        v_player_id := public.create_player_template_with_positions(
            'nicolas-gonzalez',
            v_club_id,
            'Nico González',
            '1998-04-06',
            'Argentina',
            'RW'::public.enum_player_position,
            ARRAY['LW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 81,
            82, 78, 74, 80, 52, 76, TRUE
        );
    END IF;

    -- Player: Francisco Conceição (francisco-conceicao)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'juventus';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'francisco-conceicao') THEN
        v_player_id := public.create_player_template_with_positions(
            'francisco-conceicao',
            v_club_id,
            'Francisco Conceição',
            '2002-12-14',
            'Portugal',
            'RW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 22000000.00, 77,
            87, 71, 72, 84, 30, 56, TRUE
        );
    END IF;

    -- Player: Alex Meret (alex-meret)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'napoli';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'alex-meret') THEN
        v_player_id := public.create_player_template_with_positions(
            'alex-meret',
            v_club_id,
            'Alex Meret',
            '1997-03-22',
            'Italy',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 12000000.00, 81,
            82, 79, 81, 78, 72, 80, TRUE
        );
    END IF;

    -- Player: Elia Caprile (elia-caprile)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'napoli';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'elia-caprile') THEN
        v_player_id := public.create_player_template_with_positions(
            'elia-caprile',
            v_club_id,
            'Elia Caprile',
            '2001-08-25',
            'Italy',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 10000000.00, 76,
            77, 74, 76, 73, 73, 76, TRUE
        );
    END IF;

    -- Player: Alessandro Buongiorno (alessandro-buongiorno)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'napoli';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'alessandro-buongiorno') THEN
        v_player_id := public.create_player_template_with_positions(
            'alessandro-buongiorno',
            v_club_id,
            'Alessandro Buongiorno',
            '1999-06-06',
            'Italy',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 81,
            74, 38, 62, 64, 82, 84, TRUE
        );
    END IF;

    -- Player: Amir Rrahmani (amir-rahmani)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'napoli';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'amir-rahmani') THEN
        v_player_id := public.create_player_template_with_positions(
            'amir-rahmani',
            v_club_id,
            'Amir Rrahmani',
            '1994-02-24',
            'Kosovo',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 15000000.00, 80,
            66, 45, 62, 62, 81, 80, TRUE
        );
    END IF;

    -- Player: Juan Jesus (juan-jesus)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'napoli';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'juan-jesus') THEN
        v_player_id := public.create_player_template_with_positions(
            'juan-jesus',
            v_club_id,
            'Juan Jesus',
            '1991-06-10',
            'Brazil',
            'CB'::public.enum_player_position,
            ARRAY['LB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 2500000.00, 75,
            68, 42, 60, 60, 76, 77, TRUE
        );
    END IF;

    -- Player: Giovanni Di Lorenzo (giovanni-di-lorenzo)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'napoli';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'giovanni-di-lorenzo') THEN
        v_player_id := public.create_player_template_with_positions(
            'giovanni-di-lorenzo',
            v_club_id,
            'Giovanni Di Lorenzo',
            '1993-08-04',
            'Italy',
            'RB'::public.enum_player_position,
            ARRAY['CB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 15000000.00, 82,
            78, 64, 76, 78, 80, 79, TRUE
        );
    END IF;

    -- Player: Pasquale Mazzocchi (pasquale-mazzocchi)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'napoli';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'pasquale-mazzocchi') THEN
        v_player_id := public.create_player_template_with_positions(
            'pasquale-mazzocchi',
            v_club_id,
            'Pasquale Mazzocchi',
            '1995-07-27',
            'Italy',
            'RB'::public.enum_player_position,
            ARRAY['LB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 4000000.00, 74,
            78, 58, 68, 73, 72, 72, TRUE
        );
    END IF;

    -- Player: Mathías Olivera (mathias-olivera)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'napoli';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'mathias-olivera') THEN
        v_player_id := public.create_player_template_with_positions(
            'mathias-olivera',
            v_club_id,
            'Mathías Olivera',
            '1997-10-31',
            'Uruguay',
            'LB'::public.enum_player_position,
            ARRAY['CB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 15000000.00, 77,
            78, 52, 68, 72, 77, 77, TRUE
        );
    END IF;

    -- Player: Leonardo Spinazzola (spinazzola-leonardo)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'napoli';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'spinazzola-leonardo') THEN
        v_player_id := public.create_player_template_with_positions(
            'spinazzola-leonardo',
            v_club_id,
            'Leonardo Spinazzola',
            '1993-03-25',
            'Italy',
            'LWB'::public.enum_player_position,
            ARRAY['LB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 4000000.00, 77,
            81, 62, 74, 78, 73, 68, TRUE
        );
    END IF;

    -- Player: Stanislav Lobotka (stanislav-lobotka)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'napoli';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'stanislav-lobotka') THEN
        v_player_id := public.create_player_template_with_positions(
            'stanislav-lobotka',
            v_club_id,
            'Stanislav Lobotka',
            '1994-11-25',
            'Slovakia',
            'CDM'::public.enum_player_position,
            ARRAY['CM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 28000000.00, 83,
            72, 60, 81, 84, 79, 72, TRUE
        );
    END IF;

    -- Player: André-Frank Zambo Anguissa (andre-frank-zambo-anguissa)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'napoli';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'andre-frank-zambo-anguissa') THEN
        v_player_id := public.create_player_template_with_positions(
            'andre-frank-zambo-anguissa',
            v_club_id,
            'André-Frank Zambo Anguissa',
            '1995-11-16',
            'Cameroon',
            'CM'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 27000000.00, 82,
            74, 68, 77, 81, 79, 85, TRUE
        );
    END IF;

    -- Player: Scott McTominay (scott-mctominay)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'napoli';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'scott-mctominay') THEN
        v_player_id := public.create_player_template_with_positions(
            'scott-mctominay',
            v_club_id,
            'Scott McTominay',
            '1996-12-08',
            'Scotland',
            'CM'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position, 'CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 32000000.00, 80,
            74, 77, 75, 76, 76, 85, TRUE
        );
    END IF;

    -- Player: Billy Gilmour (billy-gilmour)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'napoli';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'billy-gilmour') THEN
        v_player_id := public.create_player_template_with_positions(
            'billy-gilmour',
            v_club_id,
            'Billy Gilmour',
            '2001-06-11',
            'Scotland',
            'CM'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 18000000.00, 77,
            66, 62, 80, 78, 70, 66, TRUE
        );
    END IF;

    -- Player: Michael Folorunsho (michael-folorunsho)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'napoli';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'michael-folorunsho') THEN
        v_player_id := public.create_player_template_with_positions(
            'michael-folorunsho',
            v_club_id,
            'Michael Folorunsho',
            '1998-02-07',
            'Italy',
            'CM'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 14000000.00, 76,
            76, 74, 72, 76, 70, 83, TRUE
        );
    END IF;

    -- Player: Khvicha Kvaratskhelia (khvicha-kvaratskhelia)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'napoli';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'khvicha-kvaratskhelia') THEN
        v_player_id := public.create_player_template_with_positions(
            'khvicha-kvaratskhelia',
            v_club_id,
            'Khvicha Kvaratskhelia',
            '2001-02-12',
            'Georgia',
            'LW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 80000000.00, 85,
            84, 82, 81, 88, 42, 74, TRUE
        );
    END IF;

    -- Player: Matteo Politano (matteo-politano)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'napoli';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'matteo-politano') THEN
        v_player_id := public.create_player_template_with_positions(
            'matteo-politano',
            v_club_id,
            'Matteo Politano',
            '1993-08-03',
            'Italy',
            'RW'::public.enum_player_position,
            ARRAY['RM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 13000000.00, 79,
            80, 76, 76, 81, 44, 62, TRUE
        );
    END IF;

    -- Player: David Neres (david-neres)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'napoli';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'david-neres') THEN
        v_player_id := public.create_player_template_with_positions(
            'david-neres',
            v_club_id,
            'David Neres',
            '1997-03-03',
            'Brazil',
            'RW'::public.enum_player_position,
            ARRAY['LW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 28000000.00, 79,
            84, 74, 75, 84, 38, 62, TRUE
        );
    END IF;

    -- Player: Romelu Lukaku (romelu-lukaku)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'napoli';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'romelu-lukaku') THEN
        v_player_id := public.create_player_template_with_positions(
            'romelu-lukaku',
            v_club_id,
            'Romelu Lukaku',
            '1993-05-13',
            'Belgium',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 30000000.00, 82,
            75, 83, 70, 74, 38, 86, TRUE
        );
    END IF;

    -- Player: Anatoliy Trubin (anatoliy-trubin)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'benfica';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'anatoliy-trubin') THEN
        v_player_id := public.create_player_template_with_positions(
            'anatoliy-trubin',
            v_club_id,
            'Anatoliy Trubin',
            '2001-08-01',
            'Ukraine',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 25000000.00, 81,
            82, 79, 81, 78, 74, 81, TRUE
        );
    END IF;

    -- Player: Samuel Soares (samuel-soares)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'benfica';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'samuel-soares') THEN
        v_player_id := public.create_player_template_with_positions(
            'samuel-soares',
            v_club_id,
            'Samuel Soares',
            '2002-06-15',
            'Portugal',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 3000000.00, 72,
            73, 70, 72, 70, 72, 73, TRUE
        );
    END IF;

    -- Player: Nicolás Otamendi (nicolas-otamendi)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'benfica';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'nicolas-otamendi') THEN
        v_player_id := public.create_player_template_with_positions(
            'nicolas-otamendi',
            v_club_id,
            'Nicolás Otamendi',
            '1988-02-12',
            'Argentina',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 1000000.00, 81,
            52, 54, 62, 60, 83, 81, TRUE
        );
    END IF;

    -- Player: António Silva (antonio-silva)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'benfica';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'antonio-silva') THEN
        v_player_id := public.create_player_template_with_positions(
            'antonio-silva',
            v_club_id,
            'António Silva',
            '2003-10-31',
            'Portugal',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 45000000.00, 80,
            78, 38, 64, 68, 82, 79, TRUE
        );
    END IF;

    -- Player: Tomás Araújo (tomas-araujo)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'benfica';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'tomas-araujo') THEN
        v_player_id := public.create_player_template_with_positions(
            'tomas-araujo',
            v_club_id,
            'Tomás Araújo',
            '2002-05-16',
            'Portugal',
            'CB'::public.enum_player_position,
            ARRAY['RB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 15000000.00, 76,
            75, 36, 66, 68, 77, 75, TRUE
        );
    END IF;

    -- Player: Alexander Bah (alexander-bah)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'benfica';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'alexander-bah') THEN
        v_player_id := public.create_player_template_with_positions(
            'alexander-bah',
            v_club_id,
            'Alexander Bah',
            '1997-12-09',
            'Denmark',
            'RB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 13000000.00, 77,
            84, 58, 72, 74, 74, 76, TRUE
        );
    END IF;

    -- Player: Álvaro Carreras (alvaro-carreras)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'benfica';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'alvaro-carreras') THEN
        v_player_id := public.create_player_template_with_positions(
            'alvaro-carreras',
            v_club_id,
            'Álvaro Carreras',
            '2003-03-23',
            'Spain',
            'LB'::public.enum_player_position,
            ARRAY['LWB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 18000000.00, 75,
            78, 52, 70, 74, 72, 70, TRUE
        );
    END IF;

    -- Player: Florentino Luís (florentino-luis)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'benfica';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'florentino-luis') THEN
        v_player_id := public.create_player_template_with_positions(
            'florentino-luis',
            v_club_id,
            'Florentino Luís',
            '1999-08-19',
            'Portugal',
            'CDM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 79,
            68, 48, 70, 72, 82, 78, TRUE
        );
    END IF;

    -- Player: Leandro Barreiro (leandro-barreiro)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'benfica';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'leandro-barreiro') THEN
        v_player_id := public.create_player_template_with_positions(
            'leandro-barreiro',
            v_club_id,
            'Leandro Barreiro',
            '2000-01-03',
            'Luxembourg',
            'CM'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 17000000.00, 77,
            76, 66, 74, 76, 75, 79, TRUE
        );
    END IF;

    -- Player: Orkun Kökçü (orkun-kokcu)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'benfica';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'orkun-kokcu') THEN
        v_player_id := public.create_player_template_with_positions(
            'orkun-kokcu',
            v_club_id,
            'Orkun Kökçü',
            '2000-12-29',
            'Turkey',
            'CM'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 28000000.00, 81,
            72, 78, 84, 82, 70, 72, TRUE
        );
    END IF;

    -- Player: Renato Sanches (renato-sanches)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'benfica';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'renato-sanches') THEN
        v_player_id := public.create_player_template_with_positions(
            'renato-sanches',
            v_club_id,
            'Renato Sanches',
            '1997-08-18',
            'Portugal',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 6000000.00, 77,
            78, 74, 76, 81, 70, 79, TRUE
        );
    END IF;

    -- Player: Fredrik Aursnes (fredrik-aursnes)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'benfica';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'fredrik-aursnes') THEN
        v_player_id := public.create_player_template_with_positions(
            'fredrik-aursnes',
            v_club_id,
            'Fredrik Aursnes',
            '1995-12-10',
            'Norway',
            'CM'::public.enum_player_position,
            ARRAY['RB'::public.enum_player_position, 'LB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 80,
            76, 70, 78, 79, 77, 80, TRUE
        );
    END IF;

    -- Player: Ángel Di María (angel-di-maria)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'benfica';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'angel-di-maria') THEN
        v_player_id := public.create_player_template_with_positions(
            'angel-di-maria',
            v_club_id,
            'Ángel Di María',
            '1988-02-14',
            'Argentina',
            'RW'::public.enum_player_position,
            ARRAY['RM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 3000000.00, 83,
            72, 80, 86, 86, 48, 62, TRUE
        );
    END IF;

    -- Player: Kerem Aktürkoğlu (kerem-akturkoglu)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'benfica';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'kerem-akturkoglu') THEN
        v_player_id := public.create_player_template_with_positions(
            'kerem-akturkoglu',
            v_club_id,
            'Kerem Aktürkoğlu',
            '1998-10-21',
            'Turkey',
            'LW'::public.enum_player_position,
            ARRAY['LM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 18000000.00, 78,
            88, 76, 72, 80, 40, 64, TRUE
        );
    END IF;

    -- Player: Gianluca Prestianni (gianluca-prestianni)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'benfica';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'gianluca-prestianni') THEN
        v_player_id := public.create_player_template_with_positions(
            'gianluca-prestianni',
            v_club_id,
            'Gianluca Prestianni',
            '2006-01-31',
            'Argentina',
            'RW'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 10000000.00, 71,
            79, 68, 68, 76, 32, 54, TRUE
        );
    END IF;

    -- Player: Zeki Amdouni (zeki-amdouni)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'benfica';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'zeki-amdouni') THEN
        v_player_id := public.create_player_template_with_positions(
            'zeki-amdouni',
            v_club_id,
            'Zeki Amdouni',
            '2000-12-04',
            'Switzerland',
            'ST'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 12000000.00, 76,
            76, 76, 72, 77, 36, 72, TRUE
        );
    END IF;

    -- Player: Vangelis Pavlidis (vangelis-pavlidis)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'benfica';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'vangelis-pavlidis') THEN
        v_player_id := public.create_player_template_with_positions(
            'vangelis-pavlidis',
            v_club_id,
            'Vangelis Pavlidis',
            '1998-11-21',
            'Greece',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 25000000.00, 79,
            76, 81, 70, 76, 38, 80, TRUE
        );
    END IF;

    -- Player: Arthur Cabral (arthur-cabral)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'benfica';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'arthur-cabral') THEN
        v_player_id := public.create_player_template_with_positions(
            'arthur-cabral',
            v_club_id,
            'Arthur Cabral',
            '1998-04-25',
            'Brazil',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 14000000.00, 76,
            68, 77, 62, 73, 34, 82, TRUE
        );
    END IF;

    -- Player: Diogo Costa (diogo-costa)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'diogo-costa') THEN
        v_player_id := public.create_player_template_with_positions(
            'diogo-costa',
            v_club_id,
            'Diogo Costa',
            '1999-09-19',
            'Portugal',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 45000000.00, 84,
            85, 82, 84, 80, 86, 84, TRUE
        );
    END IF;

    -- Player: Cláudio Ramos (claudio-ramos)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'claudio-ramos') THEN
        v_player_id := public.create_player_template_with_positions(
            'claudio-ramos',
            v_club_id,
            'Cláudio Ramos',
            '1991-11-16',
            'Portugal',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 1500000.00, 74,
            75, 72, 74, 71, 70, 74, TRUE
        );
    END IF;

    -- Player: Nehuén Pérez (nehuen-perez)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'nehuen-perez') THEN
        v_player_id := public.create_player_template_with_positions(
            'nehuen-perez',
            v_club_id,
            'Nehuén Pérez',
            '2000-06-24',
            'Argentina',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 13000000.00, 77,
            72, 38, 58, 60, 78, 79, TRUE
        );
    END IF;

    -- Player: Zé Pedro (ze-pedro)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'ze-pedro') THEN
        v_player_id := public.create_player_template_with_positions(
            'ze-pedro',
            v_club_id,
            'Zé Pedro',
            '1997-06-06',
            'Portugal',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 4000000.00, 73,
            64, 32, 54, 56, 74, 76, TRUE
        );
    END IF;

    -- Player: Tiago Djaló (tiago-djalo)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'tiago-djalo') THEN
        v_player_id := public.create_player_template_with_positions(
            'tiago-djalo',
            v_club_id,
            'Tiago Djaló',
            '2000-04-09',
            'Portugal',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 12000000.00, 76,
            80, 36, 60, 62, 77, 76, TRUE
        );
    END IF;

    -- Player: João Mário (joao-mario-porto)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'joao-mario-porto') THEN
        v_player_id := public.create_player_template_with_positions(
            'joao-mario-porto',
            v_club_id,
            'João Mário',
            '2000-01-03',
            'Portugal',
            'RB'::public.enum_player_position,
            ARRAY['RWB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 16000000.00, 77,
            82, 60, 73, 76, 73, 70, TRUE
        );
    END IF;

    -- Player: Martim Fernandes (martim-fernandes)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'martim-fernandes') THEN
        v_player_id := public.create_player_template_with_positions(
            'martim-fernandes',
            v_club_id,
            'Martim Fernandes',
            '2006-01-18',
            'Portugal',
            'RB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 6000000.00, 72,
            78, 48, 66, 72, 68, 64, TRUE
        );
    END IF;

    -- Player: Wendell (wendell-nacimento)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'wendell-nacimento') THEN
        v_player_id := public.create_player_template_with_positions(
            'wendell-nacimento',
            v_club_id,
            'Wendell',
            '1993-07-20',
            'Brazil',
            'LB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 5000000.00, 76,
            77, 58, 70, 74, 75, 72, TRUE
        );
    END IF;

    -- Player: Alan Varela (alan-varela)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'alan-varela') THEN
        v_player_id := public.create_player_template_with_positions(
            'alan-varela',
            v_club_id,
            'Alan Varela',
            '2001-07-04',
            'Argentina',
            'CDM'::public.enum_player_position,
            ARRAY['CM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 79,
            72, 62, 75, 76, 80, 79, TRUE
        );
    END IF;

    -- Player: Stephen Eustaquio (stephen-eustaquio)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'stephen-eustaquio') THEN
        v_player_id := public.create_player_template_with_positions(
            'stephen-eustaquio',
            v_club_id,
            'Stephen Eustaquio',
            '1996-12-21',
            'Canada',
            'CM'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 11000000.00, 77,
            70, 68, 76, 76, 74, 75, TRUE
        );
    END IF;

    -- Player: Nico González (nico-gonzalez-porto)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'nico-gonzalez-porto') THEN
        v_player_id := public.create_player_template_with_positions(
            'nico-gonzalez-porto',
            v_club_id,
            'Nico González',
            '2002-01-03',
            'Spain',
            'CM'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 18000000.00, 77,
            74, 68, 77, 78, 74, 78, TRUE
        );
    END IF;

    -- Player: Vasco Sousa (vasco-sousa)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'vasco-sousa') THEN
        v_player_id := public.create_player_template_with_positions(
            'vasco-sousa',
            v_club_id,
            'Vasco Sousa',
            '2003-04-03',
            'Portugal',
            'CM'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 7000000.00, 73,
            76, 64, 74, 76, 66, 68, TRUE
        );
    END IF;

    -- Player: Galeno (galeno)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'galeno') THEN
        v_player_id := public.create_player_template_with_positions(
            'galeno',
            v_club_id,
            'Galeno',
            '1997-10-22',
            'Brazil',
            'LM'::public.enum_player_position,
            ARRAY['LW'::public.enum_player_position, 'LB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 25000000.00, 80,
            91, 76, 72, 80, 54, 74, TRUE
        );
    END IF;

    -- Player: Pepê (pepe-aquino)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'pepe-aquino') THEN
        v_player_id := public.create_player_template_with_positions(
            'pepe-aquino',
            v_club_id,
            'Pepê',
            '1997-02-24',
            'Brazil',
            'RW'::public.enum_player_position,
            ARRAY['RM'::public.enum_player_position, 'LW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 30000000.00, 81,
            88, 74, 76, 83, 56, 70, TRUE
        );
    END IF;

    -- Player: Gonçalo Borges (goncalo-borges)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'goncalo-borges') THEN
        v_player_id := public.create_player_template_with_positions(
            'goncalo-borges',
            v_club_id,
            'Gonçalo Borges',
            '2001-03-29',
            'Portugal',
            'RW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 5000000.00, 73,
            83, 62, 68, 78, 30, 58, TRUE
        );
    END IF;

    -- Player: Samu Omorodion (samu-omorodion)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'samu-omorodion') THEN
        v_player_id := public.create_player_template_with_positions(
            'samu-omorodion',
            v_club_id,
            'Samu Omorodion',
            '2004-05-05',
            'Spain',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 77,
            85, 76, 60, 70, 32, 84, TRUE
        );
    END IF;

    -- Player: Danny Namaso (danny-namaso)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'danny-namaso') THEN
        v_player_id := public.create_player_template_with_positions(
            'danny-namaso',
            v_club_id,
            'Danny Namaso',
            '2000-08-28',
            'England',
            'ST'::public.enum_player_position,
            ARRAY['CF'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 6000000.00, 73,
            76, 72, 65, 74, 34, 74, TRUE
        );
    END IF;

    -- Player: Fran Navarro (fran-navarro)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'fran-navarro') THEN
        v_player_id := public.create_player_template_with_positions(
            'fran-navarro',
            v_club_id,
            'Fran Navarro',
            '1998-02-03',
            'Spain',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 6000000.00, 75,
            74, 76, 64, 72, 32, 74, TRUE
        );
    END IF;

    -- Player: Remko Pasveer (remko-pasveer)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'remko-pasveer') THEN
        v_player_id := public.create_player_template_with_positions(
            'remko-pasveer',
            v_club_id,
            'Remko Pasveer',
            '1983-11-08',
            'Netherlands',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 250000.00, 74,
            74, 73, 75, 72, 76, 73, TRUE
        );
    END IF;

    -- Player: Jay Gorter (jay-gorter)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jay-gorter') THEN
        v_player_id := public.create_player_template_with_positions(
            'jay-gorter',
            v_club_id,
            'Jay Gorter',
            '2000-05-18',
            'Netherlands',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 1500000.00, 71,
            72, 70, 72, 69, 71, 72, TRUE
        );
    END IF;

    -- Player: Josip Šutalo (josip-sutalo)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'josip-sutalo') THEN
        v_player_id := public.create_player_template_with_positions(
            'josip-sutalo',
            v_club_id,
            'Josip Šutalo',
            '2000-02-28',
            'Croatia',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 15000000.00, 77,
            74, 38, 62, 64, 78, 78, TRUE
        );
    END IF;

    -- Player: Ahmetcan Kaplan (ahmetcan-kaplan)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'ahmetcan-kaplan') THEN
        v_player_id := public.create_player_template_with_positions(
            'ahmetcan-kaplan',
            v_club_id,
            'Ahmetcan Kaplan',
            '2003-01-16',
            'Turkey',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 10000000.00, 74,
            68, 34, 58, 60, 75, 76, TRUE
        );
    END IF;

    -- Player: Jorrel Hato (jato-hato)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jato-hato') THEN
        v_player_id := public.create_player_template_with_positions(
            'jato-hato',
            v_club_id,
            'Jorrel Hato',
            '2006-03-07',
            'Netherlands',
            'LB'::public.enum_player_position,
            ARRAY['CB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 30000000.00, 76,
            80, 45, 70, 74, 76, 73, TRUE
        );
    END IF;

    -- Player: Devyne Rensch (devyne-rensch)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'devyne-rensch') THEN
        v_player_id := public.create_player_template_with_positions(
            'devyne-rensch',
            v_club_id,
            'Devyne Rensch',
            '2003-01-18',
            'Netherlands',
            'RB'::public.enum_player_position,
            ARRAY['LB'::public.enum_player_position, 'CB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 10000000.00, 75,
            76, 52, 70, 74, 74, 71, TRUE
        );
    END IF;

    -- Player: Anton Gaaei (anton-gaaei)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'anton-gaaei') THEN
        v_player_id := public.create_player_template_with_positions(
            'anton-gaaei',
            v_club_id,
            'Anton Gaaei',
            '2002-11-19',
            'Denmark',
            'RB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 3000000.00, 71,
            78, 50, 66, 70, 68, 70, TRUE
        );
    END IF;

    -- Player: Yuri Baas (yuri-baas)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'yuri-baas') THEN
        v_player_id := public.create_player_template_with_positions(
            'yuri-baas',
            v_club_id,
            'Yuri Baas',
            '2003-03-17',
            'Netherlands',
            'CB'::public.enum_player_position,
            ARRAY['LB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 3500000.00, 72,
            72, 42, 65, 68, 73, 71, TRUE
        );
    END IF;

    -- Player: Jordan Henderson (jordan-henderson)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jordan-henderson') THEN
        v_player_id := public.create_player_template_with_positions(
            'jordan-henderson',
            v_club_id,
            'Jordan Henderson',
            '1990-06-17',
            'England',
            'CDM'::public.enum_player_position,
            ARRAY['CM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 4000000.00, 78,
            60, 64, 78, 75, 78, 76, TRUE
        );
    END IF;

    -- Player: Kenneth Taylor (kenneth-taylor)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'kenneth-taylor') THEN
        v_player_id := public.create_player_template_with_positions(
            'kenneth-taylor',
            v_club_id,
            'Kenneth Taylor',
            '2002-05-16',
            'Netherlands',
            'CM'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 15000000.00, 76,
            74, 71, 76, 77, 71, 72, TRUE
        );
    END IF;

    -- Player: Kian Fitz-Jim (kian-fitz-jim)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'kian-fitz-jim') THEN
        v_player_id := public.create_player_template_with_positions(
            'kian-fitz-jim',
            v_club_id,
            'Kian Fitz-Jim',
            '2003-07-05',
            'Netherlands',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 4000000.00, 72,
            74, 62, 74, 76, 66, 64, TRUE
        );
    END IF;

    -- Player: Branko van den Boomen (branko-van-den-boomen)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'branko-van-den-boomen') THEN
        v_player_id := public.create_player_template_with_positions(
            'branko-van-den-boomen',
            v_club_id,
            'Branko van den Boomen',
            '1995-06-21',
            'Netherlands',
            'CM'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 6000000.00, 75,
            52, 73, 82, 75, 68, 72, TRUE
        );
    END IF;

    -- Player: Benjamin Tahirović (benjamin-tahirovic)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'benjamin-tahirovic') THEN
        v_player_id := public.create_player_template_with_positions(
            'benjamin-tahirovic',
            v_club_id,
            'Benjamin Tahirović',
            '2003-03-03',
            'Bosnia and Herzegovina',
            'CDM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 5000000.00, 73,
            66, 60, 72, 73, 73, 76, TRUE
        );
    END IF;

    -- Player: Steven Berghuis (steven-berghuis)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'steven-berghuis') THEN
        v_player_id := public.create_player_template_with_positions(
            'steven-berghuis',
            v_club_id,
            'Steven Berghuis',
            '1991-12-19',
            'Netherlands',
            'RW'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 6000000.00, 79,
            70, 79, 84, 82, 50, 64, TRUE
        );
    END IF;

    -- Player: Mika Godts (mika-godts)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'mika-godts') THEN
        v_player_id := public.create_player_template_with_positions(
            'mika-godts',
            v_club_id,
            'Mika Godts',
            '2005-06-07',
            'Belgium',
            'LW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 8000000.00, 73,
            82, 66, 68, 78, 30, 54, TRUE
        );
    END IF;

    -- Player: Chuba Akpom (chuba-akpom)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'chuba-akpom') THEN
        v_player_id := public.create_player_template_with_positions(
            'chuba-akpom',
            v_club_id,
            'Chuba Akpom',
            '1995-10-09',
            'England',
            'ST'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 8000000.00, 75,
            78, 75, 64, 72, 38, 78, TRUE
        );
    END IF;

    -- Player: Wout Weghorst (wout-weghorst)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'wout-weghorst') THEN
        v_player_id := public.create_player_template_with_positions(
            'wout-weghorst',
            v_club_id,
            'Wout Weghorst',
            '1992-08-07',
            'Netherlands',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 6000000.00, 77,
            54, 79, 62, 68, 42, 86, TRUE
        );
    END IF;

    -- Player: Brian Brobbey (brian-brobbey)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'brian-brobbey') THEN
        v_player_id := public.create_player_template_with_positions(
            'brian-brobbey',
            v_club_id,
            'Brian Brobbey',
            '2002-02-01',
            'Netherlands',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 79,
            84, 78, 64, 75, 34, 88, TRUE
        );
    END IF;

END $$;

COMMIT;
