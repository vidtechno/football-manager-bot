# Telegram Football Manager Bot ⚽🏆

**Telegram Football Manager** — Telegram shaxsiy chatida (private chat) o'ynaladigan, ko'p foydalanuvchili onlayn futbol menejeri o'yini. Foydalanuvchilar o'z ligalarini yaratishlari, do'stlarini noyob 6 belgili taklif kodi orqali taklif qilishlari, Evropaning top-20 klublarini boshqarishlari, tarkib va taktikani belgilashlari hamda avtomatlashtirilgan o'yin simulyatsiyalarida chempionlik uchun bellashishlari mumkin.

---

## 📚 Loyiha Hujjatlari (Documentation)

Loyihaning to'liq spesifikatsiyasi va arxitekturasi quyidagi hujjatlarda belgilangan:

1. 📖 **[MASTER_SPEC.md](docs/MASTER_SPEC.md)** — Loyihaning yagona haqiqat manbai (**Single Source of Truth**).
2. ✅ **[BUILD_CHECKLIST.md](docs/BUILD_CHECKLIST.md)** — 33 ta bosqichdan iborat ishlab chiqish nazorat ro'yxati.
3. 🏗️ **[ARCHITECTURE.md](docs/ARCHITECTURE.md)** — Tizim arxitekturasi, serverless webhook va idempotentlik sxemasi.
4. 🗄️ **[DATABASE_PLAN.md](docs/DATABASE_PLAN.md)** — Supabase PostgreSQL ma'lumotlar bazasi loyihasi va jadvallar sxemasi.
5. ⚽ **[MATCH_ENGINE_PLAN.md](docs/MATCH_ENGINE_PLAN.md)** — Deterministik o'yin simulyatori va ehtimollik ko'rsatkichlari.
6. 🔄 **[TRANSFER_SYSTEM_PLAN.md](docs/TRANSFER_SYSTEM_PLAN.md)** — Transferlar va anti-drain qoidalari.
7. 🛡️ **[ADMIN_PANEL_PLAN.md](docs/ADMIN_PANEL_PLAN.md)** — Tizim egasi (Owner) protected veb admin paneli rejasi.
8. 📝 **[DECISIONS.md](docs/DECISIONS.md)** — Tasdiqlangan mahsulot va texnik qarorlar jurnali.

---

## 🛠️ Texnologik Stek (Tech Stack)

- **Language / Runtime:** TypeScript, Node.js (>=20.0.0)
- **Bot Framework:** grammY
- **Database & RLS:** Supabase (PostgreSQL)
- **Scheduler:** Supabase Cron
- **Deployment & Webhooks:** Vercel Functions
- **Testing & Tooling:** Vitest, ESLint, Prettier, tsx

---

## 🚀 Poydevor Buyruqlari (Foundation Commands)

Loyiha poydevori ishga tushirilgan. Quyidagi buyruqlar orqali kod va testlarni boshqarish mumkin:

```bash
# Mahalliy TypeScript kirish nuqtasini ishga tushirish (watch mode)
npm run dev

# Loyihani dist/ papkasiga kompilatsiya qilish
npm run build

# TypeScript tiplarini tekshirish (without emitting output)
npm run typecheck

# Vitest unit testlarini ishga tushirish
npm run test

# ESLint orqali linter tekshiruvini o'tkazish
npm run lint

# Prettier bilan kod formatini tekshirish va to'g'rilash
npm run format
npm run format:check
```

---

## 📌 Asosiy Ishlash Qoidalari (Working Rules)

- `MASTER_SPEC.md` loyihaning yagona haqiqat manbai hisoblanadi.
- Har bir yangi vazifani boshlashdan oldin `MASTER_SPEC.md`, `BUILD_CHECKLIST.md` va `DECISIONS.md` o'qib chiqiladi.
- Faqat so'ralgan va navbatdagi bosqich ustida ishlanadi.
- Hech qanday bosqich test qilinib tasdiqlanmasdan keyingisiga o'tilmaydi.
- Interfeys matnlari O'zbek tilida, texnik nomlar va kodlar Ingliz tilida saqlanadi.
