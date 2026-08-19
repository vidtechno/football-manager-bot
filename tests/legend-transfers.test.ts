import { describe, it, expect } from 'vitest';
import { LegendSeedSchema } from '../src/data/legend-types.js';
import {
  validateLegends,
  ALL_SUPPORTED_POSITIONS,
  REQUIRED_LEGEND_IDS,
} from '../src/data/validate-legends.js';

describe('Phase 4H Legend Transfers Dataset & Pricing Suite', () => {
  it('1. should validate legend seed schema correctly for peak Ronaldo at €500m', () => {
    const sampleLegend = {
      legendId: 'leg-cristiano-ronaldo-prime',
      canonicalKey: 'cristiano-ronaldo-prime',
      fullName: 'Cristiano Ronaldo',
      nationality: 'Portugal',
      dateOfBirth: '1985-02-05',
      primaryPosition: 'LW',
      secondaryPositions: ['ST', 'RW'],
      peakClub: 'Real Madrid',
      peakPeriod: '2011-2014',
      peakOverallRating: 94,
      outfieldAttributes: {
        pace: 93,
        shooting: 93,
        passing: 82,
        dribbling: 91,
        defending: 33,
        physical: 80,
      },
      legendTransferPriceEur: 500_000_000,
      status: 'ACTIVE',
      sourceId: 'src-ea-fc-icons-2026',
      ratingMethodology: 'Official EA FC Icon historical peak rating 2011-2014',
    };

    const parsed = LegendSeedSchema.safeParse(sampleLegend);
    expect(parsed.success).toBe(true);
  });

  it('2. should validate legend seed schema correctly for valid goalkeeper legend', () => {
    const sampleGkLegend = {
      legendId: 'leg-iker-casillas-prime',
      canonicalKey: 'iker-casillas-prime',
      fullName: 'Iker Casillas',
      nationality: 'Spain',
      dateOfBirth: '1981-05-20',
      primaryPosition: 'GK',
      secondaryPositions: [],
      peakClub: 'Real Madrid',
      peakPeriod: '2008-2012',
      peakOverallRating: 91,
      goalkeeperAttributes: {
        reflexes: 92,
        handling: 87,
        positioning: 89,
        aerialAbility: 84,
        distribution: 78,
        oneOnOne: 91,
      },
      legendTransferPriceEur: 290_000_000,
      status: 'RETIRED',
      sourceId: 'src-ea-fc-icons-2026',
      ratingMethodology: 'Official EA FC Icon historical peak rating 2008-2012',
    };

    const parsed = LegendSeedSchema.safeParse(sampleGkLegend);
    expect(parsed.success).toBe(true);
  });

  it('3. should reject peak Messi or Ronaldo if price is not exactly €500,000,000', () => {
    const invalidMessi = {
      legendId: 'leg-lionel-messi-prime',
      canonicalKey: 'lionel-messi-prime',
      fullName: 'Lionel Messi',
      nationality: 'Argentina',
      dateOfBirth: '1987-06-24',
      primaryPosition: 'RW',
      secondaryPositions: ['CF', 'CAM'],
      peakClub: 'FC Barcelona',
      peakPeriod: '2011-2012',
      peakOverallRating: 94,
      outfieldAttributes: {
        pace: 92,
        shooting: 92,
        passing: 91,
        dribbling: 96,
        defending: 30,
        physical: 68,
      },
      legendTransferPriceEur: 300_000_000, // Invalid: must be €500m
      status: 'ACTIVE',
      sourceId: 'src-ea-fc-icons-2026',
      ratingMethodology: 'Peak career analysis',
    };

    const parsed = LegendSeedSchema.safeParse(invalidMessi);
    expect(parsed.success).toBe(false);
    if (!parsed.success) {
      expect(parsed.error.message).toContain('must cost exactly €500,000,000');
    }
  });

  it('4. should reject legend prices outside the €100m - €500m range', () => {
    const cheapLegend = {
      legendId: 'leg-xavi-prime',
      canonicalKey: 'xavi-prime',
      fullName: 'Xavi Hernández',
      nationality: 'Spain',
      dateOfBirth: '1980-01-25',
      primaryPosition: 'CM',
      secondaryPositions: ['CAM'],
      peakClub: 'FC Barcelona',
      peakPeriod: '2008-2012',
      peakOverallRating: 92,
      outfieldAttributes: {
        pace: 75,
        shooting: 78,
        passing: 95,
        dribbling: 90,
        defending: 72,
        physical: 68,
      },
      legendTransferPriceEur: 50_000_000, // Invalid: below €100m minimum
      status: 'RETIRED',
      sourceId: 'src-ea-fc-icons-2026',
      ratingMethodology: 'Peak career analysis',
    };

    const parsed = LegendSeedSchema.safeParse(cheapLegend);
    expect(parsed.success).toBe(false);
  });

  it('5. [Final Dataset Gate] should confirm 60 complete legends and 100% position coverage', () => {
    const report = validateLegends();
    expect(report.snapshotDate).toBe('2026-08-19');
    expect(report.isValid).toBe(true);
    expect(report.totalLegends).toBe(60);
    expect(report.isFinalDatasetReady).toBe(true);
    expect(report.errors).toHaveLength(0);

    for (const pos of ALL_SUPPORTED_POSITIONS) {
      expect(report.positionsCovered[pos]).toBeGreaterThanOrEqual(3);
    }
  });

  it('6. should confirm all required legends exist in the final dataset', () => {
    const report = validateLegends();
    expect(report.isValid).toBe(true);
    expect(REQUIRED_LEGEND_IDS.length).toBe(9);
  });
});
