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
   - Global shablonlar (`club_templates`, `player_templates`) va ularning relatsion versiyalash modellari (`club_template_versions`, `player_template_versions`) hamda pozitsiyalar reestri (`player_template_positions`) to'liq normalizatsiya qilingan. Liga klublari (`league_clubs`), bot-menejer tayinlovlari (`bot_manager_assignments`), liga futbolchilari (`league_players`), pozitsiyalar (`league_player_positions`), klub moliyasi (`club_finances`) hamda o'zgarmas ishorali moliyaviy jurnal (`financial_ledger`) orqali har bir ligadagi futbolchilar va moliyaviy balandliklar atomar RLS va tranzaktsiyaviy RPC funksiyalari (`instantiate_league_players_from_templates`, `initialize_club_finances`, `record_financial_transaction`, `reserve_club_funds`, `release_club_reserved_funds`, `capture_club_reserved_funds`) orqali muhofaza qilinadi. Global shablonlarning admin yangilanishi allaqachon boshlangan faol ligalarga ta'sir ko'rsatmaydi.

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

### 2.3. Legend Transfers Isolation & Transactional Purchases

- **Per-League Isolation:** Har bir liga muxtor Afsonalar Bozoriga (`league_legend_market`) ega. Bitta afsonaviy futbolchi bir vaqtning o'zida bir nechta ligada mustaqil mavjud bo'lishi mumkin, lekin bitta liganing ichida faqat bitta klubga tegishli bo'lishi mumkin.
- **Squad Size Limit:** Faol klublar uchun tarkib sig'imi minimal 18, maksimal 30 ta futbolchi qilib belgilangan (kamida 2 GK, 6 DEF, 6 MID, 4 FWD).
- **Transactional Atomic Purchases:** `purchase_league_legend` RPC funksiyasi row-level locking (`FOR UPDATE`), menejer ruxsati tekshiruvi, va balans yetarliligini atomar tarzda bajaradi va tranzaksiyani `financial_ledger` jurnaliga muhrlaydi.
