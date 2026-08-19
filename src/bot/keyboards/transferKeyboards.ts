import { InlineKeyboardButton } from 'grammy/types';
import { TransferListing } from '../../services/transferService.js';

export function buildTransferMainMenuKeyboard(
  leagueId: string,
): InlineKeyboardButton[][] {
  return [
    [
      {
        text: '🛒 Futbolchi sotib olish',
        callback_data: `tr_buy_list:${leagueId}:ALL:1`,
      },
    ],
    [
      {
        text: '🏷 Futbolchi sotuvga qo‘yish',
        callback_data: `tr_sell_select:${leagueId}:1`,
      },
    ],
    [
      {
        text: '📋 Mening e’lonlarim',
        callback_data: `tr_my_listings:${leagueId}`,
      },
    ],
    [
      {
        text: '📜 Transferlar tarixi',
        callback_data: `tr_history:${leagueId}:ALL:1`,
      },
    ],
    [
      {
        text: '💰 Transfer budjeti',
        callback_data: `buy_pkg_list:${leagueId}`,
      },
    ],
    [{ text: '🏠 Bosh menyu', callback_data: 'main_menu' }],
  ];
}

export function buildTransferBrowseKeyboard(
  listings: TransferListing[],
  currentFilter: string,
  page: number,
  totalPages: number,
  leagueId: string,
): InlineKeyboardButton[][] {
  const keyboard: InlineKeyboardButton[][] = [];

  // 1. Filter Row
  const filters = [
    { label: 'Barchasi', code: 'ALL' },
    { label: 'GK', code: 'GK' },
    { label: 'DEF', code: 'DEF' },
    { label: 'MID', code: 'MID' },
    { label: 'FWD', code: 'FWD' },
    { label: 'Hamyonbop', code: 'AFFORDABLE' },
  ];

  const filterButtons: InlineKeyboardButton[] = filters.map((f) => {
    const active = currentFilter === f.code;
    return {
      text: active ? `▶️ ${f.label}` : f.label,
      callback_data: `tr_buy_list:${leagueId}:${f.code}:1`,
    };
  });

  // Split filter buttons into 2 rows of 3
  keyboard.push(filterButtons.slice(0, 3));
  keyboard.push(filterButtons.slice(3, 6));

  // 2. Listing Buttons
  listings.forEach((listing) => {
    const priceMln = (listing.askingPriceEur / 1_000_000).toFixed(1);
    keyboard.push([
      {
        text: `👤 ${listing.playerNameSnapshot} (${listing.positionCode} ${listing.overallRating}) - €${priceMln}M`,
        callback_data: `tr_buy_det:${leagueId}:${listing.id}`,
      },
    ]);
  });

  // 3. Pagination Row
  const navButtons: InlineKeyboardButton[] = [];
  if (page > 1) {
    navButtons.push({
      text: '⬅️ Oldingi',
      callback_data: `tr_buy_list:${leagueId}:${currentFilter}:${page - 1}`,
    });
  }

  navButtons.push({
    text: `📄 ${page}/${totalPages}`,
    callback_data: `tr_buy_list:${leagueId}:${currentFilter}:${page}`,
  });

  if (page < totalPages) {
    navButtons.push({
      text: '➡️ Keyingi',
      callback_data: `tr_buy_list:${leagueId}:${currentFilter}:${page + 1}`,
    });
  }

  keyboard.push(navButtons);

  // 4. Budget & Back Row
  keyboard.push([
    {
      text: '💰 Budjetni oshirish',
      callback_data: `buy_pkg_list:${leagueId}`,
    },
    { text: '🔙 Orqaga', callback_data: `tr_menu:${leagueId}` },
  ]);

  return keyboard;
}

