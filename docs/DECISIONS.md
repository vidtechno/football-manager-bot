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

---

### [2026-08-19] DEC-022: 4E-Bosqich Joriy 20 ta Klub Tarkiblari, Narxlari va Baholashlarining Versiyalangan Ma'lumotlar To'plami (Dataset Architecture & Seed Policy)

- **Maqom:** Tasdiqlangan (Approved)
- **Kontekst:** 20 ta Gigants Mode top-klublari uchun 2026-08-19 ma'lumotlar snapshot sanasi bilan joriy birinchi jamoa futbolchilari, bozor narxlari, pozitsiyalari va baholashlarining to'liq, audittan o'tadigan, versiyalangan ma'lumotlar to'plamini shakllantirish.
- **Qaror:**
  - Ma'lumotlar to'plami arxitekturasi: `data/football/2026-08-19/` katalogida `clubs.json`, `players.json`, `sources.json` hamda `validation-report.json` fayllari yaratildi.
  - Generatsiya va validatsiya: `src/data/types.ts` Zod tiplari, `src/data/validate-dataset.ts` deterministik validatsiya dvigateli va `src/data/generate-seed-sql.ts` orqali takrorlanuvchan `supabase/seed.sql` shakllantirildi.
  - Qoidalar: Har bir klub uchun 18-25 ta futbolchi (kamida 2 ta GK), GK/Outfield atributlarining qat'iy ajratilishi, non-negative EUR narxlari, va takrorlanmas `canonicalKey` belgilandi.
  - Sinov va xavfsizlik: Vitest orqali 11 ta test muvaffaqiyatli o'tdi. Masofaviy Supabase va avvalgi migratsiyalarga hech qanday o'zgartirish kiritilmadi, maxfiy kalitlar va admin Telegram ID lar sir saqlandi.

---

### [2026-08-19] DEC-023: 4F-Bosqich Tarkib Sig'imini 18-30 gacha Oshirish va Afsonalar Bozori (Legend Transfers) Poydevori Shakllantirilishi

- **Maqom:** Tasdiqlangan (Approved)
- **Kontekst:** Faol klub tarkibi sig'imini 18-25 dan 18-30 ta futbolchigacha kengaytirish, pozitsion minimal talablarni (2 GK, 6 DEF, 6 MID, 4 FWD) qat'iylashtirish, hamda har bir liga uchun ajratilgan "Legend Transfers" afsonaviy futbolchilar bozori poydevorini va tranzaktsiyaviy RPC strukturasini yaratish.
- **Qaror:**
  - Tarkib sig'imi 18-30 ga kengaytirildi, `src/data/validate-dataset.ts`, `instantiate_league_players` funksiyasi hamda testlar muvofiqlashtirildi.
  - `src/data/build-players-json.ts` xavfsiz validatsiya va passthrough wrapperga o'tkazildi, 567 ta futbolchidan iborat yangi ma'lumotlar to'plami saqlandi.
  - Afsonalar Bozori arxitekturasi: Global `legend_templates` jadvali va har bir liga uchun ajratilgan `league_legend_market` jadvali shakllantirildi (20260819140000).
  - Tranzaktsiyaviy xarid PL/pgSQL funksiyasi (`purchase_league_legend`) yaratildi: `FOR UPDATE` qulfi, ligaga tegishlilik, menejer muvofiqligi, mablag' yetarliligi tekshiruvi, balansdan ayirish hamda `financial_ledger` jurnaliga yozish atomar ravishda ta'minlandi.
  - Zod validator `src/data/validate-legends.ts` hamda loyiha arxitekturasi hujjati `docs/LEGEND_TRANSFERS_PLAN.md` shakllantirildi.
  - Vitest va pgTAP test to'plamlari muvaffaqiyatli o'tdi. Masofaviy Supabase va avvalgi migratsiyalarga o'zgartirish kiritilmadi.

---

### [2026-08-19] DEC-024: 4G-Bosqich Transfer Budjeti Paketlari, Admin Tasdiqlashi, Kunlik 3-Tur Limiti va Solo Liganing Butunlay O'chirilishi

