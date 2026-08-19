import { Bot, Context } from 'grammy';
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
import { buildOrderStatusViewMessage } from './messages/templates.js';
import { PurchaseService } from '../services/purchaseService.js';
import { LeagueService } from '../services/leagueService.js';
import { TransferService } from '../services/transferService.js';

export function registerBotRoutes(bot: Bot<Context>): void {
  // 1. Command: /start
  bot.command('start', async (ctx) => {
    await ctx.reply(
      `👋 *Assalomu alaykum! Football Manager Botiga xush kelibsiz.*\n\nQuyidagi menyu orqali ligalarni boshqarishingiz va transfer budjetini oshirishingiz mumkin.`,
      { parse_mode: 'Markdown' },
    );
  });

  // 2. Command: /admin
  bot.command('admin', async (ctx) => {
    try {
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
      // 3A. Package Menu View (buy_pkg_list:leagueId)
      if (data.startsWith('buy_pkg_list:')) {
        const leagueId = data.split(':')[1]!;
        const { text, keyboard } = handlePackageView({
          leagueName: 'Liga',
          clubName: 'Klubingiz',
          currentBudgetEur: 100_000_000,
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

        const { text, keyboard } = handlePackageSelect({
          packageId,
          leagueId,
          leagueName: 'Liga',
          clubName: 'Klubingiz',
          telegramUserId,
          adminUsername: 'diyorbek_anorboyev',
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

        const { text, keyboard } = handleLegendMarketList(
          leagueId,
          filter,
          page,
          5,
          100_000_000,
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

        const { text, keyboard } = handleLegendDetails(
          leagueId,
          legendId,
          100_000_000,
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
        const userId = ctx.from.id.toString();

        try {
          const res = await LeagueService.purchaseLeagueLegend(
            legendId,
            'league_club_id',
            userId,
          );
          const { text, keyboard } = handleLegendPurchaseSuccess(
            'Afsonaviy Futbolchi',
            'Klubingiz',
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
        const { text, keyboard } = handleTransferMainMenu(
          leagueId,
          100_000_000,
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

        const { text, keyboard } = await handleTransferBrowseList(
          leagueId,
          filter,
          page,
          100_000_000,
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
          100_000_000,
          'user_club_id',
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
        const userId = ctx.from.id.toString();

        try {
          const res = await TransferService.purchaseListing(
            listingId,
            'buyer_club_id',
            userId,
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
        const { text, keyboard } = await handleMyListingsView(
          leagueId,
          'seller_club_id',
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
        const userId = ctx.from.id.toString();

        try {
          await TransferService.cancelListing(listingId, userId);
          await ctx.reply('✅ E’lon muvaffaqiyatli bekor qilindi.');
          const { text, keyboard } = await handleMyListingsView(
            leagueId,
            'seller_club_id',
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

        const { text, keyboard } = await handleTransferHistoryView(
          leagueId,
          'club_id',
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
        await LeagueService.deleteSoloLeague(leagueId, ctx.from.id.toString());
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
        const requestId = data.split(':')[1]!;
        await ctx.answerCallbackQuery({ text: 'Tasdiqlanmoqda...' });

        // Execute atomic approval
        const res = await PurchaseService.approvePurchaseRequest(
          requestId,
          '00000000-0000-0000-0000-000000000001', // Admin ID resolved server-side
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
        const requestId = data.split(':')[1]!;
        await ctx.answerCallbackQuery({ text: 'Rad etilmoqda...' });

        // Execute rejection
        await PurchaseService.rejectPurchaseRequest(
          requestId,
          '00000000-0000-0000-0000-000000000001',
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

      // Default answer callback query to clear Telegram loading spinner
      await ctx.answerCallbackQuery();
    } catch (err: unknown) {
      const errMsg = err instanceof Error ? err.message : String(err);
      await ctx.reply(`❌ Xatolik yuz berdi: ${errMsg}`);
      await ctx.answerCallbackQuery();
    }
  });
}
