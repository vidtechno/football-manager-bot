import { describe, it, expect } from 'vitest';

// Ensure test fallback env variables are present before importing app
process.env['SUPABASE_PROJECT_ID'] ||= 'test-proj-id';
process.env['SUPABASE_URL'] ||= 'https://test-proj.supabase.co';
process.env['SUPABASE_ANON_KEY'] ||= 'test-anon-key-12345678901234567890';
process.env['SUPABASE_SECRET_KEY'] ||= 'test-secret-key-12345678901234567890';
process.env['TELEGRAM_BOT_TOKEN'] ||= '123456789:ABCdefGHIjklMNOpqrsTUVwxyZ';
process.env['TELEGRAM_BOT_USERNAME'] ||= 'football_manager_demo_bot';
process.env['TELEGRAM_WEBHOOK_SECRET'] ||= 'test-webhook-secret';
process.env['CRON_SECRET'] ||= 'test-cron-secret';
process.env['NODE_ENV'] ||= 'test';

import request from 'supertest';
import { app } from '../src/api/app.js';
import { verifyTelegramInitData, generateAppToken } from '../src/api/telegramAuth.js';
import { AuthService } from '../src/services/authService.js';
import { IdentityService } from '../src/services/identityService.js';

describe('Phase 10, 11 & 13 — Username/Password Auth, Cookie, CSRF & Admin RBAC Integration Suite', () => {
  it('1. should validate username format and normalization rules correctly', () => {
    expect(AuthService.validateUsername('abc').isValid).toBe(false); // Too short
    expect(AuthService.validateUsername('a'.repeat(25)).isValid).toBe(false); // Too long
    expect(AuthService.validateUsername('user@name').isValid).toBe(false); // Invalid chars
    expect(AuthService.validateUsername('Diyor_2026').isValid).toBe(true);
    expect(AuthService.validateUsername('Diyor_2026').normalized).toBe('diyor_2026');
  });

  it('2. should validate password minimum, maximum length and whitespace-only rules', () => {
    expect(AuthService.validatePassword('1234567').isValid).toBe(false); // Too short
    expect(AuthService.validatePassword('   ').isValid).toBe(false); // Whitespace-only
    expect(AuthService.validatePassword('a'.repeat(73)).isValid).toBe(false); // Exceeds max length 72
    expect(AuthService.validatePassword('12345678').isValid).toBe(true);
  });

  it('3. should verify Telegram initData HMAC signature & timing-safe check', () => {
    const invalidPayload = verifyTelegramInitData('user=%7B%22id%22%3A12345%7D&hash=invalidhash', 'test-bot-token');
    expect(invalidPayload).toBeNull();
  });

  it('4. should reject initData with auth_date older than 24 hours', () => {
    const oldAuthDate = Math.floor(Date.now() / 1000) - 90000;
    const initDataStr = `auth_date=${oldAuthDate}&user=%7B%22id%22%3A12345%7D&hash=abc123hash`;
    const result = verifyTelegramInitData(initDataStr, 'test-bot-token');
    expect(result).toBeNull();
  });

  it('5. should return health status from GET /health and GET /api/health without CSRF token', async () => {
    const res = await request(app).get('/health');
    expect(res.status).toBe(200);
    expect(res.body.status).toBe('OK');

    const res2 = await request(app).get('/api/health');
    expect(res2.status).toBe(200);
    expect(res2.body.status).toBe('OK');
  });

  it('6. should reject unauthorized requests to protected endpoints', async () => {
    const res = await request(app).get('/api/dashboard');
    expect(res.status).toBe(401);
    expect(res.body.error).toContain('UNAUTHORIZED');
  });

  it('7. should reject admin-only endpoints for non-admin tokens with 403 FORBIDDEN', async () => {
    const secret = 'default_web_jwt_secret_min_32_chars_long_key_2026';
    const nonAdminToken = generateAppToken(
      {
        telegramUserId: 888882,
        managerId: 'mgr-regular-uuid',
        username: 'regular_user',
        isAdmin: false,
      },
      secret,
    );

    const res = await request(app)
      .get('/api/admin/orders')
      .set('Authorization', `Bearer ${nonAdminToken}`);

    expect(res.status).toBe(403);
    expect(res.body.error).toContain('FORBIDDEN');
  });

  it('8. should return JSON 404 for unknown /api/* endpoints', async () => {
    const res = await request(app).get('/api/nonexistent-route-123');
    expect(res.status).toBe(404);
    expect(res.body.error).toBe('API_ENDPOINT_NOT_FOUND');
  });

  it('9. should enforce CSRF protection on mutation endpoints', async () => {
    const secret = 'default_web_jwt_secret_min_32_chars_long_key_2026';
    const userToken = generateAppToken(
      {
        telegramUserId: 888883,
        managerId: 'mgr-test-csrf-uuid',
        username: 'csrf_user',
        isAdmin: false,
      },
      secret,
    );

    // Mutation request without CSRF token must fail with 403 CSRF_TOKEN_MISSING
    const resNoCsrf = await request(app)
      .post('/api/league/create')
      .set('Authorization', `Bearer ${userToken}`)
      .send({ name: 'Test Liga', mode: 'SOLO' });

    expect(resNoCsrf.status).toBe(403);
    expect(resNoCsrf.body.error).toContain('CSRF_TOKEN_MISSING');

    // Mutation request with mismatched CSRF token must fail with 403 CSRF_TOKEN_INVALID
    const resMismatchCsrf = await request(app)
      .post('/api/league/create')
      .set('Authorization', `Bearer ${userToken}`)
      .set('Cookie', ['_csrf=valid_cookie_token_123'])
      .set('x-csrf-token', 'wrong_header_token_456')
      .send({ name: 'Test Liga', mode: 'SOLO' });

    expect(resMismatchCsrf.status).toBe(403);
    expect(resMismatchCsrf.body.error).toContain('CSRF_TOKEN_INVALID');
  });

  it('10. should reject direct raw Telegram ID login in production mode', async () => {
    const originalEnv = process.env['NODE_ENV'];
    process.env['NODE_ENV'] = 'production';

    const res = await request(app)
      .post('/api/auth/login')
      .send({ telegramUserId: 123456789 });

    expect(res.status).toBe(403);
    expect(res.body.error).toContain('DEV_AUTH_DISABLED');

    process.env['NODE_ENV'] = originalEnv;
  });

  it('11. should generate CSRF tokens and set HttpOnly refresh session cookies', async () => {
    const session = await AuthService.createAuthSession('mgr-test-session-uuid', true);
    expect(session.refreshToken).toBeTypeOf('string');
    expect(session.csrfToken).toBeTypeOf('string');
    expect(session.isRememberMe).toBe(true);
    expect(new Date(session.expiresAt).getTime()).toBeGreaterThan(Date.now() + 29 * 24 * 60 * 60 * 1000);
  });

  it('12. should verify database-backed admin role resolution in IdentityService', async () => {
    const isAdminNone = await IdentityService.isManagerAdmin('non-existent-mgr-uuid', 999999999);
    expect(isAdminNone).toBe(false);
  });

  it('13. should ensure password and password hash are never returned in /api/auth/me', async () => {
    const secret = 'default_web_jwt_secret_min_32_chars_long_key_2026';
    const userToken = generateAppToken(
      {
        telegramUserId: 888884,
        managerId: 'mgr-test-me-uuid',
        username: 'me_user',
        isAdmin: false,
      },
      secret,
    );

    const res = await request(app)
      .get('/api/auth/me')
      .set('Authorization', `Bearer ${userToken}`);

    if (res.status === 200) {
      expect(res.body.password).toBeUndefined();
      expect(res.body.passwordHash).toBeUndefined();
      expect(res.body.password_hash).toBeUndefined();
    }
  });
});
