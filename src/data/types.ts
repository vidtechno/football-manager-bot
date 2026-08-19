import { z } from 'zod';

export const PlayerPositionEnum = z.enum([
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
]);
export type PlayerPosition = z.infer<typeof PlayerPositionEnum>;

export const ClubMetadataSchema = z.object({
  slug: z.string().regex(/^[a-z0-9-]+$/),
  name: z.string().min(1),
  shortCode: z.string().length(3),
  country: z.string().min(1),
  domesticLeague: z.string().min(1),
  reputation: z.number().int().min(1).max(100),
});
export type ClubMetadata = z.infer<typeof ClubMetadataSchema>;

export const OutfieldAttributesSchema = z.object({
  pace: z.number().int().min(1).max(99),
  shooting: z.number().int().min(1).max(99),
  passing: z.number().int().min(1).max(99),
  dribbling: z.number().int().min(1).max(99),
  defending: z.number().int().min(1).max(99),
  physical: z.number().int().min(1).max(99),
});
export type OutfieldAttributes = z.infer<typeof OutfieldAttributesSchema>;

export const GoalkeeperAttributesSchema = z.object({
  reflexes: z.number().int().min(1).max(99),
  handling: z.number().int().min(1).max(99),
  positioning: z.number().int().min(1).max(99),
  aerialAbility: z.number().int().min(1).max(99),
  distribution: z.number().int().min(1).max(99),
  oneOnOne: z.number().int().min(1).max(99),
});
export type GoalkeeperAttributes = z.infer<typeof GoalkeeperAttributesSchema>;

export const PlayerSeedSchema = z.object({
  canonicalKey: z.string().regex(/^[a-z0-9-]+$/),
  fullName: z.string().min(1),
  dateOfBirth: z.string().regex(/^\d{4}-\d{2}-\d{2}$/),
  nationality: z.string().min(1),
  clubSlug: z.string().min(1),
  primaryPosition: PlayerPositionEnum,
  secondaryPositions: z.array(PlayerPositionEnum).default([]),
  marketValueEur: z.number().int().nonnegative(),
  overallRating: z.number().int().min(1).max(99),
  outfieldAttributes: OutfieldAttributesSchema.optional(),
  goalkeeperAttributes: GoalkeeperAttributesSchema.optional(),
  isLoan: z.boolean().default(false),
  loanParentClub: z.string().optional(),
  sourceId: z.string().min(1),
});
export type PlayerSeed = z.infer<typeof PlayerSeedSchema>;

export const SourceMetadataSchema = z.object({
  id: z.string().min(1),
  name: z.string().min(1),
  url: z.string().url(),
  retrievalDate: z.string().regex(/^\d{4}-\d{2}-\d{2}$/),
  category: z.enum([
    'OFFICIAL_CLUB',
    'LEAGUE_REGISTRATION',
    'TRANSFER_DATABASE',
    'GAME_DATABASE',
  ]),
});
export type SourceMetadata = z.infer<typeof SourceMetadataSchema>;
