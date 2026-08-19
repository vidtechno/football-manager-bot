import fs from 'node:fs';
import path from 'node:path';
import { LegendSeed } from '../../data/legend-types.js';
import {
  formatEur,
  formatInsufficientBudgetMessage,
  formatSuccessfulLegendPurchaseMessage,
} from '../../utils/formatters.js';
import { buildEmptyLegendsMarketMessage } from '../messages/templates.js';
import {
  buildLegendMarketKeyboard,
  buildLegendDetailKeyboard,
} from '../keyboards/menus.js';

let cachedLegends: LegendSeed[] | null = null;

export function loadLegends(): LegendSeed[] {
  if (cachedLegends) return cachedLegends;

  const filePath = path.resolve(
    process.cwd(),
    'data/football/legends/legends.json',
  );
  if (!fs.existsSync(filePath)) return [];

  try {
    const raw = fs.readFileSync(filePath, 'utf-8');
    cachedLegends = JSON.parse(raw);
    return cachedLegends || [];
  } catch {
    return [];
  }
}

export function handleLegendMarketList(
  leagueId: string,
  positionFilter: string = 'ALL',
  page: number = 1,
  pageSize: number = 5,
  currentBudgetEur: number = 100_000_000,
) {
  const allLegends = loadLegends();
  if (allLegends.length === 0) {
    return { text: buildEmptyLegendsMarketMessage(), keyboard: [] };
  }

  // Filter legends
  let filtered = allLegends;
  if (positionFilter === 'GK') {
    filtered = allLegends.filter((l) => l.primaryPosition === 'GK');
  } else if (positionFilter === 'DEF') {
    filtered = allLegends.filter((l) =>
      ['CB', 'LB', 'RB', 'LWB', 'RWB'].includes(l.primaryPosition),
    );
  } else if (positionFilter === 'MID') {
    filtered = allLegends.filter((l) =>
      ['CDM', 'CM', 'CAM', 'LM', 'RM'].includes(l.primaryPosition),
    );
  } else if (positionFilter === 'FWD') {
    filtered = allLegends.filter((l) =>
      ['LW', 'RW', 'CF', 'ST'].includes(l.primaryPosition),
    );
  }

  const totalPages = Math.ceil(filtered.length / pageSize) || 1;
  const safePage = Math.max(1, Math.min(page, totalPages));
  const startIndex = (safePage - 1) * pageSize;
  const pageLegends = filtered.slice(startIndex, startIndex + pageSize);

  let text = `⭐ *Afsonalar Bozori (Legend Transfers)*\n\n`;
  text += `🏦 *Klubingiz transfer budjeti:* ${formatEur(currentBudgetEur)}\n`;
  text += `🔍 *Saralash:* ${positionFilter}\n\n`;
  text += `Sotib olmoqchi bo‘lgan afsonaviy futbolchini tanlang:`;

  const keyboard = buildLegendMarketKeyboard(
    pageLegends,
    pageLegends.map((legend) =>
      allLegends.findIndex((entry) => entry.legendId === legend.legendId),
    ),
    positionFilter,
    safePage,
    totalPages,
    leagueId,
  );

  return { text, keyboard };
}

export function handleLegendDetails(
  leagueId: string,
  legendId: string,
  currentBudgetEur: number,
) {
  const allLegends = loadLegends();
  const legend = allLegends.find((l) => l.legendId === legendId);

  if (!legend) {
    throw new Error('LEGEND_NOT_FOUND');
  }

  const canAfford = currentBudgetEur >= legend.legendTransferPriceEur;

  let text = `⭐ *Afsona Tafsilotlari*\n\n`;
  text += `👤 *Ismi:* ${legend.fullName}\n`;
  text += `⭐ *OVR Baholash:* ${legend.peakOverallRating}\n`;
  text += `📍 *Pozitsiyasi:* ${legend.primaryPosition} ${legend.secondaryPositions.length ? `(${legend.secondaryPositions.join(', ')})` : ''}\n`;
  text += `🏟 *Eng gullagan davri:* ${legend.peakPeriod} (${legend.peakClub})\n`;
  text += `🇺🇿 *Fuqaroligi:* ${legend.nationality}\n\n`;

  if (legend.primaryPosition === 'GK' && legend.goalkeeperAttributes) {
    const g = legend.goalkeeperAttributes;
    text += `🧤 *Darvozabon atributlari:*\n`;
    text += `• Refleks: ${g.reflexes} | Ushlash: ${g.handling}\n`;
    text += `• Pozitsiya: ${g.positioning} | Havoda: ${g.aerialAbility}\n`;
    text += `• Tarqatish: ${g.distribution} | 1-ga-1: ${g.oneOnOne}\n\n`;
  } else if (legend.outfieldAttributes) {
    const o = legend.outfieldAttributes;
    text += `⚽ *Maydon atributlari:*\n`;
    text += `• Tezlik: ${o.pace} | Zarba: ${o.shooting}\n`;
    text += `• Uzatma: ${o.passing} | Dribling: ${o.dribbling}\n`;
    text += `• Himoya: ${o.defending} | Jismoniy: ${o.physical}\n\n`;
  }

  text += `💶 *Xarid narxi:* ${formatEur(legend.legendTransferPriceEur)}\n`;
  text += `🏦 *Klubingiz budjeti:* ${formatEur(currentBudgetEur)}\n\n`;

  if (!canAfford) {
    text += formatInsufficientBudgetMessage(
      legend.fullName,
      legend.legendTransferPriceEur,
      currentBudgetEur,
    );
  }

  const legendIndex = allLegends.findIndex(
    (entry) => entry.legendId === legendId,
  );
  const keyboard = buildLegendDetailKeyboard(legendIndex, leagueId, canAfford);

  return { text, keyboard };
}

export function handleLegendPurchaseSuccess(
  legendName: string,
  clubName: string,
  priceEur: number,
  remainingBudgetEur: number,
  leagueId: string,
) {
  const text = formatSuccessfulLegendPurchaseMessage(
    legendName,
    clubName,
    priceEur,
    remainingBudgetEur,
  );
  const keyboard = [
    [
      {
        text: '⭐ Afsonalar bozoriga qaytish',
        callback_data: `leg_list:${leagueId}:ALL:1`,
      },
    ],
    [{ text: '🏠 Bosh menyu', callback_data: 'main_menu' }],
  ];

  return { text, keyboard };
}
