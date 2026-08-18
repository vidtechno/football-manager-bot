# Telegram Football Manager - Ishlab Chiqish Nazorat Ro'yxati (BUILD_CHECKLIST.md)

> **ESLATMA:** Barcha elementlar `[ ]` (bajarilmagan) holatida saqlanadi, chunki dastur kodi va testlar hali yozilmagan. Har bir bosqich faqat uning kodi yozilib, testlari to'liq o'tgach va tasdiqlangach `[x]` deb belgilanadi.

---

## Ishlab Chiqish Bosqichlari va Qabul Mezonlari (Phases & Acceptance Criteria)

- [ ] **1. Loyiha hujjatlari (Project documentation)**
  - [ ] `MASTER_SPEC.md` loyihaning yagona haqiqat manbai sifatida to'liq yangilangan.
  - [ ] `BUILD_CHECKLIST.md`, `ARCHITECTURE.md`, `DATABASE_PLAN.md`, `MATCH_ENGINE_PLAN.md`, `TRANSFER_SYSTEM_PLAN.md`, `ADMIN_PANEL_PLAN.md`, `DECISIONS.md`, va `README.md` fayllari o'zaro moslashtirilgan.
  - [ ] Hujjatlarda hech qanday maxfiy kalitlar yoki ziddiyatlar mavjud emasligi tasdiqlangan.

- [x] **2. Node.js va TypeScript poydevori (Node.js and TypeScript foundation)**
  - [x] `package.json` va `tsconfig.json` qat'iy TypeScript sozlamalari bilan yaratilgan.
  - [x] ESLint, Prettier va kataloglar tuzilmasi (`src/bot`, `src/services`, `src/database`, `src/game`, `src/jobs`, `src/utils`) shakllantirilgan.
  - [x] Zod atrof-muhit validatsiyasi (`src/config/env.ts`) va Vitest testlari to'liq o'tgan.

- [x] **3. Git va GitHub sozlamalari (Git and GitHub setup)**
  - [x] `.gitignore` faylida `.env.local` va maxfiy fayllar to'g'ri istisno qilingan.
  - [x] `.gitattributes` LF normalizatsiyasi o'rnatilgan.
  - [x] GitHub private repository yaratilgan va remote `origin/main` ulandi.
  - [x] `.github/workflows/ci.yml` GitHub Actions CI workflow tayyorlangan.

