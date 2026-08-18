# Telegram Football Manager - Match Engine Rejasi (MATCH_ENGINE_PLAN.md)

Ushbu hujjat **Match Engine** (O'yin simulyatori) arxitekturasi, deterministik simulyatsiya algoritmlari hamda ehtimollik ko'rsatkichlarini belgilaydi.

---

## 1. Umumiy Tamoyillar (Core Principles)

- **Programmed Game Logic:** Match Engine to'liq dasturlangan o me'yin mantiqiga asoslanadi. Jonli o o'yin davomida hech qanday sun'iy intellekt (AI) modelidan foydalanilmaydi.
- **Deterministik Random Seed:** Har bir o'yin uchun `deterministic random seed` generatsiya qilinadi. Bir xil o o'yin bir necha bor qayta simulyatsiya qilinsa ham, natija mutlaqo o o'zgarmasdan bir xil chiqadi (Idempotent execution).
- **Bosqichma-bosqichlik:** Dastlab tayanch simulyator (Basic Match Engine: hisob va to'purarlar) yaratiladi va test qilinadi. Shundang so'ng kengaytirilgan o o'yin hodisalari (Advanced Match Events) qo'shiladi.

---

## 2. Kiruvchi Omillar (Simulation Inputs)

Match Engine simulyatsiyasida quyidagi parametrlar ishtirok etadi:

1. **Chiziqlar Kuchi (Lineup Strength):**
   - Asosiy 11 ta futbolchining atributlari asosida hisoblangan Hujum ($ATT$), Yarim himoya ($MID$), Himoya ($DEF$) va Darvozabon ($GK$) reytinglari.
2. **Formatsiya va Taktik Sozlamalar:**
   - Formatsiyalar (`4-3-3`, `4-2-3-1`, `4-4-2`, `3-5-2`, `3-4-3`, `5-3-2`).
   - Taktik uslublar (Mentality, Pressing, Attacking Direction, Passing Style, Defensive Line, Tempo).
   - Taktik ustunlik (Tactical matchup & counterplay).
3. **Futbolchi Holati:**
   - Forma (Form: 1-10), Fitnes (Fitness: 0-100), Ma'naviyat (Morale: 1-10).
   - Jarohat va diskvalifikatsiya holatlari.
4. **Mezbonlik Ustunligi (Home Advantage):**
   - Mezbon jamoaning chiziqlar kuchiga beriladigan kichik ijobiy ko me'rsatkich.
5. **Nazorat Qilinadigan Tasodifiylik (Controlled Randomness):**
   - Futbol omili va kutilmagan ssenariylarni ta'minlaydigan deterministik ko me'rsatkich.

---

## 3. Ehtimollik Maqsadlari (Target Probabilities)

Match Engine aniq natijalarni hardcode qilmaydi, balki ko'p sonli simulyatsiyalarda quyidagi balans va ehtimollik ko me'rsatkichlarini ta'minlash uchun sozlanadi:

### 3.1. Kuchli va Kuchsiz Klub To'qnashuvi (Real Madrid vs Benfica Rejimi)

- Kuchli klub g'alabasi: **taxminan 60%**
- Durang: **taxminan 23%**
- Kuchsiz klub g'alabasi: **taxminan 17%**
  _(Kuchsiz klubda har doim mantiqiy sensatsiya / upset yaratish imkoniyati saqlanib qoladi)._

### 3.2. Teng Kuchli Klublarning Mezbonlik O'yini (Equal Strength Matchup)

- Mezbon g'alabasi: **taxminan 39%**
- Durang: **taxminan 27%**
- Mehmon g'alabasi: **taxminan 34%**

---

## 4. O'yin Hodisalari va Chiquvchi Ma'lumotlar (Events & Outputs)

Match Engine simulyatsiyadan so'ng quyidagi ma'lumotlarni generatsiya qiladi:

1. **Yakuniy Hisob:** `home_score` va `away_score`.
2. **O'yin Statistikalari:**
   - Zarbalar (Shots) va Aniq zarbalar (Shots on target);
   - To'pga egalik qilish foizi (Possession %);
   - Burchak zarbalari (Corners) va Qo'polliklar (Fouls).
3. **Hodisalar Ro'yxati (`match_events`):**
   - Gol urganlar, assistentlar va gol daqiqalari;
   - Sariq va qizil kartochkalar;
   - Jarohatlar va almashtirishlar.
4. **Futbolchilar Bahosi va MOTM:**
   - Har bir futbolchining o o'yindagi balli (Match Rating 1.0 - 10.0) va O'yinning Eng Yaxshi Futbolchisi (Player of the Match).
5. **O'zbekcha Bildirishnoma Payloadi:**
   - Menejerlarga Telegram shaxsiy chatida yuboriladigan yakuniy o'yin hisoboti.
