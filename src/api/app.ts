import express, { Request, Response, NextFunction } from 'express';
import cors from 'cors';
import helmet from 'helmet';
import rateLimit from 'express-rate-limit';
import cookieParser from 'cookie-parser';
import path from 'path';
import fs from 'fs';
import { z } from 'zod';
import { loadEnvironment } from '../config/env.js';
import { getSupabaseAdminClient } from '../database/client.js';
import { IdentityService } from '../services/identityService.js';
import { LeagueService } from '../services/leagueService.js';
import { TransferService } from '../services/transferService.js';
import { PurchaseService } from '../services/purchaseService.js';
import { SponsorService } from '../services/sponsorService.js';
import { AuthService } from '../services/authService.js';
import {
  verifyTelegramInitData,
  generateAppToken,
  verifyAppToken,
  AppJwtPayload,
} from './telegramAuth.js';

export const app = express();

// Enable Railway Reverse Proxy IP Trust
app.set('trust proxy', 1);

const env = loadEnvironment();
const JWT_SECRET =
  env.WEB_JWT_SECRET ||
  env.TELEGRAM_WEBHOOK_SECRET ||
  'fm_jwt_fallback_secret_2026';
const IS_PROD = process.env['NODE_ENV'] === 'production';
const REFRESH_COOKIE_NAME = 'fm_refresh_token';
const CSRF_COOKIE_NAME = '_csrf';

// Security Headers
app.use(
  helmet({
    contentSecurityPolicy: false,
  }),
);

// Strict CORS
const allowedOrigins = [
  env.WEB_APP_URL || 'http://localhost:3000',
  'http://localhost:3001',
];
app.use(
  cors({
    origin: (origin, callback) => {
      if (!origin || !IS_PROD || allowedOrigins.includes(origin)) {
        callback(null, true);
      } else {
        callback(new Error('CORS_BLOCKED: Origin not allowed'));
      }
    },
    credentials: true,
  }),
);

app.use(cookieParser());
app.use(express.json({ limit: '100kb' }));

// Rate Limiters
const apiLimiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 100,
  message: { error: 'TOO_MANY_REQUESTS: API rate limit exceeded' },
});

const authLimiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 10,
  message: { error: 'TOO_MANY_REQUESTS: Auth login rate limit exceeded' },
});

const registerLimiter = rateLimit({
  windowMs: 60 * 60 * 1000,
  max: 5,
  message: {
    error:
      'TOO_MANY_REQUESTS: Ro‘yxatdan o‘tish limiti oshdi. Birozdan so‘ng urinib ko‘ring.',
  },
});

app.use('/api/', apiLimiter);

// Extend Express Request type
export interface AuthRequest extends Request {
  user?: AppJwtPayload;
}

// Helper to set HttpOnly Session Cookie & Anti-CSRF Cookie
function setAuthCookies(
  res: Response,
  refreshToken: string,
  csrfToken: string,
  isRememberMe: boolean,
) {
  const maxAgeMs = isRememberMe
    ? 30 * 24 * 60 * 60 * 1000
    : 24 * 60 * 60 * 1000;
  res.cookie(REFRESH_COOKIE_NAME, refreshToken, {
    httpOnly: true,
    secure: IS_PROD,
    sameSite: 'lax',
    path: '/',
    maxAge: maxAgeMs,
  });
  res.cookie(CSRF_COOKIE_NAME, csrfToken, {
    httpOnly: false,
    secure: IS_PROD,
    sameSite: 'lax',
    path: '/',
    maxAge: maxAgeMs,
  });
}

function clearAuthCookies(res: Response) {
  const options = {
    httpOnly: true,
    secure: IS_PROD,
    sameSite: 'lax' as const,
    path: '/',
  };
  res.clearCookie(REFRESH_COOKIE_NAME, options);
  res.clearCookie(CSRF_COOKIE_NAME, { ...options, httpOnly: false });
}

