import { Context } from 'grammy';
import { SponsorService } from '../../services/sponsorService.js';
import {
  buildUserSponsorKeyboard,
  buildAdminSponsorKeyboard,
} from '../keyboards/sponsorKeyboards.js';

export class SponsorHandler {
  /**
   * Render User Sponsorship Menu (`📢 Homiylik`)
   */
  static async renderUserSponsorMenu(
    ctx: Context,
    managerId: string,
  ): Promise<void> {
    const telegramUserId = ctx.from?.id;
    if (!telegramUserId) return;

    const sponsorSetting = await SponsorService.getActiveSponsorChannel();

    if (!sponsorSetting) {
      const text =
        `📢 *Homiylik bo‘limi*\n\n` +
        `ℹ️ Hozircha faol homiy kanal mavjud emas.\n\n` +
        `Homiy kanal ulanganidan so‘ng, har bir yakunlangan tur uchun klubingizga har safar €2.5 mln homiylik daromadi beriladi.`;

      await ctx.reply(text, {
        parse_mode: 'Markdown',
        reply_markup: buildUserSponsorKeyboard(null),
      });
      return;
    }

    const { isSubscribed, isCached, apiError } =
      await SponsorService.verifyManagerSubscription(
        ctx.api,
        telegramUserId,
        managerId,
      );

    let statusText: string;
    if (apiError) {
      statusText = `⚠️ Homiy kanalga obunangizni vaqtincha tekshirib bo‘lmadi. O‘yin natijasi va boshqa klub daromadlari saqlandi.`;
    } else if (isSubscribed) {
      statusText = `✅ *Homiylik faol*\n\nSiz homiy kanalga obuna bo‘lgansiz. Har bir yakunlangan turdan keyin klubingizga €2.5 mln homiylik puli tushadi.`;
    } else {
      statusText = `⚠️ *Homiylik faol emas*\n\nSiz homiy kanalga a’zo emassiz. Homiylik bonusini olish uchun kanalga obuna bo‘lib, “Obunani tekshirish” tugmasini bosing.\n\n_Eslatma: G‘alaba, durrang va stadion daromadlari obunasiz ham beriladi._`;
    }

    const text =
      `📢 *Homiylik bo‘limi*\n\n` +
      `📌 *Homiy kanal:* ${sponsorSetting.display_title}\n` +
      `💰 *Tur uchun homiylik bonusi:* €2,500,000\n` +
      `${isCached ? `⏱ _Status keshdan tekshirildi_\n` : ''}\n` +
      `${statusText}`;

    await ctx.reply(text, {
      parse_mode: 'Markdown',
      reply_markup: buildUserSponsorKeyboard(sponsorSetting),
    });
  }

  /**
   * Action: User Check Subscription (`✅ Obunani tekshirish`)
   */
  static async handleCheckSubscription(
    ctx: Context,
    managerId: string,
  ): Promise<void> {
    const telegramUserId = ctx.from?.id;
    if (!telegramUserId) return;

    const { isSubscribed, apiError } =
      await SponsorService.verifyManagerSubscription(
        ctx.api,
        telegramUserId,
        managerId,
      );

    if (apiError) {
      await ctx.answerCallbackQuery({
        text: '⚠️ Telegram API bilan ulanishda xatolik. Keyinroq qayta urinib ko‘ring.',
        show_alert: true,
      });
      return;
    }

    if (isSubscribed) {
      await ctx.answerCallbackQuery({
        text: '✅ Obunangiz tasdiqlandi! Keyingi turdan €2.5 mln homiylik bonusi beriladi.',
        show_alert: true,
      });
    } else {
      await ctx.answerCallbackQuery({
        text: '⚠️ Siz hali homiy kanalga obuna bo‘lmagansiz.',
        show_alert: true,
      });
    }

    await this.renderUserSponsorMenu(ctx, managerId);
  }

