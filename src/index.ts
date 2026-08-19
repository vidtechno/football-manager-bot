import { loadEnvironment } from './config/env.js';
import { createBot } from './bot/bot.js';

export function main(): void {
  const env = loadEnvironment();
  console.log(
    `Football Manager bot loyihasi tayyor. Project ID: ${env.SUPABASE_PROJECT_ID}`,
  );
  createBot();
}

if (process.argv[1] && process.argv[1].endsWith('index.js')) {
  main();
}