// CSRF Middleware Protection for Mutation Endpoints (POST/PUT/DELETE)
export function requireCsrfToken(
  req: Request,
  res: Response,
  next: NextFunction,
): void {
  if (['GET', 'HEAD', 'OPTIONS'].includes(req.method)) {
    next();
    return;
  }

  const fullPath = req.originalUrl || req.path;
  if (fullPath.includes('/auth/login') || fullPath.includes('/auth/register')) {
    next();
    return;
  }

  const cookieCsrf = req.cookies?.[CSRF_COOKIE_NAME];
  const headerCsrf = req.headers['x-csrf-token'];

  if (!cookieCsrf || !headerCsrf) {
    res
      .status(403)
      .json({ error: 'CSRF_TOKEN_MISSING: Missing anti-CSRF token' });
    return;
  }

  if (cookieCsrf !== headerCsrf) {
    res
      .status(403)
      .json({ error: 'CSRF_TOKEN_INVALID: Anti-CSRF token mismatch' });
    return;
  }

  next();
}

app.use('/api', requireCsrfToken);

// Authentication Middleware (Supports Header or In-Memory Access Token)
export async function authenticateToken(
  req: AuthRequest,
  res: Response,
  next: NextFunction,
): Promise<void> {
  const authHeader = req.headers['authorization'];
  const token =
    authHeader && authHeader.startsWith('Bearer ')
      ? authHeader.split(' ')[1]
      : null;

  if (!token) {
    res
      .status(401)
      .json({ error: 'UNAUTHORIZED: Authorization token missing' });
    return;
  }

  const payload = verifyAppToken(token, JWT_SECRET);
  if (!payload) {
    res.status(403).json({ error: 'FORBIDDEN: Invalid or expired token' });
    return;
  }

  req.user = payload;
  next();
}

// Database-backed Admin Guard Middleware
export async function requireAdmin(
  req: AuthRequest,
  res: Response,
  next: NextFunction,
): Promise<void> {
  if (!req.user) {
    res
      .status(401)
      .json({ error: 'UNAUTHORIZED: Authentication token missing' });
    return;
  }

  const isAdmin = await IdentityService.isManagerAdmin(
    req.user.managerId,
    req.user.telegramUserId,
  );

  if (!isAdmin) {
    res
      .status(403)
      .json({ error: 'FORBIDDEN: Bu bo‘limga kirish huquqingiz yo‘q' });
    return;
  }

  next();
}

// Health Endpoints
app.get('/health', (_req: Request, res: Response) => {
  res.json({ status: 'OK', timestamp: new Date().toISOString() });
});

app.get('/api/health', (_req: Request, res: Response) => {
  res.json({ status: 'OK', timestamp: new Date().toISOString() });
});

// 1. REGISTRATION ENDPOINT (Transactional Atomic PL/pgSQL RPC)
app.post(
  '/api/auth/register',
  registerLimiter,
  async (req: Request, res: Response): Promise<void> => {
    try {
      const schema = z.object({
        username: z.string().min(4).max(24),
        managerName: z.string().min(2).max(40),
        password: z.string().min(8).max(72),
        confirmPassword: z.string().min(8).max(72),
      });

      const parsed = schema.parse(req.body);
      if (parsed.password !== parsed.confirmPassword) {
        res
          .status(400)
          .json({ error: 'Kiritilgan parollar bir-biriga mos kelmadi.' });
        return;
      }

      const { managerId, username, managerName } =
        await AuthService.registerManagerWithCredentials({
          username: parsed.username,
          managerName: parsed.managerName,
          password: parsed.password,
        });

      const isAdmin = await IdentityService.isManagerAdmin(managerId, 0);

      const token = generateAppToken(
        {
          telegramUserId: 0,
          managerId,
          username,
          isAdmin,
        },
        JWT_SECRET,
      );

      const session = await AuthService.createAuthSession(
        managerId,
        false,
        req.headers['user-agent'],
        req.ip,
      );

      setAuthCookies(res, session.refreshToken, session.csrfToken, false);

      res.json({
        token,
        csrfToken: session.csrfToken,
        manager: {
          id: managerId,
          username,
          managerName,
          isAdmin,
        },
      });
    } catch (err: any) {
      res
        .status(400)
        .json({ error: err.message || 'Ro‘yxatdan o‘tishda xatolik.' });
    }
  },
);

