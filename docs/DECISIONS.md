# Telegram Football Manager - Qarorlar Jurnali (DECISIONS.md)

Ushbu hujjat **Telegram Football Manager** loyihasida qabul qilingan barcha tasdiqlangan mahsulot va texnik qarorlarni qayd etib boradi.

---

## Tasdiqlangan Qarorlar Ro'yxati (Decision Log)

### [2026-08-18] DEC-001: Loyiha Texnologik Stekini Tasdiqlash

- **Maqom:** Tasdiqlangan (Approved)
- **Kontekst:** Yuqori unumdorlikka ega serverless Telegram futbol menejeri o'yinini yaratish.
- **Qaror:** TypeScript, Node.js, grammY, Supabase PostgreSQL, Supabase Cron, Vercel Functions, GitHub, Google Antigravity.

---

### [2026-08-18] DEC-002: Yagona Haqiqat Manbai va Til Standarti

- **Maqom:** Tasdiqlangan (Approved)
- **Kontekst:** Hujjatlar va interfeys izchilligini ta'minlash.
- **Qaror:** `MASTER_SPEC.md` loyihaning yagona haqiqat manbai hisoblanadi. Botning barcha foydalanuvchi interfeysi (matnlar, tugmalar, xabarlar) O'zbek tilida yoziladi. Kod va baza nomlari Ingliz tilida saqlanadi.

---

### [2026-08-18] DEC-003: Telegram Shaxsiy Chat (Private Chat Only) Operatsiyasi

- **Maqom:** Tasdiqlangan (Approved)
- **Kontekst:** Botning ishlash muhitini soddalashtirish va foydalanuvchilar bilan bevosita muloqotni ta'minlash.
- **Qaror:** Bot to'liq shaxsiy chatda ishlaydi. Guruhlarga qo'shish yoki guruh adminlik huquqlari talab qilinmaydi.

---

### [2026-08-18] DEC-004: Dasturlangan O'yin Simulyatsiya Mantiqi (Programmed Game Logic)

- **Maqom:** Tasdiqlangan (Approved)
- **Kontekst:** O'yin natijalari va hodisalarini ishonchli va adolatli simulyatsiya qilish.
- **Qaror:** O'yin jarayoni to'liq dasturlangan o'yin mantiqiga asoslanadi. Jonli o'yin davomida hech qanday sun'iy intellekt (AI) modeliga tayanilmaydi.

---

### [2026-08-18] DEC-005: Gigants Mode va 38 Turdan Iborat Mavsum

- **Maqom:** Tasdiqlangan (Approved)
- **Kontekst:** Boshlang'ich o'yin rejimi va liga formati.
- **Qaror:** Dastlabki rejim Evropaning top-20 klubidan iborat Gigants Mode bo'ladi. Mavsum 38 tur, 380 o'yindan iborat uy-mehmon formatida o'tkaziladi. Min 1 ta odam menejer ligani boshlashi mumkin.

---

### [2026-08-18] DEC-006: Noyob 6 Belgili Liga Kodlari

- **Maqom:** Tasdiqlangan (Approved)
- **Kontekst:** Ligalarga taklif kodi orqali xavfsiz va oson qo'shilish.
- **Qaror:** Kodlar 6 belgili bo'lib, `O, 0, I, L, 1` chalg'ituvchi harflarisiz generatsiya qilinadi va bazada doimiy reestri saqlanadi.

---

### [2026-08-18] DEC-007: Bir Menejer Uchun Maksimal 2 Faol Liga Cheklovi

- **Maqom:** Tasdiqlangan (Approved)
- **Kontekst:** Server yuklamasini nazorat qilish va adolatli o'yin muhitini ta'minlash.
- **Qaror:** Bir menejer bir vaqtning o'zida ko'pi bilan 2 ta faol (kutilayotgan yoki aktiv) ligada ishtirok etishi mumkin.

---

### [2026-08-18] DEC-008: Tenglashtiruvchi Boshlang'ich Byudjet Formulasi

- **Maqom:** Tasdiqlangan (Approved)
- **Kontekst:** Kuchli va kuchsiz klublar o'rtasidagi moliyaviy balansni o'rnatish.
- **Qaror:** Byudjet = €100m + (eng yuqori tarkib qiymati - joriy klub tarkib qiymati) * 35%. Maksimal boshlang'ich byudjet: €400m.

---

### [2026-08-18] DEC-009: Transfer Oynalari va Anti-Drain Qoidalari

