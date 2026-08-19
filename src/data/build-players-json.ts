import { validateDataset } from './validate-dataset.js';

/**
 * Legacy generator wrapper.
 * This runner delegates directly to validateDataset() to ensure players.json
 * (containing 567 active players across 20 clubs) is never overwritten by obsolete data.
 */
export function safeBuildPlayersJson(): void {
  console.log('Running safe player dataset validation...');
  const report = validateDataset();
  if (!report.isValid) {
    throw new Error('Dataset validation failed.');
  }
  console.log('Player dataset is valid and preserved.');
}

if (process.argv[1] && process.argv[1].includes('build-players-json')) {
  safeBuildPlayersJson();
}
