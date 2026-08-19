import type { InlineKeyboardButton } from 'grammy/types';
import { TransferBudgetPackage } from '../../config/packages.js';
import { formatUzs } from '../../utils/formatters.js';

export function buildPackageSelectionKeyboard(
  packages: TransferBudgetPackage[],
  leagueId: string,
): InlineKeyboardButton[][] {
  const keyboard: InlineKeyboardButton[][] = [];

  for (const pkg of packages) {
    keyboard.push([
      {
        text: `💰 ${pkg.displayName} — ${formatUzs(pkg.uzsPrice)}`,
        callback_data: `buy_pkg:${pkg.id}:${leagueId}`,
      },
    ]);
  }

  keyboard.push([
    {
      text: '📋 Buyurtmalarim holati',
      callback_data: `my_orders:${leagueId}`,
    },
  ]);

  keyboard.push([
    {
      text: '⬅️ Orqaga',
      callback_data: `league_menu:${leagueId}`,
    },
  ]);

  return keyboard;
}

export function buildOrderConfirmationKeyboard(
  deepLinkUrl: string,
  leagueId: string,
): InlineKeyboardButton[][] {
  return [
    [
      {
        text: '💬 Admin bilan bog‘lanish',
        url: deepLinkUrl,
      },
    ],
    [
      {
        text: '📋 Buyurtma holati',
        callback_data: `my_orders:${leagueId}`,
      },
      {
        text: '⬅️ Orqaga',
        callback_data: `league_menu:${leagueId}`,
      },
    ],
  ];
}

export function buildSoloLeagueDeleteStep1Keyboard(leagueId: string): InlineKeyboardButton[][] {
  return [
    [
      {
        text: '❌ Bekor qilish',
        callback_data: `league_settings:${leagueId}`,
      },
      {
        text: 'Davom etish ➡️',
        callback_data: `del_solo_confirm:${leagueId}`,
      },
    ],
  ];
}

export function buildSoloLeagueDeleteStep2Keyboard(leagueId: string): InlineKeyboardButton[][] {
  return [
    [
      {
        text: '❌ Bekor qilish',
        callback_data: `league_settings:${leagueId}`,
      },
      {
        text: '🗑 Ha, ligani o‘chirish',
        callback_data: `del_solo_execute:${leagueId}`,
      },
    ],
  ];
}

export function buildAdminPendingOrdersKeyboard(
  requests: Array<{ id: string; orderCode: string }>,
): InlineKeyboardButton[][] {
  const keyboard: InlineKeyboardButton[][] = [];

  for (const req of requests) {
    keyboard.push([
      {
        text: `🔍 Buyurtma: ${req.orderCode}`,
        callback_data: `adm_view_req:${req.id}`,
      },
    ]);
  }

  keyboard.push([
    {
      text: '⬅️ Admin menyusiga qaytish',
      callback_data: 'admin_main',
    },
  ]);

  return keyboard;
}

export function buildAdminOrderActionKeyboard(requestId: string): InlineKeyboardButton[][] {
  return [
    [
      {
        text: '✅ Tasdiqlash',
        callback_data: `adm_app_req:${requestId}`,
      },
      {
        text: '❌ Rad etish',
        callback_data: `adm_rej_req:${requestId}`,
      },
    ],
    [
      {
        text: '⬅️ Orqaga',
        callback_data: 'adm_pending_orders',
      },
    ],
  ];
}
