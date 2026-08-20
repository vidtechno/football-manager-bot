import { PurchaseService } from '../../services/purchaseService.js';
import {
  buildPackageListMessage,
  buildOrderConfirmationMessage,
} from '../messages/templates.js';
import {
  buildPackageSelectionKeyboard,
  buildOrderConfirmationKeyboard,
} from '../keyboards/menus.js';

export interface HandlePackageViewParams {
  leagueName: string;
  clubName: string;
  currentBudgetEur: number;
  leagueId: string;
}

export function handlePackageView(params: HandlePackageViewParams) {
  const packages = PurchaseService.getActivePackages();
  const text = buildPackageListMessage(
    params.leagueName,
    params.clubName,
    params.currentBudgetEur,
    packages,
  );
  const keyboard = buildPackageSelectionKeyboard(packages, params.leagueId);

  return { text, keyboard };
}

export interface HandlePackageSelectParams {
  packageId: string;
  leagueId: string;
  leagueName: string;
  clubName: string;
  telegramUserId: number;
  adminUsername?: string | undefined;
  existingOrderCode?: string | undefined;
}

export function handlePackageSelect(params: HandlePackageSelectParams) {
  const pkg = PurchaseService.getPackageById(params.packageId);
  if (!pkg) {
    throw new Error('PACKAGE_NOT_FOUND');
  }

  const orderCode =
    params.existingOrderCode || PurchaseService.generateOrderCode();
  const { text, deepLink } = buildOrderConfirmationMessage({
    leagueName: params.leagueName,
    clubName: params.clubName,
    packageDisplay: pkg.displayName,
    eurAmount: pkg.eurAmount,
    uzsPrice: pkg.uzsPrice,
    orderCode,
    adminUsername: params.adminUsername,
  });

  const keyboard = buildOrderConfirmationKeyboard(deepLink, params.leagueId);

  return { text, keyboard, orderCode, pkg };
}
