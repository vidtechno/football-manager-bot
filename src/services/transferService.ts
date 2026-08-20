import { getSupabaseAdminClient } from '../database/client.js';

export interface TransferListing {
  id: string;
  leagueId: string;
  sellerClubId: string;
  leaguePlayerId: string;
  playerNameSnapshot: string;
  positionCode: string;
  overallRating: number;
  originalMarketValueEur: number;
  askingPriceEur: number;
  status: 'ACTIVE' | 'SOLD' | 'CANCELLED' | 'INVALIDATED';
  buyerClubId: string | null;
  buyerType: 'HUMAN' | 'BOT' | null;
  listedAt: string;
  botEligibleAt: string;
  completedAt: string | null;
  cancelledAt: string | null;
  sellerClubName?: string;
  buyerClubName?: string;
}

interface DbTransferListingRow {
  id: string;
  league_id: string;
  seller_club_id: string;
  league_player_id: string;
  player_name_snapshot: string;
  position_code: string;
  overall_rating: number;
  original_market_value_eur: number | string;
  asking_price_eur: number | string;
  status: 'ACTIVE' | 'SOLD' | 'CANCELLED' | 'INVALIDATED';
  buyer_club_id: string | null;
  buyer_type: 'HUMAN' | 'BOT' | null;
  listed_at: string;
  bot_eligible_at: string;
  completed_at: string | null;
  cancelled_at: string | null;
  seller_club?: { display_name?: string } | null;
  buyer_club?: { display_name?: string } | null;
}

export class TransferService {
  static async getListingLeagueId(listingId: string): Promise<string> {
    const supabase = getSupabaseAdminClient();
    const { data, error } = await supabase
      .from('league_transfer_listings')
      .select('league_id')
      .eq('id', listingId)
      .single();
    if (error) throw new Error(`LISTING_NOT_FOUND: ${error.message}`);
    return data.league_id;
  }

  /**
   * Creates a new player transfer listing via RPC create_player_transfer_listing.
   */
  static async createListing(
    leaguePlayerId: string,
    askingPriceEur: number,
    userId: string,
  ): Promise<{ success: boolean; listingId: string; askingPriceEur: number }> {
    const supabase = getSupabaseAdminClient();
    const { data, error } = await supabase.rpc(
      'create_player_transfer_listing',
      {
        p_league_player_id: leaguePlayerId,
        p_asking_price_eur: askingPriceEur,
        p_user_id: userId,
      },
    );

    if (error) {
      throw new Error(`CREATE_LISTING_FAILED: ${error.message}`);
    }

    return {
      success: data.success,
      listingId: data.listing_id,
      askingPriceEur: data.asking_price_eur,
    };
  }

  /**
   * Cancels an ACTIVE transfer listing via RPC cancel_player_transfer_listing.
   */
  static async cancelListing(
    listingId: string,
    userId: string,
  ): Promise<{ success: boolean; message: string }> {
    const supabase = getSupabaseAdminClient();
    const { data, error } = await supabase.rpc(
      'cancel_player_transfer_listing',
      {
        p_listing_id: listingId,
        p_user_id: userId,
      },
    );

    if (error) {
      throw new Error(`CANCEL_LISTING_FAILED: ${error.message}`);
    }

    return {
      success: data.success,
      message: data.message,
    };
  }

  /**
   * Executes a human purchase for a transfer listing via RPC purchase_player_transfer_listing.
   */
  static async purchaseListing(
    listingId: string,
    buyerClubId: string,
    userId: string,
  ): Promise<{ success: boolean; priceEur: number; remainingBudget: number }> {
    const supabase = getSupabaseAdminClient();
    const { data, error } = await supabase.rpc(
      'purchase_player_transfer_listing',
      {
        p_listing_id: listingId,
        p_buyer_club_id: buyerClubId,
        p_user_id: userId,
      },
    );

    if (error) {
      throw new Error(`PURCHASE_LISTING_FAILED: ${error.message}`);
    }

    return {
      success: data.success,
      priceEur: data.price_eur,
      remainingBudget: data.remaining_budget,
    };
  }