- [ ] **4. Supabase poydevori va migratsiyalar (Supabase foundation and migrations)**
  - [x] **4A. Supabase Identity & Access domen migratsiyasi (`create_identity_and_access_schema`):** Tayyorlash va remote masofaviy Supabase loyihasiga (`cxuqmfvnrzsrafjhoggu`) muvaffaqiyatli push qilish yakunlandi (20260818193305). Anonymous ruxsat taqiqi va RLS 401 qaytarilishi sinovdan o'tdi.
  - [ ] **4B1. Supabase Leagues & Membership poydevori (`create_leagues_and_membership_foundation`):** `leagues`, `league_code_registry`, `league_members`, `league_settings`, `league_rounds` jadvallari, 6-belgili kod generatori va koncurrency qulflari.
  - [ ] **4C. Supabase Global Shablonlar domen migratsiyasi:** `global_club_templates`, `global_player_templates`.
  - [ ] **4B2. Supabase League Clubs va Bot Tayinlovlari migratsiyasi:** `league_clubs` (foreign key `global_club_templates.id` bog'liqligi sababli 4C dan keyin) va `bot_manager_assignments`.
  - [ ] 45 ta to'liq normalizatsiya qilingan jadvallar loyihasi (`DATABASE_PLAN.md`) asosida qolgan SQL migratsiyalari shakllantirilgan.
  - [ ] Global shablonlar va liga nusxalari ajratilgan.
  - [ ] 12 ta ENUM turlari va 14 ta bazaviy Triggers/Stored Functions o'rnatilgan.
  - [ ] Supabase TypeScript tiplari va mijoz sozlamalari joylashtirilgan.

- [ ] **5. Telegram bot poydevori (Telegram bot foundation)**
  - [ ] grammY bot ob'ekti va middleware tuzilmasi o'rnatilgan.
  - [ ] Shaxsiy chat (private chat) tekshiruvi va markazlashtirilgan O'zbekcha matnlar lug'ati sozlangan.

- [ ] **6. Vercel webhook joylashtirishi (Vercel webhook deployment)**
  - [ ] Vercel Serverless HTTP handler yaratilgan.
  - [ ] `TELEGRAM_WEBHOOK_SECRET` siri orqali so'rovlar autentifikatsiya qilingan.
  - [ ] `processed_telegram_updates` jadvali orqali idempotentlik ta'minlangan.

- [ ] **7. Menejerlarni ro'yxatdan o'tkazish (Manager registration)**
  - [ ] `/start` buyrug'i orqali qutlov va menejer ismini kiritish jarayoni amalga oshirilgan.
  - [ ] Ism 3-24 belgi oralig'ida validatsiya qilinib, takroriy profillar yaratilishi oldi olingan.

- [ ] **8. Asosiy bot menyusi (Main bot menu)**
  - [ ] Asosiy O'zbekcha menyu tugmalari (🏆 Liga yaratish, 🔑 Ligaga qo‘shilish, 🏟 Mening ligalarim, 👤 Manager profilim, 📖 O‘yin qoidalari) ishga tushirilgan.

- [ ] **9. Liga yaratish (League creation)**
  - [ ] Liga nomi, o'yin rejimi (Gigants Mode) va tur tezligini (kuniga 1, 2, 3 yoki 4 tur) tanlash menyusi yaratilgan.

- [ ] **10. Noyob 6 belgili liga kodlari (Unique six-character league codes)**
  - [ ] `O, 0, I, L, 1` belgilarisiz noyob 6 belgili kod generatsiyasi va `league_code_registry` reestri o'rnatilgan.

- [ ] **11. Kod orqali ligaga qo'shilish (Joining leagues by code)**
  - [ ] Kodni kiritib ligaga qo'shilish va `trg_check_manager_active_league_limit` (2 faol liga cheklovi, max 20 menejer) sinovdan o'tkazilgan.

- [ ] **12. Gigants Mode klublari (Gigants Mode clubs)**
  - [ ] 20 ta dastlabki top-klub shablonlari (`club_templates`, `player_templates`) bazaga joylashtirilgan.

- [ ] **13. Klub tanlash va almashtirish (Club selection and switching)**
  - [ ] Paginatsiyali inline tugmalar, atomar klub tanlash tranzaksiyasi va boshlangunga qadar almashtirish imkoniyati yaratilgan.

- [ ] **14. Futbolchilar bazasi va pozitsiyalari (Player database and positions)**
  - [ ] Har bir klub uchun 18-25 ta futbolchi, 12 ta aniq pozitsiya va atributlar shakllantirilgan.

- [ ] **15. Klub moliyasi va boshlang'ich byudjetlar (Club finances and starting budgets)**
  - [ ] Tenglashtiruvchi byudjet formulasi (€100m + gap * 35%, max €400m) va `financial_ledger` o me'zgarmas buxgalteriya yozilgan.

- [ ] **16. Liga boshlanishi va lobbini qulflash (League start and lobby locking)**
  - [ ] Faqat League Owner boshlay olishi, `validate_league_activation` triggeri va lobbi sozlamalarini muzlatish bajarilgan.

- [ ] **17. Uy va mehmon o'yinlari ro'yxatini yaratish (Home-and-away fixture generation)**
  - [ ] 38 tur, 380 o'yinli taqvim generatsiyasi va `standings` tiebreakerlar o'rnatilgan.

- [ ] **18. Tarkib va qaydnoma boshqaruvi (Squad and lineup management)**
  - [ ] Asosiy 11 ta, zaxiradagilar, kapitan va standartlarni tanlash hamda avtomatik eng kuchli tarkib mantiqi yozilgan.

- [ ] **19. Formatsiyalar va taktik sozlamalar (Formations and tactical settings)**
  - [ ] 6 ta formatsiya va `tactical_settings` parametr sozlamalari amalga oshirilgan.

- [ ] **20. Asosiy o'yin simulyatori (Basic match engine)**
  - [ ] Deterministik random seed va ehtimollik ko me'rsatkichlariga ega bo'lgan o'yin simulyatori sinovdan o'tkazilgan.

- [ ] **21. Kengaytirilgan o'yin hodisalari (Advanced match events)**
  - [ ] Gollar, kartochkalar, jarohatlar va almashtirishlar `match_events` jadvalida yozilishi ta'minlangan.

- [ ] **22. Turnir jadvali va statistikasi (Standings and statistics)**
  - [ ] Jadval, to me'purarlar, assistentlar va klub statistikasi avtomatik yangilanishi sozlangan.

- [ ] **23. Avtomatlashtirilgan turlar (Automated rounds)**
  - [ ] Supabase Cron, idempotent `round_processing_locks` mexanizmi o me'rnatilgan.

- [ ] **24. O'yin bildirishnomalari (Match notifications)**
  - [ ] Har bir odam menejerga shaxsiy chatda O'zbekcha o'yin hisoboti yuborilishi va `notification_queue` navbati yo'lga qo me'yilgan.

- [ ] **25. Boshqaruvchisiz klublar transferi (Unmanaged-club transfers)**
  - [ ] Bo'sh klublardan 100% bozor narxida sotib olish va `trg_validate_transfer_anti_drain` triggeri bilan 8 ta anti-drain cheklovlari implementatsiya qilingan.

- [ ] **26. Menejerlar o'rtasidagi transferlar (Manager-to-manager transfers)**
  - [ ] Kamida 50% taklif narxi, `reserved_funds` jadvalida muzlatilgan pul balansi, atomar transfer va `transfer_offer_history` yozilishi yozilgan.

- [ ] **27. Transfer oynalari va eslatmalar (Transfer windows and reminders)**
  - [ ] `transfer_window_states` bo me'yicha 1-6 va 17-24 turlarda oynalarni ochish/yopish va O'zbekcha eslatmalar yuborish joriy qilingan.

- [ ] **28. Mavsumni yakunlash (Season completion)**
  - [ ] Chempionni taqdirlash (`season_championships`), statistikani `season_histories` jadvalida muzlatish va ligani yakunlash mantig'i tayyorlangan.

- [ ] **29. Owner admin paneli (Owner admin panel)**
  - [ ] Tizim egasi uchun `admin_users` va `admin_audit_logs` bilan ishlaydigan protected veb-dashboard va sozlamalar paneli yaratilgan.

- [ ] **30. Xavfsizlik va audit loglari (Security and audit logs)**
  - [ ] Immutable audit loglar va webhook/cron sirlarini tekshirish yo'lga qo'yilgan.

- [ ] **31. Avtomatlashtirilgan testlar (Automated tests)**
  - [ ] Match Engine, transferlar va baza kodi uchun Unit va Integration testlar yozilgan.

- [ ] **32. Yopiq beta test (Closed beta testing)**
  - [ ] Beta foydalanuvchilar bilan barcha ssenariylar sinovdan o'tkazilgan.

- [ ] **33. Production nashri (Production release)**
  - [ ] Loyiha asosiy serverga joylashtirilib, ommaga taqdim etilgan.
