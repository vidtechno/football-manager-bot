-- Supabase Migration: Create Identity and Access Schema
-- Target Schema: public
-- Security: RLS Enabled on all tables, Service Role Access Only

-- 1. Shared Extensions
CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";

-- 2. Reusable Triggers and Functions
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

-- 3. Enums
CREATE TYPE public.enum_manager_status AS ENUM ('ACTIVE', 'SUSPENDED', 'BLOCKED');
CREATE TYPE public.enum_admin_role AS ENUM ('SUPER_ADMIN', 'SYSTEM_ADMIN', 'MODERATOR');
CREATE TYPE public.enum_admin_status AS ENUM ('ACTIVE', 'DISABLED');
CREATE TYPE public.enum_audit_action_category AS ENUM (
    'SECURITY',
    'USER_MANAGEMENT',
    'LEAGUE_MANAGEMENT',
    'FINANCIAL_OVERRIDE',
    'SYSTEM_CONFIG'
);

-- 4. Managers Table
CREATE TABLE public.managers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    telegram_user_id BIGINT UNIQUE NOT NULL CONSTRAINT chk_managers_telegram_user_id_positive CHECK (telegram_user_id > 0),
    manager_name VARCHAR(24) NOT NULL CONSTRAINT chk_managers_manager_name_length CHECK (length(trim(manager_name)) BETWEEN 3 AND 24),
    normalized_manager_name TEXT GENERATED ALWAYS AS (lower(trim(manager_name))) STORED,
    language_code VARCHAR(10) NOT NULL DEFAULT 'uz',
    status public.enum_manager_status NOT NULL DEFAULT 'ACTIVE',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE public.managers IS 'Primary account records for Telegram managers linked by Telegram User ID.';
COMMENT ON COLUMN public.managers.telegram_user_id IS 'Globally unique Telegram User ID.';

CREATE INDEX idx_managers_telegram_user_id ON public.managers (telegram_user_id);
CREATE INDEX idx_managers_status ON public.managers (status);
CREATE INDEX idx_managers_normalized_name ON public.managers (normalized_manager_name);

CREATE TRIGGER trg_managers_updated_at
    BEFORE UPDATE ON public.managers
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- 5. Manager Profiles Table
CREATE TABLE public.manager_profiles (
    manager_id UUID PRIMARY KEY REFERENCES public.managers(id) ON DELETE CASCADE,
    display_name VARCHAR(24) NOT NULL CONSTRAINT chk_manager_profiles_display_name_length CHECK (length(trim(display_name)) BETWEEN 3 AND 24),
    bio TEXT,
    reputation_score INT NOT NULL DEFAULT 1000 CONSTRAINT chk_manager_profiles_reputation_non_negative CHECK (reputation_score >= 0),
    total_seasons INT NOT NULL DEFAULT 0 CONSTRAINT chk_manager_profiles_seasons_non_negative CHECK (total_seasons >= 0),
    titles_won INT NOT NULL DEFAULT 0 CONSTRAINT chk_manager_profiles_titles_non_negative CHECK (titles_won >= 0),
    matches_won INT NOT NULL DEFAULT 0 CONSTRAINT chk_manager_profiles_wins_non_negative CHECK (matches_won >= 0),
    matches_drawn INT NOT NULL DEFAULT 0 CONSTRAINT chk_manager_profiles_draws_non_negative CHECK (matches_drawn >= 0),
    matches_lost INT NOT NULL DEFAULT 0 CONSTRAINT chk_manager_profiles_losses_non_negative CHECK (matches_lost >= 0),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE public.manager_profiles IS 'One-to-one extension profile and summary statistics for managers.';

CREATE TRIGGER trg_manager_profiles_updated_at
    BEFORE UPDATE ON public.manager_profiles
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- 6. Admin Users Table
CREATE TABLE public.admin_users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    auth_user_id UUID UNIQUE REFERENCES auth.users(id) ON DELETE SET NULL,
    telegram_user_id BIGINT UNIQUE CONSTRAINT chk_admin_users_telegram_user_id_positive CHECK (telegram_user_id IS NULL OR telegram_user_id > 0),
    email TEXT UNIQUE CONSTRAINT chk_admin_users_email_format CHECK (email IS NULL OR email ~* '^[^@\s]+@[^@\s]+\.[^@\s]+$'),
    role public.enum_admin_role NOT NULL DEFAULT 'SYSTEM_ADMIN',
    status public.enum_admin_status NOT NULL DEFAULT 'ACTIVE',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE public.admin_users IS 'Protected admin panel identities linked safely to Supabase auth or Telegram ID.';

CREATE INDEX idx_admin_users_auth_user_id ON public.admin_users (auth_user_id);
CREATE INDEX idx_admin_users_status ON public.admin_users (status);

CREATE TRIGGER trg_admin_users_updated_at
    BEFORE UPDATE ON public.admin_users
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- 7. Manager Blocks Table
CREATE TABLE public.manager_blocks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    manager_id UUID NOT NULL REFERENCES public.managers(id) ON DELETE CASCADE,
    reason TEXT NOT NULL CONSTRAINT chk_manager_blocks_reason_length CHECK (length(trim(reason)) >= 3),
    blocked_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    blocked_by_admin_id UUID REFERENCES public.admin_users(id) ON DELETE SET NULL,
    unblocked_at TIMESTAMPTZ,
    unblocked_by_admin_id UUID REFERENCES public.admin_users(id) ON DELETE SET NULL,
    unblock_reason TEXT,
    CONSTRAINT chk_manager_blocks_unblocked_after_blocked CHECK (unblocked_at IS NULL OR unblocked_at >= blocked_at)
);

