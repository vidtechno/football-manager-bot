import { loadEnvironment } from '../config/env.js';
import { runBotTransferReviewJob } from './botTransferReviewWorker.js';

export async function runWorkerCli(): Promise<void> {
  const env = loadEnvironment();

  // Validate CRON_SECRET if passed via CLI argument or env header
  const authSecret = process.argv[2] || process.env['CRON_SECRET_AUTH'];
  if (authSecret && authSecret !== env.CRON_SECRET) {
    console.error('[WORKER_CLI] Unauthorized: CRON_SECRET mismatch.');
    process.exit(1);
  }

  try {
    const res = await runBotTransferReviewJob(20);
    console.log(`[WORKER_CLI] Job finished:`, res);
    process.exit(0);
  } catch (err: unknown) {
    const msg = err instanceof Error ? err.message : String(err);
    console.error(`[WORKER_CLI] Job failed: ${msg}`);
    process.exit(1);
  }
}

if (process.argv[1] && process.argv[1].endsWith('runBotTransferWorkerCli.js')) {
  runWorkerCli();
}
