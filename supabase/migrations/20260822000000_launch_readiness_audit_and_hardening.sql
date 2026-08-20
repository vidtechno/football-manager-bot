-- Migration: 20260822000000_launch_readiness_audit_and_hardening.sql
-- Description: Launch readiness RPC search path safety, privilege grants, and index verification.

BEGIN;

-- 1. Ensure RLS security grants for newly added tables in Phase 5
ALTER TABLE public.global_sponsor_settings ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.manager_sponsor_verifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.league_matches ENABLE ROW LEVEL SECURITY;

REVOKE ALL ON TABLE public.global_sponsor_settings FROM anon, authenticated;
REVOKE ALL ON TABLE public.manager_sponsor_verifications FROM anon, authenticated;
REVOKE ALL ON TABLE public.league_matches FROM anon, authenticated;

GRANT ALL ON TABLE public.global_sponsor_settings TO service_role;
GRANT ALL ON TABLE public.manager_sponsor_verifications TO service_role;
GRANT ALL ON TABLE public.league_matches TO service_role;

-- 2. Security hardening check on RPC functions
ALTER FUNCTION public.set_active_global_sponsor_channel(BIGINT, VARCHAR, VARCHAR, VARCHAR, UUID) SET search_path = public;
ALTER FUNCTION public.deactivate_global_sponsor_channel(UUID) SET search_path = public;
ALTER FUNCTION public.process_round_settlement_income(UUID, INT, UUID[]) SET search_path = public;

COMMENT ON FUNCTION public.set_active_global_sponsor_channel IS 'Atomically sets the single active global Telegram sponsor channel across the bot.';
COMMENT ON FUNCTION public.deactivate_global_sponsor_channel IS 'Deactivates the global Telegram sponsor channel.';
COMMENT ON FUNCTION public.process_round_settlement_income IS 'Atomically credits automatic sponsorship, match win/draw bonuses, and stadium income with strict idempotency.';

COMMIT;
