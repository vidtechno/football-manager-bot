import { loadEnvironment } from './config/env.js';
import { startBot } from './bot/bot.js';

export async function main(): Promise<void> {
  const env = loadEnvironment();
  console.log(
    `Football Manager bot loyihasi tayyor. Project ID: ${env.SUPABASE_PROJECT_ID}`,
  );
  await startBot();
}

if (process.argv[1] && process.argv[1].endsWith('index.js')) {
  void main();
}
