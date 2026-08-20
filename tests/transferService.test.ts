import { describe, it, expect, vi } from 'vitest';
import { TransferService } from '../src/services/transferService.js';

vi.mock('../src/database/client.js', () => {
  return {
    getSupabaseAdminClient: () => ({
      rpc: (fnName: string, args: Record<string, unknown>) => {
        if (fnName === 'create_player_transfer_listing') {
          const askingPrice = Number(args.p_asking_price_eur);
          if (askingPrice <= 0) {
            return Promise.resolve({
              data: null,
              error: { message: 'INVALID_ASKING_PRICE' },
            });
          }
          return Promise.resolve({
            data: {
              success: true,
              listing_id: 'listing-123',
              asking_price_eur: askingPrice,
            },
            error: null,
          });
        }

        if (fnName === 'cancel_player_transfer_listing') {
          return Promise.resolve({
            data: { success: true, message: 'Cancelled' },
            error: null,
          });
        }

        if (fnName === 'purchase_player_transfer_listing') {
          if (args.p_buyer_club_id === 'same-club') {
            return Promise.resolve({
              data: null,
              error: { message: 'CANNOT_BUY_OWN_PLAYER' },
            });
          }
          return Promise.resolve({
            data: {
              success: true,
              price_eur: 20_000_000,
              remaining_budget: 80_000_000,
            },
            error: null,
          });
        }

        if (fnName === 'process_bot_transfer_reviews') {
          return Promise.resolve({
            data: { processed_count: 5, purchased_count: 2 },
            error: null,
          });
        }

        return Promise.resolve({ data: null, error: null });
      },
    }),
  };
});

describe('TransferService Unit Tests', () => {
  it('should call create_player_transfer_listing RPC and return listing ID', async () => {
    const res = await TransferService.createListing(
      'player-123',
      25_000_000,
      'user-123',
    );
    expect(res.success).toBe(true);
    expect(res.listingId).toBe('listing-123');
    expect(res.askingPriceEur).toBe(25_000_000);
  });

  it('should throw error when creating listing with invalid price', async () => {
    await expect(
      TransferService.createListing('player-123', -500, 'user-123'),
    ).rejects.toThrow('CREATE_LISTING_FAILED: INVALID_ASKING_PRICE');
  });

  it('should call cancel_player_transfer_listing RPC', async () => {
    const res = await TransferService.cancelListing('listing-123', 'user-123');
    expect(res.success).toBe(true);
    expect(res.message).toBe('Cancelled');
  });

  it('should call purchase_player_transfer_listing RPC and return budget details', async () => {
    const res = await TransferService.purchaseListing(
      'listing-123',
      'buyer-club-123',
      'user-123',
    );
    expect(res.success).toBe(true);
    expect(res.priceEur).toBe(20_000_000);
    expect(res.remainingBudget).toBe(80_000_000);
  });

  it('should reject purchasing own player listing', async () => {
    await expect(
      TransferService.purchaseListing('listing-123', 'same-club', 'user-123'),
    ).rejects.toThrow('PURCHASE_LISTING_FAILED: CANNOT_BUY_OWN_PLAYER');
  });

  it('should call processBotReviews and return processed metrics', async () => {
    const res = await TransferService.processBotReviews(10);
    expect(res.processedCount).toBe(5);
    expect(res.purchasedCount).toBe(2);
  });
});