// 2. LOGIN ENDPOINT (Username/Password or Telegram InitData)
app.post(
  '/api/auth/login',
  authLimiter,
  async (req: Request, res: Response): Promise<void> => {
    try {
      const bodySchema = z.object({
        username: z.string().optional(),
        password: z.string().optional(),
        rememberMe: z.boolean().optional().default(false),
        initData: z.string().optional(),
        telegramUserId: z.number().optional(),
        displayName: z.string().optional(),
      });

      const parsed = bodySchema.parse(req.body);

      // Case A: Telegram Mini App InitData Login
      if (parsed.initData) {
        const verified = verifyTelegramInitData(
          parsed.initData,
          env.TELEGRAM_BOT_TOKEN,
        );
        if (!verified) {
          res.status(401).json({
            error:
              'INVALID_TELEGRAM_INIT_DATA: Signature verification failed or expired',
          });
          return;
        }
        const manager = await IdentityService.getOrCreateManager(
          verified.telegramUserId,
          verified.firstName,
        );
        const isAdmin = await IdentityService.isManagerAdmin(
          manager.id,
          verified.telegramUserId,
        );

        const token = generateAppToken(
          {
            telegramUserId: manager.telegramUserId,
            managerId: manager.id,
            username: manager.managerName,
            isAdmin,
          },
          JWT_SECRET,
        );

        const session = await AuthService.createAuthSession(
          manager.id,
          parsed.rememberMe,
          req.headers['user-agent'],
          req.ip,
        );
        setAuthCookies(
          res,
          session.refreshToken,
          session.csrfToken,
          parsed.rememberMe,
        );

        res.json({
          token,
          csrfToken: session.csrfToken,
          manager: {
            id: manager.id,
            username: manager.managerName,
            managerName: manager.managerName,
            isAdmin,
          },
        });
        return;
      }

      // Case B: Direct Telegram User ID Login strictly blocked in production
      if (parsed.telegramUserId && !parsed.username) {
        const allowDev = env.ALLOW_DEV_AUTH === 'true' && !IS_PROD;
        if (!allowDev) {
          res.status(403).json({
            error:
              'DEV_AUTH_DISABLED: Direct Telegram ID login is disabled in production',
          });
          return;
        }
        const manager = await IdentityService.getOrCreateManager(
          parsed.telegramUserId,
          parsed.displayName,
        );
        const isAdmin = await IdentityService.isManagerAdmin(
          manager.id,
          parsed.telegramUserId,
        );

        const token = generateAppToken(
          {
            telegramUserId: manager.telegramUserId,
            managerId: manager.id,
            username: manager.managerName,
            isAdmin,
          },
          JWT_SECRET,
        );
        res.json({
          token,
          manager: {
            id: manager.id,
            username: manager.managerName,
            managerName: manager.managerName,
            isAdmin,
          },
        });
        return;
      }

      // Case C: Standard Username & Password Login
      if (!parsed.username || !parsed.password) {
        res.status(400).json({ error: 'Username yoki parol noto‘g‘ri.' });
        return;
      }

      const { managerId, username, displayName } =
        await AuthService.loginManagerWithCredentials(
          parsed.username,
          parsed.password,
        );

      const supabase = getSupabaseAdminClient();
      const { data: mgr } = await supabase
        .from('managers')
        .select('telegram_user_id')
        .eq('id', managerId)
        .single();
      const isAdmin = await IdentityService.isManagerAdmin(
        managerId,
        Number(mgr?.telegram_user_id || 0),
      );

      const token = generateAppToken(
        {
          telegramUserId: Number(mgr?.telegram_user_id || 0),
          managerId,
          username,
          isAdmin,
        },
        JWT_SECRET,
      );

      const session = await AuthService.createAuthSession(
        managerId,
        parsed.rememberMe,
        req.headers['user-agent'],
        req.ip,
      );

      setAuthCookies(
        res,
        session.refreshToken,
        session.csrfToken,
        parsed.rememberMe,
      );

      res.json({
        token,
        csrfToken: session.csrfToken,
        manager: { id: managerId, username, managerName: displayName, isAdmin },
      });
    } catch {
      res.status(401).json({ error: 'Username yoki parol noto‘g‘ri.' });
    }
  },
);

