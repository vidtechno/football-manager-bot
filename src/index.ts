import { loadEnvironment } from './config/env.js';
import { startBot } from './bot/bot.js';
import { app } from './api/app.js';

export async function main(): Promise<void> {
  const env = loadEnvironment();
  console.log(
    `Football Manager bot loyihasi tayyor. Project ID: ${env.SUPABASE_PROJECT_ID}`,
  );

  const apiPort = process.env['PORT'] ? Number(process.env['PORT']) : 3001;
  app.listen(apiPort, () => {
    console.log(
      `[FOOTBALL_MANAGER_API] Secure Web API Server listening on http://localhost:${apiPort}`,
    );
  });

  await startBot();
}

if (process.argv[1] && process.argv[1].endsWith('index.js')) {
  void main();
}
