import { Bot, Context } from 'grammy';
import { loadEnvironment } from '../config/env.js';
import { registerBotRoutes } from './router.js';

let botInstance: Bot<Context> | null = null;

export function createBot(): Bot<Context> {
  if (botInstance) return botInstance;

  const env = loadEnvironment();
  botInstance = new Bot<Context>(env.TELEGRAM_BOT_TOKEN);

  botInstance.catch((err) => {
    const ctx = err.ctx;
    console.error(
      `[Grammy Error] update_id=${ctx.update.update_id}:`,
      err.error,
    );
  });

  registerBotRoutes(botInstance);

  return botInstance;
}

export async function stopBot(): Promise<void> {
  if (botInstance && botInstance.isInited()) {
    console.log('🛑 Telegram bot to‘xtatilmoqda...');
    await botInstance.stop();
    botInstance = null;
  }
}

export async function startBot(): Promise<void> {
  const bot = createBot();
  console.log('🤖 Telegram bot tekshirilmoqda...');

  const handleSignal = async (signal: string) => {
    console.log(`\n[SIGNAL] ${signal} qabul qilindi. Bot to‘xtatilyapti...`);
    await stopBot();
    process.exit(0);
  };

  process.once('SIGINT', () => {
    void handleSignal('SIGINT');
  });
  process.once('SIGTERM', () => {
    void handleSignal('SIGTERM');
  });

  await bot.init();
  console.log(`✅ Telegram token tasdiqlandi: @${bot.botInfo.username}`);

  const webhookInfo = await bot.api.getWebhookInfo();
  if (webhookInfo.url) {
    console.log('⚙️ Eski Telegram webhook o‘chirilmoqda...');
    await bot.api.deleteWebhook({ drop_pending_updates: false });
  }

  console.log('🤖 Telegram bot polling rejimida ishga tushdi.');
  await bot.start({
    drop_pending_updates: false,
    allowed_updates: ['message', 'callback_query'],
  });
}
