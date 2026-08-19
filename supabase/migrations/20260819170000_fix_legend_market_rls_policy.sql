-- SQL Migration: Fix Legend Market RLS Policy Subquery
-- Drops existing RLS policy referencing invalid column and recreates joining league_members with managers.user_id

DROP POLICY IF EXISTS "League legend market readable by league members" ON public.league_legend_market;

CREATE POLICY "League legend market readable by league members"
    ON public.league_legend_market FOR SELECT
    TO authenticated
    USING (
        EXISTS (
            SELECT 1 FROM public.league_members lm
            JOIN public.managers m ON m.id = lm.manager_id
            WHERE lm.league_id = league_legend_market.league_id
              AND m.user_id = auth.uid()
        )
    );
