# Telegram Football Manager - Tizim Arxitekturasi (ARCHITECTURE.md)

Ushbu hujjat **Telegram Football Manager** loyihasining texnik arxitekturasi, komponentlarining o'zaro aloqasi, xavfsizlik chegaralari hamda idempotentlik mexanizmlarini belgilaydi.

---

## 1. Tizim Arxitekturasi va Komponentlar (System Architecture)

```
+---------------------+
|    Telegram User    | (Private Chat Only)
+---------------------+
           |
           v (HTTPS POST / Secret Token)
+--------------------------------------------------+
| Vercel Serverless Functions (grammY Bot Engine)  |
+--------------------------------------------------+
     |                                        |
     v (Typed Queries & Service Role)         v (Queue / Rate Limits)
+------------------------------------+   +----------------------------------+
| Supabase PostgreSQL Database       |   | Telegram Notification Dispatcher |
| (45 Normalized Tables, RLS, Locks) |   +----------------------------------+
+------------------------------------+
     ^
     | (Cron Triggers / Idempotent Lock)
+------------------------------------+
| Supabase Cron Scheduler            |
+------------------------------------+
```

### 1.1. Komponentlar Vazifalari

1. **Telegram Private Chat Interfeysi:**
   - Bot faqat shaxsiy chatda o'ynaydi. Guruhlar yoki guruh adminlik huquqlari talab qilinmaydi.
   - Telegram mijozlari hech qachon Supabase PostgreSQL ma'lumotlar bazasiga to'g'ridan-to'g'ri ulanmaydi.
   - Barcha menyular, tugmalar, validatsiyalar va o me'yin hisobotlari foydalanuvchiga O'zbek tilida taqdim etiladi.

2. **Vercel Serverless Functions (Bot Engine):**
   - TypeScript va `grammY` framework'i asosida so'rovlarni qayta ishlaydi.
   - `TELEGRAM_WEBHOOK_SECRET` siri orqali har bir Telegram HTTP so me'rovi autentifikatsiya qilinadi.
   - `processed_telegram_updates` jadvali orqali Telegram update ID-lari tekshirilib, takroriy so'rovlar bajarilishining oldi olinadi.

3. **Supabase PostgreSQL (Ma'lumotlar Qatlami - 45 Normalized Tables):**
   - Relatsion ma'lumotlar ombori 45 ta to'liq normalizatsiya qilingan jadvaldan iborat.
   - Global shablonlar (`club_templates`, `player_templates`) va liganing faol nusxalari (`league_clubs`, `league_players`) to'liq ajratilgan.
   - Serverless mantiq faqat server-side muhitdagi `SUPABASE_SECRET_KEY` orqali bazaga xavfsiz ulanadi.

4. **Supabase Cron (Avtomatlashtirilgan Scheduler):**
   - `scheduled_jobs` jadvaliga asosan tur vaqti kelganda Cron trigger orqali Vercel endpoint'iga so'rov yuboradi. `CRON_SECRET` siri orqali so'rov autentifikatsiyasi amalga oshiriladi.

5. **Dasturlangan O'yin Simulyatori (Programmed Match Engine):**
   - O'yin davomida jonli sun'iy intellekt (AI) modellariga tayanmaydi. Barcha hisob-kitoblar qat'iy dasturlangan o'yin mantiqi hamda deterministik random seed orqali bajariladi.

---

## 2. Idempotentlik va Xavfsizlik Chegaralari (Idempotency & Security Boundaries)

### 2.1. Idempotent Round & Transaction Processing

- Cron har bir turni qayta ishlashdan oldin `round_processing_locks` jadvalidan qulf oladi.
- Agar tur qayta ishlanayotgan bo'lsa yoki allaqachon bajarilgan bo'lsa (`PLAYED`), qayta so'rov yuborilganda hech qanday takroriy o me me'yin natijalari, gollar yoki moliyaviy yechimlar yaratilmaydi.
- Telegram update-lari `processed_telegram_updates` jadvalida saqlanadi.
- Transferlar va pul muzlatishlar `reserved_funds` va `financial_ledger` jadvallarida atomar tranzaksiyalar orqali o'tkaziladi.

### 2.2. Xavfsizlik va Secret Verification

1. **Webhook Secret Verification:** Telegram'dan kelayotgan har bir request headers'ida `X-Telegram-Bot-Api-Secret-Token` tekshiriladi.
2. **Cron Secret Verification:** Cron trigger'larida `Authorization: Bearer <CRON_SECRET>` tekshiriladi.
3. **Environment Secret Protection:** `.env.local` sirlari hech qachon mijoz kodiga, Git repository'siga yoki hujjatlarga chiqarilmaydi.
4. **Least-Privilege RLS:** Public mijozlar uchun to'g'ridan-to me'ri bazaga kirish yopilgan.
