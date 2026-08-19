import { getSupabaseAdminClient } from '../database/client.js';

export interface LeagueSummary {
  id: string;
  name: string;
  code: string;
  status: string;
  role: string;
  clubId: string | null;
  clubName: string | null;
  budget: number;
}

export interface ClubChoice {
  id: string;
  name: string;
  shortCode: string;
  taken: boolean;
}

export interface SquadPlayer {
  id: string;
  name: string;
  rating: number;
  value: number;
  position: string;
  availability: string;
}

export class GameService {
  static async createLeague(
    managerId: string,
    name: string,
  ): Promise<LeagueSummary> {
    const db = getSupabaseAdminClient();
    const { data, error } = await db.rpc('create_league_with_owner', {
      p_owner_manager_id: managerId,
      p_league_name: name.trim(),
      p_round_speed: 1,
    });
    if (error) throw new Error(error.message);
    const leagueId = String(data.league_id);
    const { error: initError } = await db.rpc(
      'initialize_gigants_league_clubs',
      {
        p_league_id: leagueId,
      },
    );
    if (initError) throw new Error(initError.message);
    return {
      id: leagueId,
      name: String(data.name),
      code: String(data.code),
      status: String(data.status),
      role: 'OWNER',
      clubId: null,
      clubName: null,
      budget: 0,
    };
  }

  static async joinLeague(
    managerId: string,
    code: string,
  ): Promise<LeagueSummary> {
    const db = getSupabaseAdminClient();
    const { data, error } = await db.rpc('join_league_by_code', {
      p_manager_id: managerId,
      p_code: code.trim().toUpperCase(),
    });
    if (error) throw new Error(error.message);
    return {
      id: String(data.league_id),
      name: String(data.name),
      code: String(data.code),
      status: String(data.status),
      role: 'MEMBER',
      clubId: null,
      clubName: null,
      budget: 0,
    };
  }

  static async getManagerLeagues(managerId: string): Promise<LeagueSummary[]> {
    const db = getSupabaseAdminClient();
    const { data: memberships, error } = await db
      .from('league_members')
      .select('league_id, role, leagues!inner(id,name,code,status)')
      .eq('manager_id', managerId)
      .is('left_at', null);
    if (error) throw new Error(error.message);
    const result: LeagueSummary[] = [];
    for (const item of memberships ?? []) {
      const rawLeague = item.leagues as unknown;
      const league = (Array.isArray(rawLeague) ? rawLeague[0] : rawLeague) as {
        id: string;
        name: string;
        code: string;
        status: string;
      };
      const { data: club } = await db
        .from('league_clubs')
        .select('id,display_name,club_finances(available_balance)')
        .eq('league_id', league.id)
        .eq('human_manager_id', managerId)
        .maybeSingle();
      const financeRaw = club?.club_finances as unknown;
      const finance = (
        Array.isArray(financeRaw) ? financeRaw[0] : financeRaw
      ) as { available_balance?: number | string } | null;
      result.push({
        id: league.id,
        name: league.name,
        code: league.code,
        status: league.status,
        role: String(item.role),
        clubId: club?.id ?? null,
        clubName: club?.display_name ?? null,
        budget: Number(finance?.available_balance ?? 0),
      });
    }
    return result;
  }

  static async getLeague(
    managerId: string,
    leagueId: string,
  ): Promise<LeagueSummary> {
    const leagues = await this.getManagerLeagues(managerId);
    const league = leagues.find((entry) => entry.id === leagueId);
    if (!league) throw new Error('Siz ushbu liga a’zosi emassiz.');
    return league;
  }