// 3. REFRESH SESSION ENDPOINT
app.post(
  '/api/auth/refresh',
  async (req: Request, res: Response): Promise<void> => {
    try {
      const rawRefreshToken = req.cookies?.[REFRESH_COOKIE_NAME];
      if (!rawRefreshToken) {
        res
          .status(401)
          .json({ error: 'UNAUTHORIZED: Refresh session cookie missing' });
        return;
      }

      const newSession =
        await AuthService.verifyAndRotateSession(rawRefreshToken);
      setAuthCookies(
        res,
        newSession.refreshToken,
        newSession.csrfToken,
        newSession.isRememberMe,
      );

      const supabase = getSupabaseAdminClient();
      const { data: mgr } = await supabase
        .from('managers')
        .select('*')
        .eq('id', newSession.managerId)
        .single();
      const isAdmin = await IdentityService.isManagerAdmin(
        newSession.managerId,
        Number(mgr?.telegram_user_id || 0),
      );

      const token = generateAppToken(
        {
          telegramUserId: Number(mgr?.telegram_user_id || 0),
          managerId: mgr.id,
          username: mgr.manager_name,
          isAdmin,
        },
        JWT_SECRET,
      );

      res.json({ token, csrfToken: newSession.csrfToken });
    } catch (err: any) {
      clearAuthCookies(res);
      res.status(401).json({ error: err.message || 'INVALID_REFRESH_SESSION' });
    }
  },
);

// 4. LOGOUT ENDPOINT
app.post(
  '/api/auth/logout',
  async (req: Request, res: Response): Promise<void> => {
    try {
      const rawRefreshToken = req.cookies?.[REFRESH_COOKIE_NAME];
      if (rawRefreshToken) {
        await AuthService.revokeSession(rawRefreshToken);
      }
      clearAuthCookies(res);
      res.json({ success: true, message: 'Muvaffaqiyatli chiqildi' });
    } catch {
      clearAuthCookies(res);
      res.json({ success: true });
    }
  },
);

// 5. LOGOUT ALL DEVICES ENDPOINT
app.post(
  '/api/auth/logout-all',
  authenticateToken,
  async (req: AuthRequest, res: Response): Promise<void> => {
    try {
      await AuthService.revokeAllManagerSessions(req.user!.managerId);
      clearAuthCookies(res);
      res.json({ success: true, message: 'Barcha qurilmalardan chiqildi' });
    } catch (err: any) {
      res.status(500).json({ error: err.message });
    }
  },
);

// 6. GET CURRENT USER PROFILE ENDPOINT
app.get(
  '/api/auth/me',
  authenticateToken,
  async (req: AuthRequest, res: Response): Promise<void> => {
    try {
      const supabase = getSupabaseAdminClient();
      const managerId = req.user!.managerId;

      const { data: mgr } = await supabase
        .from('managers')
        .select('*')
        .eq('id', managerId)
        .single();
      const { data: cred } = await supabase
        .from('manager_credentials')
        .select('username')
        .eq('manager_id', managerId)
        .maybeSingle();
      const isAdmin = await IdentityService.isManagerAdmin(
        managerId,
        Number(mgr?.telegram_user_id || 0),
      );

      res.json({
        managerId,
        username: cred?.username || mgr?.manager_name || 'menejer',
        managerName: mgr?.manager_name || 'Menejer',
        telegramUserId: Number(mgr?.telegram_user_id || 0),
        isTelegramLinked: Number(mgr?.telegram_user_id || 0) > 0,
        isAdmin,
        csrfToken: req.cookies?.[CSRF_COOKIE_NAME] || '',
      });
    } catch {
      res.status(500).json({ error: 'SERVER_ERROR' });
    }
  },
);

// 7. LINK TELEGRAM ACCOUNT ENDPOINT
app.post(
  '/api/auth/link-telegram',
  authenticateToken,
  async (req: AuthRequest, res: Response): Promise<void> => {
    try {
      const schema = z.object({ initData: z.string() });
      const parsed = schema.parse(req.body);

      const verified = verifyTelegramInitData(
        parsed.initData,
        env.TELEGRAM_BOT_TOKEN,
      );
      if (!verified) {
        res.status(400).json({
          error: 'INVALID_TELEGRAM_INIT_DATA: Signature verification failed',
        });
        return;
      }

      await AuthService.linkTelegramAccount(
        req.user!.managerId,
        verified.telegramUserId,
      );
      res.json({
        success: true,
        message: 'Telegram akkaunti muvaffaqiyatli ulandi!',
      });
    } catch (err: any) {
      res.status(400).json({ error: err.message || 'LINK_TELEGRAM_FAILED' });
    }
  },
);

