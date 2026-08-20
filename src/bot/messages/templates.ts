import {
  formatEur,
  formatUzs,
  buildAdminPaymentDeepLink,
} from '../../utils/formatters.js';
import {
  TransferBudgetPackage,
  BUDGET_PURCHASE_WARNING_TEXT,
  SOLO_LEAGUE_DELETE_WARNING_TEXT,
} from '../../config/packages.js';

export function buildPackageListMessage(
  leagueName: string,
  clubName: string,
  currentBudgetEur: number,
  packages: TransferBudgetPackage[],
): string {
  let text = `💰 *Transfer Budjetini Oshirish*\n\n`;
  text += `🏆 *Liga:* ${leagueName}\n`;
  text += `🏟 *Klub:* ${clubName}\n`;
  text += `🏦 *Joriy transfer budjeti:* ${formatEur(currentBudgetEur)}\n\n`;
  text += `*Mavjud paketlar:*\n`;

  for (const pkg of packages) {
    text += `• *${pkg.displayName}* — ${formatUzs(pkg.uzsPrice)}\n`;
  }

  text += `\n${BUDGET_PURCHASE_WARNING_TEXT}`;
  return text;
}

export function buildOrderConfirmationMessage(params: {
  leagueName: string;
  clubName: string;
  packageDisplay: string;
  eurAmount: number;
  uzsPrice: number;
  orderCode: string;
  adminUsername?: string | undefined;
}): { text: string; deepLink: string } {
  const deepLink = buildAdminPaymentDeepLink({
    adminUsername: params.adminUsername,
    eurDisplay: params.packageDisplay,
    leagueName: params.leagueName,
    clubName: params.clubName,
    orderCode: params.orderCode,
  });

  const text =
    `📋 *Buyurtma Shakllantirildi*\n\n` +
    `🔑 *Buyurtma kodi:* \`${params.orderCode}\`\n` +
    `🏆 *Liga:* ${params.leagueName}\n` +
    `🏟 *Klub:* ${params.clubName}\n` +
    `📦 *Paket:* ${params.packageDisplay}\n` +
    `💶 *Qo‘shiladigan budjet:* ${formatEur(params.eurAmount)}\n` +
    `💵 *To‘lov summasi:* ${formatUzs(params.uzsPrice)}\n` +
    `⏳ *Holat:* ⏳ Kutilmoqda\n\n` +
    `To‘lovni amalga oshirish uchun quyidagi *💬 Admin bilan bog‘lanish* tugmasini bosing va xabarni adminga yuboring.\n\n` +
    `${BUDGET_PURCHASE_WARNING_TEXT}`;

  return { text, deepLink };
}

export function buildOrderStatusViewMessage(
  orders: Array<{
    orderCode: string;
    leagueName: string;
    clubName: string;
    packageDisplay: string;
    uzsPrice: number;
    status: 'PENDING' | 'APPROVED' | 'REJECTED' | 'EXPIRED' | 'CANCELLED';
    createdAt: string;
  }>,
): string {
  if (orders.length === 0) {
    return `📋 Sizda hali hech qanday transfer budjeti buyurtmalari mavjud emas.`;
  }

  const statusMap = {
    PENDING: '⏳ Kutilmoqda',
    APPROVED: '✅ Tasdiqlandi',
    REJECTED: '❌ Rad etildi',
    EXPIRED: '⏰ Muddati o‘tdi',
    CANCELLED: '🚫 Bekor qilindi',
  };

  let text = `📋 *Sizning Buyurtmalaringiz Tarixi*\n\n`;
  for (const o of orders) {
    text += `🔑 *Kodu:* \`${o.orderCode}\` | ${statusMap[o.status]}\n`;
    text += `🏆 ${o.leagueName} — ${o.clubName}\n`;
    text += `📦 ${o.packageDisplay} (${formatUzs(o.uzsPrice)})\n\n`;
  }
  return text.trim();
}

export function buildEmptyLegendsMarketMessage(): string {
  return (
    `ℹ️ *Legendalar Bozori*\n\n` +
    `Legendalar bozori hozircha tayyorlanmoqda.\n` +
    `Tez orada tarixdagi eng kuchli afsonaviy futbolchilar liganing muxtor afsonalar bozoriga qo‘shiladi!`
  );
}

export function buildSoloLeagueDeleteConfirmation1Message(
  leagueName: string,
): string {
  return (
    `🗑 *Ligani Butunlay O‘chirish*\n\n` +
    `🏆 *Liga:* ${leagueName}\n\n` +
    `${SOLO_LEAGUE_DELETE_WARNING_TEXT}\n\n` +
    `Ushbu ligada faqat siz (1 inson menejer) va 19 ta bot mavjud. Davom etishni xohlaysizmi?`
  );
}

export function buildSoloLeagueDeleteConfirmation2Message(
  leagueName: string,
  clubName: string,
): string {
  return (
    `⚠️ *QAT'IY TASDIQLASH*\n\n` +
    `Siz haqiqatan ham *${leagueName}* ligasini va unga bog‘langan *${clubName}* klubi ma’lumotlarini butunlay o‘chirib tashlamoqchimisiz?\n\n` +
    `Barcha o‘yinlar, jadval, va moliyaviy yozuvlar tiklab bo‘lmaydigan qilib o‘chiriladi.`
  );
}

export function buildSoloLeagueDeleteBlockedMessage(): string {
  return `❌ *Ligani o‘chirib bo‘lmaydi.*\n\nLigada sizdan tashqari boshqa haqiqiy inson menejerlar mavjud.`;
}

export function buildSoloLeagueDeleteSuccessMessage(
  leagueName: string,
): string {
  return `✅ *Liga muvaffaqiyatli o‘chirildi.*\n\n*${leagueName}* va unga tegishli barcha o‘yin ma’lumotlari butunlay tozalandi.`;
}

export function buildAdminPendingOrdersListMessage(
  requests: Array<{
    id: string;
    orderCode: string;
    leagueName: string;
    clubName: string;
    packageDisplay: string;
    uzsPrice: number;
    telegramUsername?: string | undefined;
    telegramUserId: number;
  }>,
): string {
  if (requests.length === 0) {
    return `💳 *Transfer Budjeti Buyurtmalari*\n\nHozircha kutilayotgan (PENDING) buyurtmalar mavjud emas.`;
  }

  let text = `💳 *Kutilayotgan Buyurtmalar Ro‘yxati (${requests.length})*\n\n`;
  for (const r of requests) {
    const userDisplay = r.telegramUsername
      ? `@${r.telegramUsername}`
      : `ID: ${r.telegramUserId}`;
    text += `🔑 \`${r.orderCode}\` | ${userDisplay}\n`;
    text += `🏆 ${r.leagueName} (${r.clubName})\n`;
    text += `💶 ${r.packageDisplay} — ${formatUzs(r.uzsPrice)}\n\n`;
  }
  return text.trim();
}

export function formatDailyRoundLimitMessage(
  nextAvailableTimeStr = '00:00',
): string {
  return (
    `⚠️ *Kunlik tur limiti tugadi.*\n\n` +
    `Ushbu ligada kunlik 3 ta o‘yin turi o‘tkazib bo‘lindi.\n` +
    `Keyingi tur ertaga soat ${nextAvailableTimeStr} dan keyin mavjud bo‘ladi (Toshkent vaqti).`
  );
}
