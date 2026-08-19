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
import { buildEmptyLegendsMarketMessage, buildOrderStatusViewMessage } from './messages/templates.js';
import { PurchaseService } from '../services/purchaseService.js';
import { LeagueService } from '../services/leagueService.js';

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
    } catch (err: any) {
      await ctx.reply(`❌ Xatolik: ${err.message}`);
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

      // 3D. Empty Legends Market View (legend_market:leagueId)
      if (data.startsWith('legend_market:')) {
        const text = buildEmptyLegendsMarketMessage();
        await ctx.editMessageText(text, { parse_mode: 'Markdown' });
        await ctx.answerCallbackQuery();
        return;
      }

      // 3E. Solo League Deletion Step 1 (del_solo_step1:leagueId)
      if (data.startsWith('del_solo_step1:')) {
        const leagueId = data.split(':')[1]!;
        const humanCount = await LeagueService.getHumanParticipantCount(leagueId);
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
        } catch (err: any) {
          if (err.message.includes('DAILY_ROUND_LIMIT_REACHED')) {
            const { text } = handleDailyRoundLimitReached();
            await ctx.reply(text, { parse_mode: 'Markdown' });
          } else {
            await ctx.reply(`❌ Round execution error: ${err.message}`);
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
          await ctx.reply('❌ Buyurtma topilmadi yoki allaqachon ko‘rib chiqilgan.');
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

      // Default answer callback query to clear Telegram loading spinner
      await ctx.answerCallbackQuery();
    } catch (err: any) {
      await ctx.reply(`❌ Xatolik yuz berdi: ${err.message}`);
      await ctx.answerCallbackQuery();
    }
  });
}