  static async getAvailableClubs(leagueId: string): Promise<ClubChoice[]> {
    const db = getSupabaseAdminClient();
    const { data, error } = await db
      .from('league_clubs')
      .select(
        'id,display_name,short_code,human_manager_id,bot_manager_assignments(is_active)',
      )
      .eq('league_id', leagueId)
      .order('display_name');
    if (error) throw new Error(error.message);
    return (data ?? []).map((club) => ({
      id: club.id,
      name: club.display_name,
      shortCode: club.short_code,
      taken:
        Boolean(club.human_manager_id) ||
        (
          (club.bot_manager_assignments as Array<{
            is_active: boolean;
          }> | null) ?? []
        ).some((x) => x.is_active),
    }));
  }

  static async selectClub(managerId: string, clubId: string): Promise<string> {
    const db = getSupabaseAdminClient();
    const { data: club, error: clubError } = await db
      .from('league_clubs')
      .select('league_id')
      .eq('id', clubId)
      .single();
    if (clubError) throw new Error(clubError.message);
    const leagueId = club.league_id;
    const { error } = await db.rpc('select_league_club', {
      p_manager_id: managerId,
      p_league_id: leagueId,
      p_league_club_id: clubId,
    });
    if (error) throw new Error(error.message);
    return leagueId;
  }

  static async startLeague(managerId: string, leagueId: string): Promise<void> {
    const db = getSupabaseAdminClient();
    const { error } = await db.rpc('start_playable_league', {
      p_league_id: leagueId,
      p_owner_manager_id: managerId,
    });
    if (error) throw new Error(error.message);
  }

  static async getSquad(clubId: string): Promise<SquadPlayer[]> {
    const db = getSupabaseAdminClient();
    const { data, error } = await db
      .from('league_players')
      .select(
        'id,full_name,overall_rating,market_value_eur,availability_status,league_player_positions(position_code,is_primary)',
      )
      .eq('league_club_id', clubId)
      .order('overall_rating', { ascending: false });
    if (error) throw new Error(error.message);
    return (data ?? []).map((p) => ({
      id: p.id,
      name: p.full_name,
      rating: p.overall_rating,
      value: Number(p.market_value_eur),
      availability: p.availability_status,
      position:
        (
          (p.league_player_positions as Array<{
            position_code: string;
            is_primary: boolean;
          }> | null) ?? []
        ).find((x) => x.is_primary)?.position_code ?? '—',
    }));
  }

  static async getTable(leagueId: string): Promise<
    Array<{
      name: string;
      p: number;
      w: number;
      d: number;
      l: number;
      gd: number;
      pts: number;
    }>
  > {
    const db = getSupabaseAdminClient();
    const [{ data: clubs, error }, { data: matches }] = await Promise.all([
      db
        .from('league_clubs')
        .select('id,display_name')
        .eq('league_id', leagueId),
      db
        .from('league_matches')
        .select('home_club_id,away_club_id,home_score,away_score')
        .eq('league_id', leagueId)
        .eq('status', 'COMPLETED'),
    ]);
    if (error) throw new Error(error.message);
    const table = new Map(
      (clubs ?? []).map((c) => [
        c.id,
        {
          name: c.display_name,
          p: 0,
          w: 0,
          d: 0,
          l: 0,
          gf: 0,
          ga: 0,
          gd: 0,
          pts: 0,
        },
      ]),
    );
    for (const m of matches ?? []) {
      const home = table.get(m.home_club_id);
      const away = table.get(m.away_club_id);
      if (!home || !away) continue;
      home.p++;
      away.p++;
      home.gf += m.home_score;
      home.ga += m.away_score;
      away.gf += m.away_score;
      away.ga += m.home_score;
      if (m.home_score > m.away_score) {
        home.w++;
        home.pts += 3;
        away.l++;
      } else if (m.home_score < m.away_score) {
        away.w++;
        away.pts += 3;
        home.l++;
      } else {
        home.d++;
        away.d++;
        home.pts++;
        away.pts++;
      }
    }
    return [...table.values()]
      .map((x) => ({ ...x, gd: x.gf - x.ga }))
      .sort((a, b) => b.pts - a.pts || b.gd - a.gd || b.gf - a.gf);
  }
}