// 8. SET CREDENTIALS FOR TELEGRAM MANAGER ENDPOINT
app.post(
  '/api/auth/set-credentials',
  authenticateToken,
  async (req: AuthRequest, res: Response): Promise<void> => {
    try {
      const schema = z.object({
        username: z.string().min(4).max(24),
        password: z.string().min(8).max(72),
      });
      const parsed = schema.parse(req.body);

      await AuthService.setCredentialsForManager(
        req.user!.managerId,
        parsed.username,
        parsed.password,
      );
      res.json({
        success: true,
        message: 'Username va parol muvaffaqiyatli o‘rnatildi!',
      });
    } catch (err: any) {
      res.status(400).json({ error: err.message || 'SET_CREDENTIALS_FAILED' });
    }
  },
);

// 9. CHANGE PASSWORD ENDPOINT
app.post(
  '/api/auth/change-password',
  authenticateToken,
  async (req: AuthRequest, res: Response): Promise<void> => {
    try {
      const schema = z.object({
        oldPassword: z.string(),
        newPassword: z.string().min(8).max(72),
        confirmPassword: z.string().min(8).max(72),
      });
      const parsed = schema.parse(req.body);

      if (parsed.newPassword !== parsed.confirmPassword) {
        res
          .status(400)
          .json({ error: 'Yangi parollar bir-biriga mos kelmadi.' });
        return;
      }

      await AuthService.changePassword(
        req.user!.managerId,
        parsed.oldPassword,
        parsed.newPassword,
      );
      res.json({
        success: true,
        message:
          'Parol muvaffaqiyatli o‘zgartirildi va boshqa qurilmalar o‘chirildi.',
      });
    } catch (err: any) {
      res.status(400).json({ error: err.message || 'CHANGE_PASSWORD_FAILED' });
    }
  },
);

// Existing Game Endpoints remain active
app.get(
  '/api/dashboard',
  authenticateToken,
  async (req: AuthRequest, res: Response): Promise<void> => {
    try {
      const supabase = getSupabaseAdminClient();
      const managerId = req.user!.managerId;

      const { data: clubRaw } = await supabase
        .from('league_clubs')
        .select('*, leagues(*), club_templates(*)')
        .eq('human_manager_id', managerId)
        .maybeSingle();

      const clubRow = clubRaw as any;

      if (!clubRow) {
        const { data: gigantsLeague } = await supabase
          .from('leagues')
          .select('*')
          .eq('mode', 'GIGANTRY')
          .maybeSingle();
        res.json({
          managerName: req.user!.username,
          activeLeague: gigantsLeague
            ? {
                id: gigantsLeague.id,
                name: gigantsLeague.name,
                mode: gigantsLeague.mode,
                invitationCode: gigantsLeague.invitation_code,
                currentRound: gigantsLeague.current_round || 1,
              }
            : null,
          club: null,
          squadCount: 0,
          recentLedger: [],
        });
        return;
      }

      const { count: squadCount } = await supabase
        .from('league_players')
        .select('*', { count: 'exact', head: true })
        .eq('league_club_id', clubRow.id);
      const incomeHistory = await SponsorService.getClubIncomeHistory(
        clubRow.id,
        5,
      );

      res.json({
        managerName: req.user!.username,
        activeLeague: {
          id: clubRow.leagues.id,
          name: clubRow.leagues.name,
          mode: clubRow.leagues.mode,
          invitationCode: clubRow.leagues.invitation_code,
          currentRound: clubRow.leagues.current_round || 1,
        },
        club: {
          id: clubRow.id,
          name: clubRow.display_name,
          slug: clubRow.club_templates?.slug || 'club',
          balanceEur: Number(clubRow.transfer_budget_eur),
          stadiumCapacity: clubRow.stadium_capacity || 60000,
        },
        squadCount: squadCount || 0,
        recentLedger: incomeHistory.items,
      });
    } catch {
      res.status(500).json({ error: 'SERVER_ERROR' });
    }
  },
);

