import { describe, it, expect, vi, beforeEach } from 'vitest';
import { SponsorService } from '../src/services/sponsorService.js';

// Mock getSupabaseAdminClient
vi.mock('../src/database/client.js', () => ({
  getSupabaseAdminClient: vi.fn(),
}));

import { getSupabaseAdminClient } from '../src/database/client.js';

type MockClientGetter = () => unknown;

describe('SponsorService Unit Tests', () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  describe('verifyManagerSubscription', () => {
    it('returns false when no active global sponsor channel exists', async () => {
      const mockSupabase = {
        from: vi.fn().mockReturnThis(),
        select: vi.fn().mockReturnThis(),
        eq: vi.fn().mockReturnThis(),
        maybeSingle: vi.fn().mockResolvedValue({ data: null, error: null }),
      };
      (getSupabaseAdminClient as unknown as MockClientGetter) = vi
        .fn()
        .mockReturnValue(mockSupabase);

      const mockBotApi = {
        getChatMember: vi.fn(),
      };

      const res = await SponsorService.verifyManagerSubscription(
        mockBotApi,
        123456,
        'mgr-uuid-1',
      );

      expect(res.isSubscribed).toBe(false);
      expect(res.sponsorSetting).toBeNull();
      expect(mockBotApi.getChatMember).not.toHaveBeenCalled();
    });

    it('returns cached subscription status when valid recent verification exists', async () => {
      const activeSponsor = {
        id: 'sponsor-1',
        chat_id: -100123456,
        display_title: 'Test Channel',
        is_active: true,
      };

      const cachedVerification = {
        id: 'ver-1',
        manager_id: 'mgr-uuid-1',
        sponsor_setting_id: 'sponsor-1',
        is_subscribed: true,
        verified_at: new Date().toISOString(),
      };

      const mockSupabase = {
        from: vi.fn((table: string) => {
          if (table === 'global_sponsor_settings') {
            return {
              select: () => ({
                eq: () => ({
                  maybeSingle: async () => ({
                    data: activeSponsor,
                    error: null,
                  }),
                }),
              }),
            };
          }
          if (table === 'manager_sponsor_verifications') {
            return {
              select: () => ({
                eq: () => ({
                  eq: () => ({
                    gte: () => ({
                      maybeSingle: async () => ({
                        data: cachedVerification,
                        error: null,
                      }),
                    }),
                  }),
                }),
              }),
            };
          }
          return {};
        }),
      };
      vi.mocked(getSupabaseAdminClient).mockReturnValue(mockSupabase as never);

      const mockBotApi = {
        getChatMember: vi.fn(),
      };

      const res = await SponsorService.verifyManagerSubscription(
        mockBotApi,
        123456,
        'mgr-uuid-1',
      );

      expect(res.isSubscribed).toBe(true);
      expect(res.isCached).toBe(true);
      expect(mockBotApi.getChatMember).not.toHaveBeenCalled();
    });

    it('calls Telegram API and caches status when cache is empty', async () => {
      const activeSponsor = {
        id: 'sponsor-1',
        chat_id: -100123456,
        display_title: 'Test Channel',
        is_active: true,
      };

      const upsertFn = vi.fn().mockResolvedValue({ error: null });

      const mockSupabase = {
        from: vi.fn((table: string) => {
          if (table === 'global_sponsor_settings') {
            return {
              select: () => ({
                eq: () => ({
                  maybeSingle: async () => ({
                    data: activeSponsor,
                    error: null,
                  }),
                }),
              }),
            };
          }
          if (table === 'manager_sponsor_verifications') {
            return {
              select: () => ({
                eq: () => ({
                  eq: () => ({
                    gte: () => ({
                      maybeSingle: async () => ({ data: null, error: null }),
                    }),
                  }),
                }),
              }),
              upsert: upsertFn,
            };
          }
          return {};
        }),
      };
      vi.mocked(getSupabaseAdminClient).mockReturnValue(mockSupabase as never);

      const mockBotApi = {
        getChatMember: vi
          .fn()
          .mockResolvedValue({ status: 'member', is_member: true }),
      };

      const res = await SponsorService.verifyManagerSubscription(
        mockBotApi,
        123456,
        'mgr-uuid-1',
      );

      expect(res.isSubscribed).toBe(true);
      expect(res.isCached).toBe(false);
      expect(mockBotApi.getChatMember).toHaveBeenCalledWith(-100123456, 123456);
      expect(upsertFn).toHaveBeenCalled();
    });
  });
});
