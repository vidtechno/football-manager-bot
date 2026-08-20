export type NavTab =
  | 'dashboard'
  | 'squad'
  | 'transfers'
  | 'legends'
  | 'finances'
  | 'sponsor'
  | 'profile'
  | 'admin';

export interface Club {
  id: string;
  name: string;
  shortCode: string;
  slug: string;
  reputation: number;
  balanceEur: number;
  stadiumCapacity: number;
}

export interface PlayerAttributes {
  pace: number;
  shooting: number;
  passing: number;
  dribbling: number;
  defending: number;
  physical: number;
}

export interface Player {
  id: string;
  fullName: string;
  primaryPosition:
    | 'GK'
    | 'DEF'
    | 'MID'
    | 'FWD'
    | 'CB'
    | 'LB'
    | 'RB'
    | 'CDM'
    | 'CM'
    | 'CAM'
    | 'LW'
    | 'RW'
    | 'ST';
  overallRating: number;
  marketValueEur: number;
  nationality: string;
  attributes: PlayerAttributes;
  isStarting: boolean;
  pitchX?: number;
  pitchY?: number;
}

export interface LegendPlayer {
  id: string;
  fullName: string;
  era: string;
  primaryPosition: string;
  overallRating: number;
  priceEur: number;
  nationality: string;
  attributes: PlayerAttributes;
}

export interface StandingRow {
  position: number;
  clubName: string;
  shortCode: string;
  played: number;
  won: number;
  drawn: number;
  lost: number;
  goalsFor: number;
  goalsAgainst: number;
  goalDifference: number;
  points: number;
}

export interface MatchResult {
  homeClubName: string;
  awayClubName: string;
  homeScore: number;
  awayScore: number;
  scorers: string[];
}

export interface TransferListing {
  id: string;
  playerName: string;
  position: string;
  overallRating: number;
  priceEur: number;
  sellerClubName: string;
  listedAt: string;
}

export interface LedgerItem {
  id: string;
  type: string;
  description: string;
  amountEur: number;
  date: string;
}
