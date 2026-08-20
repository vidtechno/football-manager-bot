import { getSupabaseAdminClient } from '../database/client.js';
import { loadEnvironment } from '../config/env.js';

export interface DbManager {
  id: string;
  telegramUserId: number;
  managerName: string;
  languageCode: string;
  status: string;
  createdAt: string;
}

export interface DbAdminUser {
  id: string;
  telegramUserId?: number;
  managerId?: string;
  role: string;
  status: string;
  createdAt: string;
}

export class IdentityService {
  /**
   * Resolves or creates a human manager by Telegram User ID.
   */
  static async getOrCreateManager(
    telegramUserId: number,
    displayName?: string,
  ): Promise<DbManager> {
    const supabase = getSupabaseAdminClient();

    const { data: existing, error: findError } = await supabase
      .from('managers')
      .select('*')
      .eq('telegram_user_id', telegramUserId)
      .maybeSingle();

    if (findError) {
      throw new Error(
        `DATABASE_ERROR: Failed to query manager: ${findError.message}`,
      );
    }

    if (existing) {
      return {
        id: existing.id,
        telegramUserId: Number(existing.telegram_user_id),
        managerName: existing.manager_name,
        languageCode: existing.language_code || 'uz',
        status: existing.status,
        createdAt: existing.created_at,
      };
    }

    const fallbackName =
      displayName && displayName.trim().length >= 3
        ? displayName.trim().slice(0, 24)
        : `Manager_${telegramUserId}`;

    const { data: created, error: createError } = await supabase
      .from('managers')
      .insert({
        telegram_user_id: telegramUserId,
        manager_name: fallbackName,
        language_code: 'uz',
      })
      .select('*')
      .single();

    if (createError) {
      throw new Error(
        `DATABASE_ERROR: Failed to create manager: ${createError.message}`,
      );
    }

    await supabase.from('manager_profiles').insert({
      manager_id: created.id,
      display_name: fallbackName,
    });

    return {
      id: created.id,
      telegramUserId: Number(created.telegram_user_id),
      managerName: created.manager_name,
      languageCode: created.language_code || 'uz',
      status: created.status,
      createdAt: created.created_at,
    };
  }

  /**
   * Retrieves an active admin user record by Telegram User ID.
   */
  static async getAdminUser(
    telegramUserId: number,
  ): Promise<DbAdminUser | null> {
    const supabase = getSupabaseAdminClient();

    const { data, error } = await supabase
      .from('admin_users')
      .select('*')
      .eq('telegram_user_id', telegramUserId)
      .eq('status', 'ACTIVE')
      .maybeSingle();

    if (error) {
      return null;
    }

    let admin = data;
    if (!admin) {
      const configuredAdminIds = (loadEnvironment().ADMIN_TELEGRAM_IDS ?? '')
        .split(',')
        .map((value) => Number(value.trim()))
        .filter((value) => Number.isSafeInteger(value) && value > 0);

      const {
        data: managers,
        count: managerCount,
        error: managerError,
      } = await supabase
        .from('managers')
        .select('telegram_user_id', { count: 'exact' })
        .limit(2);

      const isSecureBootstrapAdmin =
        !managerError &&
        managerCount === 1 &&
        managers?.length === 1 &&
        Number(managers[0]?.telegram_user_id) === telegramUserId;

      if (
        !configuredAdminIds.includes(telegramUserId) &&
        !isSecureBootstrapAdmin
      ) {
        return null;
      }

      const { data: provisioned, error: provisionError } = await supabase
        .from('admin_users')
        .upsert(
          {
            telegram_user_id: telegramUserId,
            role: 'SUPER_ADMIN',
            status: 'ACTIVE',
          },
          { onConflict: 'telegram_user_id' },
        )
        .select('*')
        .single();

      if (provisionError || !provisioned) {
        return null;
      }
      admin = provisioned;
    }

    return {
      id: admin.id,
      telegramUserId: Number(admin.telegram_user_id || 0),
      managerId: admin.manager_id || undefined,
      role: admin.role,
      status: admin.status,
      createdAt: admin.created_at,
    };
  }

  /**
   * Resolves whether a manager is an active admin in admin_users table (by managerId or telegramUserId).
   */
  static async isManagerAdmin(
    managerId?: string,
    telegramUserId?: number,
  ): Promise<boolean> {
    const supabase = getSupabaseAdminClient();

    if (managerId) {
      const { data } = await supabase
        .from('admin_users')
        .select('id')
        .eq('manager_id', managerId)
        .eq('status', 'ACTIVE')
        .maybeSingle();

      if (data) return true;
    }

    if (telegramUserId && telegramUserId > 0) {
      const { data } = await supabase
        .from('admin_users')
        .select('id')
        .eq('telegram_user_id', telegramUserId)
        .eq('status', 'ACTIVE')
        .maybeSingle();

      if (data) return true;
    }

    return false;
  }
}
