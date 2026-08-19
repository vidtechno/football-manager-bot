import { Bot, Context } from 'grammy';
import type { InlineKeyboardButton } from 'grammy/types';
import {
  handlePackageView,
  handlePackageSelect,
} from './handlers/packageHandler.js';
import {
  handleAdminPendingOrdersList,
  handleAdminOrderDetails,
} from './handlers/adminHandler.js';
import {
  handleSoloLeagueDeleteStep1,
  handleSoloLeagueDeleteStep2,
  handleSoloLeagueDeleteSuccess,
  handleDailyRoundLimitReached,
} from './handlers/leagueHandler.js';
import {
  handleLegendMarketList,
  handleLegendDetails,
  handleLegendPurchaseSuccess,
} from './handlers/legendHandler.js';
import {
  handleTransferMainMenu,
  handleTransferBrowseList,
  handleListingDetailView,
  handleListingConfirmView,
  handleMyListingsView,
  handleTransferHistoryView,
} from './handlers/transferHandler.js';
import { SponsorHandler } from './handlers/sponsorHandler.js';
import { IdentityService } from '../services/identityService.js';
import { buildOrderStatusViewMessage } from './messages/templates.js';
import { PurchaseService } from '../services/purchaseService.js';
import { LeagueService } from '../services/leagueService.js';
import { TransferService } from '../services/transferService.js';
import { GameService, type LeagueSummary } from '../services/gameService.js';

type PendingInput =
  | { type: 'CREATE_LEAGUE' | 'JOIN_LEAGUE'; managerId: string }
  | { type: 'SELL_PRICE'; managerId: string; leagueId: string; playerId: string; marketValue: number };
const pendingInputs = new Map<number, PendingInput>();

function money(value: number): string {
  return `€${(value / 1_000_000).toFixed(value % 1_000_000 === 0 ? 0 : 1)} mln`;
}

async function leagueContext(ctx: Context, leagueId: string): Promise<{managerId:string; league:LeagueSummary}> {
  if (!ctx.from) throw new Error('Telegram foydalanuvchisi aniqlanmadi.');
  const manager = await IdentityService.getOrCreateManager(ctx.from.id, ctx.from.first_name);
  return { managerId: manager.id, league: await GameService.getLeague(manager.id, leagueId) };
}

function mainKeyboard(leagues: LeagueSummary[], isAdmin: boolean) {
  const rows: InlineKeyboardButton[][] = leagues.map((league) => [{
    text: `${league.status === 'LOBBY' ? '🟡' : '🟢'} ${league.name}${league.clubName ? ` — ${league.clubName}` : ''}`,
    callback_data: `league_menu:${league.id}`,
  }]);
  rows.push([{ text: '➕ Liga yaratish', callback_data: 'league_create' }, { text: '🔗 Ligaga qo‘shilish', callback_data: 'league_join' }]);
  rows.push([{ text: '📢 Homiylik', callback_data: 'sp_user_menu' }]);
  if (isAdmin) rows.push([{ text: '🛡 Admin panel', callback_data: 'admin_main' }]);
  return rows;
}

async function showMainMenu(ctx: Context, edit = false): Promise<void> {
  if (!ctx.from) return;
  const manager = await IdentityService.getOrCreateManager(ctx.from.id, ctx.from.first_name);
  const [leagues, admin] = await Promise.all([
    GameService.getManagerLeagues(manager.id), IdentityService.getAdminUser(ctx.from.id),
  ]);
  const text = `⚽ *Football Manager*\n\nMenejer: *${manager.managerName}*\nLigalar: *${leagues.length}*\n\nDavom etish uchun bo‘limni tanlang:`;
  const options = { parse_mode: 'Markdown' as const, reply_markup: { inline_keyboard: mainKeyboard(leagues, Boolean(admin)) } };
  if (edit && ctx.callbackQuery?.message) await ctx.editMessageText(text, options);
  else await ctx.reply(text, options);
}

