# Telegram Football Manager - Master Specification (MASTER_SPEC.md)

> **YAGONA HAQIQAT MANBAI (SINGLE SOURCE OF TRUTH)**
> Ushbu hujjat **Telegram Football Manager** loyihasining yagona va to'liq mahsulot spesifikatsiyasi hisoblanadi. Loyihadagi barcha funksionallar, o'yin mexanikalari, texnik va biznes mantiqlar faqat ushbu hujjatga bo'ysunadi.

---

## 1. Loyiha Haqida Umumiy Ma'lumot (Product Overview)

**Telegram Football Manager** — Telegram shaxsiy chatida (private chat) o'ynaladigan ko'p foydalanuvchili onlayn futbol menejeri o'yini.

- **Boshlang'ich O'yin Rejimi:** "Gigants Mode" (Evropaning eng kuchli 20 ta top-klubi).
- **O'yinchilar Turi:** Menejerlar shaxsiy chatda bot orqali liga yaratadilar yoki taklif kodi orqali qo'shiladilar, klub tanlaydilar, tarkib va taktikani boshqaradilar, transferlarni amalga oshiradilar hamda avtomatlashtirilgan o'yin simulyatsiyalarida qatnashadilar.
- **Telegram Rejimi:** Bot faqat shaxsiy chatda (private chat) ishlaydi. Botni Telegram guruhlariga qo'shish yoki guruh admin huquqlarini berish talab etilmaydi.
- **O'yin Simulyatsiya Mantiqi:** O'yin jarayoni va simulyatsiyasi to'liq **dasturlangan o'yin mantiqi (programmed game logic)** bo'yicha ishlaydi. Jonli o'yin jarayonida hech qanday sun'iy intellekt (AI) modeliga tayanilmaydi.

### Texnologik Stek (Tech Stack)

- **Language & Runtime:** TypeScript, Node.js
- **Bot Framework:** grammY
- **Database:** Supabase PostgreSQL
- **Scheduler / Cron:** Supabase Cron
- **Deployment / Webhooks:** Vercel Functions
- **Version Control:** GitHub
- **Development Environment:** Google Antigravity

---

## 2. Til va Mahalliylashtirish Standartlari (Language Standard)

- **Interfeys Tili:** Telegram botning barcha foydalanuvchi interfeysi matnlari **to'liq O'zbek tilida** bo'lishi shart.
  - Buyruqlar, inline/keyboard tugmalar, menyu yorliqlari, validatsiya xabarlari, liga ma'lumotlari, transfer bildirishnomalari, eslatmalar, o'yin hisobotlari, turnir jadvallari, statistika va barcha xatolik matnlari O'zbek tilida yoziladi.
- **Kod va Baza Standartlari:** Kod identifikatorlari, ma'lumotlar bazasi jadvallari, ustun nomlari va fayl nomlari **Ingliz tilida** qoladi.
- **Markazlashtirilgan Matnlar:** Barcha foydalanuvchiga ko'rsatiladigan O'zbekcha matnlar markazlashtirilgan matnlar omborida (localization dictionary) saqlanadi, shunda kelajakda boshqa tillarni qo'shish imkoniyati saqlanib qoladi.

---

## 3. Menejerlarni Ro'yxatdan O'tkazish (Manager Registration)

1. Foydalanuvchi Telegram chatida `/start` buyrug'ini bosganda:
   - Bot foydalanuvchini qutlaydi.
   - Bot menejer ismini (laqabini) kiritishni so me'raydi.
   - Foydalanuvchi menejer ismini kiritadi.
   - Ism uzunligi **3–24 ta belgi** orasida bo'lishi va validatsiyadan o'tishi kerak.
   - Telegram User ID orqali menejer profili yaratiladi.
   - Qayta `/start` bosilishi takroriy profillar yaratmasligi shart.
