export interface TransferBudgetPackage {
  id: string;
  slug: string;
  displayName: string;
  eurAmount: number;
  uzsPrice: number;
  sortOrder: number;
  isActive: boolean;
}

export const DEFAULT_TRANSFER_BUDGET_PACKAGES: TransferBudgetPackage[] = [
  {
    id: 'pkg_10m',
    slug: 'pkg-10m',
    displayName: '€10 million',
    eurAmount: 10_000_000,
    uzsPrice: 5_000,
    sortOrder: 1,
    isActive: true,
  },
  {
    id: 'pkg_50m',
    slug: 'pkg-50m',
    displayName: '€50 million',
    eurAmount: 50_000_000,
    uzsPrice: 20_000,
    sortOrder: 2,
    isActive: true,
  },
  {
    id: 'pkg_100m',
    slug: 'pkg-100m',
    displayName: '€100 million',
    eurAmount: 100_000_000,
    uzsPrice: 35_000,
    sortOrder: 3,
    isActive: true,
  },
  {
    id: 'pkg_250m',
    slug: 'pkg-250m',
    displayName: '€250 million',
    eurAmount: 250_000_000,
    uzsPrice: 75_000,
    sortOrder: 4,
    isActive: true,
  },
  {
    id: 'pkg_500m',
    slug: 'pkg-500m',
    displayName: '€500 million',
    eurAmount: 500_000_000,
    uzsPrice: 125_000,
    sortOrder: 5,
    isActive: true,
  },
];

export const BUDGET_PURCHASE_WARNING_TEXT =
  '⚠️ Muhim: sotib olingan transfer mablag‘i faqat shu ligada va shu klub uchun amal qiladi. Mablag‘ boshqa ligaga yoki boshqa klubga avtomatik ko‘chirilmaydi.';

export const SOLO_LEAGUE_DELETE_WARNING_TEXT =
  '⚠️ Bu amalni ortga qaytarib bo‘lmaydi. Liga va unga tegishli barcha o‘yin ma’lumotlari butunlay o‘chiriladi.';

export const DEFAULT_ADMIN_TELEGRAM_USERNAME = 'diyorbek_anorboyev';
