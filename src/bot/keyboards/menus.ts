import type { InlineKeyboardButton } from 'grammy/types';
import { TransferBudgetPackage } from '../../config/packages.js';
import { formatEur, formatUzs } from '../../utils/formatters.js';
import { LegendSeed } from '../../data/legend-types.js';

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

export function buildSoloLeagueDeleteStep1Keyboard(
  leagueId: string,
): InlineKeyboardButton[][] {
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

export function buildSoloLeagueDeleteStep2Keyboard(
  leagueId: string,
): InlineKeyboardButton[][] {
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

export function buildAdminOrderActionKeyboard(
  requestId: string,
): InlineKeyboardButton[][] {
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

export function buildLegendMarketKeyboard(
  legends: LegendSeed[],
  positionFilter: string,
  page: number,
  totalPages: number,
  leagueId: string,
): InlineKeyboardButton[][] {
  const keyboard: InlineKeyboardButton[][] = [];

  // Position filter row
  keyboard.push([
    {
      text: positionFilter === 'ALL' ? '● Barchasi' : 'Barchasi',
      callback_data: `leg_list:${leagueId}:ALL:1`,
    },
    {
      text: positionFilter === 'GK' ? '● GK' : 'GK',
      callback_data: `leg_list:${leagueId}:GK:1`,
    },
    {
      text: positionFilter === 'DEF' ? '● DEF' : 'DEF',
      callback_data: `leg_list:${leagueId}:DEF:1`,
    },
    {
      text: positionFilter === 'MID' ? '● MID' : 'MID',
      callback_data: `leg_list:${leagueId}:MID:1`,
    },
    {
      text: positionFilter === 'FWD' ? '● FWD' : 'FWD',
      callback_data: `leg_list:${leagueId}:FWD:1`,
    },
  ]);

  // Legend item buttons
  for (const leg of legends) {
    keyboard.push([
      {
        text: `⭐ ${leg.fullName} (${leg.primaryPosition}) — ${formatEur(leg.legendTransferPriceEur)}`,
        callback_data: `leg_det:${leagueId}:${leg.legendId}`,
      },
    ]);
  }

  // Pagination row
  const pageRow: InlineKeyboardButton[] = [];
  if (page > 1) {
    pageRow.push({
      text: '⬅️ Oldingi',
      callback_data: `leg_list:${leagueId}:${positionFilter}:${page - 1}`,
    });
  }
  pageRow.push({ text: `${page} / ${totalPages || 1}`, callback_data: 'noop' });
  if (page < totalPages) {
    pageRow.push({
      text: '➡️ Keyingi',
      callback_data: `leg_list:${leagueId}:${positionFilter}:${page + 1}`,
    });
  }
  keyboard.push(pageRow);

  // Back button
  keyboard.push([
    { text: '⬅️ Orqaga', callback_data: `league_menu:${leagueId}` },
  ]);

  return keyboard;
}

export function buildLegendDetailKeyboard(
  legendId: string,
  leagueId: string,
  canAfford: boolean,
): InlineKeyboardButton[][] {
  const actionRow: InlineKeyboardButton[] = [];

  if (canAfford) {
    actionRow.push({
      text: '✅ Sotib olish',
      callback_data: `leg_buy:${leagueId}:${legendId}`,
    });
  } else {
    actionRow.push({
      text: '💰 Transfer budjetini oshirish',
      callback_data: `buy_pkg_list:${leagueId}`,
    });
  }

  return [
    actionRow,
    [
      {
        text: '⬅️ Legendalar ro‘yxatiga qaytish',
        callback_data: `leg_list:${leagueId}:ALL:1`,
      },
    ],
  ];
}