app.get(
  '/api/league',
  authenticateToken,
  async (req: AuthRequest, res: Response): Promise<void> => {
    try {
      const supabase = getSupabaseAdminClient();
      const managerId = req.user!.managerId;

      const { data: clubRaw } = await supabase
        .from('league_clubs')
        .select('league_id, leagues(*)')
        .eq('human_manager_id', managerId)
        .maybeSingle();
      const clubRow = clubRaw as any;
      let leagueId = clubRow?.league_id;

      if (!leagueId) {
        const { data: defaultLeague } = await supabase
          .from('leagues')
          .select('*')
          .eq('mode', 'GIGANTRY')
          .single();
        leagueId = defaultLeague.id;
      }

      const { data: clubsRaw } = await supabase
        .from('league_clubs')
        .select('*, club_templates(*)')
        .eq('league_id', leagueId)
        .order('points', { ascending: false })
        .order('goal_difference', { ascending: false });
      const clubs = (clubsRaw || []) as any[];
      const standings = clubs.map((c, index) => ({
        position: index + 1,
        clubName: c.display_name,
        shortCode:
          c.club_templates?.short_code ||
          c.display_name.slice(0, 3).toUpperCase(),
        played: c.matches_played || 0,
        won: c.matches_won || 0,
        drawn: c.matches_drawn || 0,
        lost: c.matches_lost || 0,
        goalsFor: c.goals_for || 0,
        goalsAgainst: c.goals_against || 0,
        goalDifference: c.goal_difference || 0,
        points: c.points || 0,
      }));

      const todayCutoff = new Date();
      todayCutoff.setHours(0, 0, 0, 0);
      const { count: dailyRoundsUsed } = await supabase
        .from('league_round_settlements')
        .select('*', { count: 'exact', head: true })
        .eq('league_id', leagueId)
        .gte('completed_at', todayCutoff.toISOString());

      res.json({
        leagueId,
        leagueName: clubRow?.leagues?.name || 'Gigants Liga 2026',
        leagueMode: clubRow?.leagues?.mode || 'GIGANTRY',
        invitationCode: clubRow?.leagues?.invitation_code || 'GIG2026',
        currentRound: clubRow?.leagues?.current_round || 1,
        dailyRoundsUsed: dailyRoundsUsed || 0,
        maxDailyRounds: 3,
        standings,
      });
    } catch {
      res.status(500).json({ error: 'SERVER_ERROR' });
    }
  },
);

app.post(
  '/api/league/create',
  authenticateToken,
  async (req: AuthRequest, res: Response): Promise<void> => {
    try {
      const schema = z.object({
        name: z.string().min(3).max(50),
        mode: z.enum(['GIGANTRY', 'SOLO']).default('SOLO'),
      });
      const parsed = schema.parse(req.body);
      const supabase = getSupabaseAdminClient();
      const { data, error } = await supabase.rpc('create_league_with_owner', {
        p_name: parsed.name,
        p_mode: parsed.mode,
        p_owner_user_id: req.user!.managerId,
      });
      if (error) {
        res.status(400).json({ error: error.message });
        return;
      }
      res.json({
        success: true,
        leagueId: data.league_id,
        invitationCode: data.invitation_code,
      });
    } catch {
      res.status(400).json({ error: 'INVALID_INPUT' });
    }
  },
);

app.post(
  '/api/league/join',
  authenticateToken,
  async (req: AuthRequest, res: Response): Promise<void> => {
    try {
      const schema = z.object({ code: z.string().length(6) });
      const parsed = schema.parse(req.body);
      const supabase = getSupabaseAdminClient();
      const { data, error } = await supabase.rpc('join_league_by_code', {
        p_invitation_code: parsed.code.toUpperCase(),
        p_user_id: req.user!.managerId,
      });
      if (error) {
        res.status(400).json({ error: error.message });
        return;
      }
      res.json({ success: true, leagueId: data.league_id });
    } catch {
      res.status(400).json({ error: 'INVALID_CODE' });
    }
  },
);

app.post(
  '/api/league/delete-solo',
  authenticateToken,
  async (req: AuthRequest, res: Response): Promise<void> => {
    try {
      const schema = z.object({ leagueId: z.string().uuid() });
      const parsed = schema.parse(req.body);
      const result = await LeagueService.deleteSoloLeague(
        parsed.leagueId,
        req.user!.managerId,
      );
      res.json(result);
    } catch (err: any) {
      res
        .status(400)
        .json({ error: err.message || 'DELETE_SOLO_LEAGUE_FAILED' });
    }
  },
);

