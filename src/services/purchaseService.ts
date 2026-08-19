import {
  DEFAULT_TRANSFER_BUDGET_PACKAGES,
  TransferBudgetPackage,
} from '../config/packages.js';
import { getSupabaseAdminClient } from '../database/client.js';

export interface PurchaseRequestRecord {
  id: string;
  orderCode: string;
  telegramUserId: number;
  leagueId: string;
  leagueClubId: string;
  leagueName: string;
  clubName: string;
  packageId: string;
  packageDisplay: string;
  eurAmount: number;
  uzsPrice: number;
  status: 'PENDING' | 'APPROVED' | 'REJECTED' | 'CANCELLED';
  createdAt: string;
}

export class PurchaseService {
  /**
   * Returns active purchase packages from canonical configuration/database.
   */
  static getActivePackages(): TransferBudgetPackage[] {
    return DEFAULT_TRANSFER_BUDGET_PACKAGES.filter((p) => p.isActive);
  }

  /**
   * Look up package by ID.
   */
  static getPackageById(packageId: string): TransferBudgetPackage | undefined {
    return DEFAULT_TRANSFER_BUDGET_PACKAGES.find(
      (p) => p.id === packageId && p.isActive,
    );
  }

  /**
   * Helper to format order code.
   */
  static generateOrderCode(): string {
    const hex = Math.random().toString(16).substring(2, 10).toUpperCase();
    return `TBP-${hex}`;
  }

  /**
   * Inserts a purchase request using RPC create_transfer_budget_purchase_request.
   */
  static async createPurchaseRequest(params: {
    leagueId: string;
    leagueClubId: string;
    packageId: string;
    telegramUserId: number;
  }): Promise<{ requestId: string; orderCode: string }> {
    const supabase = getSupabaseAdminClient();
    const { data, error } = await supabase.rpc(
      'create_transfer_budget_purchase_request',
      {
        p_league_id: params.leagueId,
        p_league_club_id: params.leagueClubId,
        p_package_id: params.packageId,
        p_telegram_user_id: params.telegramUserId,
      },
    );

    if (error) {
      throw new Error(`CREATE_PURCHASE_REQUEST_FAILED: ${error.message}`);
    }

    return {
      requestId: data.request_id,
      orderCode: data.order_code,
    };
  }

  /**
   * Approves a pending purchase request atomically via RPC approve_transfer_budget_purchase_request.
   */
  static async approvePurchaseRequest(
    requestId: string,
    adminId: string,
    adminNote?: string,
  ): Promise<{ addedEurAmount: number; newBalance: number }> {
    const supabase = getSupabaseAdminClient();
    const { data, error } = await supabase.rpc(
      'approve_transfer_budget_purchase_request',
      {
        p_request_id: requestId,
        p_admin_id: adminId,
        p_admin_note: adminNote ?? null,
      },
    );

    if (error) {
      throw new Error(`APPROVE_PURCHASE_REQUEST_FAILED: ${error.message}`);
    }

    return {
      addedEurAmount: data.added_eur_amount,
      newBalance: data.new_balance,
    };
  }

  /**
   * Rejects a pending purchase request via RPC reject_transfer_budget_purchase_request.
   */
  static async rejectPurchaseRequest(
    requestId: string,
    adminId: string,
    adminNote?: string,
  ): Promise<boolean> {
    const supabase = getSupabaseAdminClient();
    const { data, error } = await supabase.rpc(
      'reject_transfer_budget_purchase_request',
      {
        p_request_id: requestId,
        p_admin_id: adminId,
        p_admin_note: adminNote ?? null,
      },
    );

    if (error) {
      throw new Error(`REJECT_PURCHASE_REQUEST_FAILED: ${error.message}`);
    }

    return data.success;
  }

  /**
   * Fetches user's recent purchase requests filtered by Telegram user ID.
   */
  static async getUserOrders(
    telegramUserId: number,
  ): Promise<PurchaseRequestRecord[]> {
    const supabase = getSupabaseAdminClient();
    const { data, error } = await supabase
      .from('transfer_budget_purchase_requests')
      .select('*, leagues(name), league_clubs(name), transfer_budget_packages(display_name)')
      .eq('telegram_user_id', telegramUserId)
      .order('created_at', { ascending: false });

    if (error) {
      throw new Error(`GET_USER_ORDERS_FAILED: ${error.message}`);
    }

    return (data || []).map((row: any) => ({
      id: row.id,
      orderCode: row.order_code,
      telegramUserId: row.telegram_user_id,
      leagueId: row.league_id,
      leagueClubId: row.league_club_id,
      leagueName: row.leagues?.name ?? 'Liga',
      clubName: row.league_clubs?.name ?? 'Klub',
      packageId: row.package_id,
      packageDisplay: row.transfer_budget_packages?.display_name ?? 'Paket',
      eurAmount: Number(row.requested_eur_amount),
      uzsPrice: Number(row.uzs_price),
      status: row.status,
      createdAt: row.created_at,
    }));
  }

  /**
   * Fetches all pending purchase requests for admin review.
   */
  static async getPendingOrders(): Promise<PurchaseRequestRecord[]> {
    const supabase = getSupabaseAdminClient();
    const { data, error } = await supabase
      .from('transfer_budget_purchase_requests')
      .select('*, leagues(name), league_clubs(name), transfer_budget_packages(display_name), users(username)')
      .eq('status', 'PENDING')
      .order('created_at', { ascending: true });

    if (error) {
      throw new Error(`GET_PENDING_ORDERS_FAILED: ${error.message}`);
    }

    return (data || []).map((row: any) => ({
      id: row.id,
      orderCode: row.order_code,
      telegramUserId: row.telegram_user_id,
      leagueId: row.league_id,
      leagueClubId: row.league_club_id,
      leagueName: row.leagues?.name ?? 'Liga',
      clubName: row.league_clubs?.name ?? 'Klub',
      packageId: row.package_id,
      packageDisplay: row.transfer_budget_packages?.display_name ?? 'Paket',
      eurAmount: Number(row.requested_eur_amount),
      uzsPrice: Number(row.uzs_price),
      status: row.status,
      createdAt: row.created_at,
    }));
  }
}
