import fs from 'node:fs';
import path from 'node:path';
import {
  ClubMetadataSchema,
  PlayerSeedSchema,
  SourceMetadataSchema,
  ClubMetadata,
  PlayerSeed,
  SourceMetadata,
} from './types.js';

export interface ClubValidationSummary {
  slug: string;
  name: string;
  playerCount: number;
  goalkeeperCount: number;
  totalMarketValueEur: number;
  averageOverallRating: number;
  highestRatedPlayer: { name: string; rating: number };
  mostValuablePlayer: { name: string; valueEur: number };
  isSquadValid: boolean;
  errors: string[];
}

export interface DatasetValidationReport {
  snapshotDate: string;
  totalClubs: number;
  totalPlayers: number;
  totalGoalkeepers: number;
  totalLeagueMarketValueEur: number;
  isValid: boolean;
  clubSummaries: ClubValidationSummary[];
  globalErrors: string[];
}

export function validateDataset(
  baseDir: string = path.resolve(process.cwd(), 'data/football/2026-08-19'),
): DatasetValidationReport {
  const clubsPath = path.join(baseDir, 'clubs.json');
  const playersPath = path.join(baseDir, 'players.json');
  const sourcesPath = path.join(baseDir, 'sources.json');

  const globalErrors: string[] = [];

  if (!fs.existsSync(clubsPath))
    globalErrors.push(`Missing clubs.json at ${clubsPath}`);
  if (!fs.existsSync(playersPath))
    globalErrors.push(`Missing players.json at ${playersPath}`);
  if (!fs.existsSync(sourcesPath))
    globalErrors.push(`Missing sources.json at ${sourcesPath}`);

  if (globalErrors.length > 0) {
    return {
      snapshotDate: '2026-08-19',
      totalClubs: 0,
      totalPlayers: 0,
      totalGoalkeepers: 0,
      totalLeagueMarketValueEur: 0,
      isValid: false,
      clubSummaries: [],
      globalErrors,
    };
  }

  const rawClubs = JSON.parse(fs.readFileSync(clubsPath, 'utf-8'));
  const rawPlayers = JSON.parse(fs.readFileSync(playersPath, 'utf-8'));
  const rawSources = JSON.parse(fs.readFileSync(sourcesPath, 'utf-8'));

  const clubs: ClubMetadata[] = [];
  for (const c of rawClubs) {
    const res = ClubMetadataSchema.safeParse(c);
    if (!res.success) {
      globalErrors.push(
        `Invalid club metadata: ${JSON.stringify(c)} - ${res.error.message}`,
      );
    } else {
      clubs.push(res.data);
    }
  }

  if (clubs.length !== 20) {
    globalErrors.push(
      `Dataset must contain exactly 20 clubs, found ${clubs.length}`,
    );
  }

  const sourcesMap = new Map<string, SourceMetadata>();
  for (const s of rawSources) {
    const res = SourceMetadataSchema.safeParse(s);
    if (!res.success) {
      globalErrors.push(
        `Invalid source metadata: ${JSON.stringify(s)} - ${res.error.message}`,
      );
    } else {
      sourcesMap.set(res.data.id, res.data);
    }
  }

  const players: PlayerSeed[] = [];
  const seenCanonicalKeys = new Set<string>();

  for (const p of rawPlayers) {
    const res = PlayerSeedSchema.safeParse(p);
    if (!res.success) {
      globalErrors.push(
        `Invalid player record for canonicalKey ${p.canonicalKey}: ${res.error.message}`,
      );
      continue;
    }
    const player = res.data;

    // Check duplicate key
    if (seenCanonicalKeys.has(player.canonicalKey)) {
      globalErrors.push(
        `Duplicate player canonicalKey detected: ${player.canonicalKey}`,
      );
    } else {
      seenCanonicalKeys.add(player.canonicalKey);
    }

    // Check GK vs Outfield attribute separation
    if (player.primaryPosition === 'GK') {
      if (!player.goalkeeperAttributes) {
        globalErrors.push(
          `Goalkeeper ${player.fullName} (${player.canonicalKey}) missing goalkeeperAttributes`,
        );
      }
      if (player.outfieldAttributes) {
        globalErrors.push(
          `Goalkeeper ${player.fullName} (${player.canonicalKey}) must not have outfieldAttributes`,
        );
      }
    } else {
      if (!player.outfieldAttributes) {
        globalErrors.push(
          `Outfield player ${player.fullName} (${player.canonicalKey}) missing outfieldAttributes`,
        );
      }
      if (player.goalkeeperAttributes) {
        globalErrors.push(
          `Outfield player ${player.fullName} (${player.canonicalKey}) must not have goalkeeperAttributes`,
        );
      }
    }

    // Check source provenance
    if (!sourcesMap.has(player.sourceId)) {
      globalErrors.push(
        `Player ${player.fullName} (${player.canonicalKey}) references unknown sourceId: ${player.sourceId}`,
      );
    }

    players.push(player);
  }

  // Per-club validation
  const clubSummaries: ClubValidationSummary[] = [];
  let totalGoalkeepers = 0;
  let totalLeagueMarketValueEur = 0;

  for (const club of clubs) {
    const clubPlayers = players.filter((p) => p.clubSlug === club.slug);
    const clubErrors: string[] = [];

    const playerCount = clubPlayers.length;
    if (playerCount < 18 || playerCount > 30) {
      clubErrors.push(
        `Club ${club.name} (${club.slug}) squad size must be 18..30, found ${playerCount}`,
      );
    }

    const goalkeepers = clubPlayers.filter((p) => p.primaryPosition === 'GK');
    const goalkeeperCount = goalkeepers.length;
    if (goalkeeperCount < 2) {
      clubErrors.push(
        `Club ${club.name} (${club.slug}) must have at least 2 goalkeepers, found ${goalkeeperCount}`,
      );
    }

    const defPositions = new Set(['CB', 'LB', 'RB', 'LWB', 'RWB']);
    const midPositions = new Set(['CDM', 'CM', 'CAM', 'LM', 'RM']);
    const fwdPositions = new Set(['LW', 'RW', 'CF', 'ST']);

    const defenderCount = clubPlayers.filter((p) =>
      defPositions.has(p.primaryPosition),
    ).length;
    if (defenderCount < 6) {
      clubErrors.push(
        `Club ${club.name} (${club.slug}) must have at least 6 defenders, found ${defenderCount}`,
      );
    }

    const midfielderCount = clubPlayers.filter((p) =>
      midPositions.has(p.primaryPosition),
    ).length;
    if (midfielderCount < 6) {
      clubErrors.push(
        `Club ${club.name} (${club.slug}) must have at least 6 midfielders, found ${midfielderCount}`,
      );
    }

    const forwardCount = clubPlayers.filter((p) =>
      fwdPositions.has(p.primaryPosition),
    ).length;
    if (forwardCount < 4) {
      clubErrors.push(
        `Club ${club.name} (${club.slug}) must have at least 4 forwards, found ${forwardCount}`,
      );
    }

    totalGoalkeepers += goalkeeperCount;

    let totalMarketValueEur = 0;
    let sumOverall = 0;
    let highestRated = { name: 'N/A', rating: 0 };
    let mostValuable = { name: 'N/A', valueEur: 0 };

    for (const p of clubPlayers) {
      totalMarketValueEur += p.marketValueEur;
      sumOverall += p.overallRating;

      if (p.overallRating > highestRated.rating) {
        highestRated = { name: p.fullName, rating: p.overallRating };
      }
      if (p.marketValueEur > mostValuable.valueEur) {
        mostValuable = { name: p.fullName, valueEur: p.marketValueEur };
      }
    }

    totalLeagueMarketValueEur += totalMarketValueEur;
    const averageOverallRating =
      playerCount > 0 ? Number((sumOverall / playerCount).toFixed(2)) : 0;

    clubSummaries.push({
      slug: club.slug,
      name: club.name,
      playerCount,
      goalkeeperCount,
      totalMarketValueEur,
      averageOverallRating,
      highestRatedPlayer: highestRated,
      mostValuablePlayer: mostValuable,
      isSquadValid: clubErrors.length === 0,
      errors: clubErrors,
    });
  }

  const isValid =
    globalErrors.length === 0 && clubSummaries.every((s) => s.isSquadValid);

  const report: DatasetValidationReport = {
    snapshotDate: '2026-08-19',
    totalClubs: clubs.length,
    totalPlayers: players.length,
    totalGoalkeepers,
    totalLeagueMarketValueEur,
    isValid,
    clubSummaries,
    globalErrors,
  };

  fs.writeFileSync(
    path.join(baseDir, 'validation-report.json'),
    JSON.stringify(report, null, 2) + '\n',
  );

  return report;
}

if (process.argv[1] && process.argv[1].includes('validate-dataset')) {
  const report = validateDataset();
  console.log(
    `Phase 4E Dataset Validation Results (Snapshot: ${report.snapshotDate}):`,
  );
  console.log(`- Total Clubs: ${report.totalClubs}`);
  console.log(`- Total Players: ${report.totalPlayers}`);
  console.log(`- Total Goalkeepers: ${report.totalGoalkeepers}`);
  console.log(
    `- Total Combined League Market Value: €${report.totalLeagueMarketValueEur.toLocaleString()}`,
  );
  console.log(
    `- Overall Dataset Valid: ${report.isValid ? 'YES ✅' : 'NO ❌'}`,
  );
  if (!report.isValid) {
    console.error('Global Errors:', report.globalErrors);
    for (const c of report.clubSummaries) {
      if (!c.isSquadValid) {
        console.error(`Club ${c.name} Errors:`, c.errors);
      }
    }
    process.exit(1);
  }
}
