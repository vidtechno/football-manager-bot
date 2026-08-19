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
    console.error(`[Grammy Error] update_id=${ctx.update.update_id}:`, err.error);
  });

  // Register Canonical Bot Routes
  registerBotRoutes(botInstance);

  return botInstance;
}

export async function startBot(): Promise<void> {
  const bot = createBot();
  console.log('🤖 Telegram bot polling rejimida ishga tushirilmoqda...');
  await bot.start();
}
