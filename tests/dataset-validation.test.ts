import { describe, it, expect } from 'vitest';
import { validateDataset } from '../src/data/validate-dataset.js';
import { generateSeedSql } from '../src/data/generate-seed-sql.js';
import fs from 'node:fs';
import path from 'node:path';

describe('Phase 4E Dataset Validation Suite', () => {
  it('1. should validate that the dataset snapshot date is 2026-08-19 and dataset is 100% valid', () => {
    const report = validateDataset();
    expect(report.snapshotDate).toBe('2026-08-19');
    expect(report.isValid).toBe(true);
    expect(report.globalErrors).toEqual([]);
  });

  it('2. should verify exactly 20 approved clubs exist in the dataset', () => {
    const report = validateDataset();
    expect(report.totalClubs).toBe(20);
    expect(report.clubSummaries.length).toBe(20);
  });

  it('3. should enforce 18-25 players and at least 2 goalkeepers for every club squad', () => {
    const report = validateDataset();
    for (const club of report.clubSummaries) {
      expect(club.playerCount).toBeGreaterThanOrEqual(18);
      expect(club.playerCount).toBeLessThanOrEqual(25);
      expect(club.goalkeeperCount).toBeGreaterThanOrEqual(2);
      expect(club.isSquadValid).toBe(true);
      expect(club.errors).toEqual([]);
    }
  });

  it('4. should confirm non-negative market values and exact club squad value summation', () => {
    const report = validateDataset();
    expect(report.totalLeagueMarketValueEur).toBeGreaterThan(0);

    const players: Array<{ marketValueEur: number; clubSlug: string }> =
      JSON.parse(
        fs.readFileSync(
          path.resolve(process.cwd(), 'data/football/2026-08-19/players.json'),
          'utf-8',
        ),
      );

    for (const p of players) {
      expect(p.marketValueEur).toBeGreaterThanOrEqual(0);
      expect(Number.isInteger(p.marketValueEur)).toBe(true);
    }

    for (const club of report.clubSummaries) {
      const clubPlayers = players.filter((p) => p.clubSlug === club.slug);
      const expectedSum = clubPlayers.reduce(
        (acc, p) => acc + p.marketValueEur,
        0,
      );
      expect(club.totalMarketValueEur).toBe(expectedSum);
    }
  });

  it('5. should enforce strict GK vs Outfield attribute separation', () => {
    const players: Array<{
      primaryPosition: string;
      goalkeeperAttributes?: object;
      outfieldAttributes?: object;
    }> = JSON.parse(
      fs.readFileSync(
        path.resolve(process.cwd(), 'data/football/2026-08-19/players.json'),
        'utf-8',
      ),
    );

    for (const p of players) {
      if (p.primaryPosition === 'GK') {
        expect(p.goalkeeperAttributes).toBeDefined();
        expect(p.outfieldAttributes).toBeUndefined();
      } else {
        expect(p.outfieldAttributes).toBeDefined();
        expect(p.goalkeeperAttributes).toBeUndefined();
      }
    }
  });

  it('6. should generate valid reproducible seed SQL artifact', () => {
    const seedPath = path.resolve(process.cwd(), 'supabase/seed.sql');
    generateSeedSql();
    expect(fs.existsSync(seedPath)).toBe(true);

    const content = fs.readFileSync(seedPath, 'utf-8');
    expect(content).toContain('-- Reprodusibl Phase 4E Seed Data');
    expect(content).toContain('INSERT INTO public.club_template_versions');
    expect(content).toContain('public.create_player_template_with_positions');
    expect(content).toContain('INSERT INTO public.player_template_versions');
  });
});
