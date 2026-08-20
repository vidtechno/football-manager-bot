-- Migration: 20260823000000_create_manager_credentials_and_sessions.sql
-- Description: Adds manager_credentials and manager_auth_sessions for web username/password auth and session management.

-- 1. Table: manager_credentials
CREATE TABLE IF NOT EXISTS public.manager_credentials (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    manager_id UUID NOT NULL UNIQUE REFERENCES public.managers(id) ON DELETE CASCADE,
    username VARCHAR(50) NOT NULL CHECK (char_length(trim(username)) >= 4),
    username_normalized VARCHAR(50) NOT NULL UNIQUE CHECK (username_normalized = lower(trim(username_normalized))),
    password_hash TEXT NOT NULL CHECK (char_length(password_hash) > 0),
    last_login_at TIMESTAMPTZ NULL,
    password_changed_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Indexes for manager_credentials
CREATE INDEX IF NOT EXISTS idx_manager_credentials_manager_id ON public.manager_credentials(manager_id);
CREATE INDEX IF NOT EXISTS idx_manager_credentials_username_norm ON public.manager_credentials(username_normalized);

-- Trigger for manager_credentials updated_at
CREATE TRIGGER trg_manager_credentials_updated_at
    BEFORE UPDATE ON public.manager_credentials
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- 2. Table: manager_auth_sessions
CREATE TABLE IF NOT EXISTS public.manager_auth_sessions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    manager_id UUID NOT NULL REFERENCES public.managers(id) ON DELETE CASCADE,
    refresh_token_hash TEXT NOT NULL UNIQUE,
    user_agent TEXT NULL,
    ip_address TEXT NULL,
    is_remember_me BOOLEAN NOT NULL DEFAULT FALSE,
    expires_at TIMESTAMPTZ NOT NULL,
    revoked_at TIMESTAMPTZ NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Indexes for manager_auth_sessions
CREATE INDEX IF NOT EXISTS idx_manager_auth_sessions_manager_id ON public.manager_auth_sessions(manager_id);
CREATE INDEX IF NOT EXISTS idx_manager_auth_sessions_refresh_hash ON public.manager_auth_sessions(refresh_token_hash);

-- Security Hardening: Revoke direct client access to credentials and auth sessions
REVOKE ALL ON TABLE public.manager_credentials FROM anon, authenticated;
REVOKE ALL ON TABLE public.manager_auth_sessions FROM anon, authenticated;
GRANT ALL ON TABLE public.manager_credentials TO service_role;
GRANT ALL ON TABLE public.manager_auth_sessions TO service_role;