COMMENT ON TABLE public.manager_blocks IS 'Historical and active block records for managers.';

CREATE UNIQUE INDEX idx_manager_blocks_active_block ON public.manager_blocks (manager_id) WHERE (unblocked_at IS NULL);
CREATE INDEX idx_manager_blocks_manager_id ON public.manager_blocks (manager_id);

-- 8. Admin Audit Logs Table (Append-Only)
CREATE TABLE public.admin_audit_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    admin_id UUID REFERENCES public.admin_users(id) ON DELETE SET NULL,
    action_category public.enum_audit_action_category NOT NULL,
    action_name VARCHAR(100) NOT NULL,
    target_type VARCHAR(50) NOT NULL,
    target_id UUID,
    reason TEXT NOT NULL CONSTRAINT chk_admin_audit_logs_reason_length CHECK (length(trim(reason)) >= 3),
    metadata JSONB NOT NULL DEFAULT '{}'::jsonb,
    correlation_id UUID,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE public.admin_audit_logs IS 'Immutable append-only administrative audit log.';

CREATE INDEX idx_admin_audit_logs_admin_id ON public.admin_audit_logs (admin_id);
CREATE INDEX idx_admin_audit_logs_target ON public.admin_audit_logs (target_type, target_id);
CREATE INDEX idx_admin_audit_logs_category ON public.admin_audit_logs (action_category);
CREATE INDEX idx_admin_audit_logs_created_at ON public.admin_audit_logs (created_at);

-- Trigger Function to enforce append-only immutability on admin_audit_logs
CREATE OR REPLACE FUNCTION public.prevent_audit_log_modification()
RETURNS TRIGGER AS $$
BEGIN
    RAISE EXCEPTION 'admin_audit_logs jadvali mutlaqo o''zgarmas (append-only) hisoblanadi. UPDATE yoki DELETE amallari taqiqlangan.';
END;
$$ LANGUAGE plpgsql SECURITY DEFINER SET search_path = public;

CREATE TRIGGER trg_prevent_audit_log_modification
    BEFORE UPDATE OR DELETE ON public.admin_audit_logs
    FOR EACH ROW EXECUTE FUNCTION public.prevent_audit_log_modification();

-- 9. Row Level Security (RLS) & Default Grants
ALTER TABLE public.managers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.manager_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.admin_users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.manager_blocks ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.admin_audit_logs ENABLE ROW LEVEL SECURITY;

-- Revoke all permissions from untrusted API roles (anon, authenticated)
REVOKE ALL ON TABLE public.managers FROM anon, authenticated;
REVOKE ALL ON TABLE public.manager_profiles FROM anon, authenticated;
REVOKE ALL ON TABLE public.admin_users FROM anon, authenticated;
REVOKE ALL ON TABLE public.manager_blocks FROM anon, authenticated;
REVOKE ALL ON TABLE public.admin_audit_logs FROM anon, authenticated;

-- Grant full permissions to service_role (used strictly server-side)
GRANT ALL ON TABLE public.managers TO service_role;
GRANT ALL ON TABLE public.manager_profiles TO service_role;
GRANT ALL ON TABLE public.admin_users TO service_role;
GRANT ALL ON TABLE public.manager_blocks TO service_role;
GRANT ALL ON TABLE public.admin_audit_logs TO service_role;
