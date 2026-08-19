-- Reproducible Phase 4E & 4H Seed Data generated on 2026-08-19T09:09:49.136Z
-- Snapshot Date: 2026-08-19
-- Total Clubs: 20, Total Players: 567, Total Legends: 60

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
    1449000000.00,
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
    1278100000.00,
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
    680500000.00,
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
    1410800000.00,
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
    999500000.00,
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
    1406500000.00,
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
    987700000.00,
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
    874300000.00,
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
    794500000.00,
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
    1077500000.00,
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
    529200000.00,
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
    493950000.00,
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
    1477300000.00,
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
    711800000.00,
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
    557200000.00,
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
    582700000.00,
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
    427650000.00,
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
    345550000.00,
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
    466300000.00,
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
    200900000.00,
    TRUE
) ON CONFLICT (club_template_id, version) DO NOTHING;

-- 2. Seed Player Templates, Positions, and Relational Attribute Versions (v1)
DO $$
DECLARE
    v_club_id UUID;
    v_player_id UUID;
BEGIN
    -- Player: Arda Güler (arda-guler)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'real-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'arda-guler') THEN
        v_player_id := public.create_player_template_with_positions(
            'arda-guler',
            v_club_id,
            'Arda Güler',
            '2005-02-25',
            'Türkiye',
            'CAM'::public.enum_player_position,
            ARRAY['RW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 90000000.00, 78,
            74, 74, 80, 82, 52, 60, TRUE
        );
    END IF;

    -- Player: Bernardo Silva (bernardo-silva)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'real-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'bernardo-silva') THEN
        v_player_id := public.create_player_template_with_positions(
            'bernardo-silva',
            v_club_id,
            'Bernardo Silva',
            '1994-08-10',
            'Portugal',
            'CAM'::public.enum_player_position,
            ARRAY['RW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 22000000.00, 88,
            76, 78, 86, 92, 69, 70, TRUE
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
            v_player_id, 1, 160000000.00, 90,
            80, 87, 83, 88, 78, 84, TRUE
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
            v_player_id, 1, 6000000.00, 87,
            82, 54, 71, 66, 86, 86, TRUE
        );
    END IF;

    -- Player: Dean Huijsen (dean-huijsen)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'real-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'dean-huijsen') THEN
        v_player_id := public.create_player_template_with_positions(
            'dean-huijsen',
            v_club_id,
            'Dean Huijsen',
            '2005-04-14',
            'Spain',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 60000000.00, 80,
            72, 46, 58, 60, 81, 82, TRUE
        );
    END IF;

    -- Player: Ibrahima Konaté (ibrahima-konate)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'real-madrid';
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

    -- Player: Raúl Asencio (raul-asencio)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'real-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'raul-asencio') THEN
        v_player_id := public.create_player_template_with_positions(
            'raul-asencio',
            v_club_id,
            'Raúl Asencio',
            '2003-02-13',
            'Spain',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 76,
            68, 42, 54, 56, 77, 78, TRUE
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
            v_player_id, 1, 20000000.00, 85,
            83, 50, 70, 71, 85, 82, TRUE
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
            v_player_id, 1, 70000000.00, 86,
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
            v_player_id, 1, 50000000.00, 84,
            81, 67, 80, 83, 80, 80, TRUE
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
            v_player_id, 1, 90000000.00, 88,
            88, 82, 84, 84, 80, 84, TRUE
        );
    END IF;

    -- Player: Thiago Pitarch (thiago-pitarch)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'real-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'thiago-pitarch') THEN
        v_player_id := public.create_player_template_with_positions(
            'thiago-pitarch',
            v_club_id,
            'Thiago Pitarch',
            '2007-08-03',
            'Spain',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 73,
            71, 63, 74, 73, 65, 69, TRUE
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
            v_player_id, 1, 12000000.00, 81,
            82, 79, 80, 78, 74, 81, TRUE
        );
    END IF;

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
            v_player_id, 1, 15000000.00, 89,
            90, 88, 89, 88, 75, 89, TRUE
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
            v_player_id, 1, 4000000.00, 83,
            88, 63, 75, 78, 81, 84, TRUE
        );
    END IF;

    -- Player: Marc Cucurella (marc-cucurella)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'real-madrid';
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
            v_player_id, 1, 60000000.00, 80,
            78, 62, 75, 78, 78, 76, TRUE
        );
    END IF;

    -- Player: Álvaro Carreras (alvaro-carreras)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'real-madrid';
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
            v_player_id, 1, 50000000.00, 75,
            78, 52, 70, 74, 72, 70, TRUE
        );
    END IF;

    -- Player: Vinicius Junior (vinicius-junior)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'real-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'vinicius-junior') THEN
        v_player_id := public.create_player_template_with_positions(
            'vinicius-junior',
            v_club_id,
            'Vinicius Junior',
            '2000-07-12',
            'Brazil',
            'LW'::public.enum_player_position,
            ARRAY['ST'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 140000000.00, 90,
            95, 84, 81, 91, 29, 69, TRUE
        );
    END IF;

    -- Player: Denzel Dumfries (denzel-dumfries)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'real-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'denzel-dumfries') THEN
        v_player_id := public.create_player_template_with_positions(
            'denzel-dumfries',
            v_club_id,
            'Denzel Dumfries',
            '1996-04-18',
            'Netherlands',
            'RB'::public.enum_player_position,
            ARRAY['RM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 25000000.00, 82,
            83, 66, 74, 76, 78, 86, TRUE
        );
    END IF;

    -- Player: Trent Alexander-Arnold (trent-alexander-arnold)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'real-madrid';
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
            v_player_id, 1, 60000000.00, 86,
            76, 71, 90, 80, 80, 73, TRUE
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
            'RW'::public.enum_player_position,
            ARRAY['RW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 82,
            82, 75, 78, 85, 31, 54, TRUE
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
            v_player_id, 1, 45000000.00, 86,
            88, 81, 79, 87, 32, 62, TRUE
        );
    END IF;

    -- Player: Yan Diomande (yan-diomande)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'real-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'yan-diomande') THEN
        v_player_id := public.create_player_template_with_positions(
            'yan-diomande',
            v_club_id,
            'Yan Diomande',
            '2006-11-14',
            'Cote d''Ivoire',
            'RW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 90000000.00, 79,
            86, 78, 74, 82, 34, 64, TRUE
        );
    END IF;

    -- Player: Carlos Espí (carlos-espi)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'real-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'carlos-espi') THEN
        v_player_id := public.create_player_template_with_positions(
            'carlos-espi',
            v_club_id,
            'Carlos Espí',
            '2005-07-24',
            'Spain',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 76,
            78, 79, 63, 73, 31, 77, TRUE
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
            v_player_id, 1, 40000000.00, 77,
            86, 77, 62, 79, 30, 76, TRUE
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
            v_player_id, 1, 200000000.00, 91,
            97, 90, 80, 92, 36, 78, TRUE
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
            'CAM'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 100000000.00, 79,
            78, 76, 78, 80, 64, 70, TRUE
        );
    END IF;

    -- Player: Toni Fernández (toni-fernandez)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'barcelona';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'toni-fernandez') THEN
        v_player_id := public.create_player_template_with_positions(
            'toni-fernandez',
            v_club_id,
            'Toni Fernández',
            '2008-07-15',
            'Spain',
            'CAM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 3000000.00, 66,
            68, 64, 67, 68, 36, 54, TRUE
        );
    END IF;

    -- Player: Andreas Christensen (andreas-christensen)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'barcelona';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'andreas-christensen') THEN
        v_player_id := public.create_player_template_with_positions(
            'andreas-christensen',
            v_club_id,
            'Andreas Christensen',
            '1996-04-10',
            'Denmark',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 8000000.00, 73,
            65, 39, 51, 53, 74, 75, TRUE
        );
    END IF;

    -- Player: Eric García (eric-garcia)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'barcelona';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'eric-garcia') THEN
        v_player_id := public.create_player_template_with_positions(
            'eric-garcia',
            v_club_id,
            'Eric García',
            '2001-01-09',
            'Spain',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 40000000.00, 79,
            71, 45, 57, 59, 80, 81, TRUE
        );
    END IF;

    -- Player: Gerard Martín (gerard-martin)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'barcelona';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'gerard-martin') THEN
        v_player_id := public.create_player_template_with_positions(
            'gerard-martin',
            v_club_id,
            'Gerard Martín',
            '2002-02-26',
            'Spain',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 78,
            70, 44, 56, 58, 79, 80, TRUE
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
            v_player_id, 1, 100000000.00, 79,
            71, 40, 78, 72, 80, 72, TRUE
        );
    END IF;

    -- Player: Álvaro Cortés (alvaro-cortes)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'barcelona';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'alvaro-cortes') THEN
        v_player_id := public.create_player_template_with_positions(
            'alvaro-cortes',
            v_club_id,
            'Álvaro Cortés',
            '2005-03-17',
            'Spain',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 4000000.00, 70,
            62, 36, 48, 50, 71, 72, TRUE
        );
    END IF;

    -- Player: Marc Bernal (marc-bernal)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'barcelona';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'marc-bernal') THEN
        v_player_id := public.create_player_template_with_positions(
            'marc-bernal',
            v_club_id,
            'Marc Bernal',
            '2007-05-26',
            'Spain',
            'CDM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 30000000.00, 75,
            71, 57, 70, 68, 75, 76, TRUE
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
            v_player_id, 1, 18000000.00, 75,
            72, 58, 75, 74, 75, 73, TRUE
        );
    END IF;

    -- Player: Rodri (rodri)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'barcelona';
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
            v_player_id, 1, 55000000.00, 91,
            66, 75, 86, 81, 87, 85, TRUE
        );
    END IF;

    -- Player: Tommy Marqués (tommy-marques)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'barcelona';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'tommy-marques') THEN
        v_player_id := public.create_player_template_with_positions(
            'tommy-marques',
            v_club_id,
            'Tommy Marqués',
            '2006-10-30',
            'Spain',
            'CDM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 3000000.00, 66,
            62, 48, 61, 59, 66, 67, TRUE
        );
    END IF;

    -- Player: Brian Fariñas (brian-farinas)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'barcelona';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'brian-farinas') THEN
        v_player_id := public.create_player_template_with_positions(
            'brian-farinas',
            v_club_id,
            'Brian Fariñas',
            '2006-02-09',
            'Spain',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 2500000.00, 66,
            64, 56, 67, 66, 58, 62, TRUE
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
            v_player_id, 1, 35000000.00, 87,
            82, 69, 86, 87, 77, 78, TRUE
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
            v_player_id, 1, 30000000.00, 83,
            76, 66, 79, 84, 75, 78, TRUE
        );
    END IF;

    -- Player: Guille Fernández (guille-fernandez)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'barcelona';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'guille-fernandez') THEN
        v_player_id := public.create_player_template_with_positions(
            'guille-fernandez',
            v_club_id,
            'Guille Fernández',
            '2008-06-18',
            'Spain',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 3000000.00, 66,
            64, 56, 67, 66, 58, 62, TRUE
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
            v_player_id, 1, 150000000.00, 86,
            78, 68, 86, 88, 68, 64, TRUE
        );
    END IF;

    -- Player: Joan García (joan-garcia)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'barcelona';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'joan-garcia') THEN
        v_player_id := public.create_player_template_with_positions(
            'joan-garcia',
            v_club_id,
            'Joan García',
            '2001-05-04',
            'Spain',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 45000000.00, 78,
            79, 76, 78, 77, 73, 78, TRUE
        );
    END IF;

    -- Player: Wojciech Szczesny (wojciech-szczesny)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'barcelona';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'wojciech-szczesny') THEN
        v_player_id := public.create_player_template_with_positions(
            'wojciech-szczesny',
            v_club_id,
            'Wojciech Szczesny',
            '1990-04-18',
            'Poland',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 800000.00, 64,
            65, 62, 64, 63, 59, 64, TRUE
        );
    END IF;

    -- Player: Áron Yaakobishvili (aron-yaakobishvili)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'barcelona';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'aron-yaakobishvili') THEN
        v_player_id := public.create_player_template_with_positions(
            'aron-yaakobishvili',
            v_club_id,
            'Áron Yaakobishvili',
            '2006-03-06',
            'Hungary',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 3000000.00, 65,
            66, 63, 65, 64, 60, 65, TRUE
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
            v_player_id, 1, 50000000.00, 81,
            91, 51, 73, 79, 76, 68, TRUE
        );
    END IF;

    -- Player: Anthony Gordon (anthony-gordon)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'barcelona';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'anthony-gordon') THEN
        v_player_id := public.create_player_template_with_positions(
            'anthony-gordon',
            v_club_id,
            'Anthony Gordon',
            '2001-02-24',
            'England',
            'LW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 80000000.00, 81,
            88, 80, 76, 84, 36, 66, TRUE
        );
    END IF;

    -- Player: Jesse Bisiwu (jesse-bisiwu)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'barcelona';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jesse-bisiwu') THEN
        v_player_id := public.create_player_template_with_positions(
            'jesse-bisiwu',
            v_club_id,
            'Jesse Bisiwu',
            '2008-01-22',
            'Belgium',
            'LW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 800000.00, 61,
            68, 60, 56, 64, 16, 46, TRUE
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
            'LW'::public.enum_player_position,
            ARRAY['LW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 70000000.00, 84,
            91, 80, 80, 85, 50, 73, TRUE
        );
    END IF;

    -- Player: Héctor Fort (hector-fort)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'barcelona';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'hector-fort') THEN
        v_player_id := public.create_player_template_with_positions(
            'hector-fort',
            v_club_id,
            'Héctor Fort',
            '2006-08-02',
            'Spain',
            'RB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 12000000.00, 71,
            74, 46, 61, 64, 69, 70, TRUE
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
            v_player_id, 1, 60000000.00, 85,
            82, 45, 74, 76, 85, 78, TRUE
        );
    END IF;

    -- Player: Xavi Espart (xavi-espart)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'barcelona';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'xavi-espart') THEN
        v_player_id := public.create_player_template_with_positions(
            'xavi-espart',
            v_club_id,
            'Xavi Espart',
            '2007-05-21',
            'Spain',
            'RB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 5000000.00, 68,
            71, 43, 58, 61, 66, 67, TRUE
        );
    END IF;

    -- Player: Karim Adeyemi (karim-adeyemi)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'barcelona';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'karim-adeyemi') THEN
        v_player_id := public.create_player_template_with_positions(
            'karim-adeyemi',
            v_club_id,
            'Karim Adeyemi',
            '2002-01-18',
            'Germany',
            'RW'::public.enum_player_position,
            ARRAY['ST'::public.enum_player_position, 'RW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 40000000.00, 79,
            94, 75, 68, 80, 36, 68, TRUE
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
            v_player_id, 1, 220000000.00, 83,
            88, 77, 81, 88, 26, 52, TRUE
        );
    END IF;

    -- Player: Roony Bardghji (roony-bardghji)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'barcelona';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'roony-bardghji') THEN
        v_player_id := public.create_player_template_with_positions(
            'roony-bardghji',
            v_club_id,
            'Roony Bardghji',
            '2005-11-15',
            'Sweden',
            'RW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 15000000.00, 72,
            79, 71, 67, 75, 27, 57, TRUE
        );
    END IF;

    -- Player: Kang-in Lee (kang-in-lee)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'atletico-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'kang-in-lee') THEN
        v_player_id := public.create_player_template_with_positions(
            'kang-in-lee',
            v_club_id,
            'Kang-in Lee',
            '2001-02-19',
            'Korea, South',
            'CAM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 28000000.00, 77,
            79, 75, 78, 79, 47, 65, TRUE
        );
    END IF;

    -- Player: Thomas Lemar (thomas-lemar)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'atletico-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'thomas-lemar') THEN
        v_player_id := public.create_player_template_with_positions(
            'thomas-lemar',
            v_club_id,
            'Thomas Lemar',
            '1995-11-12',
            'France',
            'CAM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 1800000.00, 67,
            69, 65, 68, 69, 37, 55, TRUE
        );
    END IF;

    -- Player: Cristian Romero (cristian-romero)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'atletico-madrid';
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
            v_player_id, 1, 50000000.00, 84,
            76, 46, 62, 65, 85, 84, TRUE
        );
    END IF;

    -- Player: Dávid Hancko (david-hancko)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'atletico-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'david-hancko') THEN
        v_player_id := public.create_player_template_with_positions(
            'david-hancko',
            v_club_id,
            'Dávid Hancko',
            '1997-12-13',
            'Slovakia',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 78,
            70, 44, 56, 58, 79, 80, TRUE
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
            v_player_id, 1, 9000000.00, 83,
            72, 45, 58, 60, 84, 83, TRUE
        );
    END IF;

    -- Player: Marc Pubill (marc-pubill)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'atletico-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'marc-pubill') THEN
        v_player_id := public.create_player_template_with_positions(
            'marc-pubill',
            v_club_id,
            'Marc Pubill',
            '2003-06-20',
            'Spain',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 78,
            70, 44, 56, 58, 79, 80, TRUE
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
            v_player_id, 1, 20000000.00, 82,
            70, 40, 62, 64, 83, 81, TRUE
        );
    END IF;

    -- Player: Morten Hjulmand (morten-hjulmand)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'atletico-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'morten-hjulmand') THEN
        v_player_id := public.create_player_template_with_positions(
            'morten-hjulmand',
            v_club_id,
            'Morten Hjulmand',
            '1999-06-25',
            'Denmark',
            'CDM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 45000000.00, 79,
            75, 61, 74, 72, 79, 80, TRUE
        );
    END IF;

    -- Player: Johnny Cardoso (johnny-cardoso)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'atletico-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'johnny-cardoso') THEN
        v_player_id := public.create_player_template_with_positions(
            'johnny-cardoso',
            v_club_id,
            'Johnny Cardoso',
            '2001-09-20',
            'United States',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 76,
            74, 66, 77, 76, 68, 72, TRUE
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
            v_player_id, 1, 5000000.00, 82,
            64, 72, 84, 78, 77, 76, TRUE
        );
    END IF;

    -- Player: Obed Vargas (obed-vargas)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'atletico-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'obed-vargas') THEN
        v_player_id := public.create_player_template_with_positions(
            'obed-vargas',
            v_club_id,
            'Obed Vargas',
            '2005-08-05',
            'Mexico',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 10000000.00, 74,
            72, 64, 75, 74, 66, 70, TRUE
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
            v_player_id, 1, 55000000.00, 77,
            75, 67, 77, 78, 72, 73, TRUE
        );
    END IF;

    -- Player: Rodrigo Mendoza (rodrigo-mendoza)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'atletico-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'rodrigo-mendoza') THEN
        v_player_id := public.create_player_template_with_positions(
            'rodrigo-mendoza',
            v_club_id,
            'Rodrigo Mendoza',
            '2005-03-15',
            'Spain',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 76,
            74, 66, 77, 76, 68, 72, TRUE
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
            v_player_id, 1, 15000000.00, 88,
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
            v_player_id, 1, 3000000.00, 76,
            78, 74, 76, 75, 71, 77, TRUE
        );
    END IF;

    -- Player: Alejandro Grimaldo (alejandro-grimaldo)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'atletico-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'alejandro-grimaldo') THEN
        v_player_id := public.create_player_template_with_positions(
            'alejandro-grimaldo',
            v_club_id,
            'Alejandro Grimaldo',
            '1995-09-20',
            'Spain',
            'LB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 76,
            79, 51, 66, 69, 74, 75, TRUE
        );
    END IF;

    -- Player: Matteo Ruggeri (matteo-ruggeri)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'atletico-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'matteo-ruggeri') THEN
        v_player_id := public.create_player_template_with_positions(
            'matteo-ruggeri',
            v_club_id,
            'Matteo Ruggeri',
            '2002-07-11',
            'Italy',
            'LB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 28000000.00, 77,
            80, 52, 67, 70, 75, 76, TRUE
        );
    END IF;

    -- Player: Ademola Lookman (ademola-lookman)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'atletico-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'ademola-lookman') THEN
        v_player_id := public.create_player_template_with_positions(
            'ademola-lookman',
            v_club_id,
            'Ademola Lookman',
            '1997-10-20',
            'Nigeria',
            'LW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 40000000.00, 79,
            86, 78, 74, 82, 34, 64, TRUE
        );
    END IF;

    -- Player: Arnau Ortiz (arnau-ortiz)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'atletico-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'arnau-ortiz') THEN
        v_player_id := public.create_player_template_with_positions(
            'arnau-ortiz',
            v_club_id,
            'Arnau Ortiz',
            '2001-10-29',
            'Spain',
            'LW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 1200000.00, 66,
            73, 65, 61, 69, 21, 51, TRUE
        );
    END IF;

    -- Player: Carlos Martín (carlos-martin)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'atletico-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'carlos-martin') THEN
        v_player_id := public.create_player_template_with_positions(
            'carlos-martin',
            v_club_id,
            'Carlos Martín',
            '2002-04-22',
            'Spain',
            'LW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 1500000.00, 67,
            74, 66, 62, 70, 22, 52, TRUE
        );
    END IF;

    -- Player: Álex Baena (alex-baena)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'atletico-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'alex-baena') THEN
        v_player_id := public.create_player_template_with_positions(
            'alex-baena',
            v_club_id,
            'Álex Baena',
            '2001-07-20',
            'Spain',
            'LW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 40000000.00, 79,
            86, 78, 74, 82, 34, 64, TRUE
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
            'RB'::public.enum_player_position,
            ARRAY['RB'::public.enum_player_position, 'CM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 84,
            89, 78, 79, 81, 78, 82, TRUE
        );
    END IF;

    -- Player: Giuliano Simeone (giuliano-simeone)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'atletico-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'giuliano-simeone') THEN
        v_player_id := public.create_player_template_with_positions(
            'giuliano-simeone',
            v_club_id,
            'Giuliano Simeone',
            '2002-12-18',
            'Argentina',
            'RW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 40000000.00, 79,
            86, 78, 74, 82, 34, 64, TRUE
        );
    END IF;

    -- Player: Alexander Sørloth (alexander-srloth)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'atletico-madrid';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'alexander-srloth') THEN
        v_player_id := public.create_player_template_with_positions(
            'alexander-srloth',
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
            v_player_id, 1, 18000000.00, 81,
            76, 82, 68, 73, 38, 85, TRUE
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
            v_player_id, 1, 120000000.00, 84,
            84, 85, 78, 83, 50, 77, TRUE
        );
    END IF;

    -- Player: Claudio Echeverri (claudio-echeverri)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'claudio-echeverri') THEN
        v_player_id := public.create_player_template_with_positions(
            'claudio-echeverri',
            v_club_id,
            'Claudio Echeverri',
            '2006-01-02',
            'Argentina',
            'CAM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 15000000.00, 72,
            74, 70, 73, 74, 42, 60, TRUE
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
            v_player_id, 1, 70000000.00, 88,
            85, 85, 86, 89, 56, 63, TRUE
        );
    END IF;

    -- Player: Rayan Cherki (rayan-cherki)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'rayan-cherki') THEN
        v_player_id := public.create_player_template_with_positions(
            'rayan-cherki',
            v_club_id,
            'Rayan Cherki',
            '2003-08-17',
            'France',
            'CAM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 90000000.00, 82,
            84, 80, 83, 84, 52, 70, TRUE
        );
    END IF;

    -- Player: Abdukodir Khusanov (abdukodir-khusanov)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'abdukodir-khusanov') THEN
        v_player_id := public.create_player_template_with_positions(
            'abdukodir-khusanov',
            v_club_id,
            'Abdukodir Khusanov',
            '2004-02-29',
            'Uzbekistan',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 50000000.00, 80,
            72, 46, 58, 60, 81, 82, TRUE
        );
    END IF;

    -- Player: Josko Gvardiol (josko-gvardiol)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'josko-gvardiol') THEN
        v_player_id := public.create_player_template_with_positions(
            'josko-gvardiol',
            v_club_id,
            'Josko Gvardiol',
            '2002-01-23',
            'Croatia',
            'CB'::public.enum_player_position,
            ARRAY['CB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 70000000.00, 83,
            78, 60, 74, 77, 84, 83, TRUE
        );
    END IF;

    -- Player: Juma Bah (juma-bah)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'juma-bah') THEN
        v_player_id := public.create_player_template_with_positions(
            'juma-bah',
            v_club_id,
            'Juma Bah',
            '2006-04-11',
            'Sierra Leone',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 10000000.00, 71,
            63, 37, 49, 51, 72, 73, TRUE
        );
    END IF;

    -- Player: Marc Guéhi (marc-guehi)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'marc-guehi') THEN
        v_player_id := public.create_player_template_with_positions(
            'marc-guehi',
            v_club_id,
            'Marc Guéhi',
            '2000-07-13',
            'England',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 70000000.00, 81,
            73, 47, 59, 61, 82, 83, TRUE
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
            v_player_id, 1, 55000000.00, 88,
            64, 39, 70, 69, 89, 87, TRUE
        );
    END IF;

    -- Player: Vitor Reis (vitor-reis)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'vitor-reis') THEN
        v_player_id := public.create_player_template_with_positions(
            'vitor-reis',
            v_club_id,
            'Vitor Reis',
            '2006-01-12',
            'Brazil',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 30000000.00, 75,
            67, 41, 53, 55, 76, 77, TRUE
        );
    END IF;

    -- Player: Nico González (nico-gonzalez-manchester-city)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'nico-gonzalez-manchester-city') THEN
        v_player_id := public.create_player_template_with_positions(
            'nico-gonzalez-manchester-city',
            v_club_id,
            'Nico González',
            '2002-01-03',
            'Spain',
            'CDM'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 40000000.00, 77,
            74, 68, 77, 78, 74, 78, TRUE
        );
    END IF;

    -- Player: Elliot Anderson (elliot-anderson)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'elliot-anderson') THEN
        v_player_id := public.create_player_template_with_positions(
            'elliot-anderson',
            v_club_id,
            'Elliot Anderson',
            '2002-11-06',
            'England',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 110000000.00, 82,
            80, 72, 83, 82, 74, 78, TRUE
        );
    END IF;

    -- Player: Mateo Kovacic (mateo-kovacic)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'mateo-kovacic') THEN
        v_player_id := public.create_player_template_with_positions(
            'mateo-kovacic',
            v_club_id,
            'Mateo Kovacic',
            '1994-05-06',
            'Croatia',
            'CM'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 10000000.00, 82,
            74, 69, 83, 86, 73, 71, TRUE
        );
    END IF;

    -- Player: Tijjani Reijnders (tijjani-reijnders)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
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
            v_player_id, 1, 50000000.00, 82,
            79, 74, 81, 83, 73, 76, TRUE
        );
    END IF;

    -- Player: Gerónimo Rulli (geronimo-rulli)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'geronimo-rulli') THEN
        v_player_id := public.create_player_template_with_positions(
            'geronimo-rulli',
            v_club_id,
            'Gerónimo Rulli',
            '1992-05-20',
            'Argentina',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 6000000.00, 72,
            73, 70, 72, 71, 67, 72, TRUE
        );
    END IF;

    -- Player: Gianluigi Donnarumma (gianluigi-donnarumma)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
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
            v_player_id, 1, 45000000.00, 89,
            90, 85, 88, 87, 76, 89, TRUE
        );
    END IF;

    -- Player: Marcus Bettinelli (marcus-bettinelli)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'marcus-bettinelli') THEN
        v_player_id := public.create_player_template_with_positions(
            'marcus-bettinelli',
            v_club_id,
            'Marcus Bettinelli',
            '1992-05-24',
            'England',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 300000.00, 77,
            78, 76, 77, 75, 73, 76, TRUE
        );
    END IF;

    -- Player: Josh Wilson-Esbrand (josh-wilson-esbrand)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'josh-wilson-esbrand') THEN
        v_player_id := public.create_player_template_with_positions(
            'josh-wilson-esbrand',
            v_club_id,
            'Josh Wilson-Esbrand',
            '2002-12-26',
            'England',
            'LB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 2500000.00, 68,
            71, 43, 58, 61, 66, 67, TRUE
        );
    END IF;

    -- Player: Nico O'Reilly (nico-o-reilly)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'nico-o-reilly') THEN
        v_player_id := public.create_player_template_with_positions(
            'nico-o-reilly',
            v_club_id,
            'Nico O''Reilly',
            '2005-03-21',
            'England',
            'LB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 70000000.00, 81,
            84, 56, 71, 74, 79, 80, TRUE
        );
    END IF;

    -- Player: Rayan Aït-Nouri (rayan-ait-nouri)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'rayan-ait-nouri') THEN
        v_player_id := public.create_player_template_with_positions(
            'rayan-ait-nouri',
            v_club_id,
            'Rayan Aït-Nouri',
            '2001-06-06',
            'Algeria',
            'LB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 40000000.00, 79,
            82, 54, 69, 72, 77, 78, TRUE
        );
    END IF;

    -- Player: Jack Grealish (jack-grealish)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jack-grealish') THEN
        v_player_id := public.create_player_template_with_positions(
            'jack-grealish',
            v_club_id,
            'Jack Grealish',
            '1995-09-10',
            'England',
            'LW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 76,
            83, 75, 71, 79, 31, 61, TRUE
        );
    END IF;

    -- Player: Jeremy Monga (jeremy-monga)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jeremy-monga') THEN
        v_player_id := public.create_player_template_with_positions(
            'jeremy-monga',
            v_club_id,
            'Jeremy Monga',
            '2009-07-10',
            'England',
            'LW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 15000000.00, 72,
            79, 71, 67, 75, 27, 57, TRUE
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
            v_player_id, 1, 75000000.00, 81,
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
            'LW'::public.enum_player_position,
            ARRAY['LW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 80,
            88, 72, 75, 85, 32, 58, TRUE
        );
    END IF;

    -- Player: Issa Kaboré (issa-kabore)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'issa-kabore') THEN
        v_player_id := public.create_player_template_with_positions(
            'issa-kabore',
            v_club_id,
            'Issa Kaboré',
            '2001-05-12',
            'Burkina Faso',
            'RB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 4000000.00, 70,
            73, 45, 60, 63, 68, 69, TRUE
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
            'RB'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 50000000.00, 78,
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
            v_player_id, 1, 28000000.00, 77,
            78, 58, 77, 79, 74, 62, TRUE
        );
    END IF;

    -- Player: Antoine Semenyo (antoine-semenyo)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'antoine-semenyo') THEN
        v_player_id := public.create_player_template_with_positions(
            'antoine-semenyo',
            v_club_id,
            'Antoine Semenyo',
            '2000-01-07',
            'Ghana',
            'RW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 80000000.00, 81,
            88, 80, 76, 84, 36, 66, TRUE
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
            v_player_id, 1, 220000000.00, 91,
            89, 93, 70, 80, 45, 88, TRUE
        );
    END IF;

    -- Player: Omar Marmoush (omar-marmoush)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-city';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'omar-marmoush') THEN
        v_player_id := public.create_player_template_with_positions(
            'omar-marmoush',
            v_club_id,
            'Omar Marmoush',
            '1999-02-07',
            'Egypt',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 50000000.00, 80,
            82, 83, 67, 77, 35, 81, TRUE
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
            'CAM'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 100000000.00, 82,
            82, 82, 83, 82, 64, 76, TRUE
        );
    END IF;

    -- Player: Florian Wirtz (florian-wirtz)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
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
            v_player_id, 1, 100000000.00, 88,
            81, 81, 87, 89, 54, 66, TRUE
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
            v_player_id, 1, 20000000.00, 78,
            76, 72, 80, 82, 48, 58, TRUE
        );
    END IF;

    -- Player: Giovanni Leoni (giovanni-leoni)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'giovanni-leoni') THEN
        v_player_id := public.create_player_template_with_positions(
            'giovanni-leoni',
            v_club_id,
            'Giovanni Leoni',
            '2006-12-21',
            'Italy',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 25000000.00, 74,
            66, 40, 52, 54, 75, 76, TRUE
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
            v_player_id, 1, 13000000.00, 79,
            81, 30, 68, 72, 80, 77, TRUE
        );
    END IF;

    -- Player: Jérémy Jacquet (jeremy-jacquet)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jeremy-jacquet') THEN
        v_player_id := public.create_player_template_with_positions(
            'jeremy-jacquet',
            v_club_id,
            'Jérémy Jacquet',
            '2005-07-13',
            'France',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 55000000.00, 80,
            72, 46, 58, 60, 81, 82, TRUE
        );
    END IF;

    -- Player: Ronald Araujo (ronald-araujo)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'ronald-araujo') THEN
        v_player_id := public.create_player_template_with_positions(
            'ronald-araujo',
            v_club_id,
            'Ronald Araujo',
            '1999-03-07',
            'Uruguay',
            'CB'::public.enum_player_position,
            ARRAY['RB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 86,
            80, 46, 65, 64, 86, 84, TRUE
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
            v_player_id, 1, 15000000.00, 89,
            78, 60, 71, 72, 89, 86, TRUE
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
            'CDM'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 80000000.00, 79,
            78, 68, 78, 82, 72, 77, TRUE
        );
    END IF;

    -- Player: Stefan Bajcetic (stefan-bajcetic)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'stefan-bajcetic') THEN
        v_player_id := public.create_player_template_with_positions(
            'stefan-bajcetic',
            v_club_id,
            'Stefan Bajcetic',
            '2004-10-22',
            'Spain',
            'CDM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 4000000.00, 70,
            66, 52, 65, 63, 70, 71, TRUE
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
            v_player_id, 1, 4000000.00, 80,
            64, 61, 73, 73, 81, 80, TRUE
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
            v_player_id, 1, 70000000.00, 86,
            72, 79, 84, 84, 77, 76, TRUE
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

    -- Player: Trey Nyoni (trey-nyoni)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'trey-nyoni') THEN
        v_player_id := public.create_player_template_with_positions(
            'trey-nyoni',
            v_club_id,
            'Trey Nyoni',
            '2007-06-30',
            'England',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 8000000.00, 70,
            68, 60, 71, 70, 62, 66, TRUE
        );
    END IF;

    -- Player: Alisson (alisson)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'alisson') THEN
        v_player_id := public.create_player_template_with_positions(
            'alisson',
            v_club_id,
            'Alisson',
            '1992-10-02',
            'Brazil',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 15000000.00, 75,
            76, 73, 75, 74, 70, 75, TRUE
        );
    END IF;

    -- Player: Freddie Woodman (freddie-woodman)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'freddie-woodman') THEN
        v_player_id := public.create_player_template_with_positions(
            'freddie-woodman',
            v_club_id,
            'Freddie Woodman',
            '1997-03-04',
            'England',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 3000000.00, 68,
            69, 66, 68, 67, 63, 68, TRUE
        );
    END IF;

    -- Player: Giorgi Mamardashvili (giorgi-mamardashvili)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'giorgi-mamardashvili') THEN
        v_player_id := public.create_player_template_with_positions(
            'giorgi-mamardashvili',
            v_club_id,
            'Giorgi Mamardashvili',
            '2000-09-29',
            'Georgia',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 28000000.00, 76,
            77, 74, 76, 75, 71, 76, TRUE
        );
    END IF;

    -- Player: Harvey Davies (harvey-davies)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'harvey-davies') THEN
        v_player_id := public.create_player_template_with_positions(
            'harvey-davies',
            v_club_id,
            'Harvey Davies',
            '2003-09-03',
            'England',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 500000.00, 62,
            63, 60, 62, 61, 57, 62, TRUE
        );
    END IF;

    -- Player: Vitezslav Jaros (vitezslav-jaros)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'vitezslav-jaros') THEN
        v_player_id := public.create_player_template_with_positions(
            'vitezslav-jaros',
            v_club_id,
            'Vitezslav Jaros',
            '2001-07-23',
            'Czech Republic',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 5000000.00, 70,
            71, 68, 70, 69, 65, 70, TRUE
        );
    END IF;

    -- Player: Konstantinos Tsimikas (konstantinos-tsimikas)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'konstantinos-tsimikas') THEN
        v_player_id := public.create_player_template_with_positions(
            'konstantinos-tsimikas',
            v_club_id,
            'Konstantinos Tsimikas',
            '1996-05-12',
            'Greece',
            'LB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 4500000.00, 71,
            74, 46, 61, 64, 69, 70, TRUE
        );
    END IF;

    -- Player: Milos Kerkez (milos-kerkez)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'milos-kerkez') THEN
        v_player_id := public.create_player_template_with_positions(
            'milos-kerkez',
            v_club_id,
            'Milos Kerkez',
            '2003-11-07',
            'Hungary',
            'LB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 78,
            81, 53, 68, 71, 76, 77, TRUE
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
            v_player_id, 1, 60000000.00, 83,
            84, 80, 78, 83, 44, 76, TRUE
        );
    END IF;

    -- Player: Rio Ngumoha (rio-ngumoha)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'rio-ngumoha') THEN
        v_player_id := public.create_player_template_with_positions(
            'rio-ngumoha',
            v_club_id,
            'Rio Ngumoha',
            '2008-08-29',
            'England',
            'LW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 30000000.00, 75,
            82, 74, 70, 78, 30, 60, TRUE
        );
    END IF;

    -- Player: Víctor Muñoz (victor-munoz)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'victor-munoz') THEN
        v_player_id := public.create_player_template_with_positions(
            'victor-munoz',
            v_club_id,
            'Víctor Muñoz',
            '2003-07-13',
            'Spain',
            'LW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 30000000.00, 78,
            85, 77, 73, 81, 33, 63, TRUE
        );
    END IF;

    -- Player: Calvin Ramsay (calvin-ramsay)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'calvin-ramsay') THEN
        v_player_id := public.create_player_template_with_positions(
            'calvin-ramsay',
            v_club_id,
            'Calvin Ramsay',
            '2003-07-31',
            'Scotland',
            'RB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 1500000.00, 67,
            70, 42, 57, 60, 65, 66, TRUE
        );
    END IF;

    -- Player: Conor Bradley (conor-bradley)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'conor-bradley') THEN
        v_player_id := public.create_player_template_with_positions(
            'conor-bradley',
            v_club_id,
            'Conor Bradley',
            '2003-07-09',
            'Northern Ireland',
            'RB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 25000000.00, 77,
            80, 52, 67, 70, 75, 76, TRUE
        );
    END IF;

    -- Player: Jeremie Frimpong (jeremie-frimpong)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jeremie-frimpong') THEN
        v_player_id := public.create_player_template_with_positions(
            'jeremie-frimpong',
            v_club_id,
            'Jeremie Frimpong',
            '2000-12-10',
            'Netherlands',
            'RB'::public.enum_player_position,
            ARRAY['RM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 84,
            94, 72, 78, 84, 72, 70, TRUE
        );
    END IF;

    -- Player: Federico Chiesa (federico-chiesa)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'federico-chiesa') THEN
        v_player_id := public.create_player_template_with_positions(
            'federico-chiesa',
            v_club_id,
            'Federico Chiesa',
            '1997-10-25',
            'Italy',
            'RW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 13000000.00, 75,
            82, 74, 70, 78, 30, 60, TRUE
        );
    END IF;

    -- Player: Alexander Isak (alexander-isak)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'alexander-isak') THEN
        v_player_id := public.create_player_template_with_positions(
            'alexander-isak',
            v_club_id,
            'Alexander Isak',
            '1999-09-21',
            'Sweden',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 85000000.00, 82,
            84, 85, 69, 79, 37, 83, TRUE
        );
    END IF;

    -- Player: Hugo Ekitiké (hugo-ekitike)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'liverpool';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'hugo-ekitike') THEN
        v_player_id := public.create_player_template_with_positions(
            'hugo-ekitike',
            v_club_id,
            'Hugo Ekitiké',
            '2002-06-20',
            'France',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 80000000.00, 81,
            83, 84, 68, 78, 36, 82, TRUE
        );
    END IF;

    -- Player: Eberechi Eze (eberechi-eze)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'arsenal';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'eberechi-eze') THEN
        v_player_id := public.create_player_template_with_positions(
            'eberechi-eze',
            v_club_id,
            'Eberechi Eze',
            '1998-06-29',
            'England',
            'CAM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 65000000.00, 81,
            83, 79, 82, 83, 51, 69, TRUE
        );
    END IF;

    -- Player: Ethan Nwaneri (ethan-nwaneri)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'arsenal';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'ethan-nwaneri') THEN
        v_player_id := public.create_player_template_with_positions(
            'ethan-nwaneri',
            v_club_id,
            'Ethan Nwaneri',
            '2007-03-21',
            'England',
            'CAM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 75,
            77, 73, 76, 77, 45, 63, TRUE
        );
    END IF;

    -- Player: Fábio Vieira (fabio-vieira)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'arsenal';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'fabio-vieira') THEN
        v_player_id := public.create_player_template_with_positions(
            'fabio-vieira',
            v_club_id,
            'Fábio Vieira',
            '2000-05-30',
            'Portugal',
            'CAM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 18000000.00, 76,
            78, 74, 77, 78, 46, 64, TRUE
        );
    END IF;

    -- Player: Martin Ødegaard (martin-degaard)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'arsenal';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'martin-degaard') THEN
        v_player_id := public.create_player_template_with_positions(
            'martin-degaard',
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
            v_player_id, 1, 70000000.00, 89,
            77, 82, 89, 89, 63, 67, TRUE
        );
    END IF;

    -- Player: Cristhian Mosquera (cristhian-mosquera)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'arsenal';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'cristhian-mosquera') THEN
        v_player_id := public.create_player_template_with_positions(
            'cristhian-mosquera',
            v_club_id,
            'Cristhian Mosquera',
            '2004-06-27',
            'Spain',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 40000000.00, 79,
            71, 45, 57, 59, 80, 81, TRUE
        );
    END IF;

    -- Player: Gabriel (gabriel)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'arsenal';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'gabriel') THEN
        v_player_id := public.create_player_template_with_positions(
            'gabriel',
            v_club_id,
            'Gabriel',
            '1997-12-19',
            'Brazil',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 75000000.00, 81,
            73, 47, 59, 61, 82, 83, TRUE
        );
    END IF;

    -- Player: Piero Hincapié (piero-hincapie)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'arsenal';
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
            v_player_id, 1, 50000000.00, 80,
            79, 42, 68, 70, 81, 80, TRUE
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
            v_player_id, 1, 100000000.00, 87,
            82, 40, 69, 72, 87, 82, TRUE
        );
    END IF;

    -- Player: Martín Zubimendi (martin-zubimendi)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'arsenal';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'martin-zubimendi') THEN
        v_player_id := public.create_player_template_with_positions(
            'martin-zubimendi',
            v_club_id,
            'Martín Zubimendi',
            '1999-02-02',
            'Spain',
            'CDM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 75000000.00, 81,
            77, 63, 76, 74, 81, 82, TRUE
        );
    END IF;

    -- Player: Bruno Guimarães (bruno-guimaraes)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'arsenal';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'bruno-guimaraes') THEN
        v_player_id := public.create_player_template_with_positions(
            'bruno-guimaraes',
            v_club_id,
            'Bruno Guimarães',
            '1997-11-16',
            'Brazil',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 70000000.00, 81,
            79, 71, 82, 81, 73, 77, TRUE
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
            'CM'::public.enum_player_position,
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
            v_player_id, 1, 25000000.00, 83,
            68, 76, 80, 79, 82, 84, TRUE
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
            v_player_id, 1, 30000000.00, 83,
            84, 82, 83, 79, 87, 83, TRUE
        );
    END IF;

    -- Player: Illan Meslier (illan-meslier)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'arsenal';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'illan-meslier') THEN
        v_player_id := public.create_player_template_with_positions(
            'illan-meslier',
            v_club_id,
            'Illan Meslier',
            '2000-03-02',
            'France',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 8000000.00, 72,
            73, 70, 72, 71, 67, 72, TRUE
        );
    END IF;

    -- Player: Kepa Arrizabalaga (kepa-arrizabalaga)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'arsenal';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'kepa-arrizabalaga') THEN
        v_player_id := public.create_player_template_with_positions(
            'kepa-arrizabalaga',
            v_club_id,
            'Kepa Arrizabalaga',
            '1994-10-03',
            'Spain',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 5000000.00, 70,
            71, 68, 70, 69, 65, 70, TRUE
        );
    END IF;

    -- Player: Tommy Setford (tommy-setford)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'arsenal';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'tommy-setford') THEN
        v_player_id := public.create_player_template_with_positions(
            'tommy-setford',
            v_club_id,
            'Tommy Setford',
            '2006-03-13',
            'England',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 500000.00, 59,
            60, 57, 59, 58, 54, 59, TRUE
        );
    END IF;

    -- Player: Myles Lewis-Skelly (myles-lewis-skelly)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'arsenal';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'myles-lewis-skelly') THEN
        v_player_id := public.create_player_template_with_positions(
            'myles-lewis-skelly',
            v_club_id,
            'Myles Lewis-Skelly',
            '2006-09-26',
            'England',
            'LB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 45000000.00, 76,
            79, 51, 66, 69, 74, 75, TRUE
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
            v_player_id, 1, 55000000.00, 79,
            76, 55, 74, 76, 80, 78, TRUE
        );
    END IF;

    -- Player: Christos Tzolis (christos-tzolis)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'arsenal';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'christos-tzolis') THEN
        v_player_id := public.create_player_template_with_positions(
            'christos-tzolis',
            v_club_id,
            'Christos Tzolis',
            '2002-01-30',
            'Greece',
            'LW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 40000000.00, 79,
            86, 78, 74, 82, 34, 64, TRUE
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
            v_player_id, 1, 45000000.00, 83,
            89, 77, 76, 85, 42, 72, TRUE
        );
    END IF;

    -- Player: Reiss Nelson (reiss-nelson)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'arsenal';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'reiss-nelson') THEN
        v_player_id := public.create_player_template_with_positions(
            'reiss-nelson',
            v_club_id,
            'Reiss Nelson',
            '1999-12-10',
            'England',
            'LW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 8000000.00, 73,
            80, 72, 68, 76, 28, 58, TRUE
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
            v_player_id, 1, 30000000.00, 84,
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
            v_player_id, 1, 70000000.00, 79,
            81, 45, 75, 78, 80, 77, TRUE
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
            v_player_id, 1, 110000000.00, 87,
            85, 82, 82, 87, 65, 75, TRUE
        );
    END IF;

    -- Player: Max Dowman (max-dowman)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'arsenal';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'max-dowman') THEN
        v_player_id := public.create_player_template_with_positions(
            'max-dowman',
            v_club_id,
            'Max Dowman',
            '2009-12-31',
            'England',
            'RW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 30000000.00, 75,
            82, 74, 70, 78, 30, 60, TRUE
        );
    END IF;

    -- Player: Noni Madueke (noni-madueke)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'arsenal';
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
            v_player_id, 1, 50000000.00, 78,
            86, 72, 71, 82, 28, 64, TRUE
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
            v_player_id, 1, 17000000.00, 82,
            82, 80, 76, 85, 40, 73, TRUE
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
            v_player_id, 1, 55000000.00, 84,
            80, 80, 79, 82, 52, 79, TRUE
        );
    END IF;

    -- Player: Viktor Gyökeres (viktor-gyokeres)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'arsenal';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'viktor-gyokeres') THEN
        v_player_id := public.create_player_template_with_positions(
            'viktor-gyokeres',
            v_club_id,
            'Viktor Gyökeres',
            '1998-06-04',
            'Sweden',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 65000000.00, 81,
            83, 84, 68, 78, 36, 82, TRUE
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
            'RW'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 100000000.00, 85,
            80, 82, 83, 86, 45, 64, TRUE
        );
    END IF;

    -- Player: Morgan Rogers (morgan-rogers)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'morgan-rogers') THEN
        v_player_id := public.create_player_template_with_positions(
            'morgan-rogers',
            v_club_id,
            'Morgan Rogers',
            '2002-07-26',
            'England',
            'ST'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position, 'LW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 110000000.00, 82,
            84, 80, 83, 84, 52, 70, TRUE
        );
    END IF;

    -- Player: Aarón Anselmino (aaron-anselmino)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'aaron-anselmino') THEN
        v_player_id := public.create_player_template_with_positions(
            'aaron-anselmino',
            v_club_id,
            'Aarón Anselmino',
            '2005-04-29',
            'Argentina',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 10000000.00, 74,
            66, 40, 52, 54, 75, 76, TRUE
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
            v_player_id, 1, 15000000.00, 78,
            68, 38, 62, 60, 79, 83, TRUE
        );
    END IF;

    -- Player: Benoît Badiashile (benoit-badiashile)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'benoit-badiashile') THEN
        v_player_id := public.create_player_template_with_positions(
            'benoit-badiashile',
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
            v_player_id, 1, 15000000.00, 77,
            68, 35, 66, 62, 78, 80, TRUE
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

    -- Player: Mamadou Sarr (mamadou-sarr)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'mamadou-sarr') THEN
        v_player_id := public.create_player_template_with_positions(
            'mamadou-sarr',
            v_club_id,
            'Mamadou Sarr',
            '2005-08-29',
            'Senegal',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 22000000.00, 74,
            66, 40, 52, 54, 75, 76, TRUE
        );
    END IF;

    -- Player: Maxence Lacroix (maxence-lacroix)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'maxence-lacroix') THEN
        v_player_id := public.create_player_template_with_positions(
            'maxence-lacroix',
            v_club_id,
            'Maxence Lacroix',
            '2000-04-06',
            'France',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 50000000.00, 80,
            72, 46, 58, 60, 81, 82, TRUE
        );
    END IF;

    -- Player: Tosin Adarabioyo (tosin-adarabioyo)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'tosin-adarabioyo') THEN
        v_player_id := public.create_player_template_with_positions(
            'tosin-adarabioyo',
            v_club_id,
            'Tosin Adarabioyo',
            '1997-09-24',
            'England',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 16000000.00, 75,
            67, 41, 53, 55, 76, 77, TRUE
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
            v_player_id, 1, 28000000.00, 78,
            77, 36, 60, 64, 79, 76, TRUE
        );
    END IF;

    -- Player: Dário Essugo (dario-essugo)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'dario-essugo') THEN
        v_player_id := public.create_player_template_with_positions(
            'dario-essugo',
            v_club_id,
            'Dário Essugo',
            '2005-03-14',
            'Portugal',
            'CDM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 15000000.00, 75,
            71, 57, 70, 68, 75, 76, TRUE
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
            v_player_id, 1, 100000000.00, 82,
            78, 62, 75, 78, 81, 82, TRUE
        );
    END IF;

    -- Player: Roméo Lavia (romeo-lavia)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'romeo-lavia') THEN
        v_player_id := public.create_player_template_with_positions(
            'romeo-lavia',
            v_club_id,
            'Roméo Lavia',
            '2004-01-06',
            'Belgium',
            'CDM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 22000000.00, 75,
            72, 56, 73, 76, 75, 74, TRUE
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
            v_player_id, 1, 100000000.00, 82,
            70, 74, 83, 81, 74, 76, TRUE
        );
    END IF;

    -- Player: Jordan Henderson (jordan-henderson)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jordan-henderson') THEN
        v_player_id := public.create_player_template_with_positions(
            'jordan-henderson',
            v_club_id,
            'Jordan Henderson',
            '1990-06-17',
            'England',
            'CM'::public.enum_player_position,
            ARRAY['CM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 1200000.00, 78,
            60, 64, 78, 75, 78, 76, TRUE
        );
    END IF;

    -- Player: Valentín Barco (valentin-barco)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'valentin-barco') THEN
        v_player_id := public.create_player_template_with_positions(
            'valentin-barco',
            v_club_id,
            'Valentín Barco',
            '2004-07-23',
            'Argentina',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 40000000.00, 79,
            77, 69, 80, 79, 71, 75, TRUE
        );
    END IF;

    -- Player: Gabriel Slonina (gabriel-slonina)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'gabriel-slonina') THEN
        v_player_id := public.create_player_template_with_positions(
            'gabriel-slonina',
            v_club_id,
            'Gabriel Slonina',
            '2004-05-15',
            'United States',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 3000000.00, 68,
            69, 66, 68, 67, 63, 68, TRUE
        );
    END IF;

    -- Player: Mike Penders (mike-penders)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'mike-penders') THEN
        v_player_id := public.create_player_template_with_positions(
            'mike-penders',
            v_club_id,
            'Mike Penders',
            '2005-07-31',
            'Belgium',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 25000000.00, 76,
            77, 74, 76, 75, 71, 76, TRUE
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
            v_player_id, 1, 22000000.00, 78,
            80, 76, 77, 74, 76, 78, TRUE
        );
    END IF;

    -- Player: Teddy Sharman-Lowe (teddy-sharman-lowe)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'teddy-sharman-lowe') THEN
        v_player_id := public.create_player_template_with_positions(
            'teddy-sharman-lowe',
            v_club_id,
            'Teddy Sharman-Lowe',
            '2003-03-30',
            'England',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 500000.00, 62,
            63, 60, 62, 61, 57, 62, TRUE
        );
    END IF;

    -- Player: Caleb Wiley (caleb-wiley)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'caleb-wiley') THEN
        v_player_id := public.create_player_template_with_positions(
            'caleb-wiley',
            v_club_id,
            'Caleb Wiley',
            '2004-12-22',
            'United States',
            'LB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 8000000.00, 73,
            76, 48, 63, 66, 71, 72, TRUE
        );
    END IF;

    -- Player: Jorrel Hato (jorrel-hato)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jorrel-hato') THEN
        v_player_id := public.create_player_template_with_positions(
            'jorrel-hato',
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
            v_player_id, 1, 40000000.00, 76,
            80, 45, 70, 74, 76, 73, TRUE
        );
    END IF;

    -- Player: Pep Chavarría (pep-chavarria)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'pep-chavarria') THEN
        v_player_id := public.create_player_template_with_positions(
            'pep-chavarria',
            v_club_id,
            'Pep Chavarría',
            '1998-04-10',
            'Spain',
            'LB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 10000000.00, 74,
            77, 49, 64, 67, 72, 73, TRUE
        );
    END IF;

    -- Player: Jamie Gittens (jamie-gittens)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
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
            v_player_id, 1, 30000000.00, 77,
            88, 70, 68, 83, 30, 58, TRUE
        );
    END IF;

    -- Player: Josh Acheampong (josh-acheampong)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'josh-acheampong') THEN
        v_player_id := public.create_player_template_with_positions(
            'josh-acheampong',
            v_club_id,
            'Josh Acheampong',
            '2006-05-05',
            'England',
            'RB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 25000000.00, 74,
            77, 49, 64, 67, 72, 73, TRUE
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

    -- Player: Marco Palestra (marco-palestra)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'chelsea';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'marco-palestra') THEN
        v_player_id := public.create_player_template_with_positions(
            'marco-palestra',
            v_club_id,
            'Marco Palestra',
            '2005-03-03',
            'Italy',
            'RW'::public.enum_player_position,
            ARRAY['RB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 78,
            81, 53, 68, 71, 76, 77, TRUE
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
            v_player_id, 1, 60000000.00, 82,
            80, 74, 82, 80, 80, 81, TRUE
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
            v_player_id, 1, 35000000.00, 87,
            73, 85, 90, 83, 67, 76, TRUE
        );
    END IF;

    -- Player: Jack Fletcher (jack-fletcher)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-united';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jack-fletcher') THEN
        v_player_id := public.create_player_template_with_positions(
            'jack-fletcher',
            v_club_id,
            'Jack Fletcher',
            '2007-03-19',
            'England',
            'CAM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 1500000.00, 64,
            66, 62, 65, 66, 34, 52, TRUE
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
            v_player_id, 1, 25000000.00, 80,
            74, 78, 80, 80, 62, 67, TRUE
        );
    END IF;

    -- Player: Ayden Heaven (ayden-heaven)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-united';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'ayden-heaven') THEN
        v_player_id := public.create_player_template_with_positions(
            'ayden-heaven',
            v_club_id,
            'Ayden Heaven',
            '2006-09-22',
            'England',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 30000000.00, 75,
            67, 41, 53, 55, 76, 77, TRUE
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
            v_player_id, 1, 8000000.00, 80,
            48, 54, 68, 64, 81, 84, TRUE
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
            v_player_id, 1, 50000000.00, 78,
            78, 38, 66, 68, 79, 74, TRUE
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
            v_player_id, 1, 45000000.00, 84,
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
            v_player_id, 1, 30000000.00, 84,
            68, 50, 66, 65, 85, 84, TRUE
        );
    END IF;

    -- Player: Andrey Santos (andrey-santos)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-united';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'andrey-santos') THEN
        v_player_id := public.create_player_template_with_positions(
            'andrey-santos',
            v_club_id,
            'Andrey Santos',
            '2004-05-03',
            'Brazil',
            'CDM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 40000000.00, 79,
            75, 61, 74, 72, 79, 80, TRUE
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
            v_player_id, 1, 25000000.00, 81,
            74, 58, 68, 70, 83, 82, TRUE
        );
    END IF;

    -- Player: Toby Collyer (toby-collyer)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-united';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'toby-collyer') THEN
        v_player_id := public.create_player_template_with_positions(
            'toby-collyer',
            v_club_id,
            'Toby Collyer',
            '2004-01-03',
            'England',
            'CDM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 5000000.00, 71,
            67, 53, 66, 64, 71, 72, TRUE
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
            v_player_id, 1, 70000000.00, 79,
            74, 68, 78, 83, 74, 72, TRUE
        );
    END IF;

    -- Player: Tyler Fletcher (tyler-fletcher)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-united';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'tyler-fletcher') THEN
        v_player_id := public.create_player_template_with_positions(
            'tyler-fletcher',
            v_club_id,
            'Tyler Fletcher',
            '2007-03-19',
            'Scotland',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 1500000.00, 64,
            62, 54, 65, 64, 56, 60, TRUE
        );
    END IF;

    -- Player: Youri Tielemans (youri-tielemans)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-united';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'youri-tielemans') THEN
        v_player_id := public.create_player_template_with_positions(
            'youri-tielemans',
            v_club_id,
            'Youri Tielemans',
            '1997-05-07',
            'Belgium',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 40000000.00, 79,
            77, 69, 80, 79, 71, 75, TRUE
        );
    END IF;

    -- Player: Karl Darlow (karl-darlow)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-united';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'karl-darlow') THEN
        v_player_id := public.create_player_template_with_positions(
            'karl-darlow',
            v_club_id,
            'Karl Darlow',
            '1990-10-08',
            'Wales',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 200000.00, 60,
            61, 58, 60, 59, 55, 60, TRUE
        );
    END IF;

    -- Player: Senne Lammens (senne-lammens)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-united';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'senne-lammens') THEN
        v_player_id := public.create_player_template_with_positions(
            'senne-lammens',
            v_club_id,
            'Senne Lammens',
            '2002-07-07',
            'Belgium',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 77,
            78, 75, 77, 76, 72, 77, TRUE
        );
    END IF;

    -- Player: Tom Heaton (tom-heaton)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-united';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'tom-heaton') THEN
        v_player_id := public.create_player_template_with_positions(
            'tom-heaton',
            v_club_id,
            'Tom Heaton',
            '1986-04-15',
            'England',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 100000.00, 60,
            61, 58, 60, 59, 55, 60, TRUE
        );
    END IF;

    -- Player: Harry Amass (harry-amass)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-united';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'harry-amass') THEN
        v_player_id := public.create_player_template_with_positions(
            'harry-amass',
            v_club_id,
            'Harry Amass',
            '2007-03-16',
            'England',
            'LB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 7000000.00, 69,
            72, 44, 59, 62, 67, 68, TRUE
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
            v_player_id, 1, 8000000.00, 82,
            75, 58, 79, 78, 80, 76, TRUE
        );
    END IF;

    -- Player: Patrick Dorgu (patrick-dorgu)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-united';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'patrick-dorgu') THEN
        v_player_id := public.create_player_template_with_positions(
            'patrick-dorgu',
            v_club_id,
            'Patrick Dorgu',
            '2004-10-26',
            'Denmark',
            'LB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 78,
            81, 53, 68, 71, 76, 77, TRUE
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
            v_player_id, 1, 40000000.00, 81,
            87, 82, 74, 81, 40, 74, TRUE
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
            v_player_id, 1, 30000000.00, 81,
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
            v_player_id, 1, 18000000.00, 80,
            77, 62, 76, 80, 77, 70, TRUE
        );
    END IF;

    -- Player: Amad Diallo (amad-diallo)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-united';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'amad-diallo') THEN
        v_player_id := public.create_player_template_with_positions(
            'amad-diallo',
            v_club_id,
            'Amad Diallo',
            '2002-07-11',
            'Cote d''Ivoire',
            'RW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 45000000.00, 79,
            86, 78, 74, 82, 34, 64, TRUE
        );
    END IF;

    -- Player: Bryan Mbeumo (bryan-mbeumo)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-united';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'bryan-mbeumo') THEN
        v_player_id := public.create_player_template_with_positions(
            'bryan-mbeumo',
            v_club_id,
            'Bryan Mbeumo',
            '1999-08-07',
            'Cameroon',
            'RW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 75000000.00, 81,
            88, 80, 76, 84, 36, 66, TRUE
        );
    END IF;

    -- Player: Shea Lacey (shea-lacey)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-united';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'shea-lacey') THEN
        v_player_id := public.create_player_template_with_positions(
            'shea-lacey',
            v_club_id,
            'Shea Lacey',
            '2007-04-14',
            'England',
            'RW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 5000000.00, 68,
            75, 67, 63, 71, 23, 53, TRUE
        );
    END IF;

    -- Player: Benjamin Sesko (benjamin-sesko)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-united';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'benjamin-sesko') THEN
        v_player_id := public.create_player_template_with_positions(
            'benjamin-sesko',
            v_club_id,
            'Benjamin Sesko',
            '2003-05-31',
            'Slovenia',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 75000000.00, 81,
            83, 84, 68, 78, 36, 82, TRUE
        );
    END IF;

    -- Player: Joshua Zirkzee (joshua-zirkzee)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-united';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'joshua-zirkzee') THEN
        v_player_id := public.create_player_template_with_positions(
            'joshua-zirkzee',
            v_club_id,
            'Joshua Zirkzee',
            '2001-05-22',
            'Netherlands',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 76,
            78, 79, 63, 73, 31, 77, TRUE
        );
    END IF;

    -- Player: Matheus Cunha (matheus-cunha)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'manchester-united';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'matheus-cunha') THEN
        v_player_id := public.create_player_template_with_positions(
            'matheus-cunha',
            v_club_id,
            'Matheus Cunha',
            '1999-05-27',
            'Brazil',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 75000000.00, 81,
            83, 84, 68, 78, 36, 82, TRUE
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
            'CAM'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 17000000.00, 82,
            78, 77, 81, 83, 56, 78, TRUE
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
            v_player_id, 1, 20000000.00, 85,
            73, 81, 86, 85, 52, 62, TRUE
        );
    END IF;

    -- Player: Xavi Simons (xavi-simons)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'xavi-simons') THEN
        v_player_id := public.create_player_template_with_positions(
            'xavi-simons',
            v_club_id,
            'Xavi Simons',
            '2003-04-21',
            'Netherlands',
            'CAM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 40000000.00, 79,
            81, 77, 80, 81, 49, 67, TRUE
        );
    END IF;

    -- Player: Ben Davies (ben-davies)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'ben-davies') THEN
        v_player_id := public.create_player_template_with_positions(
            'ben-davies',
            v_club_id,
            'Ben Davies',
            '1993-04-24',
            'Wales',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 3000000.00, 70,
            62, 36, 48, 50, 71, 72, TRUE
        );
    END IF;

    -- Player: Jan Paul van Hecke (jan-paul-van-hecke)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jan-paul-van-hecke') THEN
        v_player_id := public.create_player_template_with_positions(
            'jan-paul-van-hecke',
            v_club_id,
            'Jan Paul van Hecke',
            '2000-06-08',
            'Netherlands',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 60000000.00, 80,
            72, 46, 58, 60, 81, 82, TRUE
        );
    END IF;

    -- Player: Kevin Danso (kevin-danso)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'kevin-danso') THEN
        v_player_id := public.create_player_template_with_positions(
            'kevin-danso',
            v_club_id,
            'Kevin Danso',
            '1998-09-19',
            'Austria',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 76,
            68, 42, 54, 56, 77, 78, TRUE
        );
    END IF;

    -- Player: Kota Takai (kota-takai)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'kota-takai') THEN
        v_player_id := public.create_player_template_with_positions(
            'kota-takai',
            v_club_id,
            'Kota Takai',
            '2004-09-04',
            'Japan',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 5000000.00, 71,
            63, 37, 49, 51, 72, 73, TRUE
        );
    END IF;

    -- Player: Marcos Senesi (marcos-senesi)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'marcos-senesi') THEN
        v_player_id := public.create_player_template_with_positions(
            'marcos-senesi',
            v_club_id,
            'Marcos Senesi',
            '1997-05-10',
            'Argentina',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 25000000.00, 77,
            69, 43, 55, 57, 78, 79, TRUE
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
            v_player_id, 1, 50000000.00, 82,
            91, 40, 66, 68, 83, 81, TRUE
        );
    END IF;

    -- Player: Archie Gray (archie-gray)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'archie-gray') THEN
        v_player_id := public.create_player_template_with_positions(
            'archie-gray',
            v_club_id,
            'Archie Gray',
            '2006-03-12',
            'England',
            'CDM'::public.enum_player_position,
            ARRAY['RB'::public.enum_player_position, 'CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 74,
            75, 58, 73, 75, 71, 70, TRUE
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
            'CDM'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 81,
            72, 68, 79, 81, 78, 78, TRUE
        );
    END IF;

    -- Player: Sandro Tonali (sandro-tonali)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'sandro-tonali') THEN
        v_player_id := public.create_player_template_with_positions(
            'sandro-tonali',
            v_club_id,
            'Sandro Tonali',
            '2000-05-08',
            'Italy',
            'CDM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 80000000.00, 81,
            77, 63, 76, 74, 81, 82, TRUE
        );
    END IF;

    -- Player: Conor Gallagher (conor-gallagher)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
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
            v_player_id, 1, 32000000.00, 81,
            78, 74, 77, 79, 78, 83, TRUE
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
            v_player_id, 1, 35000000.00, 74,
            74, 65, 74, 76, 64, 68, TRUE
        );
    END IF;

    -- Player: Mateus Fernandes (mateus-fernandes)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'mateus-fernandes') THEN
        v_player_id := public.create_player_template_with_positions(
            'mateus-fernandes',
            v_club_id,
            'Mateus Fernandes',
            '2004-07-10',
            'Portugal',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 50000000.00, 80,
            78, 70, 81, 80, 72, 76, TRUE
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
            v_player_id, 1, 30000000.00, 79,
            77, 70, 76, 78, 74, 77, TRUE
        );
    END IF;

    -- Player: Antonín Kinský (antonin-kinsky)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'antonin-kinsky') THEN
        v_player_id := public.create_player_template_with_positions(
            'antonin-kinsky',
            v_club_id,
            'Antonín Kinský',
            '2003-03-13',
            'Czech Republic',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 15000000.00, 74,
            75, 72, 74, 73, 69, 74, TRUE
        );
    END IF;

    -- Player: Brandon Austin (brandon-austin)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'brandon-austin') THEN
        v_player_id := public.create_player_template_with_positions(
            'brandon-austin',
            v_club_id,
            'Brandon Austin',
            '1999-01-08',
            'England',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 500000.00, 62,
            63, 60, 62, 61, 57, 62, TRUE
        );
    END IF;

    -- Player: Martin Dúbravka (martin-dubravka)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'martin-dubravka') THEN
        v_player_id := public.create_player_template_with_positions(
            'martin-dubravka',
            v_club_id,
            'Martin Dúbravka',
            '1989-01-15',
            'Slovakia',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 500000.00, 63,
            64, 61, 63, 62, 58, 63, TRUE
        );
    END IF;

    -- Player: Andrew Robertson (andrew-robertson)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'andrew-robertson') THEN
        v_player_id := public.create_player_template_with_positions(
            'andrew-robertson',
            v_club_id,
            'Andrew Robertson',
            '1994-03-11',
            'Scotland',
            'LB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 7000000.00, 72,
            75, 47, 62, 65, 70, 71, TRUE
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
            v_player_id, 1, 30000000.00, 82,
            84, 60, 74, 79, 78, 78, TRUE
        );
    END IF;

    -- Player: Souza (souza)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'souza') THEN
        v_player_id := public.create_player_template_with_positions(
            'souza',
            v_club_id,
            'Souza',
            '2006-06-16',
            'Brazil',
            'LB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 12000000.00, 71,
            74, 46, 61, 64, 69, 70, TRUE
        );
    END IF;

    -- Player: Mathys Tel (mathys-tel)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'mathys-tel') THEN
        v_player_id := public.create_player_template_with_positions(
            'mathys-tel',
            v_club_id,
            'Mathys Tel',
            '2005-04-27',
            'France',
            'LW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 22000000.00, 77,
            84, 76, 72, 80, 32, 62, TRUE
        );
    END IF;

    -- Player: Mikey Moore (mikey-moore)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'mikey-moore') THEN
        v_player_id := public.create_player_template_with_positions(
            'mikey-moore',
            v_club_id,
            'Mikey Moore',
            '2007-08-11',
            'England',
            'LW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 18000000.00, 73,
            80, 72, 68, 76, 28, 58, TRUE
        );
    END IF;

    -- Player: Wilson Odobert (wilson-odobert)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'wilson-odobert') THEN
        v_player_id := public.create_player_template_with_positions(
            'wilson-odobert',
            v_club_id,
            'Wilson Odobert',
            '2004-11-28',
            'France',
            'LW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 18000000.00, 76,
            83, 75, 71, 79, 31, 61, TRUE
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

    -- Player: Mohammed Kudus (mohammed-kudus)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'mohammed-kudus') THEN
        v_player_id := public.create_player_template_with_positions(
            'mohammed-kudus',
            v_club_id,
            'Mohammed Kudus',
            '2000-08-02',
            'Ghana',
            'RW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 50000000.00, 80,
            87, 79, 75, 83, 35, 65, TRUE
        );
    END IF;

    -- Player: Dane Scarlett (dane-scarlett)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'tottenham';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'dane-scarlett') THEN
        v_player_id := public.create_player_template_with_positions(
            'dane-scarlett',
            v_club_id,
            'Dane Scarlett',
            '2004-03-24',
            'England',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 1500000.00, 67,
            69, 70, 54, 64, 22, 68, TRUE
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
            v_player_id, 1, 28000000.00, 81,
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
            v_player_id, 1, 25000000.00, 80,
            78, 78, 70, 77, 48, 78, TRUE
        );
    END IF;

    -- Player: Ismael Saibari (ismael-saibari)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayern-munich';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'ismael-saibari') THEN
        v_player_id := public.create_player_template_with_positions(
            'ismael-saibari',
            v_club_id,
            'Ismael Saibari',
            '2001-01-28',
            'Morocco',
            'CAM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 55000000.00, 80,
            82, 78, 81, 82, 50, 68, TRUE
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
            v_player_id, 1, 100000000.00, 87,
            84, 78, 83, 90, 64, 65, TRUE
        );
    END IF;

    -- Player: Lennart Karl (lennart-karl)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayern-munich';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'lennart-karl') THEN
        v_player_id := public.create_player_template_with_positions(
            'lennart-karl',
            v_club_id,
            'Lennart Karl',
            '2008-02-22',
            'Germany',
            'CAM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 60000000.00, 77,
            79, 75, 78, 79, 47, 65, TRUE
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
            v_player_id, 1, 75000000.00, 82,
            82, 42, 62, 65, 83, 84, TRUE
        );
    END IF;

    -- Player: Hiroki Ito (hiroki-ito)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayern-munich';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'hiroki-ito') THEN
        v_player_id := public.create_player_template_with_positions(
            'hiroki-ito',
            v_club_id,
            'Hiroki Ito',
            '1999-05-12',
            'Japan',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 18000000.00, 76,
            68, 42, 54, 56, 77, 78, TRUE
        );
    END IF;

    -- Player: Jonathan Tah (jonathan-tah)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayern-munich';
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
            v_player_id, 1, 28000000.00, 83,
            74, 35, 62, 60, 85, 87, TRUE
        );
    END IF;

    -- Player: Min-jae Kim (min-jae-kim)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayern-munich';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'min-jae-kim') THEN
        v_player_id := public.create_player_template_with_positions(
            'min-jae-kim',
            v_club_id,
            'Min-jae Kim',
            '1996-11-15',
            'Korea, South',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 76,
            68, 42, 54, 56, 77, 78, TRUE
        );
    END IF;

    -- Player: Aleksandar Pavlovic (aleksandar-pavlovic)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayern-munich';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'aleksandar-pavlovic') THEN
        v_player_id := public.create_player_template_with_positions(
            'aleksandar-pavlovic',
            v_club_id,
            'Aleksandar Pavlovic',
            '2004-05-03',
            'Germany',
            'CDM'::public.enum_player_position,
            ARRAY['CM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 90000000.00, 78,
            72, 68, 79, 78, 76, 75, TRUE
        );
    END IF;

    -- Player: David Santos Daiber (david-santos-daiber)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayern-munich';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'david-santos-daiber') THEN
        v_player_id := public.create_player_template_with_positions(
            'david-santos-daiber',
            v_club_id,
            'David Santos Daiber',
            '2007-01-10',
            'Portugal',
            'CDM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 3000000.00, 66,
            62, 48, 61, 59, 66, 67, TRUE
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
            v_player_id, 1, 35000000.00, 86,
            68, 74, 88, 83, 81, 76, TRUE
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
            v_player_id, 1, 15000000.00, 83,
            62, 62, 70, 71, 85, 88, TRUE
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
            'CF'::public.enum_player_position,
            ARRAY['RW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 18000000.00, 82,
            82, 81, 77, 82, 42, 68, TRUE
        );
    END IF;

    -- Player: Bara Sapoko Ndiaye (bara-sapoko-ndiaye)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayern-munich';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'bara-sapoko-ndiaye') THEN
        v_player_id := public.create_player_template_with_positions(
            'bara-sapoko-ndiaye',
            v_club_id,
            'Bara Sapoko Ndiaye',
            '2007-12-31',
            'Senegal',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 4000000.00, 67,
            65, 57, 68, 67, 59, 63, TRUE
        );
    END IF;

    -- Player: Felipe Chávez (felipe-chavez)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayern-munich';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'felipe-chavez') THEN
        v_player_id := public.create_player_template_with_positions(
            'felipe-chavez',
            v_club_id,
            'Felipe Chávez',
            '2007-04-10',
            'Peru',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 4000000.00, 67,
            65, 57, 68, 67, 59, 63, TRUE
        );
    END IF;

    -- Player: Tom Bischof (tom-bischof)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayern-munich';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'tom-bischof') THEN
        v_player_id := public.create_player_template_with_positions(
            'tom-bischof',
            v_club_id,
            'Tom Bischof',
            '2005-06-28',
            'Germany',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 40000000.00, 79,
            77, 69, 80, 79, 71, 75, TRUE
        );
    END IF;

    -- Player: Jonas Urbig (jonas-urbig)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayern-munich';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jonas-urbig') THEN
        v_player_id := public.create_player_template_with_positions(
            'jonas-urbig',
            v_club_id,
            'Jonas Urbig',
            '2003-08-08',
            'Germany',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 18000000.00, 75,
            76, 73, 75, 74, 70, 75, TRUE
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
            v_player_id, 1, 500000.00, 74,
            75, 72, 74, 71, 72, 74, TRUE
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
            v_player_id, 1, 40000000.00, 82,
            95, 66, 77, 82, 75, 76, TRUE
        );
    END IF;

    -- Player: Nathaniel Brown (nathaniel-brown)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayern-munich';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'nathaniel-brown') THEN
        v_player_id := public.create_player_template_with_positions(
            'nathaniel-brown',
            v_club_id,
            'Nathaniel Brown',
            '2003-06-16',
            'Germany',
            'LB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 50000000.00, 80,
            83, 55, 70, 73, 78, 79, TRUE
        );
    END IF;

    -- Player: Arijon Ibrahimovic (arijon-ibrahimovic)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayern-munich';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'arijon-ibrahimovic') THEN
        v_player_id := public.create_player_template_with_positions(
            'arijon-ibrahimovic',
            v_club_id,
            'Arijon Ibrahimovic',
            '2005-12-11',
            'Germany',
            'LW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 10000000.00, 71,
            78, 70, 66, 74, 26, 56, TRUE
        );
    END IF;

    -- Player: Bryan Zaragoza (bryan-zaragoza)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayern-munich';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'bryan-zaragoza') THEN
        v_player_id := public.create_player_template_with_positions(
            'bryan-zaragoza',
            v_club_id,
            'Bryan Zaragoza',
            '2001-09-09',
            'Spain',
            'LW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 8000000.00, 73,
            80, 72, 68, 76, 28, 58, TRUE
        );
    END IF;

    -- Player: Luis Díaz (luis-diaz)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayern-munich';
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
            v_player_id, 1, 70000000.00, 84,
            90, 76, 75, 86, 40, 73, TRUE
        );
    END IF;

    -- Player: Josip Stanisic (josip-stanisic)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayern-munich';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'josip-stanisic') THEN
        v_player_id := public.create_player_template_with_positions(
            'josip-stanisic',
            v_club_id,
            'Josip Stanisic',
            '2000-04-02',
            'Croatia',
            'RB'::public.enum_player_position,
            ARRAY['CB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 40000000.00, 78,
            75, 48, 72, 72, 79, 75, TRUE
        );
    END IF;

    -- Player: Konrad Laimer (konrad-laimer)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayern-munich';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'konrad-laimer') THEN
        v_player_id := public.create_player_template_with_positions(
            'konrad-laimer',
            v_club_id,
            'Konrad Laimer',
            '1997-05-27',
            'Austria',
            'RB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 32000000.00, 78,
            81, 53, 68, 71, 76, 77, TRUE
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
            v_player_id, 1, 10000000.00, 76,
            84, 48, 68, 73, 75, 76, TRUE
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
            v_player_id, 1, 170000000.00, 82,
            80, 78, 83, 85, 50, 64, TRUE
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
            v_player_id, 1, 60000000.00, 90,
            69, 93, 84, 83, 49, 82, TRUE
        );
    END IF;

    -- Player: Giannis Konstantelias (giannis-konstantelias)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'borussia-dortmund';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'giannis-konstantelias') THEN
        v_player_id := public.create_player_template_with_positions(
            'giannis-konstantelias',
            v_club_id,
            'Giannis Konstantelias',
            '2003-03-05',
            'Greece',
            'CAM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 22000000.00, 77,
            79, 75, 78, 79, 47, 65, TRUE
        );
    END IF;

    -- Player: Justin Lerma (justin-lerma)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'borussia-dortmund';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'justin-lerma') THEN
        v_player_id := public.create_player_template_with_positions(
            'justin-lerma',
            v_club_id,
            'Justin Lerma',
            '2008-05-05',
            'Ecuador',
            'CAM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 3200000.00, 66,
            68, 64, 67, 68, 36, 54, TRUE
        );
    END IF;

    -- Player: Konstantinos Karetsas (konstantinos-karetsas)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'borussia-dortmund';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'konstantinos-karetsas') THEN
        v_player_id := public.create_player_template_with_positions(
            'konstantinos-karetsas',
            v_club_id,
            'Konstantinos Karetsas',
            '2007-11-19',
            'Greece',
            'CAM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 75,
            77, 73, 76, 77, 45, 63, TRUE
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
            'CB'::public.enum_player_position,
            ARRAY['CB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 3000000.00, 80,
            70, 68, 74, 75, 80, 84, TRUE
        );
    END IF;

    -- Player: Filippo Mane (filippo-mane)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'borussia-dortmund';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'filippo-mane') THEN
        v_player_id := public.create_player_template_with_positions(
            'filippo-mane',
            v_club_id,
            'Filippo Mane',
            '2005-03-08',
            'Italy',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 2500000.00, 68,
            60, 34, 46, 48, 69, 70, TRUE
        );
    END IF;

    -- Player: Joane Gadou (joane-gadou)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'borussia-dortmund';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'joane-gadou') THEN
        v_player_id := public.create_player_template_with_positions(
            'joane-gadou',
            v_club_id,
            'Joane Gadou',
            '2007-01-17',
            'France',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 73,
            65, 39, 51, 53, 74, 75, TRUE
        );
    END IF;

    -- Player: Luca Reggiani (luca-reggiani)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'borussia-dortmund';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'luca-reggiani') THEN
        v_player_id := public.create_player_template_with_positions(
            'luca-reggiani',
            v_club_id,
            'Luca Reggiani',
            '2008-01-09',
            'Italy',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 10000000.00, 71,
            63, 37, 49, 51, 72, 73, TRUE
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
            v_player_id, 1, 55000000.00, 83,
            78, 55, 72, 74, 84, 82, TRUE
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
            'CB'::public.enum_player_position,
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
            v_player_id, 1, 18000000.00, 80,
            70, 42, 65, 62, 81, 82, TRUE
        );
    END IF;

    -- Player: Mussa Kaba (mussa-kaba)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'borussia-dortmund';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'mussa-kaba') THEN
        v_player_id := public.create_player_template_with_positions(
            'mussa-kaba',
            v_club_id,
            'Mussa Kaba',
            '2008-11-17',
            'Germany',
            'CDM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 200000.00, 58,
            54, 40, 53, 51, 58, 59, TRUE
        );
    END IF;

    -- Player: Samuele Inácio (samuele-inacio)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'borussia-dortmund';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'samuele-inacio') THEN
        v_player_id := public.create_player_template_with_positions(
            'samuele-inacio',
            v_club_id,
            'Samuele Inácio',
            '2008-04-02',
            'Italy',
            'CF'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 15000000.00, 72,
            74, 73, 68, 73, 30, 65, TRUE
        );
    END IF;

    -- Player: Carney Chukwuemeka (carney-chukwuemeka)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'borussia-dortmund';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'carney-chukwuemeka') THEN
        v_player_id := public.create_player_template_with_positions(
            'carney-chukwuemeka',
            v_club_id,
            'Carney Chukwuemeka',
            '2003-10-20',
            'Austria',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 76,
            74, 66, 77, 76, 68, 72, TRUE
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
            v_player_id, 1, 55000000.00, 77,
            74, 70, 75, 78, 72, 78, TRUE
        );
    END IF;

    -- Player: Jobe Bellingham (jobe-bellingham)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'borussia-dortmund';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jobe-bellingham') THEN
        v_player_id := public.create_player_template_with_positions(
            'jobe-bellingham',
            v_club_id,
            'Jobe Bellingham',
            '2005-09-23',
            'England',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 40000000.00, 76,
            74, 66, 77, 76, 68, 72, TRUE
        );
    END IF;

    -- Player: Joey Veerman (joey-veerman)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'borussia-dortmund';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'joey-veerman') THEN
        v_player_id := public.create_player_template_with_positions(
            'joey-veerman',
            v_club_id,
            'Joey Veerman',
            '1998-11-19',
            'Netherlands',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 25000000.00, 77,
            75, 67, 78, 77, 69, 73, TRUE
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
            v_player_id, 1, 6000000.00, 81,
            74, 80, 80, 80, 75, 78, TRUE
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
            v_player_id, 1, 500000.00, 74,
            74, 72, 75, 70, 74, 75, TRUE
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

    -- Player: Patrick Drewes (patrick-drewes)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'borussia-dortmund';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'patrick-drewes') THEN
        v_player_id := public.create_player_template_with_positions(
            'patrick-drewes',
            v_club_id,
            'Patrick Drewes',
            '1993-02-04',
            'Germany',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 300000.00, 61,
            62, 59, 61, 60, 56, 61, TRUE
        );
    END IF;

    -- Player: Silas Ostrzinski (silas-ostrzinski)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'borussia-dortmund';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'silas-ostrzinski') THEN
        v_player_id := public.create_player_template_with_positions(
            'silas-ostrzinski',
            v_club_id,
            'Silas Ostrzinski',
            '2003-11-19',
            'Germany',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 200000.00, 59,
            60, 57, 59, 58, 54, 59, TRUE
        );
    END IF;

    -- Player: Daniel Svensson (daniel-svensson)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'borussia-dortmund';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'daniel-svensson') THEN
        v_player_id := public.create_player_template_with_positions(
            'daniel-svensson',
            v_club_id,
            'Daniel Svensson',
            '2002-02-12',
            'Sweden',
            'LB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 22000000.00, 77,
            80, 52, 67, 70, 75, 76, TRUE
        );
    END IF;

    -- Player: Kauã Prates (kaua-prates)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'borussia-dortmund';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'kaua-prates') THEN
        v_player_id := public.create_player_template_with_positions(
            'kaua-prates',
            v_club_id,
            'Kauã Prates',
            '2008-08-12',
            'Brazil',
            'LB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 10000000.00, 71,
            74, 46, 61, 64, 69, 70, TRUE
        );
    END IF;

    -- Player: Mathis Albert (mathis-albert)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'borussia-dortmund';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'mathis-albert') THEN
        v_player_id := public.create_player_template_with_positions(
            'mathis-albert',
            v_club_id,
            'Mathis Albert',
            '2009-05-21',
            'United States',
            'LW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 300000.00, 58,
            65, 57, 53, 61, 13, 43, TRUE
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
            v_player_id, 1, 25000000.00, 78,
            79, 58, 72, 73, 77, 80, TRUE
        );
    END IF;

    -- Player: Fábio Silva (fabio-silva)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'borussia-dortmund';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'fabio-silva') THEN
        v_player_id := public.create_player_template_with_positions(
            'fabio-silva',
            v_club_id,
            'Fábio Silva',
            '2002-07-19',
            'Portugal',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 22000000.00, 77,
            79, 80, 64, 74, 32, 78, TRUE
        );
    END IF;

    -- Player: Maximilian Beier (maximilian-beier)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'borussia-dortmund';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'maximilian-beier') THEN
        v_player_id := public.create_player_template_with_positions(
            'maximilian-beier',
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
            v_player_id, 1, 40000000.00, 78,
            88, 77, 68, 76, 34, 70, TRUE
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
            v_player_id, 1, 32000000.00, 82,
            78, 84, 70, 76, 38, 84, TRUE
        );
    END IF;

    -- Player: Ibrahim Maza (ibrahim-maza)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'ibrahim-maza') THEN
        v_player_id := public.create_player_template_with_positions(
            'ibrahim-maza',
            v_club_id,
            'Ibrahim Maza',
            '2005-11-24',
            'Algeria',
            'CAM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 45000000.00, 76,
            78, 74, 77, 78, 46, 64, TRUE
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
            v_player_id, 1, 1500000.00, 80,
            74, 78, 81, 80, 58, 66, TRUE
        );
    END IF;

    -- Player: Malik Tillman (malik-tillman)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'malik-tillman') THEN
        v_player_id := public.create_player_template_with_positions(
            'malik-tillman',
            v_club_id,
            'Malik Tillman',
            '2002-05-28',
            'United States',
            'CAM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 30000000.00, 78,
            80, 76, 79, 80, 48, 66, TRUE
        );
    END IF;

    -- Player: Axel Tape (axel-tape)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'axel-tape') THEN
        v_player_id := public.create_player_template_with_positions(
            'axel-tape',
            v_club_id,
            'Axel Tape',
            '2007-08-10',
            'France',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 8000000.00, 70,
            62, 36, 48, 50, 71, 72, TRUE
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
            v_player_id, 1, 35000000.00, 82,
            76, 50, 72, 74, 83, 80, TRUE
        );
    END IF;

    -- Player: Facundo Medina (facundo-medina)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'facundo-medina') THEN
        v_player_id := public.create_player_template_with_positions(
            'facundo-medina',
            v_club_id,
            'Facundo Medina',
            '1999-05-28',
            'Argentina',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 18000000.00, 76,
            68, 42, 54, 56, 77, 78, TRUE
        );
    END IF;

    -- Player: Jarell Quansah (jarell-quansah)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
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
            v_player_id, 1, 45000000.00, 75,
            68, 35, 62, 64, 76, 75, TRUE
        );
    END IF;

    -- Player: Jeanuël Belocian (jeanuel-belocian)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jeanuel-belocian') THEN
        v_player_id := public.create_player_template_with_positions(
            'jeanuel-belocian',
            v_club_id,
            'Jeanuël Belocian',
            '2005-02-17',
            'France',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 12000000.00, 74,
            66, 40, 52, 54, 75, 76, TRUE
        );
    END IF;

    -- Player: Loïc Badé (loic-bade)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'loic-bade') THEN
        v_player_id := public.create_player_template_with_positions(
            'loic-bade',
            v_club_id,
            'Loïc Badé',
            '2000-04-11',
            'France',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 76,
            68, 42, 54, 56, 77, 78, TRUE
        );
    END IF;

    -- Player: Tim Oermann (tim-oermann)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'tim-oermann') THEN
        v_player_id := public.create_player_template_with_positions(
            'tim-oermann',
            v_club_id,
            'Tim Oermann',
            '2003-10-06',
            'Germany',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 4000000.00, 70,
            62, 36, 48, 50, 71, 72, TRUE
        );
    END IF;

    -- Player: Equi Fernández (equi-fernandez)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'equi-fernandez') THEN
        v_player_id := public.create_player_template_with_positions(
            'equi-fernandez',
            v_club_id,
            'Equi Fernández',
            '2002-07-25',
            'Argentina',
            'CDM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 76,
            72, 58, 71, 69, 76, 77, TRUE
        );
    END IF;

    -- Player: Kennet Eichhorn (kennet-eichhorn)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'kennet-eichhorn') THEN
        v_player_id := public.create_player_template_with_positions(
            'kennet-eichhorn',
            v_club_id,
            'Kennet Eichhorn',
            '2009-07-27',
            'Germany',
            'CDM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 73,
            69, 55, 68, 66, 73, 74, TRUE
        );
    END IF;

    -- Player: Robert Andrich (robert-andrich)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'robert-andrich') THEN
        v_player_id := public.create_player_template_with_positions(
            'robert-andrich',
            v_club_id,
            'Robert Andrich',
            '1994-09-22',
            'Germany',
            'CDM'::public.enum_player_position,
            ARRAY['CB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 6000000.00, 81,
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
            v_player_id, 1, 20000000.00, 81,
            68, 74, 84, 80, 74, 72, TRUE
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
            v_player_id, 1, 25000000.00, 82,
            74, 72, 80, 81, 80, 80, TRUE
        );
    END IF;

    -- Player: Janis Blaswich (janis-blaswich)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'janis-blaswich') THEN
        v_player_id := public.create_player_template_with_positions(
            'janis-blaswich',
            v_club_id,
            'Janis Blaswich',
            '1991-05-02',
            'Germany',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 700000.00, 64,
            65, 62, 64, 63, 59, 64, TRUE
        );
    END IF;

    -- Player: Mark Flekken (mark-flekken)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'mark-flekken') THEN
        v_player_id := public.create_player_template_with_positions(
            'mark-flekken',
            v_club_id,
            'Mark Flekken',
            '1993-06-13',
            'Netherlands',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 6000000.00, 72,
            73, 70, 72, 71, 67, 72, TRUE
        );
    END IF;

    -- Player: Niklas Lomb (niklas-lomb)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'niklas-lomb') THEN
        v_player_id := public.create_player_template_with_positions(
            'niklas-lomb',
            v_club_id,
            'Niklas Lomb',
            '1993-07-28',
            'Germany',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 250000.00, 60,
            61, 58, 60, 59, 55, 60, TRUE
        );
    END IF;

    -- Player: Miguel Gutiérrez (miguel-gutierrez)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'miguel-gutierrez') THEN
        v_player_id := public.create_player_template_with_positions(
            'miguel-gutierrez',
            v_club_id,
            'Miguel Gutiérrez',
            '2001-07-27',
            'Spain',
            'LB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 22000000.00, 77,
            80, 52, 67, 70, 75, 76, TRUE
        );
    END IF;

    -- Player: Afonso Moreira (afonso-moreira)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'afonso-moreira') THEN
        v_player_id := public.create_player_template_with_positions(
            'afonso-moreira',
            v_club_id,
            'Afonso Moreira',
            '2005-03-19',
            'Portugal',
            'LW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 76,
            83, 75, 71, 79, 31, 61, TRUE
        );
    END IF;

    -- Player: Eliesse Ben Seghir (eliesse-ben-seghir)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'eliesse-ben-seghir') THEN
        v_player_id := public.create_player_template_with_positions(
            'eliesse-ben-seghir',
            v_club_id,
            'Eliesse Ben Seghir',
            '2005-02-16',
            'Morocco',
            'LW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 76,
            83, 75, 71, 79, 31, 61, TRUE
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
            v_player_id, 1, 8000000.00, 79,
            78, 78, 74, 79, 44, 72, TRUE
        );
    END IF;

    -- Player: Arthur (arthur)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'arthur') THEN
        v_player_id := public.create_player_template_with_positions(
            'arthur',
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
            v_player_id, 1, 8000000.00, 72,
            78, 45, 65, 72, 68, 66, TRUE
        );
    END IF;

    -- Player: Lucas Vázquez (lucas-vazquez)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'lucas-vazquez') THEN
        v_player_id := public.create_player_template_with_positions(
            'lucas-vazquez',
            v_club_id,
            'Lucas Vázquez',
            '1991-07-01',
            'Spain',
            'RB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 1500000.00, 68,
            71, 43, 58, 61, 66, 67, TRUE
        );
    END IF;

    -- Player: Ernest Poku (ernest-poku)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'ernest-poku') THEN
        v_player_id := public.create_player_template_with_positions(
            'ernest-poku',
            v_club_id,
            'Ernest Poku',
            '2004-01-28',
            'Netherlands',
            'RW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 25000000.00, 77,
            84, 76, 72, 80, 32, 62, TRUE
        );
    END IF;

    -- Player: Farid Alfa-Ruprecht (farid-alfa-ruprecht)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'farid-alfa-ruprecht') THEN
        v_player_id := public.create_player_template_with_positions(
            'farid-alfa-ruprecht',
            v_club_id,
            'Farid Alfa-Ruprecht',
            '2006-03-28',
            'Germany',
            'RW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 3000000.00, 66,
            73, 65, 61, 69, 21, 51, TRUE
        );
    END IF;

    -- Player: Montrell Culbreath (montrell-culbreath)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'montrell-culbreath') THEN
        v_player_id := public.create_player_template_with_positions(
            'montrell-culbreath',
            v_club_id,
            'Montrell Culbreath',
            '2007-08-29',
            'Germany',
            'RW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 15000000.00, 72,
            79, 71, 67, 75, 27, 57, TRUE
        );
    END IF;

    -- Player: Nathan Tella (nathan-tella)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'nathan-tella') THEN
        v_player_id := public.create_player_template_with_positions(
            'nathan-tella',
            v_club_id,
            'Nathan Tella',
            '1999-07-05',
            'Nigeria',
            'RW'::public.enum_player_position,
            ARRAY['RW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 15000000.00, 77,
            86, 70, 70, 77, 42, 64, TRUE
        );
    END IF;

    -- Player: Christian Kofane (christian-kofane)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'bayer-leverkusen';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'christian-kofane') THEN
        v_player_id := public.create_player_template_with_positions(
            'christian-kofane',
            v_club_id,
            'Christian Kofane',
            '2006-07-26',
            'Cameroon',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 40000000.00, 76,
            78, 79, 63, 73, 31, 77, TRUE
        );
    END IF;

    -- Player: Dro Fernández (dro-fernandez)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'paris-saint-germain';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'dro-fernandez') THEN
        v_player_id := public.create_player_template_with_positions(
            'dro-fernandez',
            v_club_id,
            'Dro Fernández',
            '2008-01-12',
            'Spain',
            'CAM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 10000000.00, 71,
            73, 69, 72, 73, 41, 59, TRUE
        );
    END IF;

    -- Player: Ilya Zabarnyi (ilya-zabarnyi)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'paris-saint-germain';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'ilya-zabarnyi') THEN
        v_player_id := public.create_player_template_with_positions(
            'ilya-zabarnyi',
            v_club_id,
            'Ilya Zabarnyi',
            '2002-09-01',
            'Ukraine',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 40000000.00, 79,
            71, 45, 57, 59, 80, 81, TRUE
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
            v_player_id, 1, 22000000.00, 77,
            72, 40, 72, 72, 78, 74, TRUE
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
            v_player_id, 1, 28000000.00, 87,
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
            v_player_id, 1, 80000000.00, 79,
            78, 36, 62, 64, 81, 82, TRUE
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
            'CDM'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 140000000.00, 85,
            78, 74, 84, 86, 74, 68, TRUE
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
            v_player_id, 1, 30000000.00, 82,
            66, 78, 83, 82, 74, 74, TRUE
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
            v_player_id, 1, 140000000.00, 80,
            76, 66, 80, 82, 77, 76, TRUE
        );
    END IF;

    -- Player: Senny Mayulu (senny-mayulu)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'paris-saint-germain';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'senny-mayulu') THEN
        v_player_id := public.create_player_template_with_positions(
            'senny-mayulu',
            v_club_id,
            'Senny Mayulu',
            '2006-05-17',
            'France',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 40000000.00, 76,
            74, 66, 77, 76, 68, 72, TRUE
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
            v_player_id, 1, 80000000.00, 80,
            78, 70, 78, 80, 76, 78, TRUE
        );
    END IF;

    -- Player: Alessandro Longoni (alessandro-longoni)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'paris-saint-germain';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'alessandro-longoni') THEN
        v_player_id := public.create_player_template_with_positions(
            'alessandro-longoni',
            v_club_id,
            'Alessandro Longoni',
            '2008-01-31',
            'Italy',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 300000.00, 58,
            59, 56, 58, 57, 53, 58, TRUE
        );
    END IF;

    -- Player: Lucas Chevalier (lucas-chevalier)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'paris-saint-germain';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'lucas-chevalier') THEN
        v_player_id := public.create_player_template_with_positions(
            'lucas-chevalier',
            v_club_id,
            'Lucas Chevalier',
            '2001-11-06',
            'France',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 25000000.00, 76,
            77, 74, 76, 75, 71, 76, TRUE
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
            v_player_id, 1, 30000000.00, 78,
            80, 76, 77, 75, 75, 78, TRUE
        );
    END IF;

    -- Player: Lucas Digne (lucas-digne)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'paris-saint-germain';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'lucas-digne') THEN
        v_player_id := public.create_player_template_with_positions(
            'lucas-digne',
            v_club_id,
            'Lucas Digne',
            '1993-07-20',
            'France',
            'LB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 6000000.00, 73,
            76, 48, 63, 66, 71, 72, TRUE
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
            v_player_id, 1, 18000000.00, 83,
            76, 54, 72, 72, 84, 81, TRUE
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
            v_player_id, 1, 80000000.00, 83,
            89, 64, 76, 81, 79, 76, TRUE
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
            v_player_id, 1, 90000000.00, 80,
            89, 74, 76, 82, 34, 64, TRUE
        );
    END IF;

    -- Player: Khvicha Kvaratskhelia (khvicha-kvaratskhelia)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'paris-saint-germain';
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
            v_player_id, 1, 140000000.00, 85,
            84, 82, 81, 88, 42, 74, TRUE
        );
    END IF;

    -- Player: Mika Godts (mika-godts)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'paris-saint-germain';
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
            v_player_id, 1, 35000000.00, 73,
            82, 66, 68, 78, 30, 54, TRUE
        );
    END IF;

    -- Player: Quentin Ndjantou (quentin-ndjantou)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'paris-saint-germain';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'quentin-ndjantou') THEN
        v_player_id := public.create_player_template_with_positions(
            'quentin-ndjantou',
            v_club_id,
            'Quentin Ndjantou',
            '2007-07-23',
            'France',
            'LW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 8000000.00, 70,
            77, 69, 65, 73, 25, 55, TRUE
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
            v_player_id, 1, 80000000.00, 84,
            92, 75, 80, 82, 76, 78, TRUE
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
            'RW'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 120000000.00, 77,
            82, 72, 76, 83, 45, 66, TRUE
        );
    END IF;

    -- Player: Ibrahim Mbaye (ibrahim-mbaye)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'paris-saint-germain';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'ibrahim-mbaye') THEN
        v_player_id := public.create_player_template_with_positions(
            'ibrahim-mbaye',
            v_club_id,
            'Ibrahim Mbaye',
            '2008-01-24',
            'Senegal',
            'RW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 30000000.00, 75,
            82, 74, 70, 78, 30, 60, TRUE
        );
    END IF;

    -- Player: Maghnes Akliouche (maghnes-akliouche)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'paris-saint-germain';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'maghnes-akliouche') THEN
        v_player_id := public.create_player_template_with_positions(
            'maghnes-akliouche',
            v_club_id,
            'Maghnes Akliouche',
            '2002-02-25',
            'France',
            'RW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 50000000.00, 80,
            87, 79, 75, 83, 35, 65, TRUE
        );
    END IF;

    -- Player: Ferran Torres (ferran-torres)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'paris-saint-germain';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'ferran-torres') THEN
        v_player_id := public.create_player_template_with_positions(
            'ferran-torres',
            v_club_id,
            'Ferran Torres',
            '2000-02-29',
            'Spain',
            'ST'::public.enum_player_position,
            ARRAY['ST'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 55000000.00, 80,
            82, 78, 76, 81, 35, 66, TRUE
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
            'ST'::public.enum_player_position,
            ARRAY['LW'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 100000000.00, 86,
            91, 77, 81, 89, 36, 56, TRUE
        );
    END IF;

    -- Player: Yanis Massolin (yanis-massolin)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'inter';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'yanis-massolin') THEN
        v_player_id := public.create_player_template_with_positions(
            'yanis-massolin',
            v_club_id,
            'Yanis Massolin',
            '2002-09-20',
            'France',
            'CAM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 4500000.00, 71,
            73, 69, 72, 73, 41, 59, TRUE
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
            v_player_id, 1, 65000000.00, 87,
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
            v_player_id, 1, 12000000.00, 84,
            74, 52, 74, 72, 84, 78, TRUE
        );
    END IF;

    -- Player: John Stones (john-stones)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'inter';
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
            v_player_id, 1, 12000000.00, 85,
            72, 51, 79, 78, 85, 77, TRUE
        );
    END IF;

    -- Player: Manuel Akanji (manuel-akanji)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'inter';
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
            v_player_id, 1, 17000000.00, 84,
            78, 48, 74, 73, 84, 80, TRUE
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
            v_player_id, 1, 50000000.00, 77,
            74, 38, 64, 65, 78, 84, TRUE
        );
    END IF;

    -- Player: Aleksandar Stanković (aleksandar-stankovic)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'inter';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'aleksandar-stankovic') THEN
        v_player_id := public.create_player_template_with_positions(
            'aleksandar-stankovic',
            v_club_id,
            'Aleksandar Stanković',
            '2005-08-03',
            'Serbia',
            'CDM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 32000000.00, 78,
            74, 60, 73, 71, 78, 79, TRUE
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
            'Türkiye',
            'CDM'::public.enum_player_position,
            ARRAY['CM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 16000000.00, 86,
            68, 80, 88, 84, 76, 72, TRUE
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
            v_player_id, 1, 12000000.00, 76,
            68, 64, 78, 77, 72, 68, TRUE
        );
    END IF;

    -- Player: Andy Diouf (andy-diouf)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'inter';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'andy-diouf') THEN
        v_player_id := public.create_player_template_with_positions(
            'andy-diouf',
            v_club_id,
            'Andy Diouf',
            '2003-05-17',
            'France',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 76,
            74, 66, 77, 76, 68, 72, TRUE
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
            v_player_id, 1, 3000000.00, 83,
            72, 78, 82, 83, 70, 68, TRUE
        );
    END IF;

    -- Player: Nicolò Barella (nicolo-barella)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'inter';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'nicolo-barella') THEN
        v_player_id := public.create_player_template_with_positions(
            'nicolo-barella',
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
            v_player_id, 1, 50000000.00, 87,
            80, 76, 84, 84, 79, 82, TRUE
        );
    END IF;

    -- Player: Petar Sučić (petar-sucic)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'inter';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'petar-sucic') THEN
        v_player_id := public.create_player_template_with_positions(
            'petar-sucic',
            v_club_id,
            'Petar Sučić',
            '2003-10-25',
            'Croatia',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 45000000.00, 79,
            77, 69, 80, 79, 71, 75, TRUE
        );
    END IF;

    -- Player: Piotr Zielinski (piotr-zielinski)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'inter';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'piotr-zielinski') THEN
        v_player_id := public.create_player_template_with_positions(
            'piotr-zielinski',
            v_club_id,
            'Piotr Zielinski',
            '1994-05-20',
            'Poland',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 10000000.00, 74,
            72, 64, 75, 74, 66, 70, TRUE
        );
    END IF;

    -- Player: Ivan Provedel (ivan-provedel)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'inter';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'ivan-provedel') THEN
        v_player_id := public.create_player_template_with_positions(
            'ivan-provedel',
            v_club_id,
            'Ivan Provedel',
            '1994-03-17',
            'Italy',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 3000000.00, 68,
            69, 66, 68, 67, 63, 68, TRUE
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
            v_player_id, 1, 10000000.00, 76,
            76, 74, 75, 72, 76, 75, TRUE
        );
    END IF;

    -- Player: Raffaele Di Gennaro (raffaele-di-gennaro)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'inter';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'raffaele-di-gennaro') THEN
        v_player_id := public.create_player_template_with_positions(
            'raffaele-di-gennaro',
            v_club_id,
            'Raffaele Di Gennaro',
            '1993-10-03',
            'Italy',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 300000.00, 60,
            61, 58, 60, 59, 55, 60, TRUE
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
            'LB'::public.enum_player_position,
            ARRAY['LWB'::public.enum_player_position, 'CB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 23000000.00, 79,
            82, 62, 74, 76, 76, 78, TRUE
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
            'LB'::public.enum_player_position,
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

    -- Player: Djed Spence (djed-spence)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'inter';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'djed-spence') THEN
        v_player_id := public.create_player_template_with_positions(
            'djed-spence',
            v_club_id,
            'Djed Spence',
            '2000-08-09',
            'England',
            'RB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 40000000.00, 79,
            82, 54, 69, 72, 77, 78, TRUE
        );
    END IF;

    -- Player: Luis Henrique (luis-henrique)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'inter';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'luis-henrique') THEN
        v_player_id := public.create_player_template_with_positions(
            'luis-henrique',
            v_club_id,
            'Luis Henrique',
            '2001-12-14',
            'Brazil',
            'RM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 22000000.00, 77,
            81, 72, 74, 78, 50, 67, TRUE
        );
    END IF;

    -- Player: Ange-Yoan Bonny (ange-yoan-bonny)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'inter';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'ange-yoan-bonny') THEN
        v_player_id := public.create_player_template_with_positions(
            'ange-yoan-bonny',
            v_club_id,
            'Ange-Yoan Bonny',
            '2003-10-25',
            'Cote d''Ivoire',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 78,
            80, 81, 65, 75, 33, 79, TRUE
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
            v_player_id, 1, 85000000.00, 89,
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
            v_player_id, 1, 50000000.00, 83,
            86, 80, 75, 80, 42, 82, TRUE
        );
    END IF;

    -- Player: Pio Esposito (pio-esposito)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'inter';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'pio-esposito') THEN
        v_player_id := public.create_player_template_with_positions(
            'pio-esposito',
            v_club_id,
            'Pio Esposito',
            '2005-06-28',
            'Italy',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 45000000.00, 79,
            81, 82, 66, 76, 34, 80, TRUE
        );
    END IF;

    -- Player: Alphadjo Cissè (alphadjo-cisse)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'alphadjo-cisse') THEN
        v_player_id := public.create_player_template_with_positions(
            'alphadjo-cisse',
            v_club_id,
            'Alphadjo Cissè',
            '2006-10-22',
            'Italy',
            'CAM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 7000000.00, 69,
            71, 67, 70, 71, 39, 57, TRUE
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
            v_player_id, 1, 17000000.00, 82,
            82, 40, 62, 64, 83, 80, TRUE
        );
    END IF;

    -- Player: Filippo Terracciano (filippo-terracciano)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'filippo-terracciano') THEN
        v_player_id := public.create_player_template_with_positions(
            'filippo-terracciano',
            v_club_id,
            'Filippo Terracciano',
            '2003-02-08',
            'Italy',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 4500000.00, 71,
            63, 37, 49, 51, 72, 73, TRUE
        );
    END IF;

    -- Player: Koni De Winter (koni-de-winter)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'koni-de-winter') THEN
        v_player_id := public.create_player_template_with_positions(
            'koni-de-winter',
            v_club_id,
            'Koni De Winter',
            '2002-06-12',
            'Belgium',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 23000000.00, 77,
            69, 43, 55, 57, 78, 79, TRUE
        );
    END IF;

    -- Player: Mario Gila (mario-gila)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'mario-gila') THEN
        v_player_id := public.create_player_template_with_positions(
            'mario-gila',
            v_club_id,
            'Mario Gila',
            '2000-08-29',
            'Spain',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 30000000.00, 78,
            70, 44, 56, 58, 79, 80, TRUE
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
            v_player_id, 1, 17000000.00, 77,
            65, 34, 60, 60, 79, 78, TRUE
        );
    END IF;

    -- Player: Sankhoun Diawara (sankhoun-diawara)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'sankhoun-diawara') THEN
        v_player_id := public.create_player_template_with_positions(
            'sankhoun-diawara',
            v_club_id,
            'Sankhoun Diawara',
            '2006-01-13',
            'France',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 2000000.00, 65,
            57, 31, 43, 45, 66, 67, TRUE
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
            v_player_id, 1, 40000000.00, 78,
            76, 42, 60, 62, 79, 86, TRUE
        );
    END IF;

    -- Player: Ardon Jashari (ardon-jashari)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'ardon-jashari') THEN
        v_player_id := public.create_player_template_with_positions(
            'ardon-jashari',
            v_club_id,
            'Ardon Jashari',
            '2002-07-30',
            'Switzerland',
            'CDM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 25000000.00, 77,
            73, 59, 72, 70, 77, 78, TRUE
        );
    END IF;

    -- Player: Samuele Ricci (samuele-ricci)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'samuele-ricci') THEN
        v_player_id := public.create_player_template_with_positions(
            'samuele-ricci',
            v_club_id,
            'Samuele Ricci',
            '2001-08-21',
            'Italy',
            'CDM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 22000000.00, 77,
            73, 59, 72, 70, 77, 78, TRUE
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
            v_player_id, 1, 23000000.00, 80,
            74, 66, 76, 77, 79, 83, TRUE
        );
    END IF;

    -- Player: Adrien Rabiot (adrien-rabiot)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'adrien-rabiot') THEN
        v_player_id := public.create_player_template_with_positions(
            'adrien-rabiot',
            v_club_id,
            'Adrien Rabiot',
            '1995-04-03',
            'France',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 18000000.00, 76,
            74, 66, 77, 76, 68, 72, TRUE
        );
    END IF;

    -- Player: Christian Comotto (christian-comotto)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'christian-comotto') THEN
        v_player_id := public.create_player_template_with_positions(
            'christian-comotto',
            v_club_id,
            'Christian Comotto',
            '2008-04-25',
            'Italy',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 5000000.00, 68,
            66, 58, 69, 68, 60, 64, TRUE
        );
    END IF;

    -- Player: Luka Modrić (luka-modric)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
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
            v_player_id, 1, 3500000.00, 86,
            71, 75, 89, 87, 72, 65, TRUE
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
            v_player_id, 1, 8500000.00, 80,
            75, 75, 78, 82, 74, 84, TRUE
        );
    END IF;

    -- Player: Warren Bondo (warren-bondo)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'warren-bondo') THEN
        v_player_id := public.create_player_template_with_positions(
            'warren-bondo',
            v_club_id,
            'Warren Bondo',
            '2003-09-15',
            'France',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 6000000.00, 72,
            70, 62, 73, 72, 64, 68, TRUE
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
            v_player_id, 1, 14000000.00, 76,
            82, 62, 74, 79, 70, 76, TRUE
        );
    END IF;

    -- Player: Lorenzo Torriani (lorenzo-torriani)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'lorenzo-torriani') THEN
        v_player_id := public.create_player_template_with_positions(
            'lorenzo-torriani',
            v_club_id,
            'Lorenzo Torriani',
            '2005-01-31',
            'Italy',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 800000.00, 63,
            64, 61, 63, 62, 58, 63, TRUE
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
            v_player_id, 1, 20000000.00, 87,
            87, 85, 86, 84, 88, 86, TRUE
        );
    END IF;

    -- Player: Pietro Terracciano (pietro-terracciano)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'pietro-terracciano') THEN
        v_player_id := public.create_player_template_with_positions(
            'pietro-terracciano',
            v_club_id,
            'Pietro Terracciano',
            '1990-03-08',
            'Italy',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 900000.00, 65,
            66, 63, 65, 64, 60, 65, TRUE
        );
    END IF;

    -- Player: Davide Bartesaghi (davide-bartesaghi)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'davide-bartesaghi') THEN
        v_player_id := public.create_player_template_with_positions(
            'davide-bartesaghi',
            v_club_id,
            'Davide Bartesaghi',
            '2005-12-29',
            'Italy',
            'LB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 22000000.00, 74,
            77, 49, 64, 67, 72, 73, TRUE
        );
    END IF;

    -- Player: Pervis Estupiñán (pervis-estupinan)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'pervis-estupinan') THEN
        v_player_id := public.create_player_template_with_positions(
            'pervis-estupinan',
            v_club_id,
            'Pervis Estupiñán',
            '1998-01-21',
            'Ecuador',
            'LB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 12000000.00, 74,
            77, 49, 64, 67, 72, 73, TRUE
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
            v_player_id, 1, 50000000.00, 86,
            93, 79, 76, 87, 36, 77, TRUE
        );
    END IF;

    -- Player: Alexis Saelemaekers (alexis-saelemaekers)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'alexis-saelemaekers') THEN
        v_player_id := public.create_player_template_with_positions(
            'alexis-saelemaekers',
            v_club_id,
            'Alexis Saelemaekers',
            '1999-06-27',
            'Belgium',
            'RM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 76,
            80, 71, 73, 77, 49, 66, TRUE
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
            v_player_id, 1, 40000000.00, 83,
            85, 80, 78, 85, 42, 66, TRUE
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
            v_player_id, 1, 18000000.00, 78,
            86, 72, 73, 82, 34, 62, TRUE
        );
    END IF;

    -- Player: Christopher Nkunku (christopher-nkunku)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'christopher-nkunku') THEN
        v_player_id := public.create_player_template_with_positions(
            'christopher-nkunku',
            v_club_id,
            'Christopher Nkunku',
            '1997-11-14',
            'France',
            'ST'::public.enum_player_position,
            ARRAY['ST'::public.enum_player_position, 'CAM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 25000000.00, 83,
            82, 82, 80, 86, 38, 67, TRUE
        );
    END IF;

    -- Player: Francesco Camarda (francesco-camarda)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'francesco-camarda') THEN
        v_player_id := public.create_player_template_with_positions(
            'francesco-camarda',
            v_club_id,
            'Francesco Camarda',
            '2008-03-10',
            'Italy',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 15000000.00, 72,
            74, 75, 59, 69, 27, 73, TRUE
        );
    END IF;

    -- Player: Gonçalo Ramos (goncalo-ramos)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
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

    -- Player: Santiago Gimenez (santiago-gimenez)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ac-milan';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'santiago-gimenez') THEN
        v_player_id := public.create_player_template_with_positions(
            'santiago-gimenez',
            v_club_id,
            'Santiago Gimenez',
            '2001-04-18',
            'Mexico',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 18000000.00, 76,
            78, 79, 63, 73, 31, 77, TRUE
        );
    END IF;

    -- Player: Bremer (bremer)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'juventus';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'bremer') THEN
        v_player_id := public.create_player_template_with_positions(
            'bremer',
            v_club_id,
            'Bremer',
            '1997-03-18',
            'Brazil',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 78,
            70, 44, 56, 58, 79, 80, TRUE
        );
    END IF;

    -- Player: Daniele Rugani (daniele-rugani)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'juventus';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'daniele-rugani') THEN
        v_player_id := public.create_player_template_with_positions(
            'daniele-rugani',
            v_club_id,
            'Daniele Rugani',
            '1994-07-29',
            'Italy',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 2000000.00, 68,
            60, 34, 46, 48, 69, 70, TRUE
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
            v_player_id, 1, 14000000.00, 78,
            72, 45, 60, 62, 80, 82, TRUE
        );
    END IF;

    -- Player: Jhon Lucumí (jhon-lucumi)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'juventus';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jhon-lucumi') THEN
        v_player_id := public.create_player_template_with_positions(
            'jhon-lucumi',
            v_club_id,
            'Jhon Lucumí',
            '1998-06-26',
            'Colombia',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 22000000.00, 77,
            69, 43, 55, 57, 78, 79, TRUE
        );
    END IF;

    -- Player: Lloyd Kelly (lloyd-kelly)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'juventus';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'lloyd-kelly') THEN
        v_player_id := public.create_player_template_with_positions(
            'lloyd-kelly',
            v_club_id,
            'Lloyd Kelly',
            '1998-10-06',
            'England',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 23000000.00, 77,
            69, 43, 55, 57, 78, 79, TRUE
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
            v_player_id, 1, 32000000.00, 77,
            80, 38, 66, 68, 78, 74, TRUE
        );
    END IF;

    -- Player: Arthur Melo (arthur-melo)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'juventus';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'arthur-melo') THEN
        v_player_id := public.create_player_template_with_positions(
            'arthur-melo',
            v_club_id,
            'Arthur Melo',
            '1996-08-12',
            'Brazil',
            'CDM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 4000000.00, 70,
            66, 52, 65, 63, 70, 71, TRUE
        );
    END IF;

    -- Player: Manuel Locatelli (manuel-locatelli)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'juventus';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'manuel-locatelli') THEN
        v_player_id := public.create_player_template_with_positions(
            'manuel-locatelli',
            v_club_id,
            'Manuel Locatelli',
            '1998-01-08',
            'Italy',
            'CDM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 25000000.00, 77,
            73, 59, 72, 70, 77, 78, TRUE
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
            'CDM'::public.enum_player_position,
            ARRAY['CM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 14000000.00, 83,
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
            v_player_id, 1, 18000000.00, 83,
            70, 77, 83, 83, 78, 77, TRUE
        );
    END IF;

    -- Player: Fabio Miretti (fabio-miretti)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'juventus';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'fabio-miretti') THEN
        v_player_id := public.create_player_template_with_positions(
            'fabio-miretti',
            v_club_id,
            'Fabio Miretti',
            '2003-08-03',
            'Italy',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 15000000.00, 75,
            73, 65, 76, 75, 67, 71, TRUE
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
            v_player_id, 1, 38000000.00, 79,
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
            v_player_id, 1, 30000000.00, 80,
            76, 72, 76, 78, 76, 82, TRUE
        );
    END IF;

    -- Player: Carlo Pinsoglio (carlo-pinsoglio)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'juventus';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'carlo-pinsoglio') THEN
        v_player_id := public.create_player_template_with_positions(
            'carlo-pinsoglio',
            v_club_id,
            'Carlo Pinsoglio',
            '1990-03-16',
            'Italy',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 200000.00, 60,
            61, 58, 60, 59, 55, 60, TRUE
        );
    END IF;

    -- Player: Guglielmo Vicario (guglielmo-vicario)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'juventus';
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
            v_player_id, 1, 18000000.00, 83,
            84, 81, 82, 78, 76, 84, TRUE
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
            v_player_id, 1, 2000000.00, 78,
            79, 77, 78, 75, 72, 77, TRUE
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
            v_player_id, 1, 10000000.00, 82,
            83, 80, 82, 78, 77, 82, TRUE
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
            'LB'::public.enum_player_position,
            ARRAY['LB'::public.enum_player_position, 'CM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 81,
            80, 64, 78, 81, 77, 73, TRUE
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
            v_player_id, 1, 7000000.00, 74,
            75, 38, 64, 68, 74, 76, TRUE
        );
    END IF;

    -- Player: Jérémie Boga (jeremie-boga)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'juventus';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jeremie-boga') THEN
        v_player_id := public.create_player_template_with_positions(
            'jeremie-boga',
            v_club_id,
            'Jérémie Boga',
            '1997-01-03',
            'Cote d''Ivoire',
            'LW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 8000000.00, 73,
            80, 72, 68, 76, 28, 58, TRUE
        );
    END IF;

    -- Player: Kenan Yıldız (kenan-yldz)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'juventus';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'kenan-yldz') THEN
        v_player_id := public.create_player_template_with_positions(
            'kenan-yldz',
            v_club_id,
            'Kenan Yıldız',
            '2005-05-04',
            'Türkiye',
            'LW'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position, 'ST'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 75000000.00, 79,
            82, 76, 75, 83, 40, 68, TRUE
        );
    END IF;

    -- Player: Kerim Alajbegovic (kerim-alajbegovic)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'juventus';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'kerim-alajbegovic') THEN
        v_player_id := public.create_player_template_with_positions(
            'kerim-alajbegovic',
            v_club_id,
            'Kerim Alajbegovic',
            '2007-09-21',
            'Bosnia-Herzegovina',
            'LW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 25000000.00, 74,
            81, 73, 69, 77, 29, 59, TRUE
        );
    END IF;

    -- Player: Nico González (nico-gonzalez-juventus)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'juventus';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'nico-gonzalez-juventus') THEN
        v_player_id := public.create_player_template_with_positions(
            'nico-gonzalez-juventus',
            v_club_id,
            'Nico González',
            '1998-04-06',
            'Argentina',
            'LW'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 22000000.00, 77,
            74, 68, 77, 78, 74, 78, TRUE
        );
    END IF;

    -- Player: Zeki Çelik (zeki-celik)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'juventus';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'zeki-celik') THEN
        v_player_id := public.create_player_template_with_positions(
            'zeki-celik',
            v_club_id,
            'Zeki Çelik',
            '1997-02-17',
            'Türkiye',
            'RB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 14000000.00, 75,
            78, 50, 65, 68, 73, 74, TRUE
        );
    END IF;

    -- Player: Edon Zhegrova (edon-zhegrova)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'juventus';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'edon-zhegrova') THEN
        v_player_id := public.create_player_template_with_positions(
            'edon-zhegrova',
            v_club_id,
            'Edon Zhegrova',
            '1999-03-31',
            'Kosovo',
            'RW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 10000000.00, 74,
            81, 73, 69, 77, 29, 59, TRUE
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
            v_player_id, 1, 30000000.00, 77,
            87, 71, 72, 84, 30, 56, TRUE
        );
    END IF;

    -- Player: Arkadiusz Milik (arkadiusz-milik)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'juventus';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'arkadiusz-milik') THEN
        v_player_id := public.create_player_template_with_positions(
            'arkadiusz-milik',
            v_club_id,
            'Arkadiusz Milik',
            '1994-02-28',
            'Poland',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 1500000.00, 67,
            69, 70, 54, 64, 22, 68, TRUE
        );
    END IF;

    -- Player: Jeff Ekhator (jeff-ekhator)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'juventus';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jeff-ekhator') THEN
        v_player_id := public.create_player_template_with_positions(
            'jeff-ekhator',
            v_club_id,
            'Jeff Ekhator',
            '2006-11-11',
            'Italy',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 18000000.00, 73,
            75, 76, 60, 70, 28, 74, TRUE
        );
    END IF;

    -- Player: Jonathan David (jonathan-david)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'juventus';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jonathan-david') THEN
        v_player_id := public.create_player_template_with_positions(
            'jonathan-david',
            v_club_id,
            'Jonathan David',
            '2000-01-14',
            'Canada',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 30000000.00, 78,
            80, 81, 65, 75, 33, 79, TRUE
        );
    END IF;

    -- Player: Randal Kolo Muani (randal-kolo-muani)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'juventus';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'randal-kolo-muani') THEN
        v_player_id := public.create_player_template_with_positions(
            'randal-kolo-muani',
            v_club_id,
            'Randal Kolo Muani',
            '1998-12-05',
            'France',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 76,
            78, 79, 63, 73, 31, 77, TRUE
        );
    END IF;

    -- Player: Antonio Vergara (antonio-vergara)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'napoli';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'antonio-vergara') THEN
        v_player_id := public.create_player_template_with_positions(
            'antonio-vergara',
            v_club_id,
            'Antonio Vergara',
            '2003-01-16',
            'Italy',
            'CAM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 15000000.00, 75,
            77, 73, 76, 77, 45, 63, TRUE
        );
    END IF;

    -- Player: Kevin De Bruyne (kevin-de-bruyne)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'napoli';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'kevin-de-bruyne') THEN
        v_player_id := public.create_player_template_with_positions(
            'kevin-de-bruyne',
            v_club_id,
            'Kevin De Bruyne',
            '1991-06-28',
            'Belgium',
            'CAM'::public.enum_player_position,
            ARRAY['CAM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 8000000.00, 90,
            72, 88, 94, 87, 65, 75, TRUE
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
            v_player_id, 1, 30000000.00, 81,
            74, 38, 62, 64, 82, 84, TRUE
        );
    END IF;

    -- Player: Amir Rrahmani (amir-rrahmani)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'napoli';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'amir-rrahmani') THEN
        v_player_id := public.create_player_template_with_positions(
            'amir-rrahmani',
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
            v_player_id, 1, 10000000.00, 80,
            66, 45, 62, 62, 81, 80, TRUE
        );
    END IF;

    -- Player: Christian Garofalo (christian-garofalo)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'napoli';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'christian-garofalo') THEN
        v_player_id := public.create_player_template_with_positions(
            'christian-garofalo',
            v_club_id,
            'Christian Garofalo',
            '2007-01-04',
            'Italy',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 250000.00, 58,
            50, 24, 36, 38, 59, 60, TRUE
        );
    END IF;

    -- Player: Luca Marianucci (luca-marianucci)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'napoli';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'luca-marianucci') THEN
        v_player_id := public.create_player_template_with_positions(
            'luca-marianucci',
            v_club_id,
            'Luca Marianucci',
            '2004-07-23',
            'Italy',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 7000000.00, 72,
            64, 38, 50, 52, 73, 74, TRUE
        );
    END IF;

    -- Player: Nosa Edward Obaretin (nosa-edward-obaretin)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'napoli';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'nosa-edward-obaretin') THEN
        v_player_id := public.create_player_template_with_positions(
            'nosa-edward-obaretin',
            v_club_id,
            'Nosa Edward Obaretin',
            '2003-01-26',
            'Italy',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 1500000.00, 67,
            59, 33, 45, 47, 68, 69, TRUE
        );
    END IF;

    -- Player: Rafa Marín (rafa-marin)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'napoli';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'rafa-marin') THEN
        v_player_id := public.create_player_template_with_positions(
            'rafa-marin',
            v_club_id,
            'Rafa Marín',
            '2002-05-19',
            'Spain',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 12000000.00, 74,
            66, 40, 52, 54, 75, 76, TRUE
        );
    END IF;

    -- Player: Sam Beukema (sam-beukema)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'napoli';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'sam-beukema') THEN
        v_player_id := public.create_player_template_with_positions(
            'sam-beukema',
            v_club_id,
            'Sam Beukema',
            '1998-11-17',
            'Netherlands',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 22000000.00, 77,
            69, 43, 55, 57, 78, 79, TRUE
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
            'CDM'::public.enum_player_position,
            ARRAY['CDM'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 77,
            66, 62, 80, 78, 70, 66, TRUE
        );
    END IF;

    -- Player: Jens Cajuste (jens-cajuste)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'napoli';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jens-cajuste') THEN
        v_player_id := public.create_player_template_with_positions(
            'jens-cajuste',
            v_club_id,
            'Jens Cajuste',
            '1999-08-10',
            'Sweden',
            'CDM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 7000000.00, 72,
            68, 54, 67, 65, 72, 73, TRUE
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
            v_player_id, 1, 10000000.00, 83,
            72, 60, 81, 84, 79, 72, TRUE
        );
    END IF;

    -- Player: Frank Anguissa (frank-anguissa)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'napoli';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'frank-anguissa') THEN
        v_player_id := public.create_player_template_with_positions(
            'frank-anguissa',
            v_club_id,
            'Frank Anguissa',
            '1995-11-16',
            'Cameroon',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 15000000.00, 75,
            73, 65, 76, 75, 67, 71, TRUE
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
            v_player_id, 1, 5000000.00, 76,
            76, 74, 72, 76, 70, 83, TRUE
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
            v_player_id, 1, 40000000.00, 80,
            74, 77, 75, 76, 76, 85, TRUE
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
            v_player_id, 1, 8000000.00, 81,
            82, 79, 81, 78, 72, 80, TRUE
        );
    END IF;

    -- Player: Nikita Contini (nikita-contini)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'napoli';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'nikita-contini') THEN
        v_player_id := public.create_player_template_with_positions(
            'nikita-contini',
            v_club_id,
            'Nikita Contini',
            '1996-05-21',
            'Italy',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 400000.00, 61,
            62, 59, 61, 60, 56, 61, TRUE
        );
    END IF;

    -- Player: Vanja Milinković-Savić (vanja-milinkovic-savic)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'napoli';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'vanja-milinkovic-savic') THEN
        v_player_id := public.create_player_template_with_positions(
            'vanja-milinkovic-savic',
            v_club_id,
            'Vanja Milinković-Savić',
            '1997-02-20',
            'Serbia',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 75,
            76, 73, 75, 74, 70, 75, TRUE
        );
    END IF;

    -- Player: Leonardo Spinazzola (leonardo-spinazzola)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'napoli';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'leonardo-spinazzola') THEN
        v_player_id := public.create_player_template_with_positions(
            'leonardo-spinazzola',
            v_club_id,
            'Leonardo Spinazzola',
            '1993-03-25',
            'Italy',
            'LB'::public.enum_player_position,
            ARRAY['LB'::public.enum_player_position]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 3500000.00, 77,
            81, 62, 74, 78, 73, 68, TRUE
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

    -- Player: Alisson Santos (alisson-santos)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'napoli';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'alisson-santos') THEN
        v_player_id := public.create_player_template_with_positions(
            'alisson-santos',
            v_club_id,
            'Alisson Santos',
            '2002-09-27',
            'Brazil',
            'LW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 28000000.00, 77,
            84, 76, 72, 80, 32, 62, TRUE
        );
    END IF;

    -- Player: Noa Lang (noa-lang)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'napoli';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'noa-lang') THEN
        v_player_id := public.create_player_template_with_positions(
            'noa-lang',
            v_club_id,
            'Noa Lang',
            '1999-06-17',
            'Netherlands',
            'LW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 22000000.00, 77,
            84, 76, 72, 80, 32, 62, TRUE
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
            v_player_id, 1, 7500000.00, 82,
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
            v_player_id, 1, 1500000.00, 74,
            78, 58, 68, 73, 72, 72, TRUE
        );
    END IF;

    -- Player: Cyril Ngonge (cyril-ngonge)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'napoli';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'cyril-ngonge') THEN
        v_player_id := public.create_player_template_with_positions(
            'cyril-ngonge',
            v_club_id,
            'Cyril Ngonge',
            '2000-05-26',
            'Belgium',
            'RW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 7000000.00, 72,
            79, 71, 67, 75, 27, 57, TRUE
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
            v_player_id, 1, 23000000.00, 79,
            84, 74, 75, 84, 38, 62, TRUE
        );
    END IF;

    -- Player: Jesper Lindstrøm (jesper-lindstrm)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'napoli';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jesper-lindstrm') THEN
        v_player_id := public.create_player_template_with_positions(
            'jesper-lindstrm',
            v_club_id,
            'Jesper Lindstrøm',
            '2000-02-29',
            'Denmark',
            'RW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 4000000.00, 70,
            77, 69, 65, 73, 25, 55, TRUE
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
            v_player_id, 1, 5000000.00, 79,
            80, 76, 76, 81, 44, 62, TRUE
        );
    END IF;

    -- Player: Lorenzo Lucca (lorenzo-lucca)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'napoli';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'lorenzo-lucca') THEN
        v_player_id := public.create_player_template_with_positions(
            'lorenzo-lucca',
            v_club_id,
            'Lorenzo Lucca',
            '2000-09-10',
            'Italy',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 76,
            78, 79, 63, 73, 31, 77, TRUE
        );
    END IF;

    -- Player: Rasmus Højlund (rasmus-hjlund)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'napoli';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'rasmus-hjlund') THEN
        v_player_id := public.create_player_template_with_positions(
            'rasmus-hjlund',
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
            v_player_id, 1, 60000000.00, 80,
            85, 78, 65, 74, 34, 82, TRUE
        );
    END IF;

    -- Player: Georgiy Sudakov (georgiy-sudakov)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'benfica';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'georgiy-sudakov') THEN
        v_player_id := public.create_player_template_with_positions(
            'georgiy-sudakov',
            v_club_id,
            'Georgiy Sudakov',
            '2002-09-01',
            'Ukraine',
            'CAM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 25000000.00, 77,
            79, 75, 78, 79, 47, 65, TRUE
        );
    END IF;

    -- Player: João Rego (joao-rego)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'benfica';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'joao-rego') THEN
        v_player_id := public.create_player_template_with_positions(
            'joao-rego',
            v_club_id,
            'João Rego',
            '2005-06-20',
            'Portugal',
            'CAM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 3000000.00, 69,
            71, 67, 70, 71, 39, 57, TRUE
        );
    END IF;

    -- Player: Clément Lenglet (clement-lenglet)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'benfica';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'clement-lenglet') THEN
        v_player_id := public.create_player_template_with_positions(
            'clement-lenglet',
            v_club_id,
            'Clément Lenglet',
            '1995-06-17',
            'France',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 4000000.00, 70,
            62, 36, 48, 50, 71, 72, TRUE
        );
    END IF;

    -- Player: Gabriel Índio (gabriel-indio)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'benfica';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'gabriel-indio') THEN
        v_player_id := public.create_player_template_with_positions(
            'gabriel-indio',
            v_club_id,
            'Gabriel Índio',
            '2008-07-26',
            'Brazil',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 50000.00, 58,
            50, 24, 36, 38, 59, 60, TRUE
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
            v_player_id, 1, 30000000.00, 76,
            75, 36, 66, 68, 77, 75, TRUE
        );
    END IF;

    -- Player: Enzo Barrenechea (enzo-barrenechea)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'benfica';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'enzo-barrenechea') THEN
        v_player_id := public.create_player_template_with_positions(
            'enzo-barrenechea',
            v_club_id,
            'Enzo Barrenechea',
            '2001-05-22',
            'Argentina',
            'CDM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 12000000.00, 74,
            70, 56, 69, 67, 74, 75, TRUE
        );
    END IF;

    -- Player: Manu Silva (manu-silva)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'benfica';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'manu-silva') THEN
        v_player_id := public.create_player_template_with_positions(
            'manu-silva',
            v_club_id,
            'Manu Silva',
            '2001-06-12',
            'Portugal',
            'CDM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 7000000.00, 72,
            68, 54, 67, 65, 72, 73, TRUE
        );
    END IF;

    -- Player: Richard Ríos (richard-rios)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'benfica';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'richard-rios') THEN
        v_player_id := public.create_player_template_with_positions(
            'richard-rios',
            v_club_id,
            'Richard Ríos',
            '2000-06-02',
            'Colombia',
            'CDM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 25000000.00, 77,
            73, 59, 72, 70, 77, 78, TRUE
        );
    END IF;

    -- Player: Rafa Silva (rafa-silva)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'benfica';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'rafa-silva') THEN
        v_player_id := public.create_player_template_with_positions(
            'rafa-silva',
            v_club_id,
            'Rafa Silva',
            '1993-05-17',
            'Portugal',
            'CF'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 4000000.00, 71,
            73, 72, 67, 72, 29, 64, TRUE
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
            v_player_id, 1, 15000000.00, 80,
            76, 70, 78, 79, 77, 80, TRUE
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
            v_player_id, 1, 18000000.00, 77,
            76, 66, 74, 76, 75, 79, TRUE
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

    -- Player: José Neto (jose-neto)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'benfica';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jose-neto') THEN
        v_player_id := public.create_player_template_with_positions(
            'jose-neto',
            v_club_id,
            'José Neto',
            '2008-04-19',
            'Portugal',
            'LB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 3000000.00, 66,
            69, 41, 56, 59, 64, 65, TRUE
        );
    END IF;

    -- Player: Samuel Dahl (samuel-dahl)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'benfica';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'samuel-dahl') THEN
        v_player_id := public.create_player_template_with_positions(
            'samuel-dahl',
            v_club_id,
            'Samuel Dahl',
            '2003-03-04',
            'Sweden',
            'LB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 13000000.00, 75,
            78, 50, 65, 68, 73, 74, TRUE
        );
    END IF;

    -- Player: Andreas Schjelderup (andreas-schjelderup)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'benfica';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'andreas-schjelderup') THEN
        v_player_id := public.create_player_template_with_positions(
            'andreas-schjelderup',
            v_club_id,
            'Andreas Schjelderup',
            '2004-06-01',
            'Norway',
            'LW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 40000000.00, 79,
            86, 78, 74, 82, 34, 64, TRUE
        );
    END IF;

    -- Player: Bruma (bruma)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'benfica';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'bruma') THEN
        v_player_id := public.create_player_template_with_positions(
            'bruma',
            v_club_id,
            'Bruma',
            '1994-10-24',
            'Portugal',
            'LW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 3000000.00, 69,
            76, 68, 64, 72, 24, 54, TRUE
        );
    END IF;

    -- Player: Jakub Kamiński (jakub-kaminski)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'benfica';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jakub-kaminski') THEN
        v_player_id := public.create_player_template_with_positions(
            'jakub-kaminski',
            v_club_id,
            'Jakub Kamiński',
            '2002-06-05',
            'Poland',
            'LW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 17000000.00, 76,
            83, 75, 71, 79, 31, 61, TRUE
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
            v_player_id, 1, 7000000.00, 77,
            84, 58, 72, 74, 74, 76, TRUE
        );
    END IF;

    -- Player: Daniel Banjaqui (daniel-banjaqui)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'benfica';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'daniel-banjaqui') THEN
        v_player_id := public.create_player_template_with_positions(
            'daniel-banjaqui',
            v_club_id,
            'Daniel Banjaqui',
            '2008-03-24',
            'Portugal',
            'RB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 5000000.00, 68,
            71, 43, 58, 61, 66, 67, TRUE
        );
    END IF;

    -- Player: Dodi Lukébakio (dodi-lukebakio)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'benfica';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'dodi-lukebakio') THEN
        v_player_id := public.create_player_template_with_positions(
            'dodi-lukebakio',
            v_club_id,
            'Dodi Lukébakio',
            '1997-09-24',
            'Belgium',
            'RW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 15000000.00, 75,
            82, 74, 70, 78, 30, 60, TRUE
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
            v_player_id, 1, 20000000.00, 71,
            79, 68, 68, 76, 32, 54, TRUE
        );
    END IF;

    -- Player: Tiago Gouveia (tiago-gouveia)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'benfica';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'tiago-gouveia') THEN
        v_player_id := public.create_player_template_with_positions(
            'tiago-gouveia',
            v_club_id,
            'Tiago Gouveia',
            '2001-06-18',
            'Portugal',
            'RW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 3500000.00, 70,
            77, 69, 65, 73, 25, 55, TRUE
        );
    END IF;

    -- Player: Anísio Cabral (anisio-cabral)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'benfica';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'anisio-cabral') THEN
        v_player_id := public.create_player_template_with_positions(
            'anisio-cabral',
            v_club_id,
            'Anísio Cabral',
            '2008-02-15',
            'Portugal',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 5000000.00, 68,
            70, 71, 55, 65, 23, 69, TRUE
        );
    END IF;

    -- Player: Jhon Durán (jhon-duran)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'benfica';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jhon-duran') THEN
        v_player_id := public.create_player_template_with_positions(
            'jhon-duran',
            v_club_id,
            'Jhon Durán',
            '2003-12-13',
            'Colombia',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 15000000.00, 75,
            77, 78, 62, 72, 30, 76, TRUE
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
            v_player_id, 1, 28000000.00, 79,
            76, 81, 70, 76, 38, 80, TRUE
        );
    END IF;

    -- Player: Gabri Veiga (gabri-veiga)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'gabri-veiga') THEN
        v_player_id := public.create_player_template_with_positions(
            'gabri-veiga',
            v_club_id,
            'Gabri Veiga',
            '2002-05-27',
            'Spain',
            'CAM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 30000000.00, 78,
            80, 76, 79, 80, 48, 66, TRUE
        );
    END IF;

    -- Player: Iván Jaime (ivan-jaime)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'ivan-jaime') THEN
        v_player_id := public.create_player_template_with_positions(
            'ivan-jaime',
            v_club_id,
            'Iván Jaime',
            '2000-09-26',
            'Spain',
            'CAM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 4000000.00, 70,
            72, 68, 71, 72, 40, 58, TRUE
        );
    END IF;

    -- Player: Rodrigo Mora (rodrigo-mora)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'rodrigo-mora') THEN
        v_player_id := public.create_player_template_with_positions(
            'rodrigo-mora',
            v_club_id,
            'Rodrigo Mora',
            '2007-05-05',
            'Portugal',
            'CAM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 38000000.00, 76,
            78, 74, 77, 78, 46, 64, TRUE
        );
    END IF;

    -- Player: Dominik Prpić (dominik-prpic)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'dominik-prpic') THEN
        v_player_id := public.create_player_template_with_positions(
            'dominik-prpic',
            v_club_id,
            'Dominik Prpić',
            '2004-05-19',
            'Croatia',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 4000000.00, 70,
            62, 36, 48, 50, 71, 72, TRUE
        );
    END IF;

    -- Player: Jakub Kiwior (jakub-kiwior)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jakub-kiwior') THEN
        v_player_id := public.create_player_template_with_positions(
            'jakub-kiwior',
            v_club_id,
            'Jakub Kiwior',
            '2000-02-15',
            'Poland',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 35000000.00, 78,
            70, 44, 56, 58, 79, 80, TRUE
        );
    END IF;

    -- Player: Jan Bednarek (jan-bednarek)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jan-bednarek') THEN
        v_player_id := public.create_player_template_with_positions(
            'jan-bednarek',
            v_club_id,
            'Jan Bednarek',
            '1996-04-12',
            'Poland',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 11000000.00, 74,
            66, 40, 52, 54, 75, 76, TRUE
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
            v_player_id, 1, 12000000.00, 77,
            72, 38, 58, 60, 78, 79, TRUE
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
            v_player_id, 1, 32000000.00, 79,
            72, 62, 75, 76, 80, 79, TRUE
        );
    END IF;

    -- Player: In-beom Hwang (in-beom-hwang)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'in-beom-hwang') THEN
        v_player_id := public.create_player_template_with_positions(
            'in-beom-hwang',
            v_club_id,
            'In-beom Hwang',
            '1996-09-20',
            'Korea, South',
            'CDM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 7000000.00, 72,
            68, 54, 67, 65, 72, 73, TRUE
        );
    END IF;

    -- Player: Pablo Rosario (pablo-rosario)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'pablo-rosario') THEN
        v_player_id := public.create_player_template_with_positions(
            'pablo-rosario',
            v_club_id,
            'Pablo Rosario',
            '1997-01-07',
            'Dominican Republic',
            'CDM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 8000000.00, 73,
            69, 55, 68, 66, 73, 74, TRUE
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
            v_player_id, 1, 6000000.00, 77,
            70, 68, 76, 76, 74, 75, TRUE
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
            v_player_id, 1, 2000000.00, 73,
            76, 64, 74, 76, 66, 68, TRUE
        );
    END IF;

    -- Player: Victor Froholdt (victor-froholdt)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'victor-froholdt') THEN
        v_player_id := public.create_player_template_with_positions(
            'victor-froholdt',
            v_club_id,
            'Victor Froholdt',
            '2006-02-25',
            'Denmark',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 50000000.00, 77,
            75, 67, 78, 77, 69, 73, TRUE
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
            v_player_id, 1, 800000.00, 74,
            75, 72, 74, 71, 70, 74, TRUE
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
            v_player_id, 1, 40000000.00, 84,
            85, 82, 84, 80, 86, 84, TRUE
        );
    END IF;

    -- Player: João Afonso (joao-afonso)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'joao-afonso') THEN
        v_player_id := public.create_player_template_with_positions(
            'joao-afonso',
            v_club_id,
            'João Afonso',
            '2007-04-30',
            'Portugal',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 1500000.00, 63,
            64, 61, 63, 62, 58, 63, TRUE
        );
    END IF;

    -- Player: João Costa (joao-costa)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'joao-costa') THEN
        v_player_id := public.create_player_template_with_positions(
            'joao-costa',
            v_club_id,
            'João Costa',
            '1996-02-02',
            'Portugal',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 500000.00, 62,
            63, 60, 62, 61, 57, 62, TRUE
        );
    END IF;

    -- Player: Francisco Moura (francisco-moura)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'francisco-moura') THEN
        v_player_id := public.create_player_template_with_positions(
            'francisco-moura',
            v_club_id,
            'Francisco Moura',
            '1999-08-16',
            'Portugal',
            'LB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 9000000.00, 73,
            76, 48, 63, 66, 71, 72, TRUE
        );
    END IF;

    -- Player: Zaidu Sanusi (zaidu-sanusi)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'zaidu-sanusi') THEN
        v_player_id := public.create_player_template_with_positions(
            'zaidu-sanusi',
            v_club_id,
            'Zaidu Sanusi',
            '1997-06-13',
            'Nigeria',
            'LB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 3000000.00, 69,
            72, 44, 59, 62, 67, 68, TRUE
        );
    END IF;

    -- Player: Borja Sainz (borja-sainz)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'borja-sainz') THEN
        v_player_id := public.create_player_template_with_positions(
            'borja-sainz',
            v_club_id,
            'Borja Sainz',
            '2001-02-21',
            'Spain',
            'LW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 76,
            83, 75, 71, 79, 31, 61, TRUE
        );
    END IF;

    -- Player: Oskar Pietuszewski (oskar-pietuszewski)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'oskar-pietuszewski') THEN
        v_player_id := public.create_player_template_with_positions(
            'oskar-pietuszewski',
            v_club_id,
            'Oskar Pietuszewski',
            '2008-05-20',
            'Poland',
            'LW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 25000000.00, 74,
            81, 73, 69, 77, 29, 59, TRUE
        );
    END IF;

    -- Player: Alberto Costa (alberto-costa)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'alberto-costa') THEN
        v_player_id := public.create_player_template_with_positions(
            'alberto-costa',
            v_club_id,
            'Alberto Costa',
            '2003-09-29',
            'Portugal',
            'RB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 18000000.00, 76,
            79, 51, 66, 69, 74, 75, TRUE
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
            v_player_id, 1, 12000000.00, 72,
            78, 48, 66, 72, 68, 64, TRUE
        );
    END IF;

    -- Player: Gabriel Veron (gabriel-veron)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'gabriel-veron') THEN
        v_player_id := public.create_player_template_with_positions(
            'gabriel-veron',
            v_club_id,
            'Gabriel Veron',
            '2002-09-03',
            'Brazil',
            'RW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 2500000.00, 68,
            75, 67, 63, 71, 23, 53, TRUE
        );
    END IF;

    -- Player: Pepê (pepe)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'pepe') THEN
        v_player_id := public.create_player_template_with_positions(
            'pepe',
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
            v_player_id, 1, 17000000.00, 81,
            88, 74, 76, 83, 56, 70, TRUE
        );
    END IF;

    -- Player: William Gomes (william-gomes)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'william-gomes') THEN
        v_player_id := public.create_player_template_with_positions(
            'william-gomes',
            v_club_id,
            'William Gomes',
            '2006-03-15',
            'Brazil',
            'RW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 25000000.00, 74,
            81, 73, 69, 77, 29, 59, TRUE
        );
    END IF;

    -- Player: André Silva (andre-silva)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'andre-silva') THEN
        v_player_id := public.create_player_template_with_positions(
            'andre-silva',
            v_club_id,
            'André Silva',
            '1995-11-06',
            'Portugal',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 3000000.00, 69,
            71, 72, 56, 66, 24, 70, TRUE
        );
    END IF;

    -- Player: Deniz Gül (deniz-gul)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'deniz-gul') THEN
        v_player_id := public.create_player_template_with_positions(
            'deniz-gul',
            v_club_id,
            'Deniz Gül',
            '2004-07-02',
            'Türkiye',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 5000000.00, 71,
            73, 74, 58, 68, 26, 72, TRUE
        );
    END IF;

    -- Player: Samu Aghehowa (samu-aghehowa)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'porto';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'samu-aghehowa') THEN
        v_player_id := public.create_player_template_with_positions(
            'samu-aghehowa',
            v_club_id,
            'Samu Aghehowa',
            '2004-05-05',
            'Spain',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 45000000.00, 79,
            81, 82, 66, 76, 34, 80, TRUE
        );
    END IF;

    -- Player: Abdellah Ouazane (abdellah-ouazane)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'abdellah-ouazane') THEN
        v_player_id := public.create_player_template_with_positions(
            'abdellah-ouazane',
            v_club_id,
            'Abdellah Ouazane',
            '2009-01-15',
            'Morocco',
            'CAM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 1500000.00, 64,
            66, 62, 65, 66, 34, 52, TRUE
        );
    END IF;

    -- Player: Julian Brandt (julian-brandt)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
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
            v_player_id, 1, 15000000.00, 84,
            77, 78, 85, 86, 54, 68, TRUE
        );
    END IF;

    -- Player: Oscar Gloukh (oscar-gloukh)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'oscar-gloukh') THEN
        v_player_id := public.create_player_template_with_positions(
            'oscar-gloukh',
            v_club_id,
            'Oscar Gloukh',
            '2004-04-01',
            'Israel',
            'CAM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 13000000.00, 75,
            77, 73, 76, 77, 45, 63, TRUE
        );
    END IF;

    -- Player: Rayane Bounida (rayane-bounida)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'rayane-bounida') THEN
        v_player_id := public.create_player_template_with_positions(
            'rayane-bounida',
            v_club_id,
            'Rayane Bounida',
            '2006-03-03',
            'Morocco',
            'CAM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 5000000.00, 68,
            70, 66, 69, 70, 38, 56, TRUE
        );
    END IF;

    -- Player: Aaron Bouwman (aaron-bouwman)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'aaron-bouwman') THEN
        v_player_id := public.create_player_template_with_positions(
            'aaron-bouwman',
            v_club_id,
            'Aaron Bouwman',
            '2007-08-28',
            'Netherlands',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 3500000.00, 67,
            59, 33, 45, 47, 68, 69, TRUE
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
            'Türkiye',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 7000000.00, 74,
            68, 34, 58, 60, 75, 76, TRUE
        );
    END IF;

    -- Player: Daley Blind (daley-blind)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'daley-blind') THEN
        v_player_id := public.create_player_template_with_positions(
            'daley-blind',
            v_club_id,
            'Daley Blind',
            '1990-03-09',
            'Netherlands',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 1200000.00, 67,
            59, 33, 45, 47, 68, 69, TRUE
        );
    END IF;

    -- Player: Dies Janse (dies-janse)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'dies-janse') THEN
        v_player_id := public.create_player_template_with_positions(
            'dies-janse',
            v_club_id,
            'Dies Janse',
            '2006-01-17',
            'Netherlands',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 6500000.00, 69,
            61, 35, 47, 49, 70, 71, TRUE
        );
    END IF;

    -- Player: Josip Sutalo (josip-sutalo)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'josip-sutalo') THEN
        v_player_id := public.create_player_template_with_positions(
            'josip-sutalo',
            v_club_id,
            'Josip Sutalo',
            '2000-02-28',
            'Croatia',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 12000000.00, 77,
            74, 38, 62, 64, 78, 78, TRUE
        );
    END IF;

    -- Player: Ko Itakura (ko-itakura)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'ko-itakura') THEN
        v_player_id := public.create_player_template_with_positions(
            'ko-itakura',
            v_club_id,
            'Ko Itakura',
            '1997-01-27',
            'Japan',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 8000000.00, 73,
            65, 39, 51, 53, 74, 75, TRUE
        );
    END IF;

    -- Player: Youri Baas (youri-baas)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'youri-baas') THEN
        v_player_id := public.create_player_template_with_positions(
            'youri-baas',
            v_club_id,
            'Youri Baas',
            '2003-03-17',
            'Netherlands',
            'CB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 76,
            68, 42, 54, 56, 77, 78, TRUE
        );
    END IF;

    -- Player: Jorthy Mokio (jorthy-mokio)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jorthy-mokio') THEN
        v_player_id := public.create_player_template_with_positions(
            'jorthy-mokio',
            v_club_id,
            'Jorthy Mokio',
            '2008-02-29',
            'DR Congo',
            'CDM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 8000000.00, 70,
            66, 52, 65, 63, 70, 71, TRUE
        );
    END IF;

    -- Player: Youri Regeer (youri-regeer)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'youri-regeer') THEN
        v_player_id := public.create_player_template_with_positions(
            'youri-regeer',
            v_club_id,
            'Youri Regeer',
            '2003-08-18',
            'Netherlands',
            'CDM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 5000000.00, 71,
            67, 53, 66, 64, 71, 72, TRUE
        );
    END IF;

    -- Player: Davy Klaassen (davy-klaassen)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'davy-klaassen') THEN
        v_player_id := public.create_player_template_with_positions(
            'davy-klaassen',
            v_club_id,
            'Davy Klaassen',
            '1993-02-21',
            'Netherlands',
            'CM'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 2000000.00, 69,
            67, 59, 70, 69, 61, 65, TRUE
        );
    END IF;

    -- Player: Joeri Heerkens (joeri-heerkens)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'joeri-heerkens') THEN
        v_player_id := public.create_player_template_with_positions(
            'joeri-heerkens',
            v_club_id,
            'Joeri Heerkens',
            '2006-05-08',
            'Netherlands',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 1000000.00, 61,
            62, 59, 61, 60, 56, 61, TRUE
        );
    END IF;

    -- Player: Maarten Paes (maarten-paes)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'maarten-paes') THEN
        v_player_id := public.create_player_template_with_positions(
            'maarten-paes',
            v_club_id,
            'Maarten Paes',
            '1998-05-14',
            'Indonesia',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 2000000.00, 67,
            68, 65, 67, 66, 62, 67, TRUE
        );
    END IF;

    -- Player: Marc ter Stegen (marc-ter-stegen)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'marc-ter-stegen') THEN
        v_player_id := public.create_player_template_with_positions(
            'marc-ter-stegen',
            v_club_id,
            'Marc ter Stegen',
            '1992-04-30',
            'Germany',
            'GK'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current
        ) VALUES (
            v_player_id, 1, 3000000.00, 69,
            70, 67, 69, 68, 64, 69, TRUE
        );
    END IF;

    -- Player: Caio Henrique (caio-henrique)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'caio-henrique') THEN
        v_player_id := public.create_player_template_with_positions(
            'caio-henrique',
            v_club_id,
            'Caio Henrique',
            '1997-07-31',
            'Brazil',
            'LB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 12000000.00, 74,
            77, 49, 64, 67, 72, 73, TRUE
        );
    END IF;

    -- Player: Jofre Torrents (jofre-torrents)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'jofre-torrents') THEN
        v_player_id := public.create_player_template_with_positions(
            'jofre-torrents',
            v_club_id,
            'Jofre Torrents',
            '2007-01-28',
            'Spain',
            'LB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 1000000.00, 62,
            65, 37, 52, 55, 60, 61, TRUE
        );
    END IF;

    -- Player: Owen Wijndal (owen-wijndal)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'owen-wijndal') THEN
        v_player_id := public.create_player_template_with_positions(
            'owen-wijndal',
            v_club_id,
            'Owen Wijndal',
            '1999-11-28',
            'Netherlands',
            'LB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 3000000.00, 69,
            72, 44, 59, 62, 67, 68, TRUE
        );
    END IF;

    -- Player: Amourricho van Axel Dongen (amourricho-van-axel-dongen)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'amourricho-van-axel-dongen') THEN
        v_player_id := public.create_player_template_with_positions(
            'amourricho-van-axel-dongen',
            v_club_id,
            'Amourricho van Axel Dongen',
            '2004-09-29',
            'Netherlands',
            'LW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 400000.00, 62,
            69, 61, 57, 65, 17, 47, TRUE
        );
    END IF;

    -- Player: Oliver Edvardsen (oliver-edvardsen)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'oliver-edvardsen') THEN
        v_player_id := public.create_player_template_with_positions(
            'oliver-edvardsen',
            v_club_id,
            'Oliver Edvardsen',
            '1999-03-19',
            'Norway',
            'LW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 3000000.00, 69,
            76, 68, 64, 72, 24, 54, TRUE
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
            v_player_id, 1, 5000000.00, 71,
            78, 50, 66, 70, 68, 70, TRUE
        );
    END IF;

    -- Player: Lucas Rosa (lucas-rosa)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'lucas-rosa') THEN
        v_player_id := public.create_player_template_with_positions(
            'lucas-rosa',
            v_club_id,
            'Lucas Rosa',
            '2000-04-03',
            'Brazil',
            'RB'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 5000000.00, 71,
            74, 46, 61, 64, 69, 70, TRUE
        );
    END IF;

    -- Player: Maher Carrizo (maher-carrizo)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'maher-carrizo') THEN
        v_player_id := public.create_player_template_with_positions(
            'maher-carrizo',
            v_club_id,
            'Maher Carrizo',
            '2006-02-19',
            'Argentina',
            'RW'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 8000000.00, 70,
            77, 69, 65, 73, 25, 55, TRUE
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
            v_player_id, 1, 2000000.00, 79,
            70, 79, 84, 82, 50, 64, TRUE
        );
    END IF;

    -- Player: Don-Angelo Konadu (don-angelo-konadu)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'don-angelo-konadu') THEN
        v_player_id := public.create_player_template_with_positions(
            'don-angelo-konadu',
            v_club_id,
            'Don-Angelo Konadu',
            '2006-05-03',
            'Netherlands',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 800000.00, 61,
            63, 64, 48, 58, 16, 62, TRUE
        );
    END IF;

    -- Player: Kasper Dolberg (kasper-dolberg)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'kasper-dolberg') THEN
        v_player_id := public.create_player_template_with_positions(
            'kasper-dolberg',
            v_club_id,
            'Kasper Dolberg',
            '1997-10-06',
            'Denmark',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 7000000.00, 72,
            74, 75, 59, 69, 27, 73, TRUE
        );
    END IF;

    -- Player: Marcos Leonardo (marcos-leonardo)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'marcos-leonardo') THEN
        v_player_id := public.create_player_template_with_positions(
            'marcos-leonardo',
            v_club_id,
            'Marcos Leonardo',
            '2003-05-02',
            'Brazil',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 76,
            78, 79, 63, 73, 31, 77, TRUE
        );
    END IF;

    -- Player: Tolu Arokodare (tolu-arokodare)
    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = 'ajax';
    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = 'tolu-arokodare') THEN
        v_player_id := public.create_player_template_with_positions(
            'tolu-arokodare',
            v_club_id,
            'Tolu Arokodare',
            '2000-11-23',
            'Nigeria',
            'ST'::public.enum_player_position,
            '{}'::public.enum_player_position[]
        );
        INSERT INTO public.player_template_versions (
            player_template_id, version, market_value_eur, overall_rating,
            pace, shooting, passing, dribbling, defending, physical, is_current
        ) VALUES (
            v_player_id, 1, 20000000.00, 76,
            78, 79, 63, 73, 31, 77, TRUE
        );
    END IF;