- **Maqom:** Tasdiqlangan (Approved)
- **Kontekst:** Afsonalarni faqat klub transfer budjeti (`club_finances.current_balance`) orqali xarid qilishni belgilash, narx diapazonini €100m-€500m ga (peak Messi va Ronaldo uchun €500m) muvofiqlashtirish, 5 ta real to'lov paketi va admin tasdiqlash oqimini shakllantirish, kunlik tur limitini 3 ta turga tushirish, hamda solo ligani o'chirish tranzaktsion imkoniyatini taqdim etish.
- **Qaror:**
  - `legend_templates` jadvaliga `CHECK (default_price_eur BETWEEN 100000000 AND 500000000)` cheklovi o'rnatildi. Peak Messi va Ronaldo narxi qat'iy €500m ga belgilandi.
  - 5 ta sozlanadigan paketlar `transfer_budget_packages` va buyurtma so'rovlari `transfer_budget_purchase_requests` jadvallari shakllantirildi (20260819150000).
  - Admin tasdiqlashi `approve_transfer_budget_purchase_request` atomar va idempotent qilindi (`FOR UPDATE` qulfi, balansga qo'shish va `TRANSFER_PURCHASE` moliyaviy jurnal yozuvi).
  - Kunlik tur limiti Toshkent vaqti (`Asia/Tashkent`) bo'yicha ko'pi bilan 3 ta tur etib belgilandi (`check_daily_round_limit`).
  - Solo liga egasi (1 inson menejer, 19 bot) uchun ligani butunlay tranzaktsiyaviy o'chirish RPC funksiyasi (`delete_solo_league`) shakllantirildi. Ko'p insonli ligalarda o'chirish taqiqlandi.
  - Telegram matnlari va URL deep link generatori (`buildAdminPaymentDeepLink`) O'zbek tilidagi qat'iy uslubiy qoidalarga muvofiqlashtirildi.
  - Vitest (25 test) va pgTAP SQL testlari to'liq yozildi va o'tdi.

---

### [2026-08-19] DEC-025: 4H-Bosqich Telegram Bot Ishga Tushirish Integratsiyasi va Xavfsizlikni Kuchaytirish (Security Hardening & Runtime UI Integration)

- **Maqom:** Tasdiqlangan (Approved)
- **Kontekst:** RPC funksiyalari xavfsizligini oshirish (`EXECUTE` huquqlarini `service_role` uchun cheklash, `SET search_path = public`), Telegram bot menyulari, tugmalari va deep-link interfeysini to'liq ulash, kanonik tur o'tkazish tranzaksiyasiga Toshkent vaqti bo'yicha kunlik 3-tur limitini integratsiyalash, hamda solo ligani o'chirishning 2 bosqichli Telegram UI oqimini taqdim etish.
- **Qaror:**
  - Migratsiya `20260819160000_harden_rpc_security_and_round_limits.sql` yaratildi: nozik RPC funksiyalaridan (`delete_solo_league`, `approve_transfer_budget_purchase_request`, `reject_transfer_budget_purchase_request`, `purchase_league_legend`, `create_transfer_budget_purchase_request`, `execute_league_round`) `anon` va `authenticated` bajarish huquqlari bekor qilindi, faqat `service_role` ga berildi.
  - Kanonik tur o'tkazish funksiyasi `execute_league_round` yaratildi: u o'z tranzaksiyasi ichida birinchi bo'lib `check_daily_round_limit(p_league_id)` chaqiruvini bajaradi (Toshkent vaqti bo'yicha kuniga ko'pi bilan 3 tur).
  - Telegram bot xabarlari `src/bot/messages/templates.ts`, klaviaturalari `src/bot/keyboards/menus.ts`, xizmatlari `src/services/purchaseService.ts` va handlerlari `src/bot/handlers/` yaratildi.
  - `buildAdminPaymentDeepLink` generatori `https://t.me/diyorbek_anorboyev?text=...` URL shaklida kodlangan deep link havola yaratadi.
  - Solo liganing 2 bosqichli o'chirilishi `handleSoloLeagueDeleteStep1` va `handleSoloLeagueDeleteStep2` orqali ta'minlandi (ko'p insonli ligada taqiqlandi).
  - Bo'sh afsonalar bozori uchun `buildEmptyLegendsMarketMessage` (`ℹ️ Legendalar bozori hozircha tayyorlanmoqda.`) o'rnatildi.
  - Vitest test to'plami `tests/bot-runtime-integration.test.ts` va pgTAP SQL test to'plami `supabase/tests/rpc_security_and_round_limits.test.sql` muvaffaqiyatli o'tdi.

---

---

### [2026-08-20] DEC-027: Doimiy Ochiq Futbolchilar Transfer Bozori va Bot Xaridlari Mantig‘i

- **Maqom:** Tasdiqlangan (Approved)
- **Kontekst:** Transferlar uchun turlar bo‘yicha har qanday cheklovlarni (1-6 va boshqa tur cheklovlarini) olib tashlash, transfer bozorini 24/7 doimiy ochiq etib belgilash, har bir klub uchun ko‘pi bilan 4 ta faol e’lon (`ACTIVE`) ruxsat etish, hamda 24 soatdan so‘ng o‘yinchilarni bot klublar tomonidan avtomatik sotib olinishining xavfsiz va ehtimollikka asoslangan tizimini joriy etish.
- **Qaror:**
  - Migratsiya `20260820000000_permanent_player_transfer_market.sql` yaratildi: `enum_transfer_listing_status`, `enum_transfer_buyer_type` tiplari hamda `league_transfer_listings` jadvali va u bo‘yicha partial unique index `uq_active_listing_per_player` tashkil etildi.
  - Atomar database RPC funksiyalari o‘rnatildi:
    - `create_player_transfer_listing`: 4 ta faol e’lon va sotuvdan so‘ng kamida 18 ta o‘yinchi tarkib cheklovini va sotuvchi egaligini tekshiradi.
    - `cancel_player_transfer_listing`: Sotuvchi menejerga o‘z faol e’lonini bekor qilish imkonini beradi (`status = 'CANCELLED'`).
    - `purchase_player_transfer_listing`: Atomar tranzaksiyada row lock qo‘llaydi, balans va tarkib hajmini (xaridor <= 30, sotuvchi >= 18) tekshiradi, o‘yinchi egaligini o‘tkazadi, audit ledger yozuvlarini yaratadi.
    - `process_bot_transfer_reviews`: 24 soatdan oshgan faol e’lonlarni (overall <= 82, narx <= 120%) ko‘rib chiqadi va 70%/45%/25% ehtimollik bo‘yicha mos bot klubga sotadi (`buyer_type = 'BOT'`).
  - TypeScript servis qatlami `src/services/transferService.ts`, Telegram UI klaviaturalari `src/bot/keyboards/transferKeyboards.ts`, handlerlari `src/bot/handlers/transferHandler.ts` va bot ishchisi `src/jobs/botTransferReviewWorker.ts` yaratildi.
  - Vitest test to‘plami `tests/transferService.test.ts` hamda pgTAP SQL test to‘plami `supabase/tests/transfer_market.test.sql` to‘liq sinovdan o‘tkazildi.

- **Qaror:**
  - Bot routerida `adm_app_req` va `adm_rej_req` callback routelari to'liq kiritildi va server-side idempotent xarid RPC lariga ulandi.
  - Afsonalar bozori ma'lumotlar to me'yorlari shakllantirildi: 60 ta futbolchi, 15 ta pozitsiyadan har birida kamida 3 ta birinchi darajali pozitsiya (GK: 4, CB: 6, LB: 4, RB: 4, LWB: 3, RWB: 3, CDM: 4, CM: 5, CAM: 4, LM: 3, RM: 3, LW: 4, RW: 4, CF: 3, ST: 5).
  - Barcha 9 ta majburiy afsonalar (Cristiano Ronaldo, Lionel Messi, Marcelo, Gareth Bale, Eden Hazard, Luka Modrić, Toni Kroos, Xavi, Andrés Iniesta) prime kalitlar bilan kiritildi. Peak Messi va Ronaldo narxi €500,000,000 ga belgilandi, boshqa afsonalar narxlari €100m-€500m diapazonida darajalarga ko'ra taksimlandi.
  - Manbalar fayli `data/football/legends/sources.json` va avtomatlashtirilgan Zod validatsiyasi `src/data/validate-legends.ts` yaratildi. Validatsiya hisoboti `validation-report.json` ga yozildi.
  - Deterministik seed SQL generatori `src/data/generate-seed-sql.ts` orqali 60 ta legend template versiyasi `supabase/seed.sql` tarkibiga takrorlanuvchan ravishda kiritildi.
  - Telegram bot UI handlerlari `src/bot/handlers/legendHandler.ts` yaratildi: saralash (GK, DEF, MID, FWD, ALL), sahifalash, batafsil ma'lumot ekrani, va byudjet yetishmovchiligi/xarid xabarlari ulindi.
  - 32 ta Vitest va pgTAP unit va integratsiya testlari o'tdi.
