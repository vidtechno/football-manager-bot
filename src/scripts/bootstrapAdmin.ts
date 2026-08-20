import bcrypt from 'bcryptjs';
import { getSupabaseAdminClient } from '../database/client.js';
import { AuthService } from '../services/authService.js';

export async function bootstrapAdmin(): Promise<void> {
  const username = (process.env['ADMIN_BOOTSTRAP_USERNAME'] || 'diyoration')
    .trim()
    .toLowerCase();
  const managerName = (
    process.env['ADMIN_BOOTSTRAP_MANAGER_NAME'] || 'Diyorbek'
  ).trim();
  const password = process.env['ADMIN_BOOTSTRAP_PASSWORD'];

  if (!password || password.trim().length === 0) {
    console.error(
      '[ADMIN_BOOTSTRAP_ERROR] Missing ADMIN_BOOTSTRAP_PASSWORD environment variable.',
    );
    process.exit(1);
  }

  const valPass = AuthService.validatePassword(password);
  if (!valPass.isValid) {
    console.error(`[ADMIN_BOOTSTRAP_ERROR] ${valPass.error}`);
    process.exit(1);
  }

  const supabase = getSupabaseAdminClient();

  // 1. Check if manager credentials already exist for username
  const { data: existingCred } = await supabase
    .from('manager_credentials')
    .select('*, managers(*)')
    .eq('username_normalized', username)
    .maybeSingle();

  let managerId: string;

  if (existingCred) {
    managerId = existingCred.manager_id;
    // Update password hash if changed
    const passwordHash = await bcrypt.hash(password, 12);
    await supabase
      .from('manager_credentials')
      .update({
        password_hash: passwordHash,
        password_changed_at: new Date().toISOString(),
      })
      .eq('id', existingCred.id);
  } else {
    // Register web-only manager atomically
    const regResult = await AuthService.registerManagerWithCredentials({
      username,
      managerName,
      password,
    });
    managerId = regResult.managerId;
  }

  // 2. Ensure admin_users entry exists and is active
  const { data: existingAdmin } = await supabase
    .from('admin_users')
    .select('*')
    .eq('manager_id', managerId)
    .maybeSingle();

  if (existingAdmin) {
    if (
      existingAdmin.status !== 'ACTIVE' ||
      existingAdmin.role !== 'SUPER_ADMIN'
    ) {
      await supabase
        .from('admin_users')
        .update({
          status: 'ACTIVE',
          role: 'SUPER_ADMIN',
          updated_at: new Date().toISOString(),
        })
        .eq('id', existingAdmin.id);
    }
  } else {
    const { error: adminErr } = await supabase.from('admin_users').insert({
      manager_id: managerId,
      role: 'SUPER_ADMIN',
      status: 'ACTIVE',
    });

    if (adminErr) {
      console.error(
        `[ADMIN_BOOTSTRAP_ERROR] Failed to insert admin_user: ${adminErr.message}`,
      );
      process.exit(1);
    }
  }

  console.log(
    `[ADMIN_BOOTSTRAP] Idempotent admin bootstrap completed successfully for username: ${username}`,
  );
}

// Execute CLI script if run directly
if (import.meta.url === `file://${process.argv[1]}`) {
  bootstrapAdmin()
    .then(() => process.exit(0))
    .catch((err) => {
      console.error('[ADMIN_BOOTSTRAP_ERROR]', err.message);
      process.exit(1);
    });
}
