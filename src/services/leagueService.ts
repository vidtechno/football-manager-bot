import { getSupabaseAdminClient } from '../database/client.js';

export class LeagueService {
  /**
   * Deletes a solo league via RPC delete_solo_league.
   */
  static async deleteSoloLeague(
    leagueId: string,
    userId: string,
  ): Promise<{ success: boolean; message: string }> {
    const supabase = getSupabaseAdminClient();
    const { data, error } = await supabase.rpc('delete_solo_league', {
      p_league_id: leagueId,
      p_user_id: userId,
    });

    if (error) {
      throw new Error(`DELETE_SOLO_LEAGUE_FAILED: ${error.message}`);
    }

    return {
      success: data.success,
      message: data.message,
    };
  }

  /**
   * Advances a league round via canonical RPC execute_league_round, then processes automatic club income.
   * Enforces 3-round daily limit in Asia/Tashkent calendar day inside its transaction.
   */
  static async executeLeagueRound(
    leagueId: string,
    roundNumber?: number,
    eligibleSponsorshipManagerIds: string[] = [],
  ): Promise<{
    completedRoundNumber: number;
    completedAt: string;
    incomeSettlement?: { clubsProcessed: number; totalCreditedEur: number };
  }> {
    const supabase = getSupabaseAdminClient();
    const { data, error } = await supabase.rpc('execute_league_round', {
      p_league_id: leagueId,
      p_round_number: roundNumber ?? null,
    });

    if (error) {
      throw new Error(`EXECUTE_LEAGUE_ROUND_FAILED: ${error.message}`);
    }

    const completedRoundNumber = data.completed_round_number;
    const completedAt = data.completed_at;

    // Process automatic club income (sponsorship, win/draw bonus, stadium income)
    const { data: incomeData, error: incomeError } = await supabase.rpc(
      'process_round_settlement_income',
      {
        p_league_id: leagueId,
        p_round_number: completedRoundNumber,
        p_eligible_sponsorship_manager_ids: eligibleSponsorshipManagerIds,
      },
    );

    if (incomeError) {
      throw new Error(`ROUND_INCOME_SETTLEMENT_FAILED: ${incomeError.message}`);
    }

    return {
      completedRoundNumber,
      completedAt,
      incomeSettlement: {
        clubsProcessed: incomeData.clubs_processed,
        totalCreditedEur: incomeData.total_credited_eur,
      },
    };
  }

  /**
   * Purchases a legend player for a league club via RPC purchase_league_legend.
   */
  static async purchaseLeagueLegend(
    leagueLegendId: string,
    leagueClubId: string,
    userId: string,
  ): Promise<{ remainingBudget: number }> {
    const supabase = getSupabaseAdminClient();
    const { data, error } = await supabase.rpc('purchase_league_legend', {
      p_league_legend_id: leagueLegendId,
      p_league_club_id: leagueClubId,
      p_user_id: userId,
    });

    if (error) {
      throw new Error(`PURCHASE_LEGEND_FAILED: ${error.message}`);
    }

    return {
      remainingBudget: data.remaining_budget,
    };
  }

  /**
   * Returns human participant count for a league.
   */
  static async getHumanParticipantCount(leagueId: string): Promise<number> {
    const supabase = getSupabaseAdminClient();
    const { data, error } = await supabase
      .from('league_clubs')
      .select('user_id')
      .eq('league_id', leagueId)
      .not('user_id', 'is', null);

    if (error) {
      throw new Error(`GET_HUMAN_COUNT_FAILED: ${error.message}`);
    }

    const uniqueUsers = new Set(data.map((row) => row.user_id));
    return uniqueUsers.size;
  }
}
