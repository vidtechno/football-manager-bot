import { InlineKeyboard } from 'grammy';
import { DbGlobalSponsorSettingRow } from '../../services/sponsorService.js';

export function buildUserSponsorKeyboard(
  sponsorSetting: DbGlobalSponsorSettingRow | null,
): InlineKeyboard {
  const keyboard = new InlineKeyboard();

  if (sponsorSetting) {
    const url =
      sponsorSetting.invite_url ||
      (sponsorSetting.channel_username
        ? `https://t.me/${sponsorSetting.channel_username.replace('@', '')}`
        : null);

    if (url) {
      keyboard.url('📢 Kanalga obuna bo‘lish', url).row();
    }
    keyboard
      .text('✅ Obunani tekshirish', 'sp_check_sub')
      .text('📊 Homiylik tarixi', 'sp_history_1')
      .row();
  }

  keyboard.text('🔙 Orqaga', 'fin_menu');
  return keyboard;
}

export function buildAdminSponsorKeyboard(
  sponsorSetting: DbGlobalSponsorSettingRow | null,
): InlineKeyboard {
  const keyboard = new InlineKeyboard();

  if (sponsorSetting && sponsorSetting.is_active) {
    keyboard
      .text('🔄 Kanalni almashtirish', 'sp_admin_add')
      .text('⏸ Homiylikni to‘xtatish', 'sp_admin_pause')
      .row();
    keyboard
      .text('🔍 Kanalni tekshirish', 'sp_admin_test')
      .text('🗑 Kanalni uzish', 'sp_admin_remove')
      .row();
  } else {
    keyboard.text('➕ Homiy kanal ulash', 'sp_admin_add').row();
    if (sponsorSetting && !sponsorSetting.is_active) {
      keyboard.text('▶️ Homiylikni faollashtirish', 'sp_admin_resume').row();
    }
  }

  keyboard.text('🔙 Admin panel', 'admin_menu');
  return keyboard;
}

export function buildAdminSponsorConfirmKeyboard(): InlineKeyboard {
  return new InlineKeyboard()
    .text('✅ Tasdiqlash', 'sp_admin_confirm')
    .text('❌ Bekor qilish', 'sp_admin_menu')
    .row();
}
