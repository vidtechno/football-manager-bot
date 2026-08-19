import fs from 'node:fs';
import path from 'node:path';
import { validateDataset } from './validate-dataset.js';
import { ClubMetadata, PlayerSeed } from './types.js';

export function generateSeedSql(
  baseDir: string = path.resolve(process.cwd(), 'data/football/2026-08-19'),
  outputSqlPath: string = path.resolve(process.cwd(), 'supabase/seed.sql'),
): void {
  const report = validateDataset(baseDir);
  if (!report.isValid) {
    throw new Error('Cannot generate seed SQL: Dataset validation failed.');
  }

  const rawClubs: ClubMetadata[] = JSON.parse(
    fs.readFileSync(path.join(baseDir, 'clubs.json'), 'utf-8'),
  );
  const rawPlayers: PlayerSeed[] = JSON.parse(
    fs.readFileSync(path.join(baseDir, 'players.json'), 'utf-8'),
  );

  let sql = `-- Reprodusibl Phase 4E Seed Data generated on ${new Date().toISOString()}\n`;
  sql += `-- Snapshot Date: ${report.snapshotDate}\n`;
  sql += `-- Total Clubs: ${report.totalClubs}, Total Players: ${report.totalPlayers}, Total Value: €${report.totalLeagueMarketValueEur.toLocaleString()}\n\n`;

  sql += `BEGIN;\n\n`;

  // Seed club template versions for all 20 clubs
  sql += `-- 1. Seed Initial Club Template Versions (v1)\n`;
  for (const clubSummary of report.clubSummaries) {
    const clubMeta = rawClubs.find((c) => c.slug === clubSummary.slug)!;
    sql += `INSERT INTO public.club_template_versions (\n`;
    sql += `    club_template_id,\n`;
    sql += `    version,\n`;
    sql += `    reputation,\n`;
    sql += `    base_squad_value,\n`;
    sql += `    is_current\n`;
    sql += `) VALUES (\n`;
    sql += `    (SELECT id FROM public.club_templates WHERE slug = '${clubMeta.slug}'),\n`;
    sql += `    1,\n`;
    sql += `    ${clubMeta.reputation},\n`;
    sql += `    ${clubSummary.totalMarketValueEur}.00,\n`;
    sql += `    TRUE\n`;
    sql += `) ON CONFLICT (club_template_id, version) DO NOTHING;\n\n`;
  }

  // Seed player templates, positions, and player template versions
  sql += `-- 2. Seed Player Templates, Positions, and Relational Attribute Versions (v1)\n`;
  sql += `DO $$\nDECLARE\n    v_club_id UUID;\n    v_player_id UUID;\nBEGIN\n`;

  for (const p of rawPlayers) {
    const secArray =
      p.secondaryPositions.length > 0
        ? `ARRAY[${p.secondaryPositions.map((pos: string) => `'${pos}'::public.enum_player_position`).join(', ')}]`
        : `'{}'::public.enum_player_position[]`;

    sql += `    -- Player: ${p.fullName} (${p.canonicalKey})\n`;
    sql += `    SELECT id INTO v_club_id FROM public.club_templates WHERE slug = '${p.clubSlug}';\n`;
    sql += `    IF NOT EXISTS (SELECT 1 FROM public.player_templates WHERE canonical_key = '${p.canonicalKey}') THEN\n`;
    sql += `        v_player_id := public.create_player_template_with_positions(\n`;
    sql += `            '${p.canonicalKey}',\n`;
    sql += `            v_club_id,\n`;
    sql += `            '${p.fullName.replace(/'/g, "''")}',\n`;
    sql += `            '${p.dateOfBirth}',\n`;
    sql += `            '${p.nationality.replace(/'/g, "''")}',\n`;
    sql += `            '${p.primaryPosition}'::public.enum_player_position,\n`;
    sql += `            ${secArray}\n`;
    sql += `        );\n`;

    if (p.primaryPosition === 'GK') {
      const g = p.goalkeeperAttributes!;
      sql += `        INSERT INTO public.player_template_versions (\n`;
      sql += `            player_template_id, version, market_value_eur, overall_rating,\n`;
      sql += `            reflexes, handling, positioning, aerial_ability, distribution, one_on_one, is_current\n`;
      sql += `        ) VALUES (\n`;
      sql += `            v_player_id, 1, ${p.marketValueEur}.00, ${p.overallRating},\n`;
      sql += `            ${g.reflexes}, ${g.handling}, ${g.positioning}, ${g.aerialAbility}, ${g.distribution}, ${g.oneOnOne}, TRUE\n`;
      sql += `        );\n`;
    } else {
      const o = p.outfieldAttributes!;
      sql += `        INSERT INTO public.player_template_versions (\n`;
      sql += `            player_template_id, version, market_value_eur, overall_rating,\n`;
      sql += `            pace, shooting, passing, dribbling, defending, physical, is_current\n`;
      sql += `        ) VALUES (\n`;
      sql += `            v_player_id, 1, ${p.marketValueEur}.00, ${p.overallRating},\n`;
      sql += `            ${o.pace}, ${o.shooting}, ${o.passing}, ${o.dribbling}, ${o.defending}, ${o.physical}, TRUE\n`;
      sql += `        );\n`;
    }
    sql += `    END IF;\n\n`;
  }

  sql += `END $$;\n\n`;
  sql += `COMMIT;\n`;

  const seedDir = path.dirname(outputSqlPath);
  if (!fs.existsSync(seedDir)) {
    fs.mkdirSync(seedDir, { recursive: true });
  }

  fs.writeFileSync(outputSqlPath, sql);
  console.log(
    `Generated reproducible seed SQL at ${outputSqlPath} (${(sql.length / 1024).toFixed(2)} KB).`,
  );
}

if (process.argv[1] && process.argv[1].includes('generate-seed-sql')) {
  generateSeedSql();
}
