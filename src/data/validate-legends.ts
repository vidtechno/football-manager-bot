import fs from 'node:fs';
import path from 'node:path';
import {
  LegendSeedSchema,
  LegendSeed,
  LegendDatasetReport,
} from './legend-types.js';

export const ALL_SUPPORTED_POSITIONS = [
  'GK',
  'CB',
  'LB',
  'RB',
  'LWB',
  'RWB',
  'CDM',
  'CM',
  'CAM',
  'LM',
  'RM',
  'LW',
  'RW',
  'CF',
  'ST',
] as const;

export function validateLegends(
  baseDir = path.join(process.cwd(), 'data/football/legends'),
): LegendDatasetReport {
  const filePath = path.join(baseDir, 'legends.json');
  const errors: string[] = [];

  if (!fs.existsSync(filePath)) {
    return {
      snapshotDate: '2026-08-19',
      totalLegends: 0,
      positionsCovered: {},
      isValid: false,
      isFinalDatasetReady: false,
      errors: [`Legends file not found at ${filePath}`],
    };
  }

  const rawData = fs.readFileSync(filePath, 'utf-8');
  let rawJson: unknown;
  try {
    rawJson = JSON.parse(rawData);
  } catch (err) {
    return {
      snapshotDate: '2026-08-19',
      totalLegends: 0,
      positionsCovered: {},
      isValid: false,
      isFinalDatasetReady: false,
      errors: [`Failed to parse JSON: ${String(err)}`],
    };
  }

  if (!Array.isArray(rawJson)) {
    return {
      snapshotDate: '2026-08-19',
      totalLegends: 0,
      positionsCovered: {},
      isValid: false,
      isFinalDatasetReady: false,
      errors: ['legends.json content must be a JSON array'],
    };
  }

  const legends: LegendSeed[] = [];
  const seenLegendIds = new Set<string>();
  const seenCanonicalKeys = new Set<string>();
  const positionsCovered: Record<string, number> = {};

  for (const pos of ALL_SUPPORTED_POSITIONS) {
    positionsCovered[pos] = 0;
  }

  rawJson.forEach((item, index) => {
    const parsed = LegendSeedSchema.safeParse(item);
    if (!parsed.success) {
      errors.push(`Record index ${index} invalid: ${parsed.error.message}`);
      return;
    }

    const legend = parsed.data;
    if (seenLegendIds.has(legend.legendId)) {
      errors.push(`Duplicate legendId: ${legend.legendId}`);
    }
    seenLegendIds.add(legend.legendId);

    if (seenCanonicalKeys.has(legend.canonicalKey)) {
      errors.push(`Duplicate canonicalKey: ${legend.canonicalKey}`);
    }
    seenCanonicalKeys.add(legend.canonicalKey);

    positionsCovered[legend.primaryPosition] =
      (positionsCovered[legend.primaryPosition] || 0) + 1;

    legends.push(legend);
  });

  const isFinalDatasetReady = ALL_SUPPORTED_POSITIONS.every(
    (pos) => (positionsCovered[pos] || 0) >= 3,
  );

  const isValid = errors.length === 0;

  return {
    snapshotDate: '2026-08-19',
    totalLegends: legends.length,
    positionsCovered,
    isValid,
    isFinalDatasetReady,
    errors,
  };
}

if (process.argv[1] && process.argv[1].includes('validate-legends')) {
  const report = validateLegends();
  console.log(`Legend Dataset Validation (Snapshot: ${report.snapshotDate}):`);
  console.log(`- Total Legends: ${report.totalLegends}`);
  console.log(`- Valid Infrastructure: ${report.isValid ? 'YES ✅' : 'NO ❌'}`);
  console.log(
    `- Final Dataset Ready (>=3 legends per position): ${report.isFinalDatasetReady ? 'YES ✅' : 'NO ❌ (Draft/Incomplete Infrastructure Phase)'}`,
  );
  if (!report.isValid) {
    console.error('Errors:', report.errors);
    process.exit(1);
  }
}
