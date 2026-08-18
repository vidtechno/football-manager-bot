# Telegram Football Manager - Transfer Tizimi Rejasi (TRANSFER_SYSTEM_PLAN.md)

Ushbu hujjat **Telegram Football Manager** o'yinidagi transfer oynalari, menejerlar o me'rtasidagi hamda boshqaruvchisiz klublar bilan transfer amallari mantiqini belgilaydi.

---

## 1. Transfer Oynalari Jadvali (Transfer Windows)

38 turdan iborat mavsum davomida transfer oynalari `transfer_window_states` jadvali orqali boshqariladi:

- **1-Transfer Oynasi (Ochiq):** 1-turdan 6-turgacha. (7-tur boshlanishi bilan yopiladi).
- **1-Yopiq Davr:** 7-turdan 16-turgacha.
- **2-Transfer Oynasi (Ochiq):** 17-turdan 24-turgacha. (16-tur tugagach ochiladi, 25-tur boshlanishi bilan yopiladi).
- **2-Yopiq Davr:** 25-turdan 38-turgacha.

**Telegram Eslatmalari:** Transfer oynasi ochilganda, yopilishiga 1 tur qolganda hamda yopilgan paytda barcha menejerlarga shaxsiy chatda O'zbek tilida bildirishnoma yuboriladi.

---

## 2. Menejerlar O'rtasidagi Transferlar (Manager-to-Manager Transfers)

1. **Taklif Yuborish:** Haridor menejer futbolchining muzlatilgan bozor qiymatining (`frozen_market_value`) **kamida 50%** qismidan boshlab taklif kiritishi mumkin.
2. **Pullarni Muzlatish (`reserved_funds` & `financial_ledger`):** Taklif yuborilgach, taklif qilingan summa `reserved_funds` jadvalida saqlanadi va klubning `reserved_balance` ustuniga qo'shiladi. Ushbu pul boshqa amallar uchun ishlatilishi taqiqlanadi.
3. **Qarshi Takliflar va Muzokaralar Tarixi (`transfer_offer_history`):**
   - Sotuvchi taklifni qabul qilishi (`ACCEPT`), rad etishi (`REJECT`) yoki qarshi narx taklif qilishi (`COUNTER`) mumkin.
   - Original taklif ustiga urib yozilmaydi; har bir qarshi taklif `transfer_offer_history` jadvalida saqlanadi.
4. **Taklif Holatlari (`enum_transfer_offer_status`):**
   - `PENDING`, `ACCEPTED`, `REJECTED`, `COUNTERED`, `CANCELLED`, `EXPIRED`, `FAILED`, `COMPLETED`.
5. **Atomar Bajarilish (Atomic Execution):**
   - Haridor balansidan pul yechiladi -> Sotuvchi balansiga o'tkaziladi -> `reserved_funds` o me me me'chirilib pul yechimdan chiqariladi -> Futbolchi `club_id`si yangilanadi -> `player_transfer_history` va `financial_ledger` yoziladi -> Ikkala menejerga O'zbekcha xabar yuboriladi.
6. **Cheklovlar:**
   - Bitta futbolchi bitta transfer oynasi davomida 1 martadan ko'p sotilishi taqiqlanadi (`last_transferred_round` orqali tekshiriladi).
   - Bozor qiymatining 70% idan past takliflar admin ko me'rib chiqishi uchun belgilab qo'yiladi (`is_suspicious_flag`).

---

## 3. Boshqaruvchisiz Klublar Transferi va Anti-Drain Qoidalari (Unmanaged-Club Transfers)

### 3.1. Liga Boshlanishidan Oldingi Takliflar

- Liga lobbi holatidaligi paytida bo'sh klublarga yuborilgan takliflar `PENDING` holatida turadi va pul muzlatiladi. Futbolchi darhol ko'chib o me'tmaydi.
- **Liga lock bo'lganda:**
  - Agar klubga odam menejer kelib qo'shilgan bo'lsa: bot-taklif bekor qilinadi, muzlatilgan pul yechiladi va haridorga O'zbekcha bildirishnoma yuboriladi.
  - Agar klub bo'sh (unmanaged) bo'lib qolgan bo'lsa: taklif o'z kuchida qoladi va 1-tur boshlanishidan oldin ko'rib chiqiladi.

### 3.2. Boshqaruvchisiz Klublar Qoidalari va Anti-Drain Triggers

- Bo'sh klublar uchun minimal taklif narxi **bozor qiymatining 100% qismi** hisoblanadi.
- Talabga javob beradigan takliflar avtomatik qabul qilinadi.
- **Qat'iy Anti-Drain Trigger Cheklovlari (Database Level):**
  1. Bir menejer bitta oynada jami bo'sh klublardan maksimal **3 ta futbolchi** sotib olishi mumkin;
  2. Bir menejer bitta oynada bitta bo'sh klubdan maksimal **1 ta futbolchi** sotib olishi mumkin;
  3. Bitta bo me'sh klub bitta oynada maksimal **3 ta futbolchi** sotishi mumkin;
  4. Sotuvchi bo'sh klub tarkibida **kamida 18 ta futbolchi** qolishi shart (`trg_validate_transfer_anti_drain`);
  5. Pozitsiyaviy minimal ko me'rsatkichlar saqlanishi shart (2 GK, 6 DEF, 6 MID, 4 FWD);
  6. Ushbu pozitsiya guruhidagi oxirgi majburiy futbolchilar sotilishi taqiqlanadi;
  7. Sotib olingan futbolchi kamida 3 tur davomida qayta sotilishi mumkin emas.
