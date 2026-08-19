import { getSupabaseAdminClient } from '../database/client.js';
import {
  TransferBudgetPackage,
  DEFAULT_TRANSFER_BUDGET_PACKAGES,
} from '../config/packages.js';

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
  telegramUsername?: string | undefined;
  status: 'PENDING' | 'APPROVED' | 'REJECTED' | 'EXPIRED' | 'CANCELLED';
  createdAt: string;
}

export interface PurchaseApprovalResult {
  requestId: string;
  orderCode: string;
  leagueClubId: string;
  addedEurAmount: number;
  newBalance: number;
}

type RawDbRow = Record<string, unknown>;

export class PurchaseService {
  /**
   * Returns all active transfer budget packages available for purchase.
   */
  static getActivePackages(): TransferBudgetPackage[] {
    return DEFAULT_TRANSFER_BUDGET_PACKAGES;
  }

  /**
   * Finds a transfer budget package by its ID.
   */
  static getPackageById(packageId: string): TransferBudgetPackage | undefined {
    return DEFAULT_TRANSFER_BUDGET_PACKAGES.find(
      (p: TransferBudgetPackage) => p.id === packageId,
    );
  }

  /**
   * Generates a unique short order code formatted as TBP-XXXXXX
   */
  static generateOrderCode(): string {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    let code = 'TBP-';
    for (let i = 0; i < 6; i++) {
      code += chars.charAt(Math.floor(Math.random() * chars.length));
    }
    return code;
  }

  /**
   * Creates a new transfer budget purchase request order for a user.
   */
  static async createPurchaseRequest(params: {
    telegramUserId: number;
    leagueId: string;
    leagueClubId: string;
    pkg: TransferBudgetPackage;
  }): Promise<PurchaseRequestRecord> {
    const supabase = getSupabaseAdminClient();

    // Check if user already has an active PENDING request for this league and package
    const { data: existing } = await supabase
      .from('transfer_budget_purchase_requests')
      .select(
        '*, leagues(name), league_clubs(name), transfer_budget_packages(display_name)',
      )
      .eq('telegram_user_id', params.telegramUserId)
      .eq('league_id', params.leagueId)
      .eq('package_id', params.pkg.id)
      .eq('status', 'PENDING')
      .single();

    if (existing) {
      const row = existing as RawDbRow;
      return {
        id: String(row['id']),
        orderCode: String(row['order_code']),
        telegramUserId: Number(row['telegram_user_id']),
        leagueId: String(row['league_id']),
        leagueClubId: String(row['league_club_id']),
        leagueName:
          (row['leagues'] as Record<string, string>)?.['name'] ?? 'Liga',
        clubName:
          (row['league_clubs'] as Record<string, string>)?.['name'] ?? 'Klub',
        packageId: String(row['package_id']),
        packageDisplay:
          (row['transfer_budget_packages'] as Record<string, string>)?.[
            'display_name'
          ] ?? params.pkg.displayName,
        eurAmount: Number(row['requested_eur_amount']),
        uzsPrice: Number(row['uzs_price']),
        status: row['status'] as PurchaseRequestRecord['status'],
        createdAt: String(row['created_at']),
      };
    }

    const orderCode = this.generateOrderCode();

    const { data, error } = await supabase.rpc(
      'create_transfer_budget_purchase_request',
      {
        p_telegram_user_id: params.telegramUserId,
        p_league_id: params.leagueId,
        p_league_club_id: params.leagueClubId,
        p_package_id: params.pkg.id,
        p_order_code: orderCode,
        p_requested_eur_amount: params.pkg.eurAmount,
        p_uzs_price: params.pkg.uzsPrice,
      },
    );

    if (error) {
      throw new Error(`CREATE_PURCHASE_REQUEST_FAILED: ${error.message}`);
    }

    return {
      id: String(data.id),
      orderCode: String(data.order_code),
      telegramUserId: params.telegramUserId,
      leagueId: params.leagueId,
      leagueClubId: params.leagueClubId,
      leagueName: 'Liga',
      clubName: 'Klub',
      packageId: params.pkg.id,
      packageDisplay: params.pkg.displayName,
      eurAmount: params.pkg.eurAmount,
      uzsPrice: params.pkg.uzsPrice,
      status: 'PENDING',
      createdAt: String(data.created_at),
    };
  }

