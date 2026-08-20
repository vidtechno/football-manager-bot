import { describe, it, expect } from 'vitest';
import {
  DEFAULT_TRANSFER_BUDGET_PACKAGES,
  BUDGET_PURCHASE_WARNING_TEXT,
  SOLO_LEAGUE_DELETE_WARNING_TEXT,
} from '../src/config/packages.js';
import {
  formatEur,
  formatUzs,
  buildAdminPaymentDeepLink,
  formatInsufficientBudgetMessage,
  formatSuccessfulLegendPurchaseMessage,
  formatDailyRoundLimitMessage,
} from '../src/utils/formatters.js';

describe('Phase 4G Transfer Budget Packages & Message Helpers Suite', () => {
  it('1. should contain exactly 5 active default purchase packages', () => {
    expect(DEFAULT_TRANSFER_BUDGET_PACKAGES.length).toBe(5);
    const activePackages = DEFAULT_TRANSFER_BUDGET_PACKAGES.filter(
      (p) => p.isActive,
    );
    expect(activePackages.length).toBe(5);
  });

  it('2. should verify correct EUR and UZS package values', () => {
    const expected = [
      { id: 'pkg_10m', eurAmount: 10_000_000, uzsPrice: 5_000 },
      { id: 'pkg_50m', eurAmount: 50_000_000, uzsPrice: 20_000 },
      { id: 'pkg_100m', eurAmount: 100_000_000, uzsPrice: 35_000 },
      { id: 'pkg_250m', eurAmount: 250_000_000, uzsPrice: 75_000 },
      { id: 'pkg_500m', eurAmount: 500_000_000, uzsPrice: 125_000 },
    ];

    for (let i = 0; i < expected.length; i++) {
      const pkg = DEFAULT_TRANSFER_BUDGET_PACKAGES[i];
      const exp = expected[i]!;
      expect(pkg).toBeDefined();
      if (pkg) {
        expect(pkg.id).toBe(exp.id);
        expect(pkg.eurAmount).toBe(exp.eurAmount);
        expect(pkg.uzsPrice).toBe(exp.uzsPrice);
      }
    }
  });

  it('3. should format currency numbers correctly into Uzbek display text', () => {
    expect(formatEur(100_000_000)).toBe('€100 mln');
    expect(formatEur(500_000_000)).toBe('€500 mln');
    expect(formatEur(1_000_000_000)).toBe('€1 mlrd');
    expect(formatUzs(35_000)).toBe('35 000 so‘m');
    expect(formatUzs(125_000)).toBe('125 000 so‘m');
  });

  it('4. should build valid prefilled Telegram deep link containing order details', () => {
    const link = buildAdminPaymentDeepLink({
      eurDisplay: '€100 mln',
      leagueName: 'Gigants League 1',
      clubName: 'Real Madrid',
      orderCode: 'TBP-A1B2C3D4',
    });

    expect(link).toContain('https://t.me/diyorbek_anorboyev?text=');
    const decoded = decodeURIComponent(link);
    expect(decoded).toContain('Paket: €100 mln');
    expect(decoded).toContain('Liga: Gigants League 1');
    expect(decoded).toContain('Klub: Real Madrid');
    expect(decoded).toContain('Buyurtma kodi: TBP-A1B2C3D4');
  });

  it('5. should format clear Uzbek insufficient budget warning message', () => {
    const msg = formatInsufficientBudgetMessage(
      'Cristiano Ronaldo',
      500_000_000,
      300_000_000,
    );
    expect(msg).toContain('⚠️ Transfer budjeti yetarli emas.');
    expect(msg).toContain('Afsona narxi: €500 mln');
    expect(msg).toContain('Klubingiz budjeti: €300 mln');
    expect(msg).toContain('Yetmayotgan summa: €200 mln');
  });

  it('6. should format clear Uzbek successful legend purchase message', () => {
    const msg = formatSuccessfulLegendPurchaseMessage(
      'Lionel Messi',
      'FC Barcelona',
      500_000_000,
      150_000_000,
    );
    expect(msg).toContain('✅ Legenda muvaffaqiyatli sotib olindi!');
    expect(msg).toContain('Futbolchi: Lionel Messi');
    expect(msg).toContain('Xarid narxi: €500 mln');
    expect(msg).toContain('Qolgan transfer budjeti: €150 mln');
  });

  it('7. should include required warning constants', () => {
    expect(BUDGET_PURCHASE_WARNING_TEXT).toContain(
      'faqat shu ligada va shu klub uchun amal qiladi',
    );
    expect(SOLO_LEAGUE_DELETE_WARNING_TEXT).toContain(
      'Bu amalni ortga qaytarib bo‘lmaydi',
    );
  });

  it('8. should format daily round limit error message', () => {
    const msg = formatDailyRoundLimitMessage();
    expect(msg).toContain('⚠️ Kunlik tur limiti tugadi.');
    expect(msg).toContain('3 ta o‘yin turi');
    expect(msg).toContain('00:00 (Toshkent vaqti)');
  });
});
