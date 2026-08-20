# Deployment & Scheduled Workers (Cron Jobs) Guide

This document provides setup instructions for automated background workers in Football Manager Bot.

---

## Scheduled Bot Transfer Review Worker

The bot transfer review process periodically checks active player listings older than 24 hours to evaluate potential automated purchases by bot-controlled clubs in each league.

### Requirements:

- Service role authorization (`SUPABASE_SERVICE_ROLE_KEY` or protected internal API).
- Process limit per execution: `20` listings.
- Frequency: Every hour or every 6 hours.

### Execution Command / Job Call:

```ts
import { runBotTransferReviewJob } from './src/jobs/botTransferReviewWorker.js';

// Executes scheduled review batch (up to 20 listings)
await runBotTransferReviewJob(20);
```

### Database RPC Endpoint:

```sql
-- Direct SQL execution via service_role:
SELECT public.process_bot_transfer_reviews(20);
```

### Safety & Idempotency:

- Protected by `SECURITY DEFINER SET search_path = public`.
- Executable only by `service_role`.
- Row-locked transactionally for safe concurrent execution.
- Evaluates controlled purchase probability (70% for <= market value, 45% for <= 110%, 25% for <= 120%).
- Ignores players with `overall_rating > 82` or asking price `> 120%`.
