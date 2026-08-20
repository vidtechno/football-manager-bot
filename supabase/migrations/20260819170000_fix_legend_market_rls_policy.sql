-- SQL Migration: Fix Legend Market RLS Policy Subquery
-- Drops existing RLS policy referencing invalid column and recreates querying public.leagues.id

DROP POLICY IF EXISTS "League legend market readable by league members" ON public.league_legend_market;
DROP POLICY IF EXISTS "League legend market readable by authenticated users" ON public.league_legend_market;

CREATE POLICY "League legend market readable by authenticated users"
    ON public.league_legend_market FOR SELECT
    TO authenticated
    USING (
        EXISTS (
            SELECT 1 FROM public.leagues l
            WHERE l.id = league_legend_market.league_id
        )
    );
