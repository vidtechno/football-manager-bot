import crypto from 'crypto';
import jwt from 'jsonwebtoken';

export interface TelegramUserData {
  id: number;
  first_name?: string;
  last_name?: string;
  username?: string;
  language_code?: string;
}

export interface VerifiedAuthPayload {
  telegramUserId: number;
  username?: string | undefined;
  firstName?: string | undefined;
  authDate: number;
}

export interface AppJwtPayload {
  telegramUserId: number;
  managerId: string;
  username?: string;
  isAdmin: boolean;
  iat?: number;
  exp?: number;
}

/**
 * Verifies Telegram Mini App initData using HMAC-SHA256 signature, timing-safe comparison,
 * and 24-hour auth_date expiration limit.
 */
export function verifyTelegramInitData(
  initData: string,
  botToken: string,
  maxAgeSeconds = 86400, // 24 hours
): VerifiedAuthPayload | null {
  try {
    const params = new URLSearchParams(initData);
    const hash = params.get('hash');
    if (!hash) return null;

    params.delete('hash');

    const dataCheckArr: string[] = [];
    params.forEach((value, key) => {
      dataCheckArr.push(`${key}=${value}`);
    });
    dataCheckArr.sort();
    const dataCheckString = dataCheckArr.join('\n');

    const secretKey = crypto
      .createHmac('sha256', 'WebAppData')
      .update(botToken)
      .digest();

    const calculatedHash = crypto
      .createHmac('sha256', secretKey)
      .update(dataCheckString)
      .digest('hex');

    // Timing-safe signature comparison
    const calculatedBuf = Buffer.from(calculatedHash.toLowerCase());
    const hashBuf = Buffer.from(hash.toLowerCase());

    if (
      calculatedBuf.length !== hashBuf.length ||
      !crypto.timingSafeEqual(calculatedBuf, hashBuf)
    ) {
      return null;
    }

    const authDate = Number(params.get('auth_date') || 0);
    const nowSeconds = Math.floor(Date.now() / 1000);

    // Reject expired or future auth_date
    if (
      !authDate ||
      nowSeconds - authDate > maxAgeSeconds ||
      authDate > nowSeconds + 60
    ) {
      return null;
    }

    const userRaw = params.get('user');
    let userObj: TelegramUserData | null = null;
    if (userRaw) {
      userObj = JSON.parse(userRaw);
    }

    const telegramUserId = userObj?.id || Number(params.get('user_id'));
    if (!telegramUserId) return null;

    return {
      telegramUserId,
      username: userObj?.username || params.get('username') || undefined,
      firstName: userObj?.first_name || undefined,
      authDate,
    };
  } catch {
    return null;
  }
}

export function generateAppToken(
  payload: AppJwtPayload,
  jwtSecret: string,
): string {
  return jwt.sign(payload, jwtSecret, { expiresIn: '24h' });
}

export function verifyAppToken(
  token: string,
  jwtSecret: string,
): AppJwtPayload | null {
  try {
    return jwt.verify(token, jwtSecret) as AppJwtPayload;
  } catch {
    return null;
  }
}
