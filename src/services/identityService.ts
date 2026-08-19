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
  telegramUserId: number;
  role: string;
  status: string;
  createdAt: string;
}

export class IdentityService {
  /**
   * Retrieves an existing manager by Telegram User ID, or creates one atomically if missing.
   */
  static async getOrCreateManager(
    telegramUserId: number,
    displayName?: string,
  ): Promise<DbManager> {
    const supabase = getSupabaseAdminClient();

    const { data: existing, error: findErr } = await supabase
      .from('managers')
      .select('*')
      .eq('telegram_user_id', telegramUserId)
      .maybeSingle();

    if (findErr) {
      throw new Error(`GET_MANAGER_FAILED: ${findErr.message}`);
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

    const managerName = displayName
      ? displayName.trim().slice(0, 24)
      : `Manager_${telegramUserId.toString().slice(-4)}`;

    const { data: created, error: createErr } = await supabase
      .from('managers')
      .insert({
        telegram_user_id: telegramUserId,
        manager_name: managerName,
        language_code: 'uz',
      })
      .select('*')
      .single();

    if (createErr) {
      throw new Error(`CREATE_MANAGER_FAILED: ${createErr.message}`);
    }

    // Insert manager profile default row
    await supabase
      .from('manager_profiles')
      .insert({
        manager_id: created.id,
        display_name: managerName,
      })
      .select('*')
      .maybeSingle();

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
   * Retrieves an active admin user record by Telegram User ID. Returns null if unauthorized.
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

      if (!configuredAdminIds.includes(telegramUserId)) {
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
      telegramUserId: Number(admin.telegram_user_id),
      role: admin.role,
      status: admin.status,
      createdAt: admin.created_at,
    };
  }
}
