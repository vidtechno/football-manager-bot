# Production Deployment & Operations Runbook (DEPLOYMENT_AND_RUNBOOK.md)

This runbook documents the exact, step-by-step procedures required to deploy, configure, run, and maintain the Telegram Football Manager bot in a production environment.

> ⚠️ **CAUTION:** Do NOT run remote Supabase push or bot deployment commands until production secrets are supplied and authorized by the project lead.

---

## 1. Required Environment Variables Checklist

Ensure the host environment (Vercel, Render, Railway, or VPS) has the following environment variables set:

| Variable Name             | Description                            | Example Value                              | Sensitive? |
| ------------------------- | -------------------------------------- | ------------------------------------------ | ---------- |
| `SUPABASE_PROJECT_ID`     | Unique Supabase project identifier     | `cxuqmfvnrzsrafjhoggu`                     | No         |
| `SUPABASE_URL`            | HTTPS endpoint for Supabase project    | `https://cxuqmfvnrzsrafjhoggu.supabase.co` | No         |
| `SUPABASE_ANON_KEY`       | Public anonymous API key               | `eyJhbGciOi...`                            | No         |
| `SUPABASE_SECRET_KEY`     | Protected service-role secret key      | `eyJhbGciOi...`                            | 🔒 **YES** |
| `TELEGRAM_BOT_TOKEN`      | Token provided by Telegram @BotFather  | `123456789:ABCdef...`                      | 🔒 **YES** |
| `TELEGRAM_BOT_USERNAME`   | Telegram bot username (without `@`)    | `football_manager_bot`                     | No         |
| `TELEGRAM_WEBHOOK_SECRET` | Secret token for Telegram webhooks     | `sec_abc123xyz...`                         | 🔒 **YES** |
| `CRON_SECRET`             | Authorization token for scheduled jobs | `cron_secret_777...`                       | 🔒 **YES** |
| `ADMIN_TELEGRAM_IDS`      | Comma-separated admin Telegram IDs     | `12345678,98765432`                        | 🔒 **YES** |
| `NODE_ENV`                | Environment mode                       | `production`                               | No         |

---

## 2. Ordered Step-by-Step Deployment Runbook

### Step 1: Link Remote Supabase Project

```bash
# Log in to Supabase CLI (if not already authenticated)
npx supabase login

# Link your local repo to the remote Supabase project
npx supabase link --project-ref <SUPABASE_PROJECT_ID>
```

### Step 2: Dry-Run Migration Verification

```bash
# Verify pending migrations without modifying remote database
npx supabase db push --dry-run
```

### Step 3: Apply Production Migrations

```bash
# Apply all verified SQL migrations in order to the remote database
npx supabase db push
```

### Step 4: Seed Production Data (If New Environment)

```bash
# Execute seed.sql to populate initial top-20 club templates and 567 player dataset
npx supabase db execute --file supabase/seed.sql
```

### Step 5: Telegram Bot Father Configuration

1. Open [@BotFather](https://t.me/BotFather) in Telegram.
2. Edit Bot Commands:
   - `/start` - Botni ishga tushirish va menyu
   - `/admin` - Admin panel (faqat adminlar uchun)
3. Set bot description and privacy mode.

### Step 6: Sponsor Channel Administration Setup

1. Create or select the global Telegram channel for bot sponsorship.
2. Add the bot as an **Administrator** in the channel with privileges to view member lists and invite users.
3. Obtain the channel `@username` or `-100...` Chat ID.
4. Log into `/admin` panel in the bot and run `📢 Homiy kanal boshqaruvi` -> `➕ Homiy kanal ulash`.

### Step 7: Build Production Application

```bash
# Install dependencies
npm ci

# Compile TypeScript production bundle
npm run build
```

### Step 8: Start Production Process

```bash
# Start Telegram bot long-polling process
npm start
```

### Step 9: Configure 24h Bot Transfer Review Scheduled Job

Set up a recurring 24-hour cron trigger (or Vercel Cron / Render Cron / crontab) executing:

```bash
# CLI execution with CRON_SECRET authorization
CRON_SECRET_AUTH=<CRON_SECRET> npm run worker:bot-transfers
```

---

## 3. Post-Deployment Controlled Smoke Test Checklist

- [ ] Execute `/start` command in Telegram: confirm welcome message & inline menu render in clean Uzbek.
- [ ] Create a test league & select a club: verify squad size is 18–30 players with 100% position coverage.
- [ ] Execute round: verify match result generation and 3-round daily limit enforcement.
- [ ] Check club finances: verify €2.5M sponsorship (if subscribed), match bonus (€1.5M win / €500k draw), and stadium income are credited accurately to `financial_ledger`.
- [ ] Post player on transfer market: verify listing appears in `tr_browse`.
- [ ] Open Legend market: confirm 60 legends are available for purchase.
- [ ] Execute `/admin`: verify admin order approval and sponsor channel status check.

---

## 4. Rollback & Emergency Instructions

If a critical runtime issue or database error occurs during launch:

1. **Stop Bot Process:** Immediately terminate the `npm start` process or disable long polling.
2. **Revert Deployment:** Revert the hosting deployment to the previous stable commit.
3. **Database Incident Recovery:** If a migration issue occurs, execute forward-only corrective migration:
   ```bash
   npx supabase migration new emergency_hotfix
   # Add corrective SQL script
   npx supabase db push
   ```