app.post(
  '/api/league/execute-round',
  authenticateToken,
  async (req: AuthRequest, res: Response): Promise<void> => {
    try {
      const schema = z.object({ leagueId: z.string().uuid() });
      const parsed = schema.parse(req.body);
      const result = await LeagueService.executeLeagueRound(parsed.leagueId);
      res.json(result);
    } catch (err: any) {
      res.status(400).json({ error: err.message || 'EXECUTE_ROUND_FAILED' });
    }
  },
);

app.get(
  '/api/squad',
  authenticateToken,
  async (req: AuthRequest, res: Response): Promise<void> => {
    try {
      const supabase = getSupabaseAdminClient();
      const managerId = req.user!.managerId;
      const { data: clubRow } = await supabase
        .from('league_clubs')
        .select('*')
        .eq('human_manager_id', managerId)
        .single();
      if (!clubRow) {
        res.status(404).json({ error: 'CLUB_NOT_FOUND' });
        return;
      }
      const { data: players } = await supabase
        .from('league_players')
        .select('*')
        .eq('league_club_id', clubRow.id)
        .order('overall_rating', { ascending: false });
      const squad = (players || []).map((p, idx) => ({
        id: p.id,
        fullName: p.full_name,
        primaryPosition: p.primary_position || 'CM',
        overallRating: p.overall_rating,
        marketValueEur: Number(p.market_value_eur),
        nationality: p.nationality,
        isStarting: idx < 11,
        attributes: {
          pace: p.pace || 75,
          shooting: p.shooting || 70,
          passing: p.passing || 75,
          dribbling: p.dribbling || 75,
          defending: p.defending || 65,
          physical: p.physical || 70,
        },
      }));
      res.json({ clubId: clubRow.id, clubName: clubRow.display_name, squad });
    } catch {
      res.status(500).json({ error: 'SERVER_ERROR' });
    }
  },
);

app.get(
  '/api/transfers/listings',
  authenticateToken,
  async (req: AuthRequest, res: Response): Promise<void> => {
    try {
      const supabase = getSupabaseAdminClient();
      const managerId = req.user!.managerId;
      const { data: clubRow } = await supabase
        .from('league_clubs')
        .select('league_id')
        .eq('human_manager_id', managerId)
        .maybeSingle();
      if (!clubRow) {
        res.json({ listings: [], totalPages: 1, page: 1 });
        return;
      }
      const options: Parameters<typeof TransferService.getActiveListings>[1] =
        {};
      if (req.query['position'] && req.query['position'] !== 'ALL')
        options.position = req.query['position'] as string;
      if (req.query['maxPrice'])
        options.maxPrice = Number(req.query['maxPrice']);
      if (req.query['page']) options.page = Number(req.query['page']);
      const result = await TransferService.getActiveListings(
        clubRow.league_id,
        options,
      );
      res.json(result);
    } catch {
      res.status(500).json({ error: 'SERVER_ERROR' });
    }
  },
);

app.post(
  '/api/transfers/create',
  authenticateToken,
  async (req: AuthRequest, res: Response): Promise<void> => {
    try {
      const schema = z.object({
        leaguePlayerId: z.string().uuid(),
        askingPriceEur: z.number().positive(),
      });
      const parsed = schema.parse(req.body);
      const result = await TransferService.createListing(
        parsed.leaguePlayerId,
        parsed.askingPriceEur,
        req.user!.managerId,
      );
      res.json(result);
    } catch (err: any) {
      res.status(400).json({ error: err.message || 'CREATE_LISTING_FAILED' });
    }
  },
);

app.post(
  '/api/transfers/buy',
  authenticateToken,
  async (req: AuthRequest, res: Response): Promise<void> => {
    try {
      const schema = z.object({
        listingId: z.string().uuid(),
        buyerClubId: z.string().uuid(),
      });
      const parsed = schema.parse(req.body);
      const result = await TransferService.purchaseListing(
        parsed.listingId,
        parsed.buyerClubId,
        req.user!.managerId,
      );
      res.json(result);
    } catch (err: any) {
      res.status(400).json({ error: err.message || 'PURCHASE_LISTING_FAILED' });
    }
  },
);

