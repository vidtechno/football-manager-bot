# Telegram Football Manager - Admin Panel Rejasi (ADMIN_PANEL_PLAN.md)

Ushbu hujjat **Owner Admin Panel** (Tizim egasi veb-boshqaruv paneli) arxitekturasi va funksionalligini belgilaydi.

---

## 1. Huquqlar va Xavfsizlik (Security & Roles)

- **Admin Identity (`admin_users`):** Admin panelga faqat `admin_users` jadvalida ro'yxatga olingan va `enum_admin_role` huquqiga ega foydalanuvchilar protected autentifikatsiya orqali kira oladi.
- **No Secrets in Interface:** Maxfiy kalitlar (`SUPABASE_SECRET_KEY`, `BOT_TOKEN`, `.env.local` qiymatlari) interfeysda ko'rsatib bo me'lmaydi.
- **Immutable Audit Logs (`admin_audit_logs`):** Admin tomonidan bajarilgan har bir ma'muriy amal majburiy sabab (`reason`) va o me'zgargan ob'ekt ma me me me'lumoti bilan `admin_audit_logs` jadvaliga yoziladi.
- **Destructive Operation Confirmations:** Ligani to'xtatish yoki foydalanuvchini ban qilish kabi kritik harakatlar 2 bosqichli tasdiqlashni talab qiladi.

---

## 2. Admin Panel Sahifalari va Funksiyalari (Admin Sections)

### 2.1. Dashboard (Asosiy Boshqaruv Sahifasi)

- Jami menejerlar va yangi ro'yxatdan o'tganlar (`managers`);
- Kutilayotgan, faol va yakunlangan ligalar soni (`leagues`);
- Bugungi o'yinlar statistikasi va muvaffaqiyatsiz bo'lgan o'yinlar (`system_error_logs`);
- Bildirishnomalar navbati (`notification_queue`) holati;
- Cron va webhook salomatligi (`scheduled_jobs`).

### 2.2. Managers (Menejerlar Boshqaruvi)

- Telegram ID yoki menejer ismi bo'yicha qidiruv;
- Menejerning faol ligalari va o'yinlar tarixini ko'rish;
- Menejerni bloklash (`manager_blocks`) va blokdan chiqarish;
- Shubhali harakatlar va transferlarni (`is_suspicious_flag`) inspektsiya qilish.

### 2.3. Leagues (Ligalar Boshqaruvi)

- Taklif kodi yoki liga nomi bo'yicha qidiruv;
- Liga menejerlari, klublari, turnir jadvali va taqvimni ko me'rish;
- Transfer oynalari holatini ko me'rish;
- Ligani vaqtincha to'xtatish (`PAUSE`) va qayta tiklash (`RESUME`);
- Muvaffaqiyatsiz texnik topshiriqlarni qayta ishga tushirish (`scheduled_jobs`);
- Faqat texnik favqulodda holatdagina majburiy sabab ko'rsatib ligani bekor qilish (`admin_audit_logs` yozuvi bilan).

### 2.4. Global Shablonlar Boshqaruvi (Global Templates & Versions)

- Global klub shablonlarini tahrirlash (`club_templates`, `club_template_versions`);
- Global futbolchilar shablonlarini tahrirlash (`player_templates`, `player_template_positions`, `player_template_versions`);
- Bozor qiymatlari (`base_market_value`) va reytinglarni yangilash (faqat kelajakda yaratiladigan ligalar uchun);
- Pozitsiyalar va tarkib guruhlarini boshqarish;
- Yangi shablon versiyalarini nashr etish (`version` ustuni).

### 2.5. Game Configuration (O'yin Sozlamalari)

- Boshlang'ich byudjet formulasi ko'rsatkichlari (Gap multiplier % va h.k.);
- Maksimal boshlang'ich byudjet (€400m);
- Mezbonlik ustunligi (Home advantage ko me'rsatkichi);
- Taktik koeffitsientlar va o me'yin tasodifiylik chegaralari;
- Tur jadvali va transfer oynalari turlari;
- Faol ligalar cheklovi (2 ta);
- Birinchi tur tayyorgarlik taymeri (30 daqiqa);
- Bot-menejer sozlamalari.

### 2.6. Messaging va System Loglar

- Tizim xabarnomalarini yuborish;
- System Error Loglarni ko me'rish (`system_error_logs`);
- Admin audit loglarini ko me me'rish (`admin_audit_logs`).
