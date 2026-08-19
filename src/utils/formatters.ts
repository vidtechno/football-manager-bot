import { DEFAULT_ADMIN_TELEGRAM_USERNAME } from '../config/packages.js';

export function formatEur(amount: number): string {
  if (amount >= 1_000_000_000 && amount % 1_000_000_000 === 0) {
    return `€${amount / 1_000_000_000} mlrd`;
  }
  if (amount >= 1_000_000 && amount % 1_000_000 === 0) {
    return `€${amount / 1_000_000} mln`;
  }
  return `€${amount.toLocaleString('fr-FR').replace(/\s/g, ' ')}`;
}

export function formatUzs(amount: number): string {
  return `${amount.toLocaleString('fr-FR').replace(/\s/g, ' ')} so‘m`;
}

export interface DeepLinkParams {
  adminUsername?: string | undefined;
  eurDisplay: string;
  leagueName: string;
  clubName: string;
  orderCode: string;
}

export function buildAdminPaymentDeepLink(params: DeepLinkParams): string {
  const admin = params.adminUsername || DEFAULT_ADMIN_TELEGRAM_USERNAME;
  const rawText = `Assalomu alaykum, transfer budjeti sotib olmoqchiman. Paket: ${params.eurDisplay}. Liga: ${params.leagueName}. Klub: ${params.clubName}. Buyurtma kodi: ${params.orderCode}.`;
  return `https://t.me/${admin}?text=${encodeURIComponent(rawText)}`;
}

export function formatInsufficientBudgetMessage(
  legendName: string,
  legendPriceEur: number,
  clubBudgetEur: number,
): string {
  const missing = Math.max(0, legendPriceEur - clubBudgetEur);
  return (
    `⚠️ Transfer budjeti yetarli emas.\n\n` +
    `⚽ Futbolchi: ${legendName}\n` +
    `💰 Afsona narxi: ${formatEur(legendPriceEur)}\n` +
    `🏦 Klubingiz budjeti: ${formatEur(clubBudgetEur)}\n` +
    `❌ Yetmayotgan summa: ${formatEur(missing)}\n\n` +
    `Transfer budjetingizni oshirish uchun quyidagi tugmani bosing:`
  );
}

export function formatSuccessfulLegendPurchaseMessage(
  legendName: string,
  clubName: string,
  priceEur: number,
  remainingBudgetEur: number,
): string {
  return (
    `✅ Legenda muvaffaqiyatli sotib olindi!\n\n` +
    `⚽ Futbolchi: ${legendName}\n` +
    `🏟 Klub: ${clubName}\n` +
    `💶 Xarid narxi: ${formatEur(priceEur)}\n` +
    `🏦 Qolgan transfer budjeti: ${formatEur(remainingBudgetEur)}`
  );
}

export function formatDailyRoundLimitMessage(
  nextAvailableTimeStr = '00:00 (Toshkent vaqti)',
): string {
  return (
    `⚠️ Kunlik tur limiti tugadi.\n\n` +
    `Bir kalendar kunida ko‘pi bilan 3 ta o‘yin turi o‘tkazilishi mumkin.\n` +
    `Keyingi tur ${nextAvailableTimeStr} dan so‘ng mavjud bo‘ladi.`
  );
}