2. Ro'yxatdan o'tgach, **Asosiy Menyu (Main Menu)** ochiladi:
   - 🏆 Liga yaratish
   - 🔑 Ligaga qo‘shilish
   - 🏟 Mening ligalarim
   - 👤 Manager profilim
   - 📖 O‘yin qoidalari
3. **Liga Cheklovi:** Bir menejer bir vaqtning o'zida ko'pi bilan **2 ta faol ligada** (active leagues) ishtirok etishi mumkin.
   - Kutilayotgan (waiting/lobby) va faol (active) ligalar ushbu 2 ta cheklovga kiradi.
   - Yakunlangan (completed) ligalar ushbu cheklovga kirmaydi.

---

## 4. Liga Yaratish va Noyob Liga Kodlari (League Creation & Unique Code)

### 4.1. Liga Yaratish (League Creation)

Menejer yangi xususiy liga yaratishi mumkin. Yaratuvchi quyidagilarni kiritadi:

- Liga nomi (League name);
- O'yin rejimi (Game mode - dastlab faqat Gigants Mode);
- Tur tezligi (Round speed).

**Tur Tezligi Variantlari (Round Speed Options):**

- Kuniga 1 tur (1 round per day);
- Kuniga 2 tur (2 rounds per day);
- Kuniga 3 tur (3 rounds per day);
- Kuniga 4 tur (4 rounds per day).

League Owner liga boshlanishidan oldin tur tezligini o'zgartirishi mumkin. Liga boshlangandan so'ng tur tezligi to'liq muzlatiladi (permanently locked).

### 4.2. Noyob Liga Kodi (Unique League Code)

Har bir liga avtomatik ravishda noyob **6 belgidan iborat taklif kodi (invitation code)** oladi.

- Faqat bosh harflar (A-Z) va raqamlar (0-9) ishlatiladi.
- Chalg'ituvchi belgilar o'chiriladi: `O`, `0`, `I`, `L`, `1`.
- Ma'lumotlar bazasi darajasida unique constraint o'rnatiladi.
- Bitta kod hechnarsa evaziga ikkinchi marta berilmaydi.
- O'chirilgan, bekor qilingan yoki yakunlangan ligalar kodlari qayta ishlatilmaydi.
- Barcha yaratilgan kodlarning doimiy reestri saqlanadi.

---

## 5. Ligaga Qo'shilish va Gigants Mode Lobbi (Joining & Lobby)

### 5.1. Ligaga Qo'shilish (Joining a League)

Menejer 6 belgili taklif kodini kiritish orqali ligaga qo'shiladi. Qo'shilishdan oldin tekshiriladi:

1. Liga bazada mavjudligi;
2. Liga hali boshlanmaganligi (`LOBBY` holatidaligi);
3. Liga bekor qilinmaganligi;
4. Menejer ushbu ligaga avval qo'shilmaganligi;
5. Menejerda faol ligalar soni 2 tadan kamligi;
6. Ligada odam menejerlar soni 20 tadan oshmaganligi.

Validatsiya o'tgach, foydalanuvchiga liga ma'lumotlari ko'rsatiladi va tasdiqlash so'raladi.

### 5.2. Gigants Mode va Lobbi

- Har bir Gigants Mode ligasi **har doim roppa-rosa 20 ta klubni** o'z ichiga oladi.
- Odam menejerlarning minimal soni bo'yicha cheklov yo'q (minimal 1 ta odam menejer).
- League Owner hatto o'zi yagona odam menejer bo'lgan taqdirda ham ligani boshlashi mumkin.
- Boshlanish vaqtida tanlanmagan barcha klublar dasturlangan bot-menejerlar (bot managers) boshqaruviga o'tadi.
- Maksimal odam menejerlar soni: 20 ta.

**Lobbi Menyusi Quyidagilarni Ko'rsatishi Shart:**

- Liga nomi;
- Liga egasi (League Owner);
- Taklif kodi (Invitation Code);
- Tur tezligi (Round Speed);
- Odam menejerlar soni;
- Tanlanmagan bo'sh klublar soni;
- Tanlangan klublar va ularning menejerlari;
- Liga holati (Status).

