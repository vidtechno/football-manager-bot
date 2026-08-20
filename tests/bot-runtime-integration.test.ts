import { describe, it, expect, vi } from 'vitest';
import {
  handlePackageView,
  handlePackageSelect,
} from '../src/bot/handlers/packageHandler.js';
import {
  handleAdminPendingOrdersList,
  handleAdminOrderDetails,
} from '../src/bot/handlers/adminHandler.js';
import {
  handleSoloLeagueDeleteStep1,
  handleSoloLeagueDeleteStep2,
  handleSoloLeagueDeleteSuccess,
  handleDailyRoundLimitReached,
} from '../src/bot/handlers/leagueHandler.js';
import {
  handleLegendMarketList,
  handleLegendDetails,
  handleLegendPurchaseSuccess,
} from '../src/bot/handlers/legendHandler.js';
import { buildEmptyLegendsMarketMessage } from '../src/bot/messages/templates.js';

describe('Phase 4H Telegram Bot Runtime Integration Suite', () => {
  it('1. should render 💰 Transfer budjetini oshirish package menu with 5 packages', () => {
    const res = handlePackageView({
      leagueName: 'Gigants League 1',
      clubName: 'Real Madrid',
      currentBudgetEur: 100_000_000,
      leagueId: 'leg_12345',
    });

    expect(res.text).toContain('Transfer Budjetini Oshirish');
    expect(res.text).toContain('Real Madrid');
    expect(res.text).toContain('€100 mln');
    expect(res.keyboard.length).toBe(7); // 5 package buttons + 1 my_orders button + 1 back button
    expect(res.keyboard[0]![0]!.text).toContain('€10 million — 5 000 so‘m');
    expect(res.keyboard[4]![0]!.text).toContain('€500 million — 125 000 so‘m');
  });

  it('2. should render order confirmation screen with prefilled Telegram deep link targeting @diyorbek_anorboyev', () => {
    const res = handlePackageSelect({
      packageId: 'pkg_100m',
      leagueId: 'leg_12345',
      leagueName: 'Gigants League 1',
      clubName: 'Real Madrid',
      telegramUserId: 99887766,
      existingOrderCode: 'TBP-TEST01',
    });

    expect(res.text).toContain('Buyurtma Shakllantirildi');
    expect(res.text).toContain('TBP-TEST01');
    expect(res.text).toContain('€100 mln');
    expect(res.text).toContain('35 000 so‘m');

    // Button 0 row 0 is 💬 Admin bilan bog‘lanish URL button
    const adminBtn = res.keyboard[0]![0]!;
    expect(adminBtn.text).toBe('💬 Admin bilan bog‘lanish');
    if ('url' in adminBtn) {
      expect(adminBtn.url).toBeDefined();
      expect(adminBtn.url).toContain('https://t.me/diyorbek_anorboyev?text=');
      const decodedUrl = decodeURIComponent(adminBtn.url);
      expect(decodedUrl).toContain('TBP-TEST01');
      expect(decodedUrl).toContain('Paket: €100 million');
      expect(decodedUrl).toContain('Liga: Gigants League 1');
      expect(decodedUrl).toContain('Klub: Real Madrid');
    } else {
      throw new Error('Expected UrlButton but received callback button');
    }
  });

  it('3. should render Admin Pending Orders List and Details screens', () => {
    const sampleOrders = [
      {
        id: 'req_001',
        orderCode: 'TBP-ADM001',
        leagueName: 'Gigants League 1',
        clubName: 'FC Barcelona',
        packageDisplay: '€500 million',
        eurAmount: 500_000_000,
        uzsPrice: 125_000,
        telegramUsername: 'barca_manager',
        telegramUserId: 11223344,
        createdAt: '2026-08-19 13:40',
      },
    ];

    const listRes = handleAdminPendingOrdersList(sampleOrders);
    expect(listRes.text).toContain('Kutilayotgan Buyurtmalar Ro‘yxati (1)');
    expect(listRes.text).toContain('TBP-ADM001');
    expect(listRes.keyboard[0]![0]!.text).toContain('TBP-ADM001');

    const detailRes = handleAdminOrderDetails(sampleOrders[0]!);
    expect(detailRes.text).toContain('Buyurtma Tafsilotlari');
    expect(detailRes.text).toContain('@barca_manager');
    expect(detailRes.text).toContain('€500 mln');
    expect(detailRes.keyboard[0]![0]!.text).toBe('✅ Tasdiqlash');
    expect(detailRes.keyboard[0]![1]!.text).toBe('❌ Rad etish');
  });

  it('4. should render 2-step solo league deletion UI flow and block multi-human leagues', () => {
    // Multi-human league -> blocked
    const blockedRes = handleSoloLeagueDeleteStep1(
      'leg_123',
      'Multi League',
      3,
    );
    expect(blockedRes.text).toContain('Ligani o‘chirib bo‘lmaydi');
    expect(blockedRes.text).toContain('boshqa haqiqiy inson menejerlar mavjud');

    // Solo league -> Step 1 confirmation
    const step1 = handleSoloLeagueDeleteStep1('leg_123', 'Solo League', 1);
    expect(step1.text).toContain('Ligani Butunlay O‘chirish');
    expect(step1.text).toContain('Bu amalni ortga qaytarib bo‘lmaydi');
    expect(step1.keyboard[0]![0]!.text).toBe('❌ Bekor qilish');
    expect(step1.keyboard[0]![1]!.text).toBe('Davom etish ➡️');

    // Step 2 explicit confirmation
    const step2 = handleSoloLeagueDeleteStep2(
      'leg_123',
      'Solo League',
      'Solo FC',
    );
    expect(step2.text).toContain("QAT'IY TASDIQLASH");
    expect(step2.keyboard[0]![1]!.text).toBe('🗑 Ha, ligani o‘chirish');

    // Success response
    const success = handleSoloLeagueDeleteSuccess('Solo League');
    expect(success.text).toContain('Liga muvaffaqiyatli o‘chirildi');
  });

  it('5. should render daily 3-round limit error message', () => {
    const res = handleDailyRoundLimitReached();
    expect(res.text).toContain('Kunlik tur limiti tugadi');
    expect(res.text).toContain('3 ta o‘yin turi');
    expect(res.text).toContain('00:00');
    expect(res.text).toContain('Toshkent vaqti');
  });

  it('6. should render empty Legend Transfers market message gracefully when dataset empty', () => {
    const text = buildEmptyLegendsMarketMessage();
    expect(text).toContain('Legendalar Bozori');
    expect(text).toContain('hozircha tayyorlanmoqda');
  });

  it('7. should render Legend Transfers market list with position filters and pagination', () => {
    const listRes = handleLegendMarketList('leg_123', 'ALL', 1, 5, 100_000_000);
    expect(listRes.text).toContain('Afsonalar Bozori');
    expect(listRes.text).toContain('€100 mln');
    expect(listRes.keyboard.length).toBe(8); // 1 filter row + 5 item rows + 1 pagination row + 1 back row

    const gkRes = handleLegendMarketList('leg_123', 'GK', 1, 5, 100_000_000);
    expect(gkRes.text).toContain('*Saralash:* GK');
    expect(gkRes.keyboard[1]![0]!.text).toContain('GK');
  });

  it('8. should render Legend Details screen and handle insufficient budget vs sufficient budget', () => {
    // Insufficient budget for peak Ronaldo (€500m vs €100m budget)
    const ronaldoRes = handleLegendDetails(
      'leg_123',
      'leg-cristiano-ronaldo-prime',
      100_000_000,
    );
    expect(ronaldoRes.text).toContain('Cristiano Ronaldo');
    expect(ronaldoRes.text).toContain('€500 mln');
    expect(ronaldoRes.text).toContain('Transfer budjeti yetarli emas');
    expect(ronaldoRes.keyboard[0]![0]!.text).toBe(
      '💰 Transfer budjetini oshirish',
    );

    // Sufficient budget (€600m budget for peak Ronaldo)
    const richRes = handleLegendDetails(
      'leg_123',
      'leg-cristiano-ronaldo-prime',
      600_000_000,
    );
    expect(richRes.keyboard[0]![0]!.text).toBe('✅ Sotib olish');

    // Purchase success message
    const purchaseRes = handleLegendPurchaseSuccess(
      'Cristiano Ronaldo',
      'Real Madrid',
      500_000_000,
      100_000_000,
      'leg_123',
    );
    expect(purchaseRes.text).toContain('Legenda muvaffaqiyatli sotib olindi');
    expect(purchaseRes.text).toContain('€500 mln');
  });

  it('9. should initialize Bot router cleanly with environment variables', async () => {
    process.env['SUPABASE_PROJECT_ID'] = 'test-proj';
    process.env['SUPABASE_URL'] = 'https://test-proj.supabase.co';
    process.env['SUPABASE_ANON_KEY'] = 'anon-key-test';
    process.env['SUPABASE_SECRET_KEY'] = 'service-role-test';
    process.env['TELEGRAM_BOT_TOKEN'] = '123456789:ABCdefGhIJKlmNoPQRsTUVwxyZ';
    process.env['TELEGRAM_BOT_USERNAME'] = 'football_manager_test_bot';
    process.env['TELEGRAM_WEBHOOK_SECRET'] = 'wh-secret-test';
    process.env['CRON_SECRET'] = 'cron-secret-test';

    const { createBot } = await import('../src/bot/bot.js');
    const bot = createBot();
    expect(bot).toBeDefined();
    expect(bot.api).toBeDefined();
  });

  it('10. should verify production entrypoint main() is async and calls startBot()', async () => {
    const botModule = await import('../src/bot/bot.js');
    const startBotSpy = vi.spyOn(botModule, 'startBot').mockResolvedValue();

    const { main } = await import('../src/index.js');
    expect(typeof main).toBe('function');

    await main();
    expect(startBotSpy).toHaveBeenCalledTimes(1);
  });
});
