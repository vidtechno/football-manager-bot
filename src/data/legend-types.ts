import { z } from 'zod';
import {
  PlayerPositionEnum,
  OutfieldAttributesSchema,
  GoalkeeperAttributesSchema,
} from './types.js';

export const LegendStatusSchema = z.enum(['RETIRED', 'ACTIVE']);
export type LegendStatus = z.infer<typeof LegendStatusSchema>;

export const LegendSeedSchema = z
  .object({
    legendId: z
      .string()
      .regex(
        /^leg-[a-z0-9-]+$/,
        'legendId must start with leg- and be lowercase kebab-case',
      ),
    canonicalKey: z
      .string()
      .regex(/^[a-z0-9-]+$/, 'canonicalKey must be lowercase kebab-case'),
    fullName: z.string().min(1),
    nationality: z.string().min(1),
    dateOfBirth: z
      .string()
      .regex(/^\d{4}-\d{2}-\d{2}$/, 'dateOfBirth must be YYYY-MM-DD format'),
    primaryPosition: PlayerPositionEnum,
    secondaryPositions: z.array(PlayerPositionEnum).default([]),
    peakClub: z.string().min(1),
    peakPeriod: z.string().min(1),
    peakOverallRating: z.number().int().min(1).max(99),
    outfieldAttributes: OutfieldAttributesSchema.optional(),
    goalkeeperAttributes: GoalkeeperAttributesSchema.optional(),
    legendTransferPriceEur: z
      .number()
      .int()
      .min(100_000_000, 'Minimum legend price is €100,000,000')
      .max(500_000_000, 'Maximum legend price is €500,000,000'),
    status: LegendStatusSchema,
    sourceId: z.string().min(1),
    ratingMethodology: z.string().min(1),
    historicalStats: z.record(z.string(), z.unknown()).optional(),
  })
  .superRefine((data, ctx) => {
    if (
      (data.canonicalKey === 'cristiano-ronaldo-prime' ||
        data.canonicalKey === 'lionel-messi-prime') &&
      data.legendTransferPriceEur !== 500_000_000
    ) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        message:
          'Peak Cristiano Ronaldo and Lionel Messi must cost exactly €500,000,000',
        path: ['legendTransferPriceEur'],
      });
    }

    if (data.primaryPosition === 'GK') {
      if (!data.goalkeeperAttributes) {
        ctx.addIssue({
          code: z.ZodIssueCode.custom,
          message: 'Goalkeeper legend must specify goalkeeperAttributes',
          path: ['goalkeeperAttributes'],
        });
      }
      if (data.outfieldAttributes) {
        ctx.addIssue({
          code: z.ZodIssueCode.custom,
          message: 'Goalkeeper legend must not specify outfieldAttributes',
          path: ['outfieldAttributes'],
        });
      }
    } else {
      if (!data.outfieldAttributes) {
        ctx.addIssue({
          code: z.ZodIssueCode.custom,
          message: 'Outfield legend must specify outfieldAttributes',
          path: ['outfieldAttributes'],
        });
      }
      if (data.goalkeeperAttributes) {
        ctx.addIssue({
          code: z.ZodIssueCode.custom,
          message: 'Outfield legend must not specify goalkeeperAttributes',
          path: ['goalkeeperAttributes'],
        });
      }
    }
  });

export type LegendSeed = z.infer<typeof LegendSeedSchema>;

export interface LegendDatasetReport {
  snapshotDate: string;
  totalLegends: number;
  positionsCovered: Record<string, number>;
  isValid: boolean;
  isFinalDatasetReady: boolean;
  errors: string[];
}
