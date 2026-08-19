import { Bot, Context } from 'grammy';
import { loadEnvironment } from '../config/env.js';
import { registerBotRoutes } from './router.js';

let botInstance: Bot<Context> | null = null;

export function createBot(): Bot<Context> {
  if (botInstance) return botInstance;

  const env = loadEnvironment();
  botInstance = new Bot<Context>(env.TELEGRAM_BOT_TOKEN);

  // Centralized Error Handling
  botInstance.catch((err) => {
    const ctx = err.ctx;
    console.error(
      `[Grammy Error] update_id=${ctx.update.update_id}:`,
      err.error,
    );
  });

  // Register Canonical Bot Routes
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
  console.log('🤖 Telegram bot polling rejimida ishga tushirilmoqda...');

  const handleSignal = async (signal: string) => {
    console.log(`\n[SIGNAL] ${signal} qabul qilindi. Bot to‘xtatilyapti...`);
    await stopBot();
    process.exit(0);
  };

  process.once('SIGINT', () => handleSignal('SIGINT'));
  process.once('SIGTERM', () => handleSignal('SIGTERM'));

  await bot.start();
}