  /**
   * Returns active transfer listings for a league with optional position/affordable filters and pagination.
   */
  static async getActiveListings(
    leagueId: string,
    options: {
      position?: string;
      maxPrice?: number;
      page?: number;
      pageSize?: number;
      priceSort?: 'asc' | 'desc';
    } = {},
  ): Promise<{
    listings: TransferListing[];
    totalPages: number;
    page: number;
  }> {
    const supabase = getSupabaseAdminClient();
    const page = options.page || 1;
    const pageSize = options.pageSize || 5;

    let query = supabase
      .from('league_transfer_listings')
      .select('*, seller_club:league_clubs!seller_club_id(display_name)', {
        count: 'exact',
      })
      .eq('league_id', leagueId)
      .eq('status', 'ACTIVE');

    if (options.position && options.position !== 'ALL') {
      if (options.position === 'GK') {
        query = query.eq('position_code', 'GK');
      } else if (options.position === 'DEF') {
        query = query.in('position_code', ['CB', 'LB', 'RB', 'LWB', 'RWB']);
      } else if (options.position === 'MID') {
        query = query.in('position_code', ['CDM', 'CM', 'CAM', 'LM', 'RM']);
      } else if (options.position === 'FWD') {
        query = query.in('position_code', ['LW', 'RW', 'CF', 'ST']);
      }
    }

    if (options.maxPrice !== undefined) {
      query = query.lte('asking_price_eur', options.maxPrice);
    }

    if (options.priceSort) {
      query = query.order('asking_price_eur', {
        ascending: options.priceSort === 'asc',
      });
    } else {
      query = query.order('listed_at', { ascending: false });
    }

    const from = (page - 1) * pageSize;
    const to = from + pageSize - 1;

    const { data, count, error } = await query.range(from, to);

    if (error) {
      throw new Error(`GET_ACTIVE_LISTINGS_FAILED: ${error.message}`);
    }

    const totalPages = Math.ceil((count || 0) / pageSize) || 1;

    const listings: TransferListing[] = (data || []).map(
      (row: DbTransferListingRow) => ({
        id: row.id,
        leagueId: row.league_id,
        sellerClubId: row.seller_club_id,
        leaguePlayerId: row.league_player_id,
        playerNameSnapshot: row.player_name_snapshot,
        positionCode: row.position_code,
        overallRating: row.overall_rating,
        originalMarketValueEur: Number(row.original_market_value_eur),
        askingPriceEur: Number(row.asking_price_eur),
        status: row.status,
        buyerClubId: row.buyer_club_id,
        buyerType: row.buyer_type,
        listedAt: row.listed_at,
        botEligibleAt: row.bot_eligible_at,
        completedAt: row.completed_at,
        cancelledAt: row.cancelled_at,
        sellerClubName: row.seller_club?.display_name || 'Noma‘lum Klub',
      }),
    );

    return { listings, totalPages, page };
  }

  /**
   * Returns active listings for a specific seller club.
   */
  static async getClubActiveListings(
    clubId: string,
  ): Promise<TransferListing[]> {
    const supabase = getSupabaseAdminClient();
    const { data, error } = await supabase
      .from('league_transfer_listings')
      .select('*')
      .eq('seller_club_id', clubId)
      .eq('status', 'ACTIVE')
      .order('listed_at', { ascending: false });

    if (error) {
      throw new Error(`GET_CLUB_LISTINGS_FAILED: ${error.message}`);
    }

    return (data || []).map((row: DbTransferListingRow) => ({
      id: row.id,
      leagueId: row.league_id,
      sellerClubId: row.seller_club_id,
      leaguePlayerId: row.league_player_id,
      playerNameSnapshot: row.player_name_snapshot,
      positionCode: row.position_code,
      overallRating: row.overall_rating,
      originalMarketValueEur: Number(row.original_market_value_eur),
      askingPriceEur: Number(row.asking_price_eur),
      status: row.status,
      buyerClubId: row.buyer_club_id,
      buyerType: row.buyer_type,
      listedAt: row.listed_at,
      botEligibleAt: row.bot_eligible_at,
      completedAt: row.completed_at,
      cancelledAt: row.cancelled_at,
    }));
  }

