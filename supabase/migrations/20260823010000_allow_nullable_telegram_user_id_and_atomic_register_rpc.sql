-- Migration: 20260823010000_allow_nullable_telegram_user_id_and_atomic_register_rpc.sql
-- Description: Allows nullable telegram_user_id for website-only managers and adds atomic RPC registration.

-- 1. Allow nullable telegram_user_id in managers table for website-only accounts
ALTER TABLE public.managers ALTER COLUMN telegram_user_id DROP NOT NULL;
ALTER TABLE public.managers DROP CONSTRAINT IF EXISTS chk_managers_telegram_user_id_positive;
ALTER TABLE public.managers ADD CONSTRAINT chk_managers_telegram_user_id_positive CHECK (telegram_user_id IS NULL OR telegram_user_id > 0);

-- 2. Atomic Registration RPC Procedure
CREATE OR REPLACE FUNCTION public.register_web_manager_atomic(
    p_username text,
    p_manager_name text,
    p_password_hash text
)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_clean_username text;
    v_norm_username text;
    v_clean_manager_name text;
    v_manager_id uuid;
    v_cred_id uuid;
BEGIN
    v_clean_username := trim(p_username);
    v_norm_username := lower(v_clean_username);
    v_clean_manager_name := trim(p_manager_name);

    IF length(v_norm_username) < 4 OR length(v_norm_username) > 24 THEN
        RAISE EXCEPTION 'Username 4 va 24 belgi orasida bo‘lishi shart.';
    END IF;

    IF length(v_clean_manager_name) < 2 OR length(v_clean_manager_name) > 40 THEN
        RAISE EXCEPTION 'Menejer ismi kamida 2 ta belgidan iborat bo‘lishi shart.';
    END IF;

    -- Check case-insensitive duplicate username
    IF EXISTS (SELECT 1 FROM public.manager_credentials WHERE username_normalized = v_norm_username) THEN
        RAISE EXCEPTION 'Bu username allaqachon band.' USING ERRCODE = '23505';
    END IF;

    -- Insert into managers with NULL telegram_user_id for web-only manager
    INSERT INTO public.managers (
        telegram_user_id,
        manager_name,
        language_code,
        status
    ) VALUES (
        NULL,
        v_clean_manager_name,
        'uz',
        'ACTIVE'
    ) RETURNING id INTO v_manager_id;

    -- Insert into manager_profiles
    INSERT INTO public.manager_profiles (
        manager_id,
        display_name
    ) VALUES (
        v_manager_id,
        v_clean_manager_name
    );

    -- Insert into manager_credentials
    INSERT INTO public.manager_credentials (
        manager_id,
        username,
        username_normalized,
        password_hash
    ) VALUES (
        v_manager_id,
        v_clean_username,
        v_norm_username,
        p_password_hash
    ) RETURNING id INTO v_cred_id;

    RETURN jsonb_build_object(
        'manager_id', v_manager_id,
        'username', v_clean_username,
        'username_normalized', v_norm_username,
        'manager_name', v_clean_manager_name,
        'telegram_user_id', NULL
    );
EXCEPTION
    WHEN unique_violation THEN
        RAISE EXCEPTION 'Bu username allaqachon band.' USING ERRCODE = '23505';
END;
$$;

GRANT EXECUTE ON FUNCTION public.register_web_manager_atomic(text, text, text) TO service_role;
