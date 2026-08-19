import { formatEur, formatUzs } from '../../utils/formatters.js';
import { buildAdminPendingOrdersListMessage } from '../messages/templates.js';
import {
  buildAdminPendingOrdersKeyboard,
  buildAdminOrderActionKeyboard,
} from '../keyboards/menus.js';

export interface AdminPendingOrderView {
  id: string;
  orderCode: string;
  leagueName: string;
  clubName: string;
  packageDisplay: string;
  eurAmount: number;
  uzsPrice: number;
  telegramUsername?: string | undefined;
  telegramUserId: number;
  createdAt: string;
}

export function handleAdminPendingOrdersList(
  requests: AdminPendingOrderView[],
) {
  const text = buildAdminPendingOrdersListMessage(requests);
  const keyboard = buildAdminPendingOrdersKeyboard(requests);
  return { text, keyboard };
}

export function handleAdminOrderDetails(req: AdminPendingOrderView) {
  const userDisplay = req.telegramUsername
    ? `@${req.telegramUsername}`
    : `ID: ${req.telegramUserId}`;
  const text =
    `💳 *Buyurtma Tafsilotlari*\n\n` +
    `🔑 *Buyurtma kodi:* \`${req.orderCode}\`\n` +
    `👤 *Foydalanuvchi:* ${userDisplay} (\`${req.telegramUserId}\`)\n` +
    `🏆 *Liga:* ${req.leagueName}\n` +
    `🏟 *Klub:* ${req.clubName}\n` +
    `📦 *Paket:* ${req.packageDisplay}\n` +
    `💶 *Qo‘shiladigan budjet:* ${formatEur(req.eurAmount)}\n` +
    `💵 *Kutilayotgan to‘lov:* ${formatUzs(req.uzsPrice)}\n` +
    `📅 *Yaratilgan vaqti:* ${req.createdAt}\n\n` +
    `To‘lovni tekshirib, quyidagi tugmalar orqali tasdiqlang yoki rad eting.`;

  const keyboard = buildAdminOrderActionKeyboard(req.id);
  return { text, keyboard };
}
