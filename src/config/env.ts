import { config } from 'dotenv';
import { z } from 'zod';

const envSchema = z.object({
  SUPABASE_PROJECT_ID: z
    .string({
      message: "Atrof-muhit o'zgaruvchisi yetishmayapti: SUPABASE_PROJECT_ID",
    })
    .min(
      1,
      "Atrof-muhit o'zgaruvchisi bo'sh bo'lishi mumkin emas: SUPABASE_PROJECT_ID",
    ),

  SUPABASE_URL: z
    .string({
      message: "Atrof-muhit o'zgaruvchisi yetishmayapti: SUPABASE_URL",
    })
    .url("Atrof-muhit o'zgaruvchisi noto'g'ri URL formatida: SUPABASE_URL")
    .refine(
      (val) => val.startsWith('https://'),
      "Atrof-muhit o'zgaruvchisi HTTPS URL bo'lishi shart: SUPABASE_URL",
    ),

  SUPABASE_ANON_KEY: z
    .string({
      message: "Atrof-muhit o'zgaruvchisi yetishmayapti: SUPABASE_ANON_KEY",
    })
    .min(
      1,
      "Atrof-muhit o'zgaruvchisi bo'sh bo'lishi mumkin emas: SUPABASE_ANON_KEY",
    ),

  SUPABASE_SECRET_KEY: z
    .string({
      message: "Atrof-muhit o'zgaruvchisi yetishmayapti: SUPABASE_SECRET_KEY",
    })
    .min(
      1,
      "Atrof-muhit o'zgaruvchisi bo'sh bo'lishi mumkin emas: SUPABASE_SECRET_KEY",
    ),

  TELEGRAM_BOT_TOKEN: z
    .string({
      message: "Atrof-muhit o'zgaruvchisi yetishmayapti: TELEGRAM_BOT_TOKEN",
    })
    .min(
      1,
      "Atrof-muhit o'zgaruvchisi bo'sh bo'lishi mumkin emas: TELEGRAM_BOT_TOKEN",
    )
    .regex(
      /^\d+:[A-Za-z0-9_-]+$/,
      "Atrof-muhit o'zgaruvchisi noto'g'ri formatda: TELEGRAM_BOT_TOKEN",
    ),

  TELEGRAM_BOT_USERNAME: z
    .string({
      message: "Atrof-muhit o'zgaruvchisi yetishmayapti: TELEGRAM_BOT_USERNAME",
    })
    .min(
      1,
      "Atrof-muhit o'zgaruvchisi bo'sh bo'lishi mumkin emas: TELEGRAM_BOT_USERNAME",
    )
    .refine(
      (val) => !val.includes('@'),
      "Atrof-muhit o'zgaruvchisi '@' belgisini o'z ichiga olmasligi kerak: TELEGRAM_BOT_USERNAME",
    ),

  TELEGRAM_WEBHOOK_SECRET: z
    .string({
      message:
        "Atrof-muhit o'zgaruvchisi yetishmayapti: TELEGRAM_WEBHOOK_SECRET",
    })
    .min(
      1,
      "Atrof-muhit o'zgaruvchisi bo'sh bo'lishi mumkin emas: TELEGRAM_WEBHOOK_SECRET",
    ),

  CRON_SECRET: z
    .string({
      message: "Atrof-muhit o'zgaruvchisi yetishmayapti: CRON_SECRET",
    })
    .min(
      1,
      "Atrof-muhit o'zgaruvchisi bo'sh bo'lishi mumkin emas: CRON_SECRET",
    ),
});

export type EnvConfig = z.infer<typeof envSchema>;

let cachedEnv: EnvConfig | null = null;

export function loadEnvironment(
  customEnv?: Record<string, string | undefined>,
): EnvConfig {
  if (customEnv) {
    const result = envSchema.safeParse(customEnv);
    if (!result.success) {
      const firstIssue = result.error.issues[0];
      const errorMessage =
        firstIssue?.message ?? 'Atrof-muhit sozlamalarida xatolik yuz berdi.';
      throw new Error(errorMessage);
    }
    return result.data;
  }

  if (cachedEnv) {
    return cachedEnv;
  }

  if (process.env['NODE_ENV'] !== 'production') {
    config({ path: '.env.local' });
  }

  const result = envSchema.safeParse(process.env);
  if (!result.success) {
    const firstIssue = result.error.issues[0];
    const errorMessage =
      firstIssue?.message ?? 'Atrof-muhit sozlamalarida xatolik yuz berdi.';
    throw new Error(errorMessage);
  }

  cachedEnv = result.data;
  return cachedEnv;
}

export function clearEnvCache(): void {
  cachedEnv = null;
}
