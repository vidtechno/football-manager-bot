import { TransferService } from '../services/transferService.js';

/**
 * Scheduled worker job to review 24h+ active listings for eligible bot club purchases.
 * Idempotent, transactional, service-role executed.
 */
export async function runBotTransferReviewJob(batchLimit = 20): Promise<{
  processedCount: number;
  purchasedCount: number;
}> {
  console.log(
    `[BOT_TRANSFER_REVIEW_JOB] Starting scheduled bot transfer review (batch limit: ${batchLimit})...`,
  );
  try {
    const result = await TransferService.processBotReviews(batchLimit);
    console.log(
      `[BOT_TRANSFER_REVIEW_JOB] Completed successfully: ${result.processedCount} listings reviewed, ${result.purchasedCount} purchases executed.`,
    );
    return result;
  } catch (err: unknown) {
    const errMsg = err instanceof Error ? err.message : String(err);
    console.error(
      `[BOT_TRANSFER_REVIEW_JOB] Error executing bot transfer review: ${errMsg}`,
    );
    throw err;
  }
}