  /**
   * Fetches all purchase orders submitted by a Telegram user.
   */
  static async getUserOrders(
    telegramUserId: number,
  ): Promise<PurchaseRequestRecord[]> {
    const supabase = getSupabaseAdminClient();
    const { data, error } = await supabase
      .from('transfer_budget_purchase_requests')
      .select(
        '*, leagues(name), league_clubs(name), transfer_budget_packages(display_name)',
      )
      .eq('telegram_user_id', telegramUserId)
      .order('created_at', { ascending: false });

    if (error) {
      throw new Error(`GET_USER_ORDERS_FAILED: ${error.message}`);
    }

    return ((data || []) as RawDbRow[]).map((row) => ({
      id: String(row['id']),
      orderCode: String(row['order_code']),
      telegramUserId: Number(row['telegram_user_id']),
      leagueId: String(row['league_id']),
      leagueClubId: String(row['league_club_id']),
      leagueName:
        (row['leagues'] as Record<string, string>)?.['name'] ?? 'Liga',
      clubName:
        (row['league_clubs'] as Record<string, string>)?.['name'] ?? 'Klub',
      packageId: String(row['package_id']),
      packageDisplay:
        (row['transfer_budget_packages'] as Record<string, string>)?.[
          'display_name'
        ] ?? 'Paket',
      eurAmount: Number(row['requested_eur_amount']),
      uzsPrice: Number(row['uzs_price']),
      status: row['status'] as PurchaseRequestRecord['status'],
      createdAt: String(row['created_at']),
    }));
  }

  /**
   * Fetches all pending purchase requests for admin review.
   */
  static async getPendingOrders(): Promise<PurchaseRequestRecord[]> {
    const supabase = getSupabaseAdminClient();
    const { data, error } = await supabase
      .from('transfer_budget_purchase_requests')
      .select(
        '*, leagues(name), league_clubs(name), transfer_budget_packages(display_name), users(username)',
      )
      .eq('status', 'PENDING')
      .order('created_at', { ascending: true });

    if (error) {
      throw new Error(`GET_PENDING_ORDERS_FAILED: ${error.message}`);
    }

    return ((data || []) as RawDbRow[]).map((row) => ({
      id: String(row['id']),
      orderCode: String(row['order_code']),
      telegramUserId: Number(row['telegram_user_id']),
      leagueId: String(row['league_id']),
      leagueClubId: String(row['league_club_id']),
      leagueName:
        (row['leagues'] as Record<string, string>)?.['name'] ?? 'Liga',
      clubName:
        (row['league_clubs'] as Record<string, string>)?.['name'] ?? 'Klub',
      packageId: String(row['package_id']),
      packageDisplay:
        (row['transfer_budget_packages'] as Record<string, string>)?.[
          'display_name'
        ] ?? 'Paket',
      eurAmount: Number(row['requested_eur_amount']),
      uzsPrice: Number(row['uzs_price']),
      telegramUsername: (row['users'] as Record<string, string> | undefined)?.[
        'username'
      ],
      status: row['status'] as PurchaseRequestRecord['status'],
      createdAt: String(row['created_at']),
    }));
  }

  /**
   * Approves a pending purchase request, adding transfer budget to the club and recording financial ledger.
   */
  static async approvePurchaseRequest(
    requestId: string,
    adminId: string,
    notes?: string,
  ): Promise<PurchaseApprovalResult> {
    const supabase = getSupabaseAdminClient();
    const { data, error } = await supabase.rpc(
      'approve_transfer_budget_purchase_request',
      {
        p_request_id: requestId,
        p_admin_id: adminId,
        p_admin_notes: notes || 'Approved via Telegram Bot',
      },
    );

    if (error) {
      throw new Error(`APPROVE_PURCHASE_REQUEST_FAILED: ${error.message}`);
    }

    return {
      requestId: String(data.request_id),
      orderCode: String(data.order_code),
      leagueClubId: String(data.league_club_id),
      addedEurAmount: Number(data.added_eur_amount),
      newBalance: Number(data.new_balance),
    };
  }

  /**
   * Rejects a pending purchase request.
   */
  static async rejectPurchaseRequest(
    requestId: string,
    adminId: string,
    notes?: string,
  ): Promise<void> {
    const supabase = getSupabaseAdminClient();
    const { error } = await supabase.rpc(
      'reject_transfer_budget_purchase_request',
      {
        p_request_id: requestId,
        p_admin_id: adminId,
        p_admin_notes: notes || 'Rejected via Telegram Bot',
      },
    );

    if (error) {
      throw new Error(`REJECT_PURCHASE_REQUEST_FAILED: ${error.message}`);
    }
  }
}