END $$;

-- 3. Seed Legend Templates (60 Legends)
INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-cristiano-ronaldo-prime', 'cristiano-ronaldo-prime', 'Cristiano Ronaldo', 'Portugal', '1985-02-05',
    'LW'::public.enum_player_position, ARRAY['ST'::public.enum_player_position, 'RW'::public.enum_player_position], 'Real Madrid', '2011-2014', 94,
    500000000.00, 'ACTIVE', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 2011-2014', '{"pace":93,"shooting":93,"passing":82,"dribbling":91,"defending":33,"physical":80}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-lionel-messi-prime', 'lionel-messi-prime', 'Lionel Messi', 'Argentina', '1987-06-24',
    'RW'::public.enum_player_position, ARRAY['CF'::public.enum_player_position, 'CAM'::public.enum_player_position], 'FC Barcelona', '2011-2012', 94,
    500000000.00, 'ACTIVE', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 2011-2012', '{"pace":92,"shooting":92,"passing":91,"dribbling":96,"defending":30,"physical":68}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-marcelo-prime', 'marcelo-prime', 'Marcelo Vieira da Silva', 'Brazil', '1988-05-12',
    'LB'::public.enum_player_position, ARRAY['LWB'::public.enum_player_position], 'Real Madrid', '2016-2018', 89,
    220000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 2016-2018', '{"pace":82,"shooting":72,"passing":83,"dribbling":87,"defending":81,"physical":77}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-gareth-bale-prime', 'gareth-bale-prime', 'Gareth Bale', 'Wales', '1989-07-16',
    'RW'::public.enum_player_position, ARRAY['RM'::public.enum_player_position, 'LB'::public.enum_player_position], 'Real Madrid', '2013-2016', 89,
    230000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 2013-2016', '{"pace":94,"shooting":87,"passing":84,"dribbling":86,"defending":58,"physical":80}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-eden-hazard-prime', 'eden-hazard-prime', 'Eden Hazard', 'Belgium', '1991-01-07',
    'LW'::public.enum_player_position, ARRAY['LM'::public.enum_player_position, 'CAM'::public.enum_player_position], 'Chelsea', '2017-2019', 89,
    210000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 2017-2019', '{"pace":91,"shooting":83,"passing":86,"dribbling":94,"defending":35,"physical":66}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-luka-modric-prime', 'luka-modric-prime', 'Luka Modrić', 'Croatia', '1985-09-09',
    'CM'::public.enum_player_position, ARRAY['CAM'::public.enum_player_position], 'Real Madrid', '2017-2018', 91,
    320000000.00, 'ACTIVE', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 2017-2018', '{"pace":76,"shooting":76,"passing":89,"dribbling":91,"defending":72,"physical":66}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-toni-kroos-prime', 'toni-kroos-prime', 'Toni Kroos', 'Germany', '1990-01-04',
    'CM'::public.enum_player_position, ARRAY['CDM'::public.enum_player_position], 'Real Madrid', '2016-2020', 90,
    280000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 2016-2020', '{"pace":53,"shooting":81,"passing":91,"dribbling":81,"defending":70,"physical":69}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-xavi-prime', 'xavi-prime', 'Xavi Hernández', 'Spain', '1980-01-25',
    'CM'::public.enum_player_position, ARRAY['CAM'::public.enum_player_position], 'FC Barcelona', '2008-2012', 92,
    350000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 2008-2012', '{"pace":70,"shooting":74,"passing":94,"dribbling":90,"defending":70,"physical":66}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-andres-iniesta-prime', 'andres-iniesta-prime', 'Andrés Iniesta', 'Spain', '1984-05-11',
    'CM'::public.enum_player_position, ARRAY['LW'::public.enum_player_position, 'CAM'::public.enum_player_position], 'FC Barcelona', '2008-2012', 92,
    350000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 2008-2012', '{"pace":75,"shooting":72,"passing":90,"dribbling":92,"defending":63,"physical":60}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, goalkeeper_attributes
) VALUES (
    'leg-lev-yashin-prime', 'lev-yashin-prime', 'Lev Yashin', 'Russia', '1929-10-22',
    'GK'::public.enum_player_position, '{}'::public.enum_player_position[], 'Dynamo Moscow', '1956-1964', 93,
    400000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 1956-1964', '{"reflexes":95,"handling":89,"positioning":92,"aerialAbility":88,"distribution":75,"oneOnOne":94}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, goalkeeper_attributes
) VALUES (
    'leg-gianluigi-buffon-prime', 'gianluigi-buffon-prime', 'Gianluigi Buffon', 'Italy', '1978-01-28',
    'GK'::public.enum_player_position, '{}'::public.enum_player_position[], 'Juventus', '2003-2006', 92,
    340000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 2003-2006', '{"reflexes":94,"handling":90,"positioning":93,"aerialAbility":86,"distribution":74,"oneOnOne":92}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, goalkeeper_attributes
) VALUES (
    'leg-iker-casillas-prime', 'iker-casillas-prime', 'Iker Casillas', 'Spain', '1981-05-20',
    'GK'::public.enum_player_position, '{}'::public.enum_player_position[], 'Real Madrid', '2008-2012', 91,
    290000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 2008-2012', '{"reflexes":92,"handling":87,"positioning":89,"aerialAbility":84,"distribution":78,"oneOnOne":91}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, goalkeeper_attributes
) VALUES (
    'leg-peter-schmeichel-prime', 'peter-schmeichel-prime', 'Peter Schmeichel', 'Denmark', '1963-11-18',
    'GK'::public.enum_player_position, '{}'::public.enum_player_position[], 'Manchester United', '1996-1999', 90,
    250000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 1996-1999', '{"reflexes":91,"handling":89,"positioning":88,"aerialAbility":90,"distribution":80,"oneOnOne":90}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-franz-beckenbauer-prime', 'franz-beckenbauer-prime', 'Franz Beckenbauer', 'Germany', '1945-09-11',
    'CB'::public.enum_player_position, ARRAY['CDM'::public.enum_player_position], 'Bayern Munich', '1972-1976', 93,
    420000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 1972-1976', '{"pace":81,"shooting":76,"passing":88,"dribbling":86,"defending":94,"physical":82}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-paolo-maldini-prime', 'paolo-maldini-prime', 'Paolo Maldini', 'Italy', '1968-06-26',
    'CB'::public.enum_player_position, ARRAY['LB'::public.enum_player_position], 'AC Milan', '1993-2003', 93,
    430000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 1993-2003', '{"pace":85,"shooting":56,"passing":75,"dribbling":70,"defending":95,"physical":83}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-sergio-ramos-prime', 'sergio-ramos-prime', 'Sergio Ramos', 'Spain', '1986-03-30',
    'CB'::public.enum_player_position, ARRAY['RB'::public.enum_player_position], 'Real Madrid', '2014-2018', 92,
    350000000.00, 'ACTIVE', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 2014-2018', '{"pace":78,"shooting":68,"passing":76,"dribbling":72,"defending":92,"physical":87}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-alessandro-nesta-prime', 'alessandro-nesta-prime', 'Alessandro Nesta', 'Italy', '1976-03-19',
    'CB'::public.enum_player_position, '{}'::public.enum_player_position[], 'AC Milan', '2002-2007', 91,
    310000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 2002-2007', '{"pace":74,"shooting":40,"passing":68,"dribbling":66,"defending":93,"physical":83}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-fabio-cannavaro-prime', 'fabio-cannavaro-prime', 'Fabio Cannavaro', 'Italy', '1973-09-13',
    'CB'::public.enum_player_position, '{}'::public.enum_player_position[], 'Juventus', '2006', 90,
    260000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 2006', '{"pace":80,"shooting":43,"passing":62,"dribbling":68,"defending":92,"physical":85}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-carles-puyol-prime', 'carles-puyol-prime', 'Carles Puyol', 'Spain', '1978-04-13',
    'CB'::public.enum_player_position, ARRAY['RB'::public.enum_player_position], 'FC Barcelona', '2008-2011', 90,
    250000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 2008-2011', '{"pace":72,"shooting":45,"passing":60,"dribbling":58,"defending":91,"physical":89}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-roberto-carlos-prime', 'roberto-carlos-prime', 'Roberto Carlos da Silva', 'Brazil', '1973-04-10',
    'LB'::public.enum_player_position, ARRAY['LWB'::public.enum_player_position], 'Real Madrid', '1997-2002', 90,
    260000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 1997-2002', '{"pace":92,"shooting":83,"passing":80,"dribbling":81,"defending":82,"physical":86}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-ashley-cole-prime', 'ashley-cole-prime', 'Ashley Cole', 'England', '1980-12-20',
    'LB'::public.enum_player_position, '{}'::public.enum_player_position[], 'Chelsea', '2008-2012', 88,
    170000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 2008-2012', '{"pace":86,"shooting":60,"passing":76,"dribbling":78,"defending":86,"physical":78}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-giacinto-facchetti-prime', 'giacinto-facchetti-prime', 'Giacinto Facchetti', 'Italy', '1942-07-18',
    'LB'::public.enum_player_position, ARRAY['CB'::public.enum_player_position], 'Inter Milan', '1965-1971', 88,
    160000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 1965-1971', '{"pace":84,"shooting":68,"passing":75,"dribbling":76,"defending":87,"physical":82}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-cafu-prime', 'cafu-prime', 'Marcos Evangelista de Morais (Cafu)', 'Brazil', '1970-06-07',
    'RB'::public.enum_player_position, ARRAY['RWB'::public.enum_player_position], 'AC Milan', '2001-2005', 90,
    270000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 2001-2005', '{"pace":88,"shooting":64,"passing":82,"dribbling":83,"defending":85,"physical":86}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-dani-alves-prime', 'dani-alves-prime', 'Daniel Alves da Silva', 'Brazil', '1983-05-06',
    'RB'::public.enum_player_position, ARRAY['RWB'::public.enum_player_position], 'FC Barcelona', '2009-2015', 90,
    270000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 2009-2015', '{"pace":86,"shooting":72,"passing":84,"dribbling":85,"defending":82,"physical":80}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-philipp-lahm-prime', 'philipp-lahm-prime', 'Philipp Lahm', 'Germany', '1983-11-11',
    'RB'::public.enum_player_position, ARRAY['LB'::public.enum_player_position, 'CDM'::public.enum_player_position], 'Bayern Munich', '2011-2014', 90,
    260000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 2011-2014', '{"pace":82,"shooting":58,"passing":84,"dribbling":82,"defending":88,"physical":72}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-javier-zanetti-prime', 'javier-zanetti-prime', 'Javier Zanetti', 'Argentina', '1973-08-10',
    'RB'::public.enum_player_position, ARRAY['CDM'::public.enum_player_position, 'LB'::public.enum_player_position], 'Inter Milan', '2008-2010', 89,
    210000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 2008-2010', '{"pace":83,"shooting":55,"passing":78,"dribbling":80,"defending":86,"physical":84}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-andreas-brehme-prime', 'andreas-brehme-prime', 'Andreas Brehme', 'Germany', '1960-11-09',
    'LWB'::public.enum_player_position, ARRAY['LB'::public.enum_player_position, 'LM'::public.enum_player_position], 'Inter Milan', '1988-1991', 88,
    160000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 1988-1991', '{"pace":81,"shooting":76,"passing":84,"dribbling":78,"defending":84,"physical":78}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-bixente-lizarazu-prime', 'bixente-lizarazu-prime', 'Bixente Lizarazu', 'France', '1969-12-09',
    'LWB'::public.enum_player_position, ARRAY['LB'::public.enum_player_position], 'Bayern Munich', '1998-2001', 87,
    140000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 1998-2001', '{"pace":85,"shooting":56,"passing":74,"dribbling":78,"defending":83,"physical":76}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-junior-prime', 'junior-prime', 'Leovegildo Lins da Gama Júnior', 'Brazil', '1954-06-29',
    'LWB'::public.enum_player_position, ARRAY['LB'::public.enum_player_position, 'CM'::public.enum_player_position], 'Flamengo', '1980-1983', 87,
    130000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 1980-1983', '{"pace":82,"shooting":68,"passing":81,"dribbling":82,"defending":81,"physical":77}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-carlos-alberto-prime', 'carlos-alberto-prime', 'Carlos Alberto Torres', 'Brazil', '1944-07-17',
    'RWB'::public.enum_player_position, ARRAY['RB'::public.enum_player_position, 'CB'::public.enum_player_position], 'Santos', '1968-1972', 89,
    210000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 1968-1972', '{"pace":84,"shooting":66,"passing":80,"dribbling":78,"defending":86,"physical":84}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-gianluca-zambrotta-prime', 'gianluca-zambrotta-prime', 'Gianluca Zambrotta', 'Italy', '1977-02-19',
    'RWB'::public.enum_player_position, ARRAY['RB'::public.enum_player_position, 'LWB'::public.enum_player_position], 'Juventus', '2003-2006', 87,
    140000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 2003-2006', '{"pace":86,"shooting":62,"passing":76,"dribbling":79,"defending":82,"physical":80}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-djalma-santos-prime', 'djalma-santos-prime', 'Djalma Pereira Dias dos Santos', 'Brazil', '1929-02-27',
    'RWB'::public.enum_player_position, ARRAY['RB'::public.enum_player_position], 'Palmeiras', '1958-1962', 88,
    150000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 1958-1962', '{"pace":83,"shooting":55,"passing":75,"dribbling":76,"defending":87,"physical":83}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-lothar-matthaus-prime', 'lothar-matthaus-prime', 'Lothar Matthäus', 'Germany', '1961-03-21',
    'CDM'::public.enum_player_position, ARRAY['CM'::public.enum_player_position, 'CB'::public.enum_player_position], 'Inter Milan', '1990-1994', 92,
    360000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 1990-1994', '{"pace":83,"shooting":85,"passing":87,"dribbling":82,"defending":88,"physical":85}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-sergio-busquets-prime', 'sergio-busquets-prime', 'Sergio Busquets Burgos', 'Spain', '1988-07-16',
    'CDM'::public.enum_player_position, ARRAY['CM'::public.enum_player_position], 'FC Barcelona', '2011-2015', 90,
    260000000.00, 'ACTIVE', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 2011-2015', '{"pace":45,"shooting":62,"passing":83,"dribbling":81,"defending":86,"physical":80}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-claude-makelele-prime', 'claude-makelele-prime', 'Claude Makélélé', 'France', '1973-02-18',
    'CDM'::public.enum_player_position, '{}'::public.enum_player_position[], 'Chelsea', '2004-2007', 89,
    220000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 2004-2007', '{"pace":76,"shooting":48,"passing":75,"dribbling":74,"defending":89,"physical":86}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-frank-rijkaard-prime', 'frank-rijkaard-prime', 'Frank Rijkaard', 'Netherlands', '1962-09-30',
    'CDM'::public.enum_player_position, ARRAY['CB'::public.enum_player_position], 'AC Milan', '1988-1992', 90,
    270000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 1988-1992', '{"pace":77,"shooting":72,"passing":80,"dribbling":77,"defending":88,"physical":86}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-andrea-pirlo-prime', 'andrea-pirlo-prime', 'Andrea Pirlo', 'Italy', '1979-05-19',
    'CM'::public.enum_player_position, ARRAY['CDM'::public.enum_player_position], 'AC Milan', '2006-2012', 90,
    280000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 2006-2012', '{"pace":66,"shooting":78,"passing":93,"dribbling":85,"defending":68,"physical":63}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-zinedine-zidane-prime', 'zinedine-zidane-prime', 'Zinedine Zidane', 'France', '1972-06-23',
    'CAM'::public.enum_player_position, ARRAY['CM'::public.enum_player_position], 'Real Madrid', '2000-2003', 93,
    430000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 2000-2003', '{"pace":80,"shooting":84,"passing":92,"dribbling":93,"defending":62,"physical":82}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-kaka-prime', 'kaka-prime', 'Ricardo Izecson dos Santos Leite (Kaká)', 'Brazil', '1982-04-22',
    'CAM'::public.enum_player_position, ARRAY['CF'::public.enum_player_position], 'AC Milan', '2006-2007', 91,
    330000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 2006-2007', '{"pace":91,"shooting":86,"passing":88,"dribbling":92,"defending":44,"physical":73}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-michel-platini-prime', 'michel-platini-prime', 'Michel Platini', 'France', '1955-06-21',
    'CAM'::public.enum_player_position, ARRAY['CF'::public.enum_player_position], 'Juventus', '1983-1985', 92,
    370000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 1983-1985', '{"pace":78,"shooting":88,"passing":93,"dribbling":89,"defending":52,"physical":72}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-ruud-gullit-prime', 'ruud-gullit-prime', 'Ruud Gullit', 'Netherlands', '1962-09-01',
    'CAM'::public.enum_player_position, ARRAY['CM'::public.enum_player_position, 'CF'::public.enum_player_position], 'AC Milan', '1987-1990', 90,
    290000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 1987-1990', '{"pace":86,"shooting":85,"passing":86,"dribbling":86,"defending":78,"physical":87}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-pavel-nedved-prime', 'pavel-nedved-prime', 'Pavel Nedvěd', 'Czech Republic', '1972-08-30',
    'LM'::public.enum_player_position, ARRAY['CAM'::public.enum_player_position, 'LW'::public.enum_player_position], 'Juventus', '2002-2004', 90,
    250000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 2002-2004', '{"pace":86,"shooting":86,"passing":86,"dribbling":87,"defending":68,"physical":82}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-ryan-giggs-prime', 'ryan-giggs-prime', 'Ryan Giggs', 'Wales', '1973-11-29',
    'LM'::public.enum_player_position, ARRAY['LW'::public.enum_player_position], 'Manchester United', '1998-2001', 89,
    210000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 1998-2001', '{"pace":90,"shooting":78,"passing":84,"dribbling":88,"defending":48,"physical":70}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-robert-pires-prime', 'robert-pires-prime', 'Robert Pires', 'France', '1973-10-29',
    'LM'::public.enum_player_position, ARRAY['RM'::public.enum_player_position, 'CAM'::public.enum_player_position], 'Arsenal', '2001-2004', 88,
    170000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 2001-2004', '{"pace":86,"shooting":82,"passing":84,"dribbling":87,"defending":40,"physical":64}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-david-beckham-prime', 'david-beckham-prime', 'David Beckham', 'England', '1975-05-02',
    'RM'::public.enum_player_position, ARRAY['CM'::public.enum_player_position], 'Manchester United', '1998-2003', 89,
    220000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 1998-2003', '{"pace":76,"shooting":82,"passing":93,"dribbling":81,"defending":70,"physical":80}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-luis-figo-prime', 'luis-figo-prime', 'Luís Figo', 'Portugal', '1972-11-04',
    'RM'::public.enum_player_position, ARRAY['RW'::public.enum_player_position, 'CAM'::public.enum_player_position], 'Real Madrid', '1999-2002', 90,
    270000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 1999-2002', '{"pace":87,"shooting":83,"passing":87,"dribbling":90,"defending":42,"physical":77}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-jairzinho-prime', 'jairzinho-prime', 'Jair Ventura Filho (Jairzinho)', 'Brazil', '1944-12-25',
    'RM'::public.enum_player_position, ARRAY['RW'::public.enum_player_position, 'ST'::public.enum_player_position], 'Botafogo', '1970', 89,
    210000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 1970', '{"pace":90,"shooting":85,"passing":80,"dribbling":89,"defending":48,"physical":82}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-ronaldinho-prime', 'ronaldinho-prime', 'Ronaldo de Assis Moreira (Ronaldinho)', 'Brazil', '1980-03-21',
    'LW'::public.enum_player_position, ARRAY['CAM'::public.enum_player_position], 'FC Barcelona', '2004-2006', 92,
    380000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 2004-2006', '{"pace":91,"shooting":88,"passing":90,"dribbling":95,"defending":36,"physical":78}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-franck-ribery-prime', 'franck-ribery-prime', 'Franck Ribéry', 'France', '1983-04-07',
    'LW'::public.enum_player_position, ARRAY['LM'::public.enum_player_position], 'Bayern Munich', '2012-2014', 89,
    220000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 2012-2014', '{"pace":89,"shooting":81,"passing":84,"dribbling":91,"defending":38,"physical":65}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-george-best-prime', 'george-best-prime', 'George Best', 'Northern Ireland', '1946-05-22',
    'RW'::public.enum_player_position, ARRAY['LW'::public.enum_player_position], 'Manchester United', '1968', 91,
    330000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 1968', '{"pace":91,"shooting":86,"passing":82,"dribbling":94,"defending":50,"physical":71}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-arjen-robben-prime', 'arjen-robben-prime', 'Arjen Robben', 'Netherlands', '1984-01-23',
    'RW'::public.enum_player_position, ARRAY['RM'::public.enum_player_position], 'Bayern Munich', '2012-2014', 89,
    230000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 2012-2014', '{"pace":92,"shooting":86,"passing":80,"dribbling":90,"defending":32,"physical":64}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-diego-maradona-prime', 'diego-maradona-prime', 'Diego Armando Maradona', 'Argentina', '1960-10-30',
    'CF'::public.enum_player_position, ARRAY['CAM'::public.enum_player_position], 'SSC Napoli', '1986-1990', 93,
    440000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 1986-1990', '{"pace":88,"shooting":91,"passing":90,"dribbling":95,"defending":40,"physical":75}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-johan-cruyff-prime', 'johan-cruyff-prime', 'Johan Cruyff', 'Netherlands', '1947-04-25',
    'CF'::public.enum_player_position, ARRAY['CAM'::public.enum_player_position, 'LW'::public.enum_player_position], 'Ajax', '1971-1974', 93,
    440000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 1971-1974', '{"pace":91,"shooting":90,"passing":89,"dribbling":93,"defending":42,"physical":73}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-dennis-bergkamp-prime', 'dennis-bergkamp-prime', 'Dennis Bergkamp', 'Netherlands', '1969-05-10',
    'CF'::public.enum_player_position, ARRAY['CAM'::public.enum_player_position], 'Arsenal', '1997-2002', 90,
    260000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 1997-2002', '{"pace":81,"shooting":87,"passing":86,"dribbling":89,"defending":36,"physical":74}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-ronaldo-nazario-prime', 'ronaldo-nazario-prime', 'Ronaldo Luís Nazário de Lima', 'Brazil', '1976-09-18',
    'ST'::public.enum_player_position, '{}'::public.enum_player_position[], 'Inter Milan', '1997-2003', 93,
    450000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 1997-2003', '{"pace":95,"shooting":93,"passing":79,"dribbling":93,"defending":35,"physical":76}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-thierry-henry-prime', 'thierry-henry-prime', 'Thierry Henry', 'France', '1977-08-17',
    'ST'::public.enum_player_position, ARRAY['LW'::public.enum_player_position], 'Arsenal', '2002-2006', 91,
    340000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 2002-2006', '{"pace":93,"shooting":90,"passing":83,"dribbling":90,"defending":38,"physical":78}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-pele-prime', 'pele-prime', 'Edson Arantes do Nascimento (Pelé)', 'Brazil', '1940-10-23',
    'ST'::public.enum_player_position, ARRAY['CF'::public.enum_player_position], 'Santos', '1962-1970', 93,
    450000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 1962-1970', '{"pace":93,"shooting":92,"passing":87,"dribbling":93,"defending":38,"physical":76}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-ferenc-puskas-prime', 'ferenc-puskas-prime', 'Ferenc Puskás', 'Hungary', '1927-04-01',
    'ST'::public.enum_player_position, ARRAY['CF'::public.enum_player_position], 'Real Madrid', '1958-1962', 91,
    340000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 1958-1962', '{"pace":88,"shooting":93,"passing":85,"dribbling":89,"defending":34,"physical":74}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-marco-van-basten-prime', 'marco-van-basten-prime', 'Marco van Basten', 'Netherlands', '1964-10-31',
    'ST'::public.enum_player_position, '{}'::public.enum_player_position[], 'AC Milan', '1988-1992', 91,
    330000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 1988-1992', '{"pace":83,"shooting":92,"passing":76,"dribbling":86,"defending":38,"physical":78}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

INSERT INTO public.legend_templates (
    legend_id, canonical_key, full_name, nationality, date_of_birth,
    primary_position, secondary_positions, peak_club, peak_period, peak_overall_rating,
    default_price_eur, status, source_id, rating_methodology, outfield_attributes
) VALUES (
    'leg-zlatan-ibrahimovic-prime', 'zlatan-ibrahimovic-prime', 'Zlatan Ibrahimović', 'Sweden', '1981-10-03',
    'ST'::public.enum_player_position, ARRAY['CF'::public.enum_player_position], 'Paris Saint-Germain', '2012-2016', 90,
    270000000.00, 'RETIRED', 'src-ea-fc-icons-2026', 'Official EA FC Icon historical peak rating 2012-2016', '{"pace":76,"shooting":90,"passing":81,"dribbling":86,"defending":34,"physical":88}'::jsonb
) ON CONFLICT (legend_id) DO UPDATE SET
    default_price_eur = EXCLUDED.default_price_eur,
    peak_overall_rating = EXCLUDED.peak_overall_rating;

COMMIT;
