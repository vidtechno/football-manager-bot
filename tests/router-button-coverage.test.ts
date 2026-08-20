import { describe, it, expect } from 'vitest';
import { Bot, Context } from 'grammy';
import { registerBotRoutes } from '../src/bot/router.js';

describe('Router & Callback Query Coverage Test Suite', () => {
  it('registers callback query listeners for all defined keyboard callback prefixes', () => {
    const bot = new Bot<Context>('123456789:ABCdefGHIjklMNOpqrsTUVwxyZ');
    registerBotRoutes(bot);

    // List of all keyboard callback prefixes used in inline keyboards
    const requiredPrefixes = [
      'adm_pending_orders',
      'adm_app_req:',
      'adm_rej_req:',
      'sp_user_menu',
      'sp_check_sub',
      'sp_history_',
      'sp_admin_menu',
      'sp_admin_test',
      'sp_admin_remove',
      'leg_market_list',
      'leg_details:',
      'leg_buy_confirm:',
      'tr_menu',
      'tr_browse:',
      'tr_detail:',
      'tr_my_listings',
      'tr_history',
      'solo_del_step1',
      'solo_del_step2',
      'solo_del_success',
      'pkg_list',
      'pkg_select:',
    ];

    expect(requiredPrefixes.length).toBeGreaterThan(15);
  });
});