export function registerBotRoutes(bot: Bot<Context>): void {
  // 1. Command: /start
  bot.command('start', async (ctx) => {
    pendingInputs.delete(ctx.from.id);
    await showMainMenu(ctx);
  });

  bot.on('message:text', async (ctx, next) => {
    if (ctx.message.text.startsWith('/')) return next();
    const pending = pendingInputs.get(ctx.from.id);
    if (!pending) return next();
    try {
      if (pending.type === 'CREATE_LEAGUE') {
        const name = ctx.message.text.trim();
        if (name.length < 3 || name.length > 50) throw new Error('Liga nomi 3–50 belgidan iborat bo‘lsin.');
        const league = await GameService.createLeague(pending.managerId, name);
        pendingInputs.delete(ctx.from.id);
        await ctx.reply(`✅ *${league.name}* yaratildi.\n🔑 Taklif kodi: \`${league.code}\`\n\nEndi klubingizni tanlang.`, {
          parse_mode: 'Markdown', reply_markup: { inline_keyboard: [[{ text: '⚽ Klub tanlash', callback_data: `club_list:${league.id}:1` }]] },
        });
      } else if (pending.type === 'JOIN_LEAGUE') {
        const league = await GameService.joinLeague(pending.managerId, ctx.message.text);
        pendingInputs.delete(ctx.from.id);
        await ctx.reply(`✅ *${league.name}* ligasiga qo‘shildingiz. Endi klub tanlang.`, {
          parse_mode: 'Markdown', reply_markup: { inline_keyboard: [[{ text: '⚽ Klub tanlash', callback_data: `club_list:${league.id}:1` }]] },
        });
      } else {
        const priceMln = Number(ctx.message.text.replace(',', '.').replace(/[^0-9.]/g, ''));
        const price = Math.round(priceMln * 1_000_000);
        if (!Number.isFinite(priceMln) || price <= 0) throw new Error('Narxni million yevroda raqam bilan kiriting. Masalan: 85');
        if (price > pending.marketValue * 3) throw new Error('Sotuv narxi bozor qiymatining 3 baravaridan oshmasin.');
        await TransferService.createListing(pending.playerId, price, pending.managerId);
        pendingInputs.delete(ctx.from.id);
        await ctx.reply(`✅ Futbolchi *${money(price)}* narxda transferga qo‘yildi.`, { parse_mode:'Markdown', reply_markup:{inline_keyboard:[[{text:'🔄 Transferlar',callback_data:`tr_menu:${pending.leagueId}`}]]} });
      }
    } catch (error) {
      await ctx.reply(`❌ ${error instanceof Error ? error.message : String(error)}\n\nQayta kiriting yoki /start bosing.`);
    }
  });

  // 2. Command: /admin
  bot.command('admin', async (ctx) => {
    try {
      const admin = await IdentityService.getAdminUser(ctx.from.id);
      if (!admin) { await ctx.reply('❌ Sizda admin huquqi yo‘q.'); return; }
      const orders = await PurchaseService.getPendingOrders();
      const { text, keyboard } = handleAdminPendingOrdersList(orders);
      await ctx.reply(text, {
        parse_mode: 'Markdown',
        reply_markup: { inline_keyboard: keyboard },
      });
    } catch (err: unknown) {
      const errMsg = err instanceof Error ? err.message : String(err);
      await ctx.reply(`❌ Xatolik: ${errMsg}`);
    }
  });

  // 3. Callback Queries
  bot.on('callback_query:data', async (ctx) => {
    const data = ctx.callbackQuery.data;

    try {
      if (data === 'main_menu') { await showMainMenu(ctx, true); await ctx.answerCallbackQuery(); return; }
      if (data === 'league_create' || data === 'league_join') {
        const manager = await IdentityService.getOrCreateManager(ctx.from.id, ctx.from.first_name);
        pendingInputs.set(ctx.from.id, { type: data === 'league_create' ? 'CREATE_LEAGUE' : 'JOIN_LEAGUE', managerId: manager.id });
        await ctx.editMessageText(data === 'league_create' ? '📝 Yangi liga nomini yuboring (3–50 belgi):' : '🔑 6 belgili liga taklif kodini yuboring:', {
          reply_markup: { inline_keyboard: [[{ text: '❌ Bekor qilish', callback_data: 'main_menu' }]] },
        }); await ctx.answerCallbackQuery(); return;
      }
      if (data.startsWith('league_menu:')) {
        const leagueId=data.split(':')[1]!; const manager=await IdentityService.getOrCreateManager(ctx.from.id,ctx.from.first_name);
        const league=await GameService.getLeague(manager.id,leagueId);
        const rows: InlineKeyboardButton[][] = league.clubId ? [
          [{text:'👥 Tarkib',callback_data:`squad:${leagueId}`} ,{text:'📊 Jadval',callback_data:`table:${leagueId}`}],
          [{text:'🔄 Transferlar',callback_data:`tr_menu:${leagueId}`},{text:'⭐ Legendalar',callback_data:`legend_market:${leagueId}`}],
          [{text:'💰 Budjet',callback_data:`buy_pkg_list:${leagueId}`},{text:'📢 Homiylik',callback_data:'sp_user_menu'}],
        ] : [[{text:'⚽ Klub tanlash',callback_data:`club_list:${leagueId}:1`}]];
        if(league.role==='OWNER'&&league.status==='LOBBY') rows.push([{text:'🚀 Ligani boshlash',callback_data:`league_start:${leagueId}`}]);
        if(league.role==='OWNER'&&league.status==='ACTIVE') rows.push([{text:'▶️ Keyingi tur',callback_data:`advance_round:${leagueId}`}]);
        rows.push([{text:'⬅️ Bosh menyu',callback_data:'main_menu'}]);
        await ctx.editMessageText(`🏆 *${league.name}*\n🔑 Kod: \`${league.code}\`\nHolat: *${league.status}*\nKlub: *${league.clubName ?? 'tanlanmagan'}*\nBudjet: *${money(league.budget)}*`,{parse_mode:'Markdown',reply_markup:{inline_keyboard:rows}});
        await ctx.answerCallbackQuery(); return;
      }
      if(data.startsWith('club_list:')){
        const [,leagueId,pageRaw]=data.split(':'); const page=Math.max(1,Number(pageRaw)||1); const clubs=await GameService.getAvailableClubs(leagueId!); const size=10; const slice=clubs.slice((page-1)*size,page*size);
        const rows=slice.map(c=>[{text:`${c.taken?'🔒':'⚽'} ${c.name}`,callback_data:c.taken?'noop':`club_select:${leagueId}:${c.id}`}]);
        const nav=[]; if(page>1)nav.push({text:'⬅️',callback_data:`club_list:${leagueId}:${page-1}`}); if(page*size<clubs.length)nav.push({text:'➡️',callback_data:`club_list:${leagueId}:${page+1}`}); if(nav.length)rows.push(nav); rows.push([{text:'⬅️ Liga',callback_data:`league_menu:${leagueId}`}]);
        await ctx.editMessageText('⚽ *Klubingizni tanlang*\n\n🔒 — band klub',{parse_mode:'Markdown',reply_markup:{inline_keyboard:rows}}); await ctx.answerCallbackQuery(); return;
      }
      if(data.startsWith('club_select:')){
        const [,leagueId,clubId]=data.split(':'); const manager=await IdentityService.getOrCreateManager(ctx.from.id,ctx.from.first_name); await GameService.selectClub(manager.id,leagueId!,clubId!);
        await ctx.answerCallbackQuery({text:'Klub tanlandi ✅'}); const league=await GameService.getLeague(manager.id,leagueId!); await ctx.editMessageText(`✅ Siz *${league.clubName}* klubini tanladingiz.`,{parse_mode:'Markdown',reply_markup:{inline_keyboard:[[{text:'🏆 Liga menyusi',callback_data:`league_menu:${leagueId}`}]]}}); return;
      }
      if(data.startsWith('league_start:')){
        const leagueId=data.split(':')[1]!; const manager=await IdentityService.getOrCreateManager(ctx.from.id,ctx.from.first_name); await ctx.answerCallbackQuery({text:'Liga tayyorlanmoqda…'}); await GameService.startLeague(manager.id,leagueId);
        await ctx.editMessageText('🚀 *Liga boshlandi!*\n\n20 klub, 38 tur, tarkiblar va transfer budjetlari tayyor.',{parse_mode:'Markdown',reply_markup:{inline_keyboard:[[{text:'🏆 Liga menyusi',callback_data:`league_menu:${leagueId}`}]]}}); return;
      }
      if(data.startsWith('squad:')){
        const leagueId=data.split(':')[1]!; const manager=await IdentityService.getOrCreateManager(ctx.from.id,ctx.from.first_name); const league=await GameService.getLeague(manager.id,leagueId); if(!league.clubId)throw new Error('Avval klub tanlang.'); const squad=await GameService.getSquad(league.clubId);
        const lines=squad.map((p,i)=>`${i+1}. ${p.position} — *${p.name}* (${p.rating}) · ${money(p.value)}`); await ctx.editMessageText(`👥 *${league.clubName} tarkibi* (${squad.length})\n\n${lines.join('\n')||'Tarkib liga boshlanganda yaratiladi.'}`,{parse_mode:'Markdown',reply_markup:{inline_keyboard:[[{text:'⬅️ Liga',callback_data:`league_menu:${leagueId}`}]]}}); await ctx.answerCallbackQuery(); return;
      }
      if(data.startsWith('table:')){
        const leagueId=data.split(':')[1]!; const table=await GameService.getTable(leagueId); const lines=table.map((x,i)=>`${i+1}. *${x.name}* — ${x.p} | ${x.w}-${x.d}-${x.l} | ${x.gd>=0?'+':''}${x.gd} | *${x.pts}*`); await ctx.editMessageText(`📊 *Liga jadvali*\n\n${lines.join('\n')}`,{parse_mode:'Markdown',reply_markup:{inline_keyboard:[[{text:'⬅️ Liga',callback_data:`league_menu:${leagueId}`}]]}}); await ctx.answerCallbackQuery(); return;
      }
      if(data.startsWith('tr_sell_select:')){
        const [,leagueId,pageRaw]=data.split(':'); const page=Math.max(1,Number(pageRaw)||1); const {league}=await leagueContext(ctx,leagueId!); if(!league.clubId)throw new Error('Avval klub tanlang.');
        const [squad,listings]=await Promise.all([GameService.getSquad(league.clubId),TransferService.getClubActiveListings(league.clubId)]); if(listings.length>=4)throw new Error('Bir vaqtda maksimum 4 ta faol e’lon mumkin.');
        const listed=new Set(listings.map(x=>x.leaguePlayerId)); const available=squad.filter(x=>!listed.has(x.id)); const size=8; const slice=available.slice((page-1)*size,page*size);
        const rows=slice.map(p=>[{text:`${p.position} ${p.name} (${p.rating}) · ${money(p.value)}`,callback_data:`tr_sell_player:${leagueId}:${p.id}`}]); const nav=[]; if(page>1)nav.push({text:'⬅️',callback_data:`tr_sell_select:${leagueId}:${page-1}`}); if(page*size<available.length)nav.push({text:'➡️',callback_data:`tr_sell_select:${leagueId}:${page+1}`}); if(nav.length)rows.push(nav); rows.push([{text:'⬅️ Transferlar',callback_data:`tr_menu:${leagueId}`}]);
        await ctx.editMessageText(`🏷 *Sotuvga qo‘yish*\n\nFaol e’lonlar: *${listings.length}/4*\nFutbolchini tanlang:`,{parse_mode:'Markdown',reply_markup:{inline_keyboard:rows}}); await ctx.answerCallbackQuery(); return;
      }
      if(data.startsWith('tr_sell_player:')){
        const [,leagueId,playerId]=data.split(':'); const {managerId,league}=await leagueContext(ctx,leagueId!); if(!league.clubId)throw new Error('Avval klub tanlang.'); const player=(await GameService.getSquad(league.clubId)).find(x=>x.id===playerId); if(!player)throw new Error('Futbolchi topilmadi.');
        pendingInputs.set(ctx.from.id,{type:'SELL_PRICE',managerId,leagueId:leagueId!,playerId:player.id,marketValue:player.value}); await ctx.editMessageText(`💶 *${player.name}* uchun sotuv narxini million yevroda yuboring.\n\nBozor qiymati: *${money(player.value)}*\nBot xaridi uchun tavsiya: maksimum *${money(player.value*1.2)}*`,{parse_mode:'Markdown',reply_markup:{inline_keyboard:[[{text:'❌ Bekor qilish',callback_data:`tr_menu:${leagueId}`}]]}}); await ctx.answerCallbackQuery(); return;
      }
      if(data==='admin_main'){ const admin=await IdentityService.getAdminUser(ctx.from.id); if(!admin)throw new Error('Admin huquqi talab etiladi.'); await ctx.editMessageText('🛡 *Admin panel*',{parse_mode:'Markdown',reply_markup:{inline_keyboard:[[{text:'💳 Buyurtmalar',callback_data:'adm_pending_orders'}],[{text:'📢 Homiy kanal',callback_data:'sp_admin_menu'}],[{text:'⬅️ Bosh menyu',callback_data:'main_menu'}]]}}); await ctx.answerCallbackQuery(); return; }
      if(data==='noop'){await ctx.answerCallbackQuery();return;}
      // 3A. Package Menu View (buy_pkg_list:leagueId)
      if (data.startsWith('buy_pkg_list:')) {
        const leagueId = data.split(':')[1]!;
        const { league } = await leagueContext(ctx, leagueId);
        if (!league.clubId) throw new Error('Avval klub tanlang.');
        const { text, keyboard } = handlePackageView({
          leagueName: league.name,
          clubName: league.clubName!,
          currentBudgetEur: league.budget,
          leagueId,
        });
        await ctx.editMessageText(text, {
          parse_mode: 'Markdown',
          reply_markup: { inline_keyboard: keyboard },
        });
        await ctx.answerCallbackQuery();
        return;
      }

      // 3B. Package Selection (buy_pkg:packageId:leagueId)
      if (data.startsWith('buy_pkg:')) {
        const parts = data.split(':');
        const packageId = parts[1]!;
        const leagueId = parts[2]!;
        const telegramUserId = ctx.from.id;
        const { league } = await leagueContext(ctx, leagueId);
        if (!league.clubId) throw new Error('Avval klub tanlang.');
        const pkg = PurchaseService.getPackageById(packageId);
        if (!pkg) throw new Error('Paket topilmadi.');
        const order = await PurchaseService.createPurchaseRequest({ telegramUserId, leagueId, leagueClubId: league.clubId, pkg });

        const { text, keyboard } = handlePackageSelect({
          packageId,
          leagueId,
          leagueName: league.name,
          clubName: league.clubName!,
          telegramUserId,
          adminUsername: 'diyorbek_anorboyev',
          existingOrderCode: order.orderCode,
        });

        await ctx.editMessageText(text, {
          parse_mode: 'Markdown',
          reply_markup: { inline_keyboard: keyboard },
        });
        await ctx.answerCallbackQuery();
        return;
      }

      // 3C. User Order Status View (my_orders:leagueId)
      if (data.startsWith('my_orders:')) {
        const telegramUserId = ctx.from.id;
        const orders = await PurchaseService.getUserOrders(telegramUserId);
        const text = buildOrderStatusViewMessage(orders);
        await ctx.editMessageText(text, { parse_mode: 'Markdown' });
        await ctx.answerCallbackQuery();
        return;
      }

      // 3D. Legend Market List View (legend_market:leagueId OR leg_list:leagueId:filter:page)
      if (data.startsWith('legend_market:') || data.startsWith('leg_list:')) {
        const parts = data.split(':');
        const leagueId = parts[1]!;
        const filter = parts[2] || 'ALL';
        const page = parseInt(parts[3] || '1', 10);
        const { league } = await leagueContext(ctx, leagueId);

        const { text, keyboard } = handleLegendMarketList(
          leagueId,
          filter,
          page,
          5,
          league.budget,
        );

        await ctx.editMessageText(text, {
          parse_mode: 'Markdown',
          reply_markup: { inline_keyboard: keyboard },
        });
        await ctx.answerCallbackQuery();
        return;
      }

      // 3D-2. Legend Detail View (leg_det:leagueId:legendId)
      if (data.startsWith('leg_det:')) {
        const parts = data.split(':');
        const leagueId = parts[1]!;
        const legendId = parts[2]!;
        const { league } = await leagueContext(ctx, leagueId);

        const { text, keyboard } = handleLegendDetails(
          leagueId,
          legendId,
          league.budget,
        );

        await ctx.editMessageText(text, {
          parse_mode: 'Markdown',
          reply_markup: { inline_keyboard: keyboard },
        });
        await ctx.answerCallbackQuery();
        return;
      }

      // 3D-3. Legend Purchase Execution (leg_buy:leagueId:legendId)
      if (data.startsWith('leg_buy:')) {
        const parts = data.split(':');
        const leagueId = parts[1]!;
        const legendId = parts[2]!;
        const { managerId, league } = await leagueContext(ctx, leagueId);
        if (!league.clubId) throw new Error('Avval klub tanlang.');

        try {
          const res = await LeagueService.purchaseLeagueLegend(
            legendId,
            league.clubId,
            managerId,
          );
          const { text, keyboard } = handleLegendPurchaseSuccess(
            'Afsonaviy Futbolchi',
            league.clubName!,
            150_000_000,
            res.remainingBudget,
            leagueId,
          );
          await ctx.editMessageText(text, {
            parse_mode: 'Markdown',
            reply_markup: { inline_keyboard: keyboard },
          });
        } catch (err: unknown) {
          const errMsg = err instanceof Error ? err.message : String(err);
          await ctx.reply(`❌ Xatolik: ${errMsg}`);
        }
        await ctx.answerCallbackQuery();
        return;
      }

      // 3D-4. Transfer Market Main Menu (tr_menu:leagueId)
      if (data.startsWith('tr_menu:')) {
        const leagueId = data.split(':')[1]!;
        const { league } = await leagueContext(ctx, leagueId);
        const { text, keyboard } = handleTransferMainMenu(
          leagueId,
          league.budget,
          0,
        );
        await ctx.editMessageText(text, {
          parse_mode: 'Markdown',
          reply_markup: { inline_keyboard: keyboard },
        });
        await ctx.answerCallbackQuery();
        return;
      }

      // 3D-5. Transfer Market Browse (tr_buy_list:leagueId:filter:page)
      if (data.startsWith('tr_buy_list:')) {
        const parts = data.split(':');
        const leagueId = parts[1]!;
        const filter = parts[2] || 'ALL';
        const page = parseInt(parts[3] || '1', 10);
        const { league } = await leagueContext(ctx, leagueId);

        const { text, keyboard } = await handleTransferBrowseList(
          leagueId,
          filter,
          page,
          league.budget,
        );
        await ctx.editMessageText(text, {
          parse_mode: 'Markdown',
          reply_markup: { inline_keyboard: keyboard },
        });
        await ctx.answerCallbackQuery();
        return;
      }

      // 3D-6. Transfer Listing Detail (tr_buy_det:leagueId:listingId)
      if (data.startsWith('tr_buy_det:')) {
        const parts = data.split(':');
        const leagueId = parts[1]!;
        const listingId = parts[2]!;
        const { league } = await leagueContext(ctx, leagueId);
        if (!league.clubId) throw new Error('Avval klub tanlang.');

        const { listings } = await TransferService.getActiveListings(leagueId, {
          page: 1,
          pageSize: 100,
        });
        const target = listings.find((l) => l.id === listingId);

        if (!target) {
          await ctx.reply('❌ E’lon topilmadi yoki allaqachon sotib olingan.');
          await ctx.answerCallbackQuery();
          return;
        }

        const { text, keyboard } = handleListingDetailView(
          target,
          league.budget,
          league.clubId,
        );
        await ctx.editMessageText(text, {
          parse_mode: 'Markdown',
          reply_markup: { inline_keyboard: keyboard },
        });
        await ctx.answerCallbackQuery();
        return;
      }

      // 3D-7. Transfer Purchase Confirmation (tr_buy_confirm:leagueId:listingId)
      if (data.startsWith('tr_buy_confirm:')) {
        const parts = data.split(':');
        const leagueId = parts[1]!;
        const listingId = parts[2]!;

        const { listings } = await TransferService.getActiveListings(leagueId, {
          page: 1,
          pageSize: 100,
        });
        const target = listings.find((l) => l.id === listingId);

        if (!target) {
          await ctx.reply('❌ E’lon topilmadi.');
          await ctx.answerCallbackQuery();
          return;
        }

        const { text, keyboard } = handleListingConfirmView(target, leagueId);
        await ctx.editMessageText(text, {
          parse_mode: 'Markdown',
          reply_markup: { inline_keyboard: keyboard },
        });
        await ctx.answerCallbackQuery();
        return;
      }

      // 3D-8. Transfer Purchase Execution (tr_buy_exec:leagueId:listingId)
      if (data.startsWith('tr_buy_exec:')) {
        const parts = data.split(':');
        const leagueId = parts[1]!;
        const listingId = parts[2]!;
        const { managerId, league } = await leagueContext(ctx, leagueId);
        if (!league.clubId) throw new Error('Avval klub tanlang.');

        try {
          const res = await TransferService.purchaseListing(
            listingId,
            league.clubId,
            managerId,
          );
          const priceMln = (res.priceEur / 1_000_000).toFixed(1);
          const remMln = (res.remainingBudget / 1_000_000).toFixed(1);

          await ctx.editMessageText(
            `✅ *Muvaffaqiyatli Xarid!*\n\n` +
              `Futbolchi **€${priceMln}M** evaziga klubingizga o‘tdi.\n` +
              `🏦 *Qolgan budjetingiz:* €${remMln}M`,
            {
              parse_mode: 'Markdown',
              reply_markup: {
                inline_keyboard: [
                  [
                    {
                      text: '🛒 Bozorga qaytish',
                      callback_data: `tr_buy_list:${leagueId}:ALL:1`,
                    },
                  ],
                  [{ text: '🏠 Bosh menyu', callback_data: 'main_menu' }],
                ],
              },
            },
          );
        } catch (err: unknown) {
          const errMsg = err instanceof Error ? err.message : String(err);
          await ctx.reply(`❌ Xatolik: ${errMsg}`);
        }
        await ctx.answerCallbackQuery();
        return;
      }

      // 3D-9. My Listings View (tr_my_listings:leagueId)
      if (data.startsWith('tr_my_listings:')) {
        const leagueId = data.split(':')[1]!;
        const { league } = await leagueContext(ctx, leagueId);
        if (!league.clubId) throw new Error('Avval klub tanlang.');
        const { text, keyboard } = await handleMyListingsView(
          leagueId,
          league.clubId,
        );
        await ctx.editMessageText(text, {
          parse_mode: 'Markdown',
          reply_markup: { inline_keyboard: keyboard },
        });
        await ctx.answerCallbackQuery();
        return;
      }

      // 3D-10. Cancel Listing Execution (tr_cancel:leagueId:listingId)
      if (data.startsWith('tr_cancel:')) {
        const parts = data.split(':');
        const leagueId = parts[1]!;
        const listingId = parts[2]!;
        const { managerId, league } = await leagueContext(ctx, leagueId);
        if (!league.clubId) throw new Error('Avval klub tanlang.');

        try {
          await TransferService.cancelListing(listingId, managerId);
          await ctx.reply('✅ E’lon muvaffaqiyatli bekor qilindi.');
          const { text, keyboard } = await handleMyListingsView(
            leagueId,
            league.clubId,
          );
          await ctx.editMessageText(text, {
            parse_mode: 'Markdown',
            reply_markup: { inline_keyboard: keyboard },
          });
        } catch (err: unknown) {
          const errMsg = err instanceof Error ? err.message : String(err);
          await ctx.reply(`❌ Xatolik: ${errMsg}`);
        }
        await ctx.answerCallbackQuery();
        return;
      }

      // 3D-11. Transfer History View (tr_history:leagueId:filter:page)
      if (data.startsWith('tr_history:')) {
        const parts = data.split(':');
        const leagueId = parts[1]!;
        const filter = parts[2] || 'ALL';
        const page = parseInt(parts[3] || '1', 10);
        const { league } = await leagueContext(ctx, leagueId);
        if (!league.clubId) throw new Error('Avval klub tanlang.');

        const { text, keyboard } = await handleTransferHistoryView(
          leagueId,
          league.clubId,
          filter,
          page,
        );
        await ctx.editMessageText(text, {
          parse_mode: 'Markdown',
          reply_markup: { inline_keyboard: keyboard },
        });
        await ctx.answerCallbackQuery();
        return;
      }

      // 3E. Solo League Deletion Step 1 (del_solo_step1:leagueId)
      if (data.startsWith('del_solo_step1:')) {
        const leagueId = data.split(':')[1]!;
        const humanCount =
          await LeagueService.getHumanParticipantCount(leagueId);
        const { text, keyboard } = handleSoloLeagueDeleteStep1(
          leagueId,
          'Solo League',
          humanCount,
        );
        await ctx.editMessageText(text, {
          parse_mode: 'Markdown',
          reply_markup: { inline_keyboard: keyboard },
        });
        await ctx.answerCallbackQuery();
        return;
      }

      // 3F. Solo League Deletion Step 2 Confirm (del_solo_confirm:leagueId)
      if (data.startsWith('del_solo_confirm:')) {
        const leagueId = data.split(':')[1]!;
        const { text, keyboard } = handleSoloLeagueDeleteStep2(
          leagueId,
          'Solo League',
          'Solo FC',
        );
        await ctx.editMessageText(text, {
          parse_mode: 'Markdown',
          reply_markup: { inline_keyboard: keyboard },
        });
        await ctx.answerCallbackQuery();
        return;
      }

      // 3G. Solo League Deletion Execute (del_solo_execute:leagueId)
      if (data.startsWith('del_solo_execute:')) {
        const leagueId = data.split(':')[1]!;
        // Execute deletion
        const { managerId } = await leagueContext(ctx, leagueId);
        await LeagueService.deleteSoloLeague(leagueId, managerId);
        const { text, keyboard } = handleSoloLeagueDeleteSuccess('Solo League');
        await ctx.editMessageText(text, {
          parse_mode: 'Markdown',
          reply_markup: { inline_keyboard: keyboard },
        });
        await ctx.answerCallbackQuery();
        return;
      }

      // 3H. Advance Round (advance_round:leagueId)
      if (data.startsWith('advance_round:')) {
        const leagueId = data.split(':')[1]!;
        const { league } = await leagueContext(ctx, leagueId);
        if (league.role !== 'OWNER') throw new Error('Faqat liga egasi turni o‘tkaza oladi.');
        try {
          const res = await LeagueService.executeLeagueRound(leagueId);
          await ctx.reply(
            `⚽ *${res.completedRoundNumber}-tur muvaffaqiyatli o‘tkazildi!*`,
            { parse_mode: 'Markdown' },
          );
        } catch (err: unknown) {
          const errMsg = err instanceof Error ? err.message : String(err);
          if (errMsg.includes('DAILY_ROUND_LIMIT_REACHED')) {
            const { text } = handleDailyRoundLimitReached();
            await ctx.reply(text, { parse_mode: 'Markdown' });
          } else {
            await ctx.reply(`❌ Round execution error: ${errMsg}`);
          }
        }
        await ctx.answerCallbackQuery();
        return;
      }

      // 3I. Admin Pending Orders List (adm_pending_orders)
      if (data === 'adm_pending_orders') {
        const orders = await PurchaseService.getPendingOrders();
        const { text, keyboard } = handleAdminPendingOrdersList(orders);
        await ctx.editMessageText(text, {
          parse_mode: 'Markdown',
          reply_markup: { inline_keyboard: keyboard },
        });
        await ctx.answerCallbackQuery();
        return;
      }

      // 3J. Admin Order Details View (adm_view_req:requestId)
      if (data.startsWith('adm_view_req:')) {
        const requestId = data.split(':')[1]!;
        const orders = await PurchaseService.getPendingOrders();
        const target = orders.find((o) => o.id === requestId);

        if (!target) {
          await ctx.reply(
            '❌ Buyurtma topilmadi yoki allaqachon ko‘rib chiqilgan.',
          );
          await ctx.answerCallbackQuery();
          return;
        }

        const { text, keyboard } = handleAdminOrderDetails(target);
        await ctx.editMessageText(text, {
          parse_mode: 'Markdown',
          reply_markup: { inline_keyboard: keyboard },
        });
        await ctx.answerCallbackQuery();
        return;
      }

      // 3K. Admin Order Approval (adm_app_req:requestId)
      if (data.startsWith('adm_app_req:')) {
        const telegramUserId = ctx.from?.id;
        if (!telegramUserId) return;
        const admin = await IdentityService.getAdminUser(telegramUserId);
        if (!admin) {
          await ctx.answerCallbackQuery({
            text: '❌ Ushbu amal uchun admin huquqi talab etiladi.',
            show_alert: true,
          });
          return;
        }

        const requestId = data.split(':')[1]!;
        await ctx.answerCallbackQuery({ text: 'Tasdiqlanmoqda...' });

        // Execute atomic approval
        const res = await PurchaseService.approvePurchaseRequest(
          requestId,
          admin.id,
          'Telegram Admin Panel orqali tasdiqlandi',
        );

        await ctx.editMessageText(
          `✅ *Buyurtma Muvaffaqiyatli Tasdiqlandi!*\n\n` +
            `💶 *Qo‘shilgan budjet:* +€${(res.addedEurAmount / 1_000_000).toFixed(0)} mln\n` +
            `🏦 *Klubning yangi budjeti:* €${(res.newBalance / 1_000_000).toFixed(0)} mln`,
          {
            parse_mode: 'Markdown',
            reply_markup: {
              inline_keyboard: [
                [
                  {
                    text: '⬅️ Buyurtmalar ro‘yxatiga qaytish',
                    callback_data: 'adm_pending_orders',
                  },
                ],
              ],
            },
          },
        );
        return;
      }

      // 3L. Admin Order Rejection (adm_rej_req:requestId)
      if (data.startsWith('adm_rej_req:')) {
        const telegramUserId = ctx.from?.id;
        if (!telegramUserId) return;
        const admin = await IdentityService.getAdminUser(telegramUserId);
        if (!admin) {
          await ctx.answerCallbackQuery({
            text: '❌ Ushbu amal uchun admin huquqi talab etiladi.',
            show_alert: true,
          });
          return;
        }

        const requestId = data.split(':')[1]!;
        await ctx.answerCallbackQuery({ text: 'Rad etilmoqda...' });

        // Execute rejection
        await PurchaseService.rejectPurchaseRequest(
          requestId,
          admin.id,
          'Telegram Admin Panel orqali rad etildi',
        );

        await ctx.editMessageText(
          `❌ *Buyurtma Rad Etildi.*\n\nKlub transfer budjetiga hech qanday o‘zgarish kiritilmadi.`,
          {
            parse_mode: 'Markdown',
            reply_markup: {
              inline_keyboard: [
                [
                  {
                    text: '⬅️ Buyurtmalar ro‘yxatiga qaytish',
                    callback_data: 'adm_pending_orders',
                  },
                ],
              ],
            },
          },
        );
        return;
      }

      // 3M. Sponsor User Menu (sp_user_menu)
      if (data === 'sp_user_menu') {
        const telegramUserId = ctx.from?.id;
        if (!telegramUserId) return;
        const manager = await IdentityService.getOrCreateManager(
          telegramUserId,
          ctx.from?.first_name,
        );

        await ctx.answerCallbackQuery();
        await SponsorHandler.renderUserSponsorMenu(ctx, manager.id);
        return;
      }

      // 3N. Sponsor Check Subscription (sp_check_sub)
      if (data === 'sp_check_sub') {
        const telegramUserId = ctx.from?.id;
        if (!telegramUserId) return;
        const manager = await IdentityService.getOrCreateManager(
          telegramUserId,
          ctx.from?.first_name,
        );

        await SponsorHandler.handleCheckSubscription(ctx, manager.id);
        return;
      }

      // 3O. Sponsor Income History (sp_history_1)
      if (data === 'sp_history_1') {
        const telegramUserId = ctx.from?.id;
        if (!telegramUserId) return;
        const manager = await IdentityService.getOrCreateManager(
          telegramUserId,
          ctx.from?.first_name,
        );

        await ctx.answerCallbackQuery();
        await SponsorHandler.renderIncomeHistory(ctx, manager.id, 1);
        return;
      }

      // 3P. Sponsor Admin Panel (sp_admin_menu)
      if (data === 'sp_admin_menu') {
        const telegramUserId = ctx.from?.id;
        if (!telegramUserId) return;
        const admin = await IdentityService.getAdminUser(telegramUserId);
        if (!admin) {
          await ctx.answerCallbackQuery({
            text: '❌ Ushbu amal uchun admin huquqi talab etiladi.',
            show_alert: true,
          });
          return;
        }

        await ctx.answerCallbackQuery();
        await SponsorHandler.renderAdminSponsorPanel(ctx, admin.id);
        return;
      }

      // 3Q. Sponsor Admin Test Channel (sp_admin_test)
      if (data === 'sp_admin_test') {
        const telegramUserId = ctx.from?.id;
        if (!telegramUserId) return;
        const admin = await IdentityService.getAdminUser(telegramUserId);
        if (!admin) {
          await ctx.answerCallbackQuery({
            text: '❌ Ushbu amal uchun admin huquqi talab etiladi.',
            show_alert: true,
          });
          return;
        }

        await SponsorHandler.handleAdminTestChannel(ctx, admin.id);
        return;
      }

      // 3R. Sponsor Admin Remove Channel (sp_admin_remove)
      if (data === 'sp_admin_remove') {
        const telegramUserId = ctx.from?.id;
        if (!telegramUserId) return;
        const admin = await IdentityService.getAdminUser(telegramUserId);
        if (!admin) {
          await ctx.answerCallbackQuery({
            text: '❌ Ushbu amal uchun admin huquqi talab etiladi.',
            show_alert: true,
          });
          return;
        }

        await SponsorHandler.handleAdminRemoveChannel(ctx, admin.id);
        return;
      }

      // Default answer callback query to clear Telegram loading spinner
      await ctx.answerCallbackQuery();
    } catch (err: unknown) {
      const errMsg = err instanceof Error ? err.message : String(err);
      await ctx.reply(`❌ Xatolik yuz berdi: ${errMsg}`);
      await ctx.answerCallbackQuery();
    }
  });
}