app.get(
  '/api/legends',
  authenticateToken,
  async (_req: AuthRequest, res: Response): Promise<void> => {
    try {
      const supabase = getSupabaseAdminClient();
      const { data: legends } = await supabase
        .from('legend_templates')
        .select('*')
        .order('overall_rating', { ascending: false });
      const items = (legends || []).map((l) => ({
        id: l.id,
        fullName: l.full_name,
        era: l.peak_era_display || 'Legendary Era',
        primaryPosition: l.primary_position || 'ST',
        overallRating: l.overall_rating,
        priceEur: Number(l.price_eur || 300_000_000),
        nationality: l.nationality,
        attributes: {
          pace: l.pace || 85,
          shooting: l.shooting || 85,
          passing: l.passing || 85,
          dribbling: l.dribbling || 85,
          defending: l.defending || 60,
          physical: l.physical || 80,
        },
      }));
      res.json({ legends: items });
    } catch {
      res.status(500).json({ error: 'SERVER_ERROR' });
    }
  },
);

app.get(
  '/api/finances/packages',
  authenticateToken,
  (_req: AuthRequest, res: Response) => {
    res.json({ packages: PurchaseService.getActivePackages() });
  },
);

app.post(
  '/api/finances/request-package',
  authenticateToken,
  async (req: AuthRequest, res: Response): Promise<void> => {
    try {
      const schema = z.object({
        leagueId: z.string().uuid(),
        leagueClubId: z.string().uuid(),
        packageId: z.string(),
      });
      const parsed = schema.parse(req.body);
      const pkg = PurchaseService.getPackageById(parsed.packageId);
      if (!pkg) {
        res.status(404).json({ error: 'PACKAGE_NOT_FOUND' });
        return;
      }
      const order = await PurchaseService.createPurchaseRequest({
        telegramUserId: req.user!.telegramUserId,
        leagueId: parsed.leagueId,
        leagueClubId: parsed.leagueClubId,
        pkg,
      });
      res.json(order);
    } catch (err: any) {
      res
        .status(400)
        .json({ error: err.message || 'CREATE_PURCHASE_REQUEST_FAILED' });
    }
  },
);

app.get(
  '/api/admin/orders',
  authenticateToken,
  requireAdmin,
  async (_req: AuthRequest, res: Response): Promise<void> => {
    try {
      const orders = await PurchaseService.getPendingOrders();
      res.json({ orders });
    } catch {
      res.status(500).json({ error: 'SERVER_ERROR' });
    }
  },
);

app.post(
  '/api/admin/approve-order',
  authenticateToken,
  requireAdmin,
  async (req: AuthRequest, res: Response): Promise<void> => {
    try {
      const schema = z.object({ requestId: z.string().uuid() });
      const parsed = schema.parse(req.body);
      const result = await PurchaseService.approvePurchaseRequest(
        parsed.requestId,
        req.user!.managerId,
      );
      res.json(result);
    } catch (err: any) {
      res.status(400).json({ error: err.message || 'APPROVE_ORDER_FAILED' });
    }
  },
);

app.post(
  '/api/admin/reject-order',
  authenticateToken,
  requireAdmin,
  async (req: AuthRequest, res: Response): Promise<void> => {
    try {
      const schema = z.object({ requestId: z.string().uuid() });
      const parsed = schema.parse(req.body);
      await PurchaseService.rejectPurchaseRequest(
        parsed.requestId,
        req.user!.managerId,
      );
      res.json({ success: true });
    } catch (err: any) {
      res.status(400).json({ error: err.message || 'REJECT_ORDER_FAILED' });
    }
  },
);

// API 404 Guard Handler
app.use('/api', (_req: Request, res: Response) => {
  res.status(404).json({ error: 'API_ENDPOINT_NOT_FOUND' });
});

// Serve compiled Vite static dist directory in Production Mode & handle SPA fallback
const distPath = path.resolve(process.cwd(), 'dist');
if (fs.existsSync(distPath)) {
  app.use(express.static(distPath));
  app.use((req: Request, res: Response, next: NextFunction) => {
    if (req.method === 'GET' && !req.path.startsWith('/api')) {
      res.sendFile(path.join(distPath, 'index.html'));
    } else {
      next();
    }
  });
}

// Global Centralized Error Handler
app.use((err: any, _req: Request, res: Response, _next: NextFunction) => {
  const status = err.status || 500;
  res.status(status).json({
    error: err.message && status < 500 ? err.message : 'SERVER_INTERNAL_ERROR',
  });
});
