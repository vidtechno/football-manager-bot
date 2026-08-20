import { describe, it, expect, vi, beforeEach } from 'vitest';
import { IdentityService } from '../src/services/identityService.js';
import { PurchaseService } from '../src/services/purchaseService.js';
import { SponsorService } from '../src/services/sponsorService.js';
import { runBotTransferReviewJob } from '../src/jobs/botTransferReviewWorker.js';

// Mock getSupabaseAdminClient
vi.mock('../src/database/client.js', () => ({
  getSupabaseAdminClient: vi.fn(),
}));

import { getSupabaseAdminClient } from '../src/database/client.js';

describe('End-to-End Launch Readiness Integration Suite', () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  it('1. User Registration & Identity Resolution Flow', async () => {
    const mockManagerRow = {
      id: 'mgr-101',
      telegram_user_id: 777111,
      manager_name: 'TestManager',
      language_code: 'uz',
      status: 'ACTIVE',
      created_at: new Date().toISOString(),
    };

    const mockSupabase = {
      from: vi.fn((table: string) => {
        if (table === 'managers') {
          return {
            select: () => ({
              eq: () => ({
                maybeSingle: async () => ({
                  data: mockManagerRow,
                  error: null,
                }),
              }),
            }),
          };
        }
        return {};
      }),
    };
    vi.mocked(getSupabaseAdminClient).mockReturnValue(mockSupabase as never);

    const manager = await IdentityService.getOrCreateManager(
      777111,
      'TestManager',
    );
    expect(manager.id).toBe('mgr-101');
    expect(manager.telegramUserId).toBe(777111);
    expect(manager.managerName).toBe('TestManager');
  });

  it('2. Admin Verification Flow', async () => {
    const mockAdminRow = {
      id: 'adm-001',
      telegram_user_id: 999888,
      role: 'SUPER_ADMIN',
      status: 'ACTIVE',
      created_at: new Date().toISOString(),
    };

    const mockSupabase = {
      from: vi.fn((table: string) => {
        if (table === 'admin_users') {
          return {
            select: () => ({
              eq: () => ({
                eq: () => ({
                  maybeSingle: async () => ({
                    data: mockAdminRow,
                    error: null,
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

    const admin = await IdentityService.getAdminUser(999888);
    expect(admin).not.toBeNull();
    expect(admin?.id).toBe('adm-001');
    expect(admin?.role).toBe('SUPER_ADMIN');
  });

  it('3. Budget Package Order Code Generation & Validation', () => {
    const activePackages = PurchaseService.getActivePackages();
    expect(activePackages.length).toBe(5);

    const pkg = PurchaseService.getPackageById('pkg_100m');
    expect(pkg).toBeDefined();
    expect(pkg?.eurAmount).toBe(100_000_000);
    expect(pkg?.uzsPrice).toBe(35_000);

    const orderCode = PurchaseService.generateOrderCode();
    expect(orderCode).toMatch(/^TBP-[A-Z0-9]{6}$/);
  });

  it('4. Sponsor Channel Subscription & 6-Hour Cache Rule', async () => {
    const activeSponsor = {
      id: 'sp-77',
      chat_id: -100999,
      display_title: 'Global Sponsor Channel',
      is_active: true,
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
                    maybeSingle: async () => ({ data: null, error: null }),
                  }),
                }),
              }),
            }),
            upsert: vi.fn().mockResolvedValue({ error: null }),
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
      777111,
      'mgr-101',
    );

    expect(res.isSubscribed).toBe(true);
    expect(res.isCached).toBe(false);
    expect(mockBotApi.getChatMember).toHaveBeenCalledWith(-100999, 777111);
  });

  it('5. 24h Bot Transfer Review Job Execution', async () => {
    const mockSupabase = {
      rpc: vi.fn().mockResolvedValue({
        data: { processed_count: 5, purchased_count: 2 },
        error: null,
      }),
    };
    vi.mocked(getSupabaseAdminClient).mockReturnValue(mockSupabase as never);

    const res = await runBotTransferReviewJob(20);
    expect(res.processedCount).toBe(5);
    expect(res.purchasedCount).toBe(2);
    expect(mockSupabase.rpc).toHaveBeenCalledWith(
      'process_bot_transfer_reviews',
      { p_batch_limit: 20 },
    );
  });
});
