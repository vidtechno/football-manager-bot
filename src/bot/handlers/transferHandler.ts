import { formatEur } from '../../utils/formatters.js';
import {
  TransferService,
  TransferListing,
} from '../../services/transferService.js';
import {
  buildTransferMainMenuKeyboard,
  buildTransferBrowseKeyboard,
  buildListingDetailKeyboard,
  buildListingConfirmKeyboard,
  buildMyListingsKeyboard,
  buildTransferHistoryKeyboard,
} from '../keyboards/transferKeyboards.js';

export function handleTransferMainMenu(
  leagueId: string,
  currentBudgetEur: number,
  activeCount: number = 0,
) {
  let text = `🔄 *Futbolchilar Transfer Bozori*\n\n`;
  text += `🏦 *Klubingiz transfer budjeti:* ${formatEur(currentBudgetEur)}\n`;
  text += `📋 *Faol e’lonlaringiz:* ${activeCount}/4\n\n`;
  text += `Quyidagi menyu orqali futbolchilarni sotib olishingiz, o‘z futbolchilaringizni sotuvga qo‘yishingiz yoki transferlar tarixini ko‘rishingiz mumkin.`;

  const keyboard = buildTransferMainMenuKeyboard(leagueId);
  return { text, keyboard };
}

export async function handleTransferBrowseList(
  leagueId: string,
  filter: string = 'ALL',
  page: number = 1,
  currentBudgetEur: number = 100_000_000,
) {
  const maxPrice = filter === 'AFFORDABLE' ? currentBudgetEur : undefined;
  const posFilter = filter === 'AFFORDABLE' ? 'ALL' : filter;

  const {
    listings,
    totalPages,
    page: safePage,
  } = await TransferService.getActiveListings(leagueId, {
    position: posFilter,
    ...(maxPrice !== undefined ? { maxPrice } : {}),
    page,
    pageSize: 5,
  });

  let text = `🛒 *Futbolchilar Bozori*\n\n`;
  text += `🏦 *Klubingiz budjeti:* ${formatEur(currentBudgetEur)}\n`;
  text += `🔍 *Filtr:* ${filter}\n\n`;

  if (listings.length === 0) {
    text += `⚠️ Hozirda ushbu parametrlar bo‘yicha sotuvda futbolchilar mavjud emas.`;
  } else {
    text += `Sotib olmoqchi bo‘lgan futbolchingizni tanlang:`;
  }

  const keyboard = buildTransferBrowseKeyboard(
    listings,
    filter,
    safePage,
    totalPages,
    leagueId,
  );

  return { text, keyboard };
}

export function handleListingDetailView(
  listing: TransferListing,
  currentBudgetEur: number,
  currentClubId: string,
) {
  const isOwnListing = listing.sellerClubId === currentClubId;
  const canAfford = currentBudgetEur >= listing.askingPriceEur;

  const priceMln = (listing.askingPriceEur / 1_000_000).toFixed(1);
  const origMln = (listing.originalMarketValueEur / 1_000_000).toFixed(1);
  const diffEur = listing.askingPriceEur - listing.originalMarketValueEur;
  const diffMln = (diffEur / 1_000_000).toFixed(1);
  const diffPercent = (
    (diffEur / (listing.originalMarketValueEur || 1)) *
    100
  ).toFixed(0);

  let text = `👤 *Futbolchi Transfer Tafsilotlari*\n\n`;
  text += `⚽ *Ismi:* ${listing.playerNameSnapshot}\n`;
  text += `🏟 *Klubi:* ${listing.sellerClubName || 'Noma‘lum'}\n`;
  text += `📍 *Pozitsiyasi:* ${listing.positionCode}\n`;
  text += `⭐ *OVR Baholash:* ${listing.overallRating}\n`;
  text += `📊 *Asl bozor qiymati:* €${origMln}M\n\n`;
  text += `💶 *Sotuv narxi:* €${priceMln}M (${diffEur >= 0 ? `+€${diffMln}M / +${diffPercent}%` : `-€${Math.abs(Number(diffMln))}M / ${diffPercent}%`})\n`;
  text += `🏦 *Klubingiz budjeti:* ${formatEur(currentBudgetEur)}\n\n`;

  if (isOwnListing) {
    text += `ℹ️ *Bu sizning e’loningiz.* O‘z futbolchingizni sotib ola olmaysiz.`;
  } else if (!canAfford) {
    text += `⚠️ *Mablag‘ yetarli emas!* Futbolchini sotib olish uchun budjetingiz yetmaydi. Budjetni oshirish menyusidan foydalanishingiz mumkin.`;
  }

  const keyboard = buildListingDetailKeyboard(
    listing.id,
    listing.leagueId,
    canAfford,
    isOwnListing,
  );

  return { text, keyboard };
}

