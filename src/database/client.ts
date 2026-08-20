import { createClient, SupabaseClient } from '@supabase/supabase-js';
import { loadEnvironment } from '../config/env.js';

let adminClient: SupabaseClient | null = null;
let anonClient: SupabaseClient | null = null;

/**
 * Returns the trusted server-side Supabase client using SUPABASE_SECRET_KEY (service_role).
 * Used strictly by the backend bot service for SECURITY DEFINER RPCs.
 */
export function getSupabaseAdminClient(): SupabaseClient {
  if (adminClient) return adminClient;

  const env = loadEnvironment();
  adminClient = createClient(env.SUPABASE_URL, env.SUPABASE_SECRET_KEY, {
    auth: {
      persistSession: false,
      autoRefreshToken: false,
    },
  });

  return adminClient;
}

/**
 * Returns the standard public client using SUPABASE_ANON_KEY.
 */
export function getSupabaseAnonClient(): SupabaseClient {
  if (anonClient) return anonClient;

  const env = loadEnvironment();
  anonClient = createClient(env.SUPABASE_URL, env.SUPABASE_ANON_KEY, {
    auth: {
      persistSession: false,
      autoRefreshToken: false,
    },
  });

  return anonClient;
}

export function resetDatabaseClients(): void {
  adminClient = null;
  anonClient = null;
}