  /**
   * View: Club Income History (`📊 Klub daromadlari`)
   */
  static async renderIncomeHistory(
    ctx: Context,
    clubId: string,
    page: number = 1,
  ): Promise<void> {
    const pageSize = 5;
    const offset = (page - 1) * pageSize;

    const { items } = await SponsorService.getClubIncomeHistory(
      clubId,
      pageSize,
      offset,
    );

    let text = `📊 *Klub daromadlari tarixi*\n\n`;
    if (items.length === 0) {
      text += `_Hozircha daromadlar yozuvi mavjud emas._`;
    } else {
      items.forEach((item) => {
        const dateStr = new Date(item.createdAt).toLocaleString('uz-UZ', {
          timeZone: 'Asia/Tashkent',
        });
        const icon =
          item.transactionType === 'SPONSORSHIP_INCOME'
            ? '📢'
            : item.transactionType === 'MATCH_WIN_BONUS'
              ? '🏆'
              : item.transactionType === 'MATCH_DRAW_BONUS'
                ? '🤝'
                : item.transactionType === 'STADIUM_INCOME'
                  ? '🏟'
                  : '💶';
        const sign = item.amountEur >= 0 ? '+' : '';
        text += `${icon} *${item.description}*\n`;
        text += `   Mablag‘: \`${sign}€${item.amountEur.toLocaleString('en-US')}\` | 📅 ${dateStr}\n\n`;
      });
    }

    await ctx.reply(text, { parse_mode: 'Markdown' });
  }

  /**
   * Render Admin Sponsor Management Panel (`📢 Homiy kanal boshqaruvi`)
   */
  static async renderAdminSponsorPanel(
    ctx: Context,
    _adminId: string,
  ): Promise<void> {
    const sponsorSetting = await SponsorService.getActiveSponsorChannel();

    let text = `📢 *Homiy kanal boshqaruvi*\n\n`;
    if (!sponsorSetting) {
      text += `ℹ️ Hozirda faol homiy kanal sozlangan emas.\n\nYangi homiy kanal ulash uchun “➕ Homiy kanal ulash” tugmasini bosing.`;
    } else {
      text += `📌 *Sarlavha:* ${sponsorSetting.display_title}\n`;
      text += `🆔 *Chat ID:* \`${sponsorSetting.chat_id}\`\n`;
      text += `👤 *Username:* ${sponsorSetting.channel_username || '_Mavjud emas_'}\n`;
      text += `🔗 *Taklif havolasi:* ${sponsorSetting.invite_url || '_Mavjud emas_'}\n`;
      text += `⚡️ *Holati:* ${sponsorSetting.is_active ? '✅ Faol' : '⏸ No-faol'}\n`;
      text += `📅 *Sozlangan vaqt:* ${new Date(sponsorSetting.created_at).toLocaleString('uz-UZ', { timeZone: 'Asia/Tashkent' })}\n`;
    }

    await ctx.reply(text, {
      parse_mode: 'Markdown',
      reply_markup: buildAdminSponsorKeyboard(sponsorSetting),
    });
  }

  /**
   * Admin Action: Test Channel Admin Status (`🔍 Kanalni tekshirish`)
   */
  static async handleAdminTestChannel(
    ctx: Context,
    _adminId: string,
  ): Promise<void> {
    const sponsorSetting = await SponsorService.getActiveSponsorChannel();
    if (!sponsorSetting) {
      await ctx.answerCallbackQuery({
        text: '❌ Faol kanal topilmadi.',
        show_alert: true,
      });
      return;
    }

    try {
      const me = await ctx.api.getMe();
      const member = await ctx.api.getChatMember(sponsorSetting.chat_id, me.id);
      if (member.status === 'administrator' || member.status === 'creator') {
        await ctx.answerCallbackQuery({
          text: `✅ Bot kanalda administrator statusiga ega (${member.status})!`,
          show_alert: true,
        });
      } else {
        await ctx.answerCallbackQuery({
          text: `⚠️ Bot kanalda administrator emas! Status: ${member.status}`,
          show_alert: true,
        });
      }
    } catch (err: unknown) {
      const msg = err instanceof Error ? err.message : String(err);
      await ctx.answerCallbackQuery({
        text: `❌ Ulanish xatosi: ${msg}`,
        show_alert: true,
      });
    }
  }

  /**
   * Admin Action: Deactivate/Remove Channel (`🗑 Kanalni uzish`)
   */
  static async handleAdminRemoveChannel(
    ctx: Context,
    adminId: string,
  ): Promise<void> {
    await SponsorService.deactivateSponsorChannel(adminId);
    await ctx.answerCallbackQuery({
      text: '✅ Homiy kanal ajratildi va faolsizlantirildi.',
      show_alert: true,
    });
    await this.renderAdminSponsorPanel(ctx, adminId);
  }
}
