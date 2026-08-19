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

export const REQUIRED_LEGEND_IDS = [
  'leg-cristiano-ronaldo-prime',
  'leg-lionel-messi-prime',
  'leg-marcelo-prime',
  'leg-gareth-bale-prime',
  'leg-eden-hazard-prime',
  'leg-luka-modric-prime',
  'leg-toni-kroos-prime',
  'leg-xavi-prime',
  'leg-andres-iniesta-prime',
];

export function validateLegends(
  baseDir = path.join(process.cwd(), 'data/football/legends'),
): LegendDatasetReport {
  const filePath = path.join(baseDir, 'legends.json');
  const sourcesPath = path.join(baseDir, 'sources.json');
  const playersPath = path.join(
    process.cwd(),
    'data/football/2026-08-19/players.json',
  );
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

  // Load valid source IDs
  const validSourceIds = new Set<string>();
  if (fs.existsSync(sourcesPath)) {
    try {
      const sourcesJson = JSON.parse(fs.readFileSync(sourcesPath, 'utf-8'));
      if (Array.isArray(sourcesJson)) {
        sourcesJson.forEach((s: Record<string, unknown>) => {
          if (typeof s['sourceId'] === 'string')
            validSourceIds.add(s['sourceId']);
        });
      }
    } catch {
      errors.push(`Failed to parse sources.json at ${sourcesPath}`);
    }
  }

  // Load active player canonical keys to ensure zero collision
  const activePlayerKeys = new Set<string>();
  if (fs.existsSync(playersPath)) {
    try {
      const playersJson = JSON.parse(fs.readFileSync(playersPath, 'utf-8'));
      if (Array.isArray(playersJson)) {
        playersJson.forEach((p: Record<string, unknown>) => {
          if (typeof p['canonicalKey'] === 'string')
            activePlayerKeys.add(p['canonicalKey']);
        });
      }
    } catch {
      // Optional check
    }
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

    // Check legendId uniqueness
    if (seenLegendIds.has(legend.legendId)) {
      errors.push(`Duplicate legendId: ${legend.legendId}`);
    }
    seenLegendIds.add(legend.legendId);

    // Check canonicalKey uniqueness & collision with active players
    if (seenCanonicalKeys.has(legend.canonicalKey)) {
      errors.push(`Duplicate canonicalKey: ${legend.canonicalKey}`);
    }
    if (activePlayerKeys.has(legend.canonicalKey)) {
      errors.push(
        `CanonicalKey collision with active player: ${legend.canonicalKey}`,
      );
    }
    seenCanonicalKeys.add(legend.canonicalKey);

    // Verify sourceId exists in sources.json
    if (validSourceIds.size > 0 && !validSourceIds.has(legend.sourceId)) {
      errors.push(
        `Unresolved sourceId '${legend.sourceId}' for legendId '${legend.legendId}'`,
      );
    }

    // Position coverage
    positionsCovered[legend.primaryPosition] =
      (positionsCovered[legend.primaryPosition] || 0) + 1;

    legends.push(legend);
  });

  // Verify required legends presence
  for (const reqId of REQUIRED_LEGEND_IDS) {
    if (!seenLegendIds.has(reqId)) {
      errors.push(`Missing required legend: ${reqId}`);
    }
  }

  const isFinalDatasetReady =
    ALL_SUPPORTED_POSITIONS.every((pos) => (positionsCovered[pos] || 0) >= 3) &&
    REQUIRED_LEGEND_IDS.every((reqId) => seenLegendIds.has(reqId));

  const isValid = errors.length === 0;

  const report: LegendDatasetReport = {
    snapshotDate: '2026-08-19',
    totalLegends: legends.length,
    positionsCovered,
    isValid,
    isFinalDatasetReady,
    errors,
  };

  // Write validation report JSON
  const reportPath = path.join(baseDir, 'validation-report.json');
  fs.writeFileSync(reportPath, JSON.stringify(report, null, 2), 'utf-8');

  return report;
}

if (process.argv[1] && process.argv[1].includes('validate-legends')) {
  const report = validateLegends();
  console.log(`Legend Dataset Validation (Snapshot: ${report.snapshotDate}):`);
  console.log(`- Total Legends: ${report.totalLegends}`);
  console.log(`- Valid Infrastructure: ${report.isValid ? 'YES ✅' : 'NO ❌'}`);
  console.log(
    `- Final Dataset Ready (>=3 legends per position): ${report.isFinalDatasetReady ? 'YES ✅' : 'NO ❌'}`,
  );
  if (!report.isValid) {
    console.error('Errors:', report.errors);
    process.exit(1);
  }
}