- **Maqom:** Tasdiqlangan (Approved)
- **Kontekst:** Transferlar intizomi va bo'sh klublarni talon-taroj qilishdan himoyalash.
- **Qaror:** Transfer oynalari 1-6 va 17-24 turlarda ochiq bo'ladi. Boshqaruvchisiz klublardan futbolchi sotib olishda 8 ta qat'iy anti-drain qoidalari va atomar tranzaksiyalar qo'llaniladi.

---

### [2026-08-18] DEC-010: Idempotent Tur Simulyatsiyasi va Deterministik Random Seed

- **Maqom:** Tasdiqlangan (Approved)
- **Kontekst:** Takroriy so'rovlarda duplikat natijalar paydo bo'lishining oldini olish.
- **Qaror:** Har bir o'yin deterministik random seed yordamida simulyatsiya qilinadi va Supabase Cron idempotent processing qulflaridan foydalanadi.

---

### [2026-08-18] DEC-011: Owner Admin Panel va O'zgarmas Audit Loglar

- **Maqom:** Tasdiqlangan (Approved)
- **Kontekst:** Tizim egasining ma'muriy boshqaruvi hamda xavfsizlik nazorati.
- **Qaror:** Tizim egasi uchun protected veb admin panel yaratiladi. Har bir ma'muriy amal majburiy sabab bilan `admin_audit_logs` jadvalida saqlanadi.

---

### [2026-08-18] DEC-012: 45 Ta To'liq Normalizatsiya Qilingan Jadvallar va Shablon-Nusxa Ajratilishi

- **Maqom:** Tasdiqlangan (Approved)
- **Kontekst:** Bazaviy ma'lumotlar yaxlitligi va masshtablash imkoniyatini audit qilish.
- **Qaror:** Ma'lumotlar bazasi 45 ta alohida normalizatsiya qilingan jadvalga bo'lindi. Global shablonlar va liganing jonli ob'ektlari to'liq ajratildi.

---

### [2026-08-18] DEC-013: 4A-Bosqich Identity & Access Domen Migratsiyasi Yaratilishi

- **Maqom:** Tasdiqlangan (Approved)
- **Kontekst:** Supabase poydevori uchun birinchi SQL migratsiyasini shakllantirish.
- **Qaror:** `20260818193305_create_identity_and_access_schema.sql` migratsiyasi va uning SQL testlar to'plami yaratildi.

---

### [2026-08-19] DEC-014: 4A-Bosqich Identity & Access Migratsiyasining Masofaviy Joylashtirilishi (Remote Deployment)

- **Maqom:** Tasdiqlangan (Approved)
- **Kontekst:** Identity & Access migratsiyasini audit qilish, GitHub ga squash merge qilish va masofaviy Supabase loyihasiga push qilish.
- **Qaror:**
  - Migratsiya dry-run va strict SQL auditidan muvaffaqiyatli o'tdi.
  - Masofaviy Supabase (`cxuqmfvnrzsrafjhoggu`) loyihasiga `20260818193305_create_identity_and_access_schema.sql` muvaffaqiyatli joriy qilindi.
  - Anonim API so'rovlariga `managers` jadvali bo'yicha ruxsat taqiqlandi (Status 401: Permission Denied).

---

### [2026-08-19] DEC-015: 4B1-Bosqich Leagues & Membership Poydevori Migratsiyasining Qat'iylashtirilishi (Hardened)

- **Maqom:** Tasdiqlangan (Approved)
- **Kontekst:** Ligalar, a'zolik, sozlamalar va turlar poydevori migratsiyasini va testlarini qat'iy xavfsizlik va mantiqiy aniqlik bilan qayta ko'rib chiqish.
- **Qaror:**
  - Noyob Kod Alfavit: `ABCDEFGHJKMNPQRSTUVWXYZ23456789` (31 belgi).
  - Unbiased Rejection Sampling yordamida 1/31 taqsimotli kriptografik generatsiya.
  - Reestr hayot sikli (`Reserved` -> `Bound` -> `Released`).

---

### [2026-08-19] DEC-016: 4B1-Bosqich Leagues & Membership Migratsiyasining Masofaviy Joylashtirilishi (Remote Deployment)