  /**
   * Returns completed transfer history for a league.
   */
  static async getTransferHistory(
    leagueId: string,
    options: {
      clubId?: string;
      filter?: 'ALL' | 'MY_CLUB' | 'PURCHASES' | 'SALES';
      page?: number;
      pageSize?: number;
    } = {},
  ): Promise<{
    listings: TransferListing[];
    totalPages: number;
    page: number;
  }> {
    const supabase = getSupabaseAdminClient();
    const page = options.page || 1;
    const pageSize = options.pageSize || 5;

    let query = supabase
      .from('league_transfer_listings')
      .select(
        '*, seller_club:league_clubs!seller_club_id(display_name), buyer_club:league_clubs!buyer_club_id(display_name)',
        { count: 'exact' },
      )
      .eq('league_id', leagueId)
      .eq('status', 'SOLD');

    if (options.clubId) {
      if (options.filter === 'PURCHASES') {
        query = query.eq('buyer_club_id', options.clubId);
      } else if (options.filter === 'SALES') {
        query = query.eq('seller_club_id', options.clubId);
      } else if (options.filter === 'MY_CLUB') {
        query = query.or(
          `seller_club_id.eq.${options.clubId},buyer_club_id.eq.${options.clubId}`,
        );
      }
    }

    query = query.order('completed_at', { ascending: false });

    const from = (page - 1) * pageSize;
    const to = from + pageSize - 1;

    const { data, count, error } = await query.range(from, to);

    if (error) {
      throw new Error(`GET_TRANSFER_HISTORY_FAILED: ${error.message}`);
    }

    const totalPages = Math.ceil((count || 0) / pageSize) || 1;

    const listings: TransferListing[] = (data || []).map(
      (row: DbTransferListingRow) => ({
        id: row.id,
        leagueId: row.league_id,
        sellerClubId: row.seller_club_id,
        leaguePlayerId: row.league_player_id,
        playerNameSnapshot: row.player_name_snapshot,
        positionCode: row.position_code,
        overallRating: row.overall_rating,
        originalMarketValueEur: Number(row.original_market_value_eur),
        askingPriceEur: Number(row.asking_price_eur),
        status: row.status,
        buyerClubId: row.buyer_club_id,
        buyerType: row.buyer_type,
        listedAt: row.listed_at,
        botEligibleAt: row.bot_eligible_at,
        completedAt: row.completed_at,
        cancelledAt: row.cancelled_at,
        sellerClubName: row.seller_club?.display_name || 'Noma‘lum Klub',
        buyerClubName: row.buyer_club?.display_name || 'Noma‘lum Klub',
      }),
    );

    return { listings, totalPages, page };
  }

  /**
   * Returns cancelled listings for a league.
   */
  static async getCancelledListings(
    leagueId: string,
    options: {
      clubId?: string;
      page?: number;
      pageSize?: number;
    } = {},
  ): Promise<{
    listings: TransferListing[];
    totalPages: number;
    page: number;
  }> {
    const supabase = getSupabaseAdminClient();
    const page = options.page || 1;
    const pageSize = options.pageSize || 5;

    let query = supabase
      .from('league_transfer_listings')
      .select('*, seller_club:league_clubs!seller_club_id(display_name)', {
        count: 'exact',
      })
      .eq('league_id', leagueId)
      .eq('status', 'CANCELLED');

    if (options.clubId) {
      query = query.eq('seller_club_id', options.clubId);
    }

    query = query.order('cancelled_at', { ascending: false });

    const from = (page - 1) * pageSize;
    const to = from + pageSize - 1;

    const { data, count, error } = await query.range(from, to);

    if (error) {
      throw new Error(`GET_CANCELLED_LISTINGS_FAILED: ${error.message}`);
    }

    const totalPages = Math.ceil((count || 0) / pageSize) || 1;

    const listings: TransferListing[] = (data || []).map(
      (row: DbTransferListingRow) => ({
        id: row.id,
        leagueId: row.league_id,
        sellerClubId: row.seller_club_id,
        leaguePlayerId: row.league_player_id,
        playerNameSnapshot: row.player_name_snapshot,
        positionCode: row.position_code,
        overallRating: row.overall_rating,
        originalMarketValueEur: Number(row.original_market_value_eur),
        askingPriceEur: Number(row.asking_price_eur),
        status: row.status,
        buyerClubId: row.buyer_club_id,
        buyerType: row.buyer_type,
        listedAt: row.listed_at,
        botEligibleAt: row.bot_eligible_at,
        completedAt: row.completed_at,
        cancelledAt: row.cancelled_at,
        sellerClubName: row.seller_club?.display_name || 'Noma‘lum Klub',
      }),
    );

    return { listings, totalPages, page };
  }

  /**
   * Executes scheduled bot review worker for 24h+ active listings via RPC process_bot_transfer_reviews.
   */
  static async processBotReviews(
    batchLimit = 20,
  ): Promise<{ processedCount: number; purchasedCount: number }> {
    const supabase = getSupabaseAdminClient();
    const { data, error } = await supabase.rpc('process_bot_transfer_reviews', {
      p_batch_limit: batchLimit,
    });

    if (error) {
      throw new Error(`PROCESS_BOT_REVIEWS_FAILED: ${error.message}`);
    }

    return {
      processedCount: data.processed_count,
      purchasedCount: data.purchased_count,
    };
  }
}