---

## 6. Klub Tanlash va Boshlang'ich 20 Klub (Club Selection & Initial Clubs)

### 6.1. Klub Tanlash Mexanizmi

- Menejerlar mavjud klublarni paginatsiyali Telegram inline tugmalari orqali tanlaydilar.
- Tanlangan klublar bloklanadi, bo'sh klublar tanlanishi mumkin.
- Bir vaqtning o me'zida ikkita menejer bir xil klubni tanlab qo'ymasligi uchun **atomar tranzaksiya (atomic execution)** qo'llaniladi.
- Liga boshlangunga qadar menejerlar klubni almashtirishlari yoki lobbidan chiqib ketishlari mumkin. Lobbidan chiqilganda klub bo'shaydi.
- Liga boshlangandan so'ng klub almashtirish va lobbidan chiqish bloklanadi.

### 6.2. Dastlabki 20 ta Top Klub (Gigants Mode Initial Clubs)

1. Real Madrid
2. Barcelona
3. Atlético Madrid
4. Manchester City
5. Liverpool
6. Arsenal
7. Chelsea
8. Manchester United
9. Tottenham
10. Bayern Munich
11. Borussia Dortmund
12. Bayer Leverkusen
13. Paris Saint-Germain
14. Inter
15. AC Milan
16. Juventus
17. Napoli
18. Benfica
19. Porto
20. Ajax

Klub ma'lumotlari qayta ishlatiladigan global shablonlar (global templates) sifatida saqlanadi. Yangi liga yaratilganda ushbu klublarning ligaga xos nusxalari (league-specific instances) shakllantiriladi.

---

## 7. Liga Boshlanishi va Format (League Start & Format)

### 7.1. Liga Boshlanishi (League Start Process)

- Faqat League Owner ligani boshlash tugmasini bosa oladi.
- Boshlashdan oldin quyidagi ma'lumotlar bilan tasdiqlash oynasi ko'rsatiladi:
  - Odam menejerlar soni;
  - Bot boshqaruvidagi klublar soni;
  - Jami klublar soni (20);
  - Tur tezligi;
  - Boshlangandan so'ng qo'shilish, chiqish, klub almashtirish va tur tezligini o'zgartirish muzlatilishi haqida ogohlantirish.