- **Maqom:** Tasdiqlangan (Approved)
- **Kontekst:** 4B1 migratsiyasini audit qilish, PR #2 orqali squash merge qilish va masofaviy Supabase loyihasiga joylashtirish.
- **Qaror:**
  - Joylashtirish sanasi: 2026-08-19
  - Migratsiya ID: `20260818195026_create_leagues_and_membership_foundation.sql`
  - PR Raqami va Commit: PR #2, Squash Merge commit `09e6071`
  - Masofaviy Supabase (`cxuqmfvnrzsrafjhoggu`) bazasiga 5 ta jadval (`leagues`, `league_code_registry`, `league_members`, `league_settings`, `league_rounds`) va RPC funksiyalari joylashtirildi.
  - Anonim API so'rovlari bo'yicha barcha 5 ta jadval uchun HTTP 401 Permission Denied holati qaytarildi.
  - Masofaviy bazaga hech qanday test yoki soxta ma'lumotlar kiritilmadi.

---

### [2026-08-19] DEC-017: GitHub Actions-da Avtomatik Supabase Migratsiya va SQL Testlarini O'rnatish

- **Maqom:** Tasdiqlangan (Approved)
- **Kontekst:** Baza migratsiyalari va SQL testlarini har bir Pull Request va `main` ga push qilinganda avtomatik ravishda izchil tekshirish.
- **Qaror:**
  - GitHub Actions `ci.yml` ga `supabase-migration-test` ish (job) qo'shildi.
  - Testlar faqat runner'ning mahalliy Docker xizmatidagi lokal Supabase stekida (`npx supabase start` va `npx supabase test db --local`) bajariladi.
  - CI HECH QACHON masofaviy Supabase loyihasiga ulanmaydi, maxfiy kalitlar yoki remote credentials ishlatmaydi.
  - Joylashtirilgan migratsiyalar o'zgarmasdir; har qanday to'g'rilash faqat yangi forward migratsiyalar orqali amalga oshiriladi.

---

### [2026-08-19] DEC-018: 4C-Bosqich Global Shablonlar Domen Migratsiyasi Shakllantirilishi

- **Maqom:** Tasdiqlangan (Approved)
- **Kontekst:** Qayta ishlatiluvchi klub shablonlari (`club_templates`), klub versiyalari (`club_template_versions`), futbolchilar shablonlari (`player_templates`), pozitsiyalar (`player_template_positions`) va atributlar versiyalari (`player_template_versions`) bazaviy sxemasini shakllantirish.
- **Qaror:**
  - `club_templates` va `player_templates` jadvallari yaratildi. Aniq 20 ta boshlang'ich klub slaglari va qisqa kodlari kiritildi.
  - Futbolchi atributlari `JSONB` ob'ektda emas, to'liq normalizatsiya qilingan relatsion ustunlarda (outfield va goalkeeper ko'rsatkichlari) saqlanadi.
  - Futbolchining yoshi o'rniga tug'ilgan sanasi (`date_of_birth`) saqlanadi.
  - Aniq 12 ta pozitsiya kodi (`enum_player_position`) yaratildi. Har bir faol futbolchida tranzaksiya yakunida kamida bitta asosiy pozitsiya bo'lishi shartiligi deferred constraint trigger orqali tekshiriladi.
  - Shablon versiyalari o'zgarmasdir. Admin Telegram ID lari manba kodiga yoki hujjatlarga qattiq yozilmaydi (`ADMIN_TELEGRAM_ID` server env orqali o'tkaziladi).
  - 5 ta jadvalda RLS yoqildi, `anon` va `authenticated` ruxsatsizlantirildi, `service_role` ga minimal DML va RPC ruxsatlari berildi.
  - Migratsiya PR #4 orqali `main` ga merge qilindi va masofaviy Supabase loyihasiga (`cxuqmfvnrzsrafjhoggu`) `20260818210748` binosida muvaffaqiyatli joylashtirildi. Anonymous API smoke test barcha 5 ta jadval bo'yicha HTTP 401 ruxsat taqiqini tasdiqladi.

---

### [2026-08-19] DEC-019: 4B2-Bosqich Liga Klublari va Bot-Menejer Tayinlovlari Poydevori Shakllantirilishi

