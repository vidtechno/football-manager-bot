-- Migration: 20260823020000_link_admin_users_to_manager_id.sql
-- Description: Adds nullable manager_id column to admin_users to link web-only manager accounts to admin roles.

ALTER TABLE public.admin_users ADD COLUMN IF NOT EXISTS manager_id UUID UNIQUE REFERENCES public.managers(id) ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_admin_users_manager_id ON public.admin_users (manager_id);
