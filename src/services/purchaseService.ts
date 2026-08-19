import {
  DEFAULT_TRANSFER_BUDGET_PACKAGES,
  TransferBudgetPackage,
} from '../config/packages.js';

export interface PurchaseRequestRecord {
  id: string;
  orderCode: string;
  telegramUserId: number;
  leagueId: string;
  leagueClubId: string;
  leagueName: string;
  clubName: string;
  packageId: string;
  packageDisplay: string;
  requestedEurAmount: number;
  uzsPrice: number;
  status: 'PENDING' | 'APPROVED' | 'REJECTED' | 'CANCELLED';
  createdAt: string;
}

export class PurchaseService {
  /**
   * Returns active purchase packages from canonical configuration/database.
   */
  static getActivePackages(): TransferBudgetPackage[] {
    return DEFAULT_TRANSFER_BUDGET_PACKAGES.filter((p) => p.isActive);
  }

  /**
   * Look up package by ID.
   */
  static getPackageById(packageId: string): TransferBudgetPackage | undefined {
    return DEFAULT_TRANSFER_BUDGET_PACKAGES.find(
      (p) => p.id === packageId && p.isActive,
    );
  }

  /**
   * Helper to format order code.
   */
  static generateOrderCode(): string {
    const hex = Math.random().toString(16).substring(2, 10).toUpperCase();
    return `TBP-${hex}`;
  }
}
