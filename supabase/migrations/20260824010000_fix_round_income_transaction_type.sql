-- Ensure CASE result bonuses are explicitly typed as the financial transaction enum.

-- 7. RPC: process_round_settlement_income (Idempotent Round Settlement Income Allocation)
CREATE OR REPLACE FUNCTION public.process_round_settlement_income(
    p_league_id UUID,
    p_round_number INT,
    p_eligible_sponsorship_manager_ids UUID[] DEFAULT ARRAY[]::UUID[]
)
RETURNS JSONB AS $$
DECLARE
    v_round RECORD;
    v_club RECORD;
    v_match RECORD;
    v_active_sponsor_id UUID;
    v_is_sponsor_eligible BOOLEAN;
    v_sponsorship_amount NUMERIC := 2500000.00; -- €2.5M
    v_win_bonus NUMERIC := 1500000.00;          -- €1.5M
    v_draw_bonus NUMERIC := 500000.00;          -- €500K
    v_result_bonus NUMERIC := 0.00;
    v_stadium_income NUMERIC := 0.00;
    v_reputation INT;
    v_idempotency_key VARCHAR(150);
    v_finance RECORD;
    v_ledger_id UUID;
    v_total_credited NUMERIC := 0.00;
    v_clubs_processed INT := 0;
BEGIN
    -- 1. Lock round record FOR UPDATE
    SELECT * INTO v_round
    FROM public.league_rounds
    WHERE league_id = p_league_id AND round_number = p_round_number
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'ROUND_NOT_FOUND' USING ERRCODE = 'P0001';
    END IF;

    -- 2. Fetch active global sponsor channel setting ID (if any)
    SELECT id INTO v_active_sponsor_id
    FROM public.global_sponsor_settings
    WHERE is_active = TRUE
    LIMIT 1;

    -- 3. Loop through all clubs in this league
    FOR v_club IN
        SELECT lc.*, ct.slug as template_slug
        FROM public.league_clubs lc
        LEFT JOIN public.club_templates ct ON lc.club_template_id = ct.id
        WHERE lc.league_id = p_league_id
    LOOP
        v_clubs_processed := v_clubs_processed + 1;

        -- A. Determine Sponsorship Eligibility (€2.5M)
        v_is_sponsor_eligible := FALSE;
        IF v_club.human_manager_id IS NULL THEN
            -- Bot clubs automatically receive sponsorship to maintain economy balance
            v_is_sponsor_eligible := TRUE;
        ELSIF v_club.human_manager_id = ANY(p_eligible_sponsorship_manager_ids) THEN
            -- Verified subscribed human manager
            v_is_sponsor_eligible := TRUE;
        END IF;

        IF v_is_sponsor_eligible AND v_sponsorship_amount > 0 THEN
            v_idempotency_key := 'INC_SPONSOR_' || v_club.id::text || '_R' || p_round_number::text;
            
            -- Check if already credited for this round
            IF NOT EXISTS (
                SELECT 1 FROM public.financial_ledger
                WHERE league_club_id = v_club.id AND idempotency_key = v_idempotency_key
            ) THEN
                SELECT * INTO v_finance FROM public.club_finances WHERE league_club_id = v_club.id FOR UPDATE;
                IF v_finance IS NOT NULL THEN
                    UPDATE public.club_finances
                    SET total_balance = total_balance + v_sponsorship_amount, updated_at = NOW()
                    WHERE league_club_id = v_club.id;

                    INSERT INTO public.financial_ledger (
                        league_id, league_club_id, transaction_type, amount_eur,
                        balance_before, balance_after, reserved_before, reserved_after,
                        idempotency_key, description
                    ) VALUES (
                        p_league_id, v_club.id, 'SPONSORSHIP_INCOME', v_sponsorship_amount,
                        v_finance.total_balance, v_finance.total_balance + v_sponsorship_amount,
                        v_finance.reserved_balance, v_finance.reserved_balance,
                        v_idempotency_key, 'Round ' || p_round_number::text || ' Sponsorship Income: +€2,500,000'
                    );
                    v_total_credited := v_total_credited + v_sponsorship_amount;
                END IF;
            END IF;
        END IF;

        -- B. Determine Match Result Bonus (Win €1.5M / Draw €500K / Loss €0)
        v_result_bonus := 0.00;
        SELECT * INTO v_match
        FROM public.league_matches
        WHERE league_round_id = v_round.id
          AND (home_club_id = v_club.id OR away_club_id = v_club.id)
        LIMIT 1;

        IF v_match IS NOT NULL THEN
            IF v_match.home_club_id = v_club.id THEN
                IF v_match.home_score > v_match.away_score THEN
                    v_result_bonus := v_win_bonus;
                ELSIF v_match.home_score = v_match.away_score THEN
                    v_result_bonus := v_draw_bonus;
                END IF;
            ELSIF v_match.away_club_id = v_club.id THEN
                IF v_match.away_score > v_match.home_score THEN
                    v_result_bonus := v_win_bonus;
                ELSIF v_match.away_score = v_match.home_score THEN
                    v_result_bonus := v_draw_bonus;
                END IF;
            END IF;
        END IF;

        IF v_result_bonus > 0 THEN
            v_idempotency_key := 'INC_RESULT_' || v_club.id::text || '_R' || p_round_number::text;
            IF NOT EXISTS (
                SELECT 1 FROM public.financial_ledger
                WHERE league_club_id = v_club.id AND idempotency_key = v_idempotency_key
            ) THEN
                SELECT * INTO v_finance FROM public.club_finances WHERE league_club_id = v_club.id FOR UPDATE;
                IF v_finance IS NOT NULL THEN
                    UPDATE public.club_finances
                    SET total_balance = total_balance + v_result_bonus, updated_at = NOW()
                    WHERE league_club_id = v_club.id;

                    INSERT INTO public.financial_ledger (
                        league_id, league_club_id,
                        transaction_type,
                        amount_eur, balance_before, balance_after, reserved_before, reserved_after,
                        idempotency_key, description
                    ) VALUES (
                        p_league_id, v_club.id,
                        (CASE WHEN v_result_bonus = v_win_bonus THEN 'MATCH_WIN_BONUS' ELSE 'MATCH_DRAW_BONUS' END)::public.enum_financial_transaction_type,
                        v_result_bonus, v_finance.total_balance, v_finance.total_balance + v_result_bonus,
                        v_finance.reserved_balance, v_finance.reserved_balance,
                        v_idempotency_key,
                        'Round ' || p_round_number::text || ' ' || (CASE WHEN v_result_bonus = v_win_bonus THEN 'Win' ELSE 'Draw' END) || ' Bonus: +€' || v_result_bonus::text
                    );
                    v_total_credited := v_total_credited + v_result_bonus;
                END IF;
            END IF;
        END IF;

        -- C. Determine Home Stadium Income (Home club only: €1.0M / €1.25M / €1.5M)
        v_stadium_income := 0.00;
        IF v_match IS NOT NULL AND v_match.home_club_id = v_club.id THEN
            -- Fetch club reputation
            SELECT reputation INTO v_reputation
            FROM public.club_template_versions
            WHERE club_template_id = v_club.club_template_id AND is_current = TRUE
            LIMIT 1;

            IF v_reputation IS NULL THEN
                v_stadium_income := 1250000.00; -- Default medium tier
            ELSIF v_reputation < 70 THEN
                v_stadium_income := 1000000.00; -- Low tier
            ELSIF v_reputation < 85 THEN
                v_stadium_income := 1250000.00; -- Medium tier
            ELSE
                v_stadium_income := 1500000.00; -- High tier
            END IF;
        END IF;

        IF v_stadium_income > 0 THEN
            v_idempotency_key := 'INC_STADIUM_' || v_club.id::text || '_R' || p_round_number::text;
            IF NOT EXISTS (
                SELECT 1 FROM public.financial_ledger
                WHERE league_club_id = v_club.id AND idempotency_key = v_idempotency_key
            ) THEN
                SELECT * INTO v_finance FROM public.club_finances WHERE league_club_id = v_club.id FOR UPDATE;
                IF v_finance IS NOT NULL THEN
                    UPDATE public.club_finances
                    SET total_balance = total_balance + v_stadium_income, updated_at = NOW()
                    WHERE league_club_id = v_club.id;

                    INSERT INTO public.financial_ledger (
                        league_id, league_club_id, transaction_type, amount_eur,
                        balance_before, balance_after, reserved_before, reserved_after,
                        idempotency_key, description
                    ) VALUES (
                        p_league_id, v_club.id, 'STADIUM_INCOME', v_stadium_income,
                        v_finance.total_balance, v_finance.total_balance + v_stadium_income,
                        v_finance.reserved_balance, v_finance.reserved_balance,
                        v_idempotency_key, 'Round ' || p_round_number::text || ' Home Stadium Income: +€' || v_stadium_income::text
                    );
                    v_total_credited := v_total_credited + v_stadium_income;
                END IF;
            END IF;
        END IF;
    END LOOP;

    RETURN jsonb_build_object(
        'success', true,
        'league_id', p_league_id,
        'round_number', p_round_number,
        'clubs_processed', v_clubs_processed,
        'total_credited_eur', v_total_credited
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;


REVOKE ALL ON FUNCTION public.process_round_settlement_income(UUID, INT, UUID[]) FROM PUBLIC, anon, authenticated;
GRANT EXECUTE ON FUNCTION public.process_round_settlement_income(UUID, INT, UUID[]) TO service_role;