- **Maqom:** Tasdiqlangan (Approved)
- **Kontekst:** Liga klublari nusxalari (`league_clubs`) va bot-menejer boshqaruvi (`bot_manager_assignments`) jadvallari hamda LOBBY boshqaruvi mexanizmini o'rnatish.
- **Qaror:**
  - `league_clubs` va `bot_manager_assignments` jadvallari yaratildi. Aniq 20 ta klub slotlari global `club_templates` ga bog'landi.
  - LOBBY holatida klub tanlash, almashtirish va bo'shatish uchun atomic RPC funksiyalari (`initialize_gigants_league_clubs`, `select_league_club`, `switch_league_club`, `release_league_club`, `assign_bots_to_unselected_clubs`) amalga oshirildi.
  - Bir vaqtda takroriy init bo'lishining oldini olish uchun `pg_advisory_xact_lock` qo'llanildi.
  - Inson menejer va bot menejer bir vaqtda bitta klubni boshqara olmasligi hamda liga LOBBY dan chiqqandan so'ng klub tanlash taqiqlanishi bazaviy validation triggerlar orqali ta'minlandi.
  - Admin Telegram ID lari manba kodiga va hujjatlarga qattiq yozilmaydi (`ADMIN_TELEGRAM_ID` env orqali beriladi).
  - Har ikkala jadvalda RLS yoqildi, `anon` va `authenticated` ruxsatlari olib tashlandi, `service_role` ga minimal DML va RPC execution berildi.

---

### [2026-08-19] DEC-020: 4D-Bosqich Liga Futbolchilari va Klub Moliyasi Poydevori Migratsiyasi Shakllantirilishi

- **Maqom:** Tasdiqlangan (Approved)
- **Kontekst:** Liga futbolchilari nusxalari (`league_players`), pozitsiyalari (`league_player_positions`), klub moliyasi (`club_finances`) va o'zgarmas moliyaviy jurnal (`financial_ledger`) jadvallarini hamda tranzaktsiyaviy RPC funksiyalarini yaratish.
- **Qaror:**
  - `league_players`, `league_player_positions`, `club_finances`, va `financial_ledger` jadvallari yaratildi.
  - `enum_player_availability_status` va `enum_financial_transaction_type` ENUM turlari kiritildi.
  - Moliyaviy yo'nalish ishorali musbat/manfiy qiymat (`amount_eur`) orqali ifodalanadi (musbat = kredit, manfiy = debet).
  - Tenglashtiruvchi boshlang'ich byudjet formulasi: `€100m + (max_squad_value - club_squad_value) * 35%` (maksimal €400m) `calculate_club_starting_budget` funksiyasida markazlashtirildi.
  - RPC funksiyalari `instantiate_league_players_from_templates`, `initialize_club_finances`, `record_financial_transaction`, `reserve_club_funds`, `release_club_reserved_funds`, `capture_club_reserved_funds` amalga oshirildi.
  - Shablon ma'lumotlari yoki versiyalar bo'sh bo'lgan holatda avtomatik xavfsiz boshqariladigan xatolik (`P0001`) qaytarilishi ta'minlandi.
  - `financial_ledger` o'zgarmasligi trigger orqali muhofaza qilindi (`UPDATE` va `DELETE` taqiqlandi).
  - Barcha 4 ta jadvalda RLS yoqildi, `anon` va `authenticated` ruxsatlari olib tashlandi, `service_role` ga kamida minimal DML va RPC bajarish ruxsatlari berildi.

---

### [2026-08-19] DEC-021: 4D-Bosqich Liga Futbolchilari va Klub Moliyasi Migratsiyasining Masofaviy Joylashtirilishi (Remote Deployment)

- **Maqom:** Tasdiqlangan (Approved)
- **Kontekst:** Phase 4D migratsiyasini audit qilish, GitHub Actions CI orqali avtomatlashtirilgan lokal migratsiya va pgTAP SQL testlaridan muvaffaqiyatli o'tkazish, PR #6 orqali squash merge qilish va masofaviy Supabase loyihasiga joylashtirish.
- **Qaror:**
  - Joylashtirish sanasi: 2026-08-19
  - Migratsiya ID: `20260819005622_create_league_players_and_finances.sql`
  - PR Raqami va Merge Commit: PR [#6](https://github.com/vidtechno/football-manager-bot/pull/6), Squash Merge commit `742fa4d79f4aaab3976f0db05322eb3b12d5b96b`
  - Masofaviy Supabase (`cxuqmfvnrzsrafjhoggu`) bazasiga 4 ta jadval (`league_players`, `league_player_positions`, `club_finances`, `financial_ledger`), 2 ta ENUM (`enum_player_availability_status`, `enum_financial_transaction_type`), va 7 ta RPC funksiyalari joylashtirildi.
  - Forward repair orqali `validate_league_club_human_selection()` funksiyasi `manager_blocks` ustunini `unblocked_at IS NULL` tekshiruviga muvofiqlashtirildi.
  - Anonim API so'rovlari bo'yicha barcha 4 ta yangi jadval uchun HTTP 401 Permission Denied holati qaytarildi.
  - Masofaviy bazaga hech qanday soxta ma'lumot kiritilmadi.

