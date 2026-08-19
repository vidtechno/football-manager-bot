import { describe, it, expect } from 'vitest';
import { LegendSeedSchema } from '../src/data/legend-types.js';
import {
  validateLegends,
  ALL_SUPPORTED_POSITIONS,
} from '../src/data/validate-legends.js';

describe('Phase 4F Legend Transfers Infrastructure Test Suite', () => {
  it('1. should validate legend seed schema correctly for valid outfield legend', () => {
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
      legendCoinPriceEur: 150000000,
      status: 'ACTIVE',
      sourceId: 'src-legend-research-2026',
      ratingMethodology:
        'Peak historical career performance analysis 2011-2014',
    };

    const parsed = LegendSeedSchema.safeParse(sampleLegend);
    expect(parsed.success).toBe(true);
  });

  it('2. should validate legend seed schema correctly for valid goalkeeper legend', () => {
    const sampleGkLegend = {
      legendId: 'leg-ikercasillas-prime',
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
      legendCoinPriceEur: 80000000,
      status: 'RETIRED',
      sourceId: 'src-legend-research-2026',
      ratingMethodology:
        'Peak historical career performance analysis 2008-2012',
    };

    const parsed = LegendSeedSchema.safeParse(sampleGkLegend);
    expect(parsed.success).toBe(true);
  });

  it('3. should reject outfield legends attempting to use goalkeeper attributes', () => {
    const invalidOutfield = {
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
      goalkeeperAttributes: {
        reflexes: 50,
        handling: 50,
        positioning: 50,
        aerialAbility: 50,
        distribution: 50,
        oneOnOne: 50,
      },
      legendCoinPriceEur: 150000000,
      status: 'ACTIVE',
      sourceId: 'src-legend-research-2026',
      ratingMethodology: 'Peak career analysis',
    };

    const parsed = LegendSeedSchema.safeParse(invalidOutfield);
    expect(parsed.success).toBe(false);
  });

  it('4. should reject legend IDs that do not follow stable leg- prefix convention', () => {
    const invalidIdLegend = {
      legendId: 'cristiano-ronaldo', // missing leg- prefix
      canonicalKey: 'cristiano-ronaldo-prime',
      fullName: 'Cristiano Ronaldo',
      nationality: 'Portugal',
      dateOfBirth: '1985-02-05',
      primaryPosition: 'LW',
      secondaryPositions: [],
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
      legendCoinPriceEur: 150000000,
      status: 'ACTIVE',
      sourceId: 'src-legend-research-2026',
      ratingMethodology: 'Peak career analysis',
    };

    const parsed = LegendSeedSchema.safeParse(invalidIdLegend);
    expect(parsed.success).toBe(false);
  });

  it('5. should confirm valid infrastructure report for draft/empty legends dataset', () => {
    const report = validateLegends();
    expect(report.snapshotDate).toBe('2026-08-19');
    expect(report.isValid).toBe(true);
    expect(report.totalLegends).toBe(0);
    expect(report.isFinalDatasetReady).toBe(false);
  });

  it('6. [Final-Dataset Gate] should verify ALL 15 positions have at least 3 legends when dataset is populated', () => {
    const report = validateLegends();
    // During infrastructure phase, dataset is empty draft, so isFinalDatasetReady MUST be false.
    // When populated in later phase, this gate will verify dataset completeness.
    expect(ALL_SUPPORTED_POSITIONS.length).toBe(15);
    if (report.totalLegends === 0) {
      expect(report.isFinalDatasetReady).toBe(false);
    } else {
      expect(report.isFinalDatasetReady).toBe(true);
    }
  });
});
