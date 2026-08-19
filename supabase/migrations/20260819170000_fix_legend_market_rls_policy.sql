-- SQL Migration: Fix Legend Market RLS Policy Subquery
-- Drops existing RLS policy referencing invalid column and recreates querying league_clubs.user_id

DROP POLICY IF EXISTS "League legend market readable by league members" ON public.league_legend_market;

CREATE POLICY "League legend market readable by league members"
    ON public.league_legend_market FOR SELECT
    TO authenticated
    USING (
        EXISTS (
            SELECT 1 FROM public.league_clubs lc
            WHERE lc.league_id = league_legend_market.league_id
              AND lc.user_id = auth.uid()
        )
    );
