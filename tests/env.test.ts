import { describe, it, expect, beforeEach } from 'vitest';
import { loadEnvironment, clearEnvCache } from '../src/config/env.js';

describe('Environment Configuration Validation', () => {
  beforeEach(() => {
    clearEnvCache();
  });

  const validMockEnv = {
    SUPABASE_PROJECT_ID: 'mock_project_id',
    SUPABASE_URL: 'https://mockproject.supabase.co',
    SUPABASE_ANON_KEY: 'mock_anon_key_secret_string',
    SUPABASE_SECRET_KEY: 'mock_secret_key_secret_string',
    TELEGRAM_BOT_TOKEN: '123456789:ABCdefGHIjklMNOpqrsTUVwxyz_123456',
    TELEGRAM_BOT_USERNAME: 'mock_bot_username',
    TELEGRAM_WEBHOOK_SECRET: 'mock_webhook_secret_value',
    CRON_SECRET: 'mock_cron_secret_value',
  };

  it('1. should pass validation with valid mock environment variables', () => {
    const config = loadEnvironment(validMockEnv);
    expect(config.SUPABASE_PROJECT_ID).toBe('mock_project_id');
    expect(config.SUPABASE_URL).toBe('https://mockproject.supabase.co');
    expect(config.TELEGRAM_BOT_USERNAME).toBe('mock_bot_username');
  });

  it('2. should produce a controlled Uzbek error when a required variable is missing', () => {
    const invalidEnv = { ...validMockEnv };
    delete (invalidEnv as Record<string, string | undefined>)[
      'SUPABASE_PROJECT_ID'
    ];

    expect(() => loadEnvironment(invalidEnv)).toThrowError(
      "Atrof-muhit o'zgaruvchisi yetishmayapti: SUPABASE_PROJECT_ID",
    );
  });

  it('3. should reject invalid Supabase URL', () => {
    const invalidEnv = {
      ...validMockEnv,
      SUPABASE_URL: 'http://not-https-url.com',
    };

    expect(() => loadEnvironment(invalidEnv)).toThrowError(
      "Atrof-muhit o'zgaruvchisi HTTPS URL bo'lishi shart: SUPABASE_URL",
    );
  });

  it('4. should reject Telegram username containing @ symbol', () => {
    const invalidEnv = {
      ...validMockEnv,
      TELEGRAM_BOT_USERNAME: '@invalid_username_with_at',
    };

    expect(() => loadEnvironment(invalidEnv)).toThrowError(
      "Atrof-muhit o'zgaruvchisi '@' belgisini o'z ichiga olmasligi kerak: TELEGRAM_BOT_USERNAME",
    );
  });

  it('5. should ensure no error message contains a secret value', () => {
    const secretValue = 'VERY_SECRET_TOKEN_DO_NOT_EXPOSE';
    const invalidEnv = {
      ...validMockEnv,
      TELEGRAM_BOT_TOKEN: 'invalid_token_format',
      CRON_SECRET: secretValue,
    };

    try {
      loadEnvironment(invalidEnv);
      expect.fail('Should have thrown validation error');
    } catch (err: unknown) {
      const message = (err as Error).message;
      expect(message).not.toContain(secretValue);
      expect(message).not.toContain('invalid_token_format');
      expect(message).toContain('TELEGRAM_BOT_TOKEN');
    }
  });
});