- **Tasdiqlangandan so'ng:**
  1. Liga holati boshlanish rejimiga o'tadi (`ACTIVE`).
  2. Taklif kodi qulflanadi.
  3. Qo'shilish va chiqish bloklanadi.
  4. Klub almashtirish bloklanadi.
  5. Tur tezligi muzlatiladi.
  6. Tanlanmagan klublarga bot-menejerlar biriktiriladi.
  7. 38 turdan iborat to'liq uy-mehmon taqvimi (home-and-away schedule) generatsiya qilinadi.
  8. Birinchi tur 30 daqiqadan so'ng o'ynalishi avtomatik rejalashtiriladi. (30 daqiqalik tayyorgarlik oynasi League Owner tasdiqlaganidan so'ng boshlanadi).

### 7.2. Liga Formati (League Format)

- Aylanma tizim (Home-and-away round-robin format).
- 20 klub -> har bir klub 38 ta o'yin o'ynaydi.
- Jami 38 tur, har bir turda 10 ta o'yin -> Mavsumda jami **380 ta o'yin**.
- **Turnir Jadvali Natijalarini Aniqlash Ketma-ketligi (Standings Tiebreakers):**
  1. Toplangan ochkolar (Points);
  2. Gollar nisbati (Goal difference);
  3. Urilgan gollar soni (Goals scored);
  4. O me'zaro o'yinlar natijasi (Head-to-head result);
  5. Jami g'alabalar soni (Total wins);
  6. Yakuniy aniqlangan qo'shimcha tay-breyker ko me'rsatkichi.

### 7.3. Ligani Bekor Qilish va Tugatish (League Termination Rules)

- Liga boshlanishidan oldin League Owner 2 ta aniq tasdiqlash bosqichidan o'tib ligani o'chirib yuborishi mumkin.
- **Liga boshlangandan so'ng:**
  - League Owner ligani o'chira olmaydi yoki bekor qila olmaydi;
  - League Owner natijalarni o me'chira olmaydi;
  - Liga boshqa menejerlar uchun davom etishi shart;
  - Faqat tizim egasi (System Owner) himoyalangan Admin Panel orqali texnik favqulodda holatdagina ligani to'xtatishi yoki bekor qilishi mumkin;
  - Har bir ma'muriy amal sababi ko'rsatilgan holda audit logga yoziladi.
- Yakunlangan liganing tarixi va statistikasi bazada doimiy saqlanadi.

---

## 8. Futbolchilar Bazasi va Atributlar (Player Database & Attributes)

### 8.1. Klub Tarkibi va Pozitsiyalar

Har bir klub tarkibida:

- **Minimal 18 ta, maksimal 25 ta futbolchi** bo'ladi.
- **Minimal pozitsiya guruhlari:**
  - 2 ta darvozabon (GK);
  - 6 ta himoyachi (DEF);
  - 6 ta yarim himoyachi (MID);
  - 4 ta hujumchi (FWD).
- **Qo'llab-quvvatlanadigan Aniq Pozitsiyalar:**
  - `GK`, `LB`, `RB`, `CB`, `CDM`, `CM`, `CAM`, `LM`, `RM`, `LW`, `RW`, `ST`.
- Futbolchi 1 ta asosiy pozitsiyaga (primary position) va ixtiyoriy ikkinchi darajali pozitsiyalarga (secondary positions) ega bo'lishi mumkin.
  - Asosiy pozitsiyada o'ynash: 100% samaradorlik.
  - Ikkinchi darajali pozitsiyada o'ynash: kichik jarima (small penalty).
  - Umuman aloqasiz pozitsiyada o'ynash: katta jarima (larger penalty).

### 8.2. Futbolchi Profil Atributlari

Har bir futbolchi quyidagi ma'lumotlarga ega:

- Ismi, yoshi, fuqaroligi;
- Asosiy va ikkinchi darajali pozitsiyalari;
- Bozor qiymati (`market_value`), umumiy reytingi (`overall_rating`);
- Individual atributlar, formasi (1–10), jismoniy holati/fitnes (0–100), jarohat va diskvalifikatsiya holati, mavsumiy statistikasi.

**Maydon Futbolchilari Atributlari (Outfield Attributes):**

- `pace` (tezlik), `shooting` (zarba), `passing` (uzatma), `dribbling` (dribling), `defending` (himoya), `physical` (jismoniy kuch).

**Darvozabon Atributlari (Goalkeeper Attributes):**

- `reflexes` (reflekslar), `handling` (to'pni ushlash), `positioning` (pozitsiya tanlash), `aerial_ability` (havodagi o'yin), `distribution` (to'pni o me'yinga kiritish), `one_on_one` (birga-bir o'yin).

### 8.3. Futbolchilar Unikalligi va Muzlatilgan Qiymatlar

- Global futbolchilar shablon sifatida saqlanadi va har bir ligaga nusxalanadi.
- Bitta liga ichida futbolchi faqat 1 ta klubga tegishli bo'lishi mumkin. Transferlar futbolchi nusxasini ko'paytirmaydi, faqat uning klubga egalik huquqini (`club_id`) o me'zgartiradi.
- Futbolchining bozor qiymati va reytingi liga yaratilgan paytda muzlatiladi (frozen) va mavsum davomida o me'zgarmaydi. Admin tomonidan global shablonlarga kiritilgan o me'garishlar faqat keyin yaratiladigan ligalarga ta'sir qiladi.

---

## 9. Klublar Balansi va Moliyaviy Modellashtirish (Club Finances)

Kuchli va kuchsiz klublar teng boshlang'ich transfer byudjetiga ega bo'lmasligi kerak. Quyidagi tenglashtiruvchi moliyaviy model qo'llaniladi:

$$\text{Boshlang'ich Byudjet} = €100\text{ million} + (\text{Eng yuqori tarkib qiymati} - \text{Joriy klub tarkib qiymati}) \times 35\%$$

- **Maksimal boshlang'ich byudjet:** €400 million.
- Formula kelajakda admin panel orqali sozlanishi mumkin.
- **Kutilayotgan xulq-atvor:** Top-klublar kuchli tarkib va kichikroq byudjet oladi; kuchsizroq klublar katta byudjet oladi, lekin ular birdaniga top-klublarga tenglashib qolmaydi.
- Barcha pul harakatlari **o'zgarmas moliyaviy tranzatsiyalar jurnalida (immutable financial transaction ledger)** qayd etiladi.
- Klub balansi hech qachon salbiy (negative) bo'lishi mumkin emas.
- Yuborilgan transfer takliflari uchun muzlatib qo'yilgan mablag'lar (reserved money) boshqa amallar uchun ishlatilishi taqiqlanadi.

---

## 10. Tarkib va Taktika Boshqaruvi (Squad & Formations)

### 10.1. Tarkibni Boshqarish

Menejerlar quyidagilarni bajarishlari mumkin:

- To'liq tarkibni ko'rish;
- Asosiy 11 ta futbolchini tanlash;
- Zaxira futbolchilarini tanlash;
- Avtomatik eng kuchli tarkibni tanlash (auto best-lineup);
- Kapitan, penalti tepuvchi va jarima zarbasi tepuvchi futbolchilarni belgilash.

Menejer valid tarkibni saqlamagan taqdirda, tizim avtomatik ravishda maydonga tushishi mumkin bo'lgan eng kuchli tarkibni tanlab beradi. Jarohatlangan va diskvalifikatsiya qilingan futbolchilar tarkibga kiritilmaydi.

### 10.2. Formatsiyalar va Taktik Sozlamalar

Dastlabki versiyada **6 ta formatsiya** qo'llab-quvvatlanadi:

1. `4-3-3`
2. `4-2-3-1`
3. `4-4-2`
4. `3-5-2`
5. `3-4-3`
6. `5-3-2`

**Qo'shimcha Taktik Sozlamalar:**

- **Mentality:** defensive, balanced, attacking;
- **Pressing:** low, medium, high;
- **Attacking Direction:** central, wings, mixed;
- **Passing Style:** short, mixed, long;
- **Defensive Line:** low, medium, high;
- **Tempo:** slow, normal, fast.

Hech qanday taktika absolut ustun bo'lishi mumkin emas. Har bir taktik tanlov o'zining kuchli va kuchsiz tomonlariga hamda qarshi taktikasiga (counterplay) ega bo'ladi.

### 10.3. Fitnes va Forma (Fitness & Form)

- Forma (Form): 1 – 10. Fitnes (Fitness): 0 – 100. Ma'naviyat (Morale): 1 – 10.
- **Fitnes Tiklanishi:** Fitnesning tiklanishi real vaqt soatlariga emas, **o'yin turlariga (game rounds)** asoslanadi. Shunday qilib, kuniga 4 tur o me'ynaydigan ligalar kuniga 1 tur o me'ynaydigan ligalarga nisbatan fitnes bo'yicha adolatsiz ustunlikka yoki zarar yetkazilishiga uchramaydi.

---

## 11. O'yin Simulyatori (Match Engine)

Matches to'liq dasturlangan mantiq asosida simulyatsiya qilinadi.

### 11.1. Simulyatsiya Faktorlari

Match Engine quyidagi omillarni hisobga oladi:

- Asosiy tarkib kuchi, darvozabon, himoya, yarim himoya va hujum chiziqlari kuchi;
- Zaxira futbolchilar va almashtirishlar;
- Formatsiya va taktik sozlamalar, taktik to'qnashuv nisbatan ustunligi;
- Futbolchilar formasi, fitnesi, jarohat va diskvalifikatsiyalar;
- Meybonlik ustunligi (Home advantage);
- Nazorat qilinadigan tasodifiylik (Controlled randomness).

### 11.2. Balans va Ehtimollik Maqsadlari (Target Probabilities)

- **Real Madrid va Benfica to'qnashuvi kabi kuchlar nisbati bo'yicha ehtimollik maqsadlari:**
  - Kuchli klub g'alabasi: taxminan 60%;
  - Durang: taxminan 23%;
  - Kuchsiz klub g'alabasi: taxminan 17%.
- **Teng kuchli klublarning mezbonlik o'yini bo'yicha ehtimollik maqsadlari:**
  - Mezbon g'alabasi: taxminan 39%;
  - Durang: taxminan 27%;
  - Mehmon g'alabasi: taxminan 34%.

### 11.3. Deterministik Tasodifiylik Urug'i (Deterministic Random Seed)

Match Engine har bir o'yin uchun deterministik tasodifiylik urug'idan (`deterministic random seed`) foydalanadi. O'yin tasodifan bir necha bor qayta ishlansa ham, **hech qachon boshqacha natija berishi mumkin emas (idempotent execution)**.

---

## 12. O'yin Hodisalari va Hisobotlar (Match Events & Reports)

### 12.1. O'yin Hodisalari (Match Events)

Simulyatsiya yakunida quyidagilar shakllanadi: yakuniy hisob, gol urganlar, assistentlar, gol daqiqalari, zarbalar, aniq zarbalar, to'p nazorati, burchak zarbalari, qo'polliklar, sariq/qizil kartochkalar, jarohatlar, almashtirishlar, futbolchilar ballari va o'yinning eng yaxshi futbolchisi (MOTM).

### 12.2. O'yin Hisobotlari (Match Reports)

Har bir tur yakunida har bir odam menejer shaxsiy Telegram bildirishnomasini (O'zbek tilida) oladi:

- Liga nomi va tur raqami;
- O'z klubi va raqib klub nomi;
- Yakuniy hisob va gol urganlar / assistentlar / daqiqalar;
- Muhim hodisalar, asosiy statistika va MOTM;
- O'yindan keyingi joriy turnir jadvalidagi o'rni va o me'garish.

Bir vaqtning o'zida ikkita ligada qatnashayotgan menejerlar har bir liga bo'yicha to'g'ri identifikatsiyalangan alohida hisobotlarni olishadi. Bildirishnomalar navbat (queue) orqali Telegram rate-limit qoidalariga rioya qilingan holda yuboriladi.

---

## 13. Transfer Tizimi (Transfer System)

### 13.1. Transfer Oynalari (Transfer Windows)

38 turdan iborat mavsumda transfer oynasi jadvali:

- **Ochiq Oynalar:** 1 – 6 turlar va 17 – 24 turlar.
- **Yopiq Oynalar:** 7 – 16 turlar va 25 – 38 turlar.
- 7-tur boshlanishi bilan 1-oyna yopiladi. 16-tur tugashi bilan 2-oyna ochiladi. 25-tur boshlanishi bilan 2-oyna yopiladi. Oyna ochilganda, yopilishiga 1 tur qolganda va yopilganda O'zbekcha eslatmalar yuboriladi.

### 13.2. Menejerlar O'rtasidagi Transferlar (Manager-to-Manager Transfers)

- Minimal taklif narxi: futbolchining muzlatilgan bozor qiymatining **kamida 50%** qismi.
- Qabul qiluvchi menejer: **Accept**, **Reject**, **Counteroffer** (qarshi taklif) bera oladi.
- Taklif holatlari: `pending`, `accepted`, `rejected`, `countered`, `cancelled`, `expired`, `failed`, `completed`.
- Taklif yuborilganda pul summasi muzlatiladi. Taklif bekor bo'lsa pul qaytariladi.
- Transfer bajarilishi **atomar tranzaksiya** hisoblanadi (pul yechiladi -> pul sotuvchiga o'tadi -> futbolchi egasi o me'garadi -> ledger yoziladi -> bildirishnoma yuboriladi).
- Bitta futbolchi bitta transfer oynasi davomida 1 martadan ko'p sotilishi taqiqlanadi. Bozor qiymatining 70% idan past takliflar admin ko'rib chiqishi uchun belgilab qo'yiladi (lekin 50% minimumga javob bersa avtomatik bloklanmaydi).

### 13.3. Boshqaruvchisiz Klublar Transferi (Unmanaged-Club Transfers)

- Liga boshlanishidan oldin bo'sh klublarga yuborilgan takliflar `pending` holatida turadi va pul muzlatiladi.
- **Liga lock bo'lgan paytda:**
  - Agar klubga odam menejer qo'shilgan bo'lsa: pending bot-taklif bekor qilinadi, pul yechimdan chiqariladi va haridorga O'zbekcha bildirishnoma yuboriladi.
  - Agar klub bo'sh (unmanaged) qolgan bo'lsa: taklif o'z kuchida qoladi.
- Bo'sh klublar uchun **minimal taklif narxi bozor qiymatining 100% qismi** hisoblanadi va munosib takliflar avtomatik qabul qilinadi.
- **Anti-Drain (Klublarni bo'shatib qo'ymaslik) Qoidalari:**
  - Bir menejer bitta oynada jami bo me'sh klublardan maksimal 3 ta futbolchi sotib olishi mumkin;
  - Bir menejer bitta oynada bitta bo'sh klubdan maksimal 1 ta futbolchi sotib olishi mumkin;
  - Bitta bo me'sh klub bitta oynada maksimal 3 ta futbolchi sotishi mumkin;
  - Sotuvchi bo'sh klub tarkibida kamida 18 ta futbolchi qolishi shart;
  - Pozitsiyaviy minimal ko'rsatkichlar saqlanishi shart;
  - Sotilgan futbolchi kamida 3 tur davomida qayta sotilishi mumkin emas.

---

## 14. Avtomatlashtirilgan Turlar va Cron (Automatic Rounds & Cron)

Supabase Cron belgilangan turlarni avtomatik qayta ishlaydi:

1. Vaqti kelgan turlarni aniqlash;
2. Qayta ishlash qulfini (`processing lock`) egallash;
3. Har bir kelgan o'yinni faqat 1 marta simulyatsiya qilish;
4. Natijalar, jadval, statistika, fitnes/forma va transfer oynasi holatini yangilash;
5. Navbatdagi turni rejalashtirish;
6. Telegram bildirishnomalarini navbatga qo'yish.

**Idempotentlik:** Qayta ishlash idempotent bo'lishi shart. Duplikat so'rovlar hech qachon takroriy natijalar, gollar yoki moliyaviy o me me'g'garishlar yaratmasligi kerak.

---

## 15. Admin Panel va Xavfsizlik (Admin Panel & Security)

Tizim egasi (System Owner) uchun himoyalangan veb Admin Panel yaratiladi.

- **Boshqaruv Paneli:** Menejerlar, faol/yopiq ligalar, bugungi o'yinlar, cron salomatligi, bildirishnomalar navbati.
- **Menejerlar va Ligalar Boshqaruvi:** Qidirish, bloklash, ligalarni pauza qilish/qayta tiklash, favqulodda bekor qilish.
- **Global Shablonlar:** Klublar, futbolchilar, bozor qiymatlari va reytinglarni yangilash.
- **O'yin Sozlamalari:** Byudjet formulasi, home advantage, taktik ko'rsatkichlar, tur jadvali.
- **Xavfsizlik:** `audit_logs` jadvali orqali barcha ma'muriy amallarni sababi bilan yozib borish, server-side secret kalitlardan foydalanish, `.env.local` sirlari hech qachon hujjatlarda yoki interfeysda ko'rinmasligi.