export function buildListingDetailKeyboard(
  listingId: string,
  leagueId: string,
  canAfford: boolean,
  isOwnListing: boolean,
): InlineKeyboardButton[][] {
  const keyboard: InlineKeyboardButton[][] = [];

  if (isOwnListing) {
    keyboard.push([
      {
        text: '❌ E’lonni bekor qilish',
        callback_data: `tr_cancel:${leagueId}:${listingId}`,
      },
    ]);
  } else if (canAfford) {
    keyboard.push([
      {
        text: '✅ Sotib olish',
        callback_data: `tr_buy_confirm:${leagueId}:${listingId}`,
      },
    ]);
  } else {
    keyboard.push([
      {
        text: '💰 Budjetni oshirish',
        callback_data: `buy_pkg_list:${leagueId}`,
      },
    ]);
  }

  keyboard.push([
    {
      text: '⬅️ Bozorga qaytish',
      callback_data: `tr_buy_list:${leagueId}:ALL:1`,
    },
  ]);

  return keyboard;
}

export function buildListingConfirmKeyboard(
  listingId: string,
  leagueId: string,
): InlineKeyboardButton[][] {
  return [
    [
      {
        text: '✅ Ha, sotib olaman',
        callback_data: `tr_buy_exec:${leagueId}:${listingId}`,
      },
    ],
    [
      {
        text: '❌ Bekor qilish',
        callback_data: `tr_buy_det:${leagueId}:${listingId}`,
      },
    ],
  ];
}

export function buildMyListingsKeyboard(
  listings: TransferListing[],
  leagueId: string,
): InlineKeyboardButton[][] {
  const keyboard: InlineKeyboardButton[][] = [];

  listings.forEach((listing) => {
    const priceMln = (listing.askingPriceEur / 1_000_000).toFixed(1);
    keyboard.push([
      {
        text: `❌ ${listing.playerNameSnapshot} (€${priceMln}M) - Bekor qilish`,
        callback_data: `tr_cancel:${leagueId}:${listing.id}`,
      },
    ]);
  });

  keyboard.push([
    {
      text: '🏷 Yangi e’lon qo‘shish',
      callback_data: `tr_sell_select:${leagueId}:1`,
    },
  ]);

  keyboard.push([{ text: '🔙 Orqaga', callback_data: `tr_menu:${leagueId}` }]);

  return keyboard;
}

export function buildTransferHistoryKeyboard(
  filter: string,
  page: number,
  totalPages: number,
  leagueId: string,
): InlineKeyboardButton[][] {
  const keyboard: InlineKeyboardButton[][] = [];

  const filters = [
    { label: 'Barchasi', code: 'ALL' },
    { label: 'Mening klubim', code: 'MY_CLUB' },
    { label: 'Xaridlar', code: 'PURCHASES' },
    { label: 'Sotuvlar', code: 'SALES' },
  ];

  const filterRow: InlineKeyboardButton[] = filters.map((f) => {
    const active = filter === f.code;
    return {
      text: active ? `▶️ ${f.label}` : f.label,
      callback_data: `tr_history:${leagueId}:${f.code}:1`,
    };
  });

  keyboard.push(filterRow.slice(0, 2));
  keyboard.push(filterRow.slice(2, 4));

  // Pagination Row
  const navButtons: InlineKeyboardButton[] = [];
  if (page > 1) {
    navButtons.push({
      text: '⬅️ Oldingi',
      callback_data: `tr_history:${leagueId}:${filter}:${page - 1}`,
    });
  }

  navButtons.push({
    text: `📄 ${page}/${totalPages}`,
    callback_data: `tr_history:${leagueId}:${filter}:${page}`,
  });

  if (page < totalPages) {
    navButtons.push({
      text: '➡️ Keyingi',
      callback_data: `tr_history:${leagueId}:${filter}:${page + 1}`,
    });
  }

  keyboard.push(navButtons);

  // Cancelled view button
  keyboard.push([
    {
      text: '🗑 Bekor qilinganlar',
      callback_data: `tr_cancelled:${leagueId}:1`,
    },
  ]);

  keyboard.push([{ text: '🔙 Orqaga', callback_data: `tr_menu:${leagueId}` }]);

  return keyboard;
}