export function handleListingConfirmView(
  listing: TransferListing,
  leagueId: string,
) {
  const priceMln = (listing.askingPriceEur / 1_000_000).toFixed(1);
  let text = `❓ *Xaridni Tasdiqlaysizmi?*\n\n`;
  text += `Ushbu futbolchini **€${priceMln} mln** evaziga sotib olishni tasdiqlaysizmi?\n\n`;
  text += `• Futbolchi: ${listing.playerNameSnapshot} (${listing.positionCode} ${listing.overallRating})\n`;
  text += `• Klubi: ${listing.sellerClubName || 'Noma‘lum'}`;

  const keyboard = buildListingConfirmKeyboard(listing.id, leagueId);
  return { text, keyboard };
}

export async function handleMyListingsView(leagueId: string, clubId: string) {
  const listings = await TransferService.getClubActiveListings(clubId);

  let text = `📋 *Mening E’lonlarim*\n\n`;
  text += `Sizda jami **${listings.length}/4** ta faol e’lon mavjud.\n\n`;

  if (listings.length === 0) {
    text += `Siz hali hech qanday futbolchini sotuvga qo‘ymadingiz.`;
  } else {
    listings.forEach((l, idx) => {
      const priceMln = (l.askingPriceEur / 1_000_000).toFixed(1);
      const origMln = (l.originalMarketValueEur / 1_000_000).toFixed(1);
      text += `${idx + 1}. *${l.playerNameSnapshot}* (${l.positionCode} ${l.overallRating})\n`;
      text += `   💶 Narxi: €${priceMln}M | Asl qiymati: €${origMln}M\n\n`;
    });
  }

  text += `\nℹ️ *Eslatma:* E’lon 24 soatdan keyin bot klublar tomonidan ham ko‘rib chiqilishi mumkin. Bot xaridi kafolatlanmaydi. Narx futbolchining asl qiymatidan 20% dan yuqori bo‘lsa, bot klublar uni sotib olmaydi.`;

  const keyboard = buildMyListingsKeyboard(listings, leagueId);
  return { text, keyboard };
}

export async function handleTransferHistoryView(
  leagueId: string,
  clubId: string,
  filter: string = 'ALL',
  page: number = 1,
) {
  const {
    listings,
    totalPages,
    page: safePage,
  } = await TransferService.getTransferHistory(leagueId, {
    clubId,
    filter: filter as 'ALL' | 'MY_CLUB' | 'PURCHASES' | 'SALES',
    page,
    pageSize: 5,
  });

  let text = `📜 *Transferlar Tarixi*\n\n`;
  text += `🔍 *Filtr:* ${filter}\n\n`;

  if (listings.length === 0) {
    text += `⚠️ Hozircha amalga oshirilgan transferlar mavjud emas.`;
  } else {
    listings.forEach((l, idx) => {
      const priceMln = (l.askingPriceEur / 1_000_000).toFixed(1);
      const buyerIcon = l.buyerType === 'BOT' ? '🤖 Bot' : '👤 Human';
      const dateStr = l.completedAt
        ? new Date(l.completedAt).toLocaleString('uz-UZ', {
            timeZone: 'Asia/Tashkent',
          })
        : 'Noma‘lum';

      text += `${idx + 1}. *${l.playerNameSnapshot}* (${l.positionCode} ${l.overallRating})\n`;
      text += `   🔴 Sotuvchi: ${l.sellerClubName}\n`;
      text += `   🟢 Xaridor: ${l.buyerClubName} (${buyerIcon})\n`;
      text += `   💶 Narxi: €${priceMln}M | 📅 ${dateStr}\n\n`;
    });
  }

  const keyboard = buildTransferHistoryKeyboard(
    filter,
    safePage,
    totalPages,
    leagueId,
  );

  return { text, keyboard };
}
