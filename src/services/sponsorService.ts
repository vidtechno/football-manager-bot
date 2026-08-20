import { getSupabaseAdminClient } from '../database/client.js';

export interface DbGlobalSponsorSettingRow {
  id: string;
  chat_id: number;
  channel_username: string | null;
  display_title: string;
  invite_url: string | null;
  is_active: boolean;
  configured_by_admin_id: string | null;
  created_at: string;
  updated_at: string;
}

export interface IncomeHistoryEntry {
  id: string;
  transactionType: string;
  amountEur: number;
  description: string;
  createdAt: string;
}

export class SponsorService {
  /**
   * Retrieves the current active global sponsor channel setting.
   */
  static async getActiveSponsorChannel(): Promise<DbGlobalSponsorSettingRow | null> {
    const supabase = getSupabaseAdminClient();
    const { data, error } = await supabase
      .from('global_sponsor_settings')
      .select('*')
      .eq('is_active', true)
      .maybeSingle();

    if (error) {
      throw new Error(`GET_ACTIVE_SPONSOR_FAILED: ${error.message}`);
    }

    return data as DbGlobalSponsorSettingRow | null;
  }

  /**
   * Sets a new active global sponsor channel via RPC (deactivates previous active setting).
   */
  static async setActiveSponsorChannel(
    chatId: number,
    channelUsername: string | null,
    displayTitle: string,
    inviteUrl: string | null,
    adminId: string,
  ): Promise<{ success: boolean; sponsorSettingId: string }> {
    const supabase = getSupabaseAdminClient();
    const { data, error } = await supabase.rpc(
      'set_active_global_sponsor_channel',
      {
        p_chat_id: chatId,
        p_channel_username: channelUsername,
        p_display_title: displayTitle,
        p_invite_url: inviteUrl,
        p_admin_id: adminId,
      },
    );

    if (error) {
      throw new Error(`SET_ACTIVE_SPONSOR_FAILED: ${error.message}`);
    }

    return {
      success: data.success,
      sponsorSettingId: data.sponsor_setting_id,
    };
  }

  /**
   * Deactivates the global sponsor channel.
   */
  static async deactivateSponsorChannel(
    adminId: string,
  ): Promise<{ success: boolean }> {
    const supabase = getSupabaseAdminClient();
    const { data, error } = await supabase.rpc(
      'deactivate_global_sponsor_channel',
      {
        p_admin_id: adminId,
      },
    );

    if (error) {
      throw new Error(`DEACTIVATE_SPONSOR_FAILED: ${error.message}`);
    }

    return { success: data.success };
  }

  /**
   * Verifies manager subscription against the active global sponsor channel with 6-hour caching & API error fallback.
   */
  static async verifyManagerSubscription(
    botApi: {
      getChatMember: (
        chatId: number,
        userId: number,
      ) => Promise<{ status: string; is_member?: boolean }>;
    },
    telegramUserId: number,
    managerId: string,
  ): Promise<{
    isSubscribed: boolean;
    sponsorSetting: DbGlobalSponsorSettingRow | null;
    isCached: boolean;
    apiError?: boolean;
  }> {
    const sponsorSetting = await this.getActiveSponsorChannel();
    if (!sponsorSetting) {
      return { isSubscribed: false, sponsorSetting: null, isCached: false };
    }

    const supabase = getSupabaseAdminClient();
    const cacheCutoff = new Date(Date.now() - 6 * 60 * 60 * 1000).toISOString(); // 6 hours

    // Check recent verification
    const { data: cached } = await supabase
      .from('manager_sponsor_verifications')
      .select('*')
      .eq('manager_id', managerId)
      .eq('sponsor_setting_id', sponsorSetting.id)
      .gte('verified_at', cacheCutoff)
      .maybeSingle();

    if (cached) {
      return {
        isSubscribed: cached.is_subscribed,
        sponsorSetting,
        isCached: true,
      };
    }

    try {
      const member = await botApi.getChatMember(
        sponsorSetting.chat_id,
        telegramUserId,
      );
      const status = member?.status;
      const isSubscribed =
        status === 'creator' ||
        status === 'administrator' ||
        status === 'member' ||
        (status === 'restricted' && member?.is_member === true);

      // Save/update verification cache
      await supabase.from('manager_sponsor_verifications').upsert(
        {
          manager_id: managerId,
          sponsor_setting_id: sponsorSetting.id,
          is_subscribed: isSubscribed,
          verified_at: new Date().toISOString(),
          verification_source: 'TELEGRAM_API',
        },
        { onConflict: 'manager_id,sponsor_setting_id' },
      );

      return { isSubscribed, sponsorSetting, isCached: false };
    } catch {
      // Temporary Telegram API failure fallback to older cached status if available
      const { data: oldCached } = await supabase
        .from('manager_sponsor_verifications')
        .select('*')
        .eq('manager_id', managerId)
        .eq('sponsor_setting_id', sponsorSetting.id)
        .maybeSingle();

      if (oldCached) {
        return {
          isSubscribed: oldCached.is_subscribed,
          sponsorSetting,
          isCached: true,
          apiError: true,
        };
      }

      return {
        isSubscribed: false,
        sponsorSetting,
        isCached: false,
        apiError: true,
      };
    }
  }

  /**
   * Retrieves income history for a club.
   */
  static async getClubIncomeHistory(
    leagueClubId: string,
    limit: number = 10,
    offset: number = 0,
  ): Promise<{ items: IncomeHistoryEntry[]; total: number }> {
    const supabase = getSupabaseAdminClient();
    const incomeTypes = [
      'SPONSORSHIP_INCOME',
      'MATCH_WIN_BONUS',
      'MATCH_DRAW_BONUS',
      'STADIUM_INCOME',
      'TRANSFER_SALE',
      'TRANSFER_PURCHASE',
    ];

    const { data, count, error } = await supabase
      .from('financial_ledger')
      .select('*', { count: 'exact' })
      .eq('league_club_id', leagueClubId)
      .in('transaction_type', incomeTypes)
      .order('created_at', { ascending: false })
      .range(offset, offset + limit - 1);

    if (error) {
      throw new Error(`GET_INCOME_HISTORY_FAILED: ${error.message}`);
    }

    const items: IncomeHistoryEntry[] = (data || []).map((row) => ({
      id: row.id,
      transactionType: row.transaction_type,
      amountEur: Number(row.amount_eur),
      description: row.description,
      createdAt: row.created_at,
    }));

    return {
      items,
      total: count || 0,
    };
  }
}
