import React, { useState, useEffect, useCallback } from 'react';
import {
  NavTab,
  Club,
  Player,
  StandingRow,
  TransferListing,
  LegendPlayer,
  LedgerItem,
} from './web/types.js';
import { ApiClient, setAuthToken, getAuthToken } from './web/apiClient.js';
import { Navbar } from './web/components/Navbar.js';
import { MobileBottomNav } from './web/components/MobileBottomNav.js';
import { LeagueView } from './web/components/LeagueView.js';
import { SquadView } from './web/components/SquadView.js';
import { TransferView } from './web/components/TransferView.js';
import { LegendView } from './web/components/LegendView.js';
import { FinanceView } from './web/components/FinanceView.js';
import { SponsorView } from './web/components/SponsorView.js';
import { ProfileView } from './web/components/ProfileView.js';
import { AdminView } from './web/components/AdminView.js';
import { AuthModal } from './web/components/AuthModal.js';
import { MatchSimulatorModal } from './web/components/MatchSimulatorModal.js';

export const App: React.FC = () => {
  const [isAuthenticated, setIsAuthenticated] = useState<boolean>(false);
  const [isAdmin, setIsAdmin] = useState<boolean>(false);
  const [showAuthModal, setShowAuthModal] = useState<boolean>(false);
  const [loading, setLoading] = useState<boolean>(true);

  const [currentTab, setCurrentTab] = useState<NavTab>('dashboard');
  const [managerId, setManagerId] = useState<string>('');
  const [username, setUsername] = useState<string>('menejer');
  const [managerName, setManagerName] = useState<string>('Menejer');
  const [isTelegramLinked, setIsTelegramLinked] = useState<boolean>(false);
  const [telegramUserId, setTelegramUserId] = useState<number>(0);

  const [club, setClub] = useState<Club | null>(null);
  const [squad, setSquad] = useState<Player[]>([]);
  const [standings, setStandings] = useState<StandingRow[]>([]);
  const [transfers, setTransfers] = useState<TransferListing[]>([]);
  const [legends, setLegends] = useState<LegendPlayer[]>([]);
  const [finances, setFinances] = useState<LedgerItem[]>([]);

  // League details
  const [leagueId, setLeagueId] = useState<string>('');
  const [leagueName, setLeagueName] = useState<string>('Gigants Liga 2026');
  const [leagueMode, setLeagueMode] = useState<'GIGANTRY' | 'SOLO'>('GIGANTRY');
  const [invitationCode, setInvitationCode] = useState<string>('GIG2026');

  const [currentRound, setCurrentRound] = useState<number>(1);
  const [dailyRoundsUsed, setDailyRoundsUsed] = useState<number>(0);
  const [showMatchModal, setShowMatchModal] = useState<boolean>(false);

  // Refetch data from API
  const refreshAppData = useCallback(async () => {
    try {
      const userRes = await ApiClient.getCurrentUser();
      setManagerId(userRes.managerId);
      setUsername(userRes.username);
      setManagerName(userRes.managerName);
      setIsAdmin(userRes.isAdmin);
      setIsTelegramLinked(userRes.isTelegramLinked);
      setTelegramUserId(userRes.telegramUserId);

      const dashboard = await ApiClient.getDashboard();
      if (dashboard.activeLeague) {
        setLeagueId(dashboard.activeLeague.id);
        setLeagueName(dashboard.activeLeague.name);
        setLeagueMode(dashboard.activeLeague.mode);
        setInvitationCode(dashboard.activeLeague.invitationCode);
        setCurrentRound(dashboard.activeLeague.currentRound);
      }
      if (dashboard.club) {
        setClub({
          id: dashboard.club.id,
          name: dashboard.club.name,
          slug: dashboard.club.slug,
          shortCode: dashboard.club.slug.slice(0, 3).toUpperCase(),
          reputation: 85,
          balanceEur: dashboard.club.balanceEur,
          stadiumCapacity: dashboard.club.stadiumCapacity || 60000,
        });
      }
      setFinances(
        (dashboard.recentLedger || []).map((l: any) => ({
          id: l.id,
          type: l.transactionType,
          description: l.description,
          amountEur: l.amountEur,
          date: new Date(l.createdAt).toLocaleDateString('uz-UZ'),
        })),
      );

      // Load league standings
      const leagueRes = await ApiClient.getLeague();
      setStandings(leagueRes.standings || []);
      setDailyRoundsUsed(leagueRes.dailyRoundsUsed || 0);

      // Load squad
      const squadRes = await ApiClient.getSquad().catch(() => null);
      if (squadRes?.squad) {
        setSquad(squadRes.squad);
      }

      // Load legends
      const legendsRes = await ApiClient.getLegends().catch(() => null);
      if (legendsRes?.legends) {
        setLegends(legendsRes.legends);
      }

      // Load transfer listings
      const transferRes = await ApiClient.getListings().catch(() => null);
      if (transferRes?.listings) {
        setTransfers(transferRes.listings);
      }
    } catch (err: unknown) {
      if (err instanceof Error) {
        console.warn('API sync warning:', err.message);
      }
    }
  }, []);

  // Initial Authentication Check (Tries Session Cookie / Auth Token)
  useEffect(() => {
    async function initAuth() {
      setLoading(true);

      // 1. Try Telegram Mini App Login
      const telegramWebApp = (window as any).Telegram?.WebApp;
      const initData = telegramWebApp?.initData;

      if (initData) {
        try {
          const res = await ApiClient.login(
            undefined,
            undefined,
            true,
            initData,
          );
          setAuthToken(res.token);
          setIsAuthenticated(true);
          await refreshAppData();
          setLoading(false);
          return;
        } catch (err) {
          console.error('Telegram initData login failed:', err);
        }
      }

      // 2. Try JWT Auth Token or Session Cookie Refresh
      const token = getAuthToken();
      if (token) {
        try {
          setIsAuthenticated(true);
          await refreshAppData();
          setLoading(false);
          return;
        } catch {
          // Fall through to cookie refresh
        }
      }

      try {
        const refreshRes = await ApiClient.refreshSession();
        setAuthToken(refreshRes.token);
        setIsAuthenticated(true);
        await refreshAppData();
      } catch {
        setIsAuthenticated(false);
        setShowAuthModal(true);
      }
      setLoading(false);
    }

    initAuth();
  }, [refreshAppData]);

  const handleLogout = async () => {
    try {
      await ApiClient.logout();
    } catch {}
    setAuthToken(null);
    setIsAuthenticated(false);
    setIsAdmin(false);
    setShowAuthModal(true);
  };

  // League Actions
  const handleCreateLeague = async (
    name: string,
    mode: 'GIGANTRY' | 'SOLO',
  ) => {
    try {
      const res = await ApiClient.createLeague(name, mode);
      setLeagueId(res.leagueId);
      setLeagueName(name);
      setLeagueMode(mode);
      setInvitationCode(res.invitationCode);
      await refreshAppData();
    } catch (err: any) {
      alert(`Liga yaratishda xatolik: ${err.message}`);
    }
  };

  const handleJoinLeague = async (code: string) => {
    try {
      const res = await ApiClient.joinLeague(code);
      setLeagueId(res.leagueId);
      await refreshAppData();
    } catch (err: any) {
      alert(`Ligaga qo'shilishda xatolik: ${err.message}`);
    }
  };

  const handleDeleteSoloLeague = async () => {
    if (!leagueId) return;
    try {
      await ApiClient.deleteSoloLeague(leagueId);
      await refreshAppData();
    } catch (err: any) {
      alert(`Ligani o'chirishda xatolik: ${err.message}`);
    }
  };

  // Toggle Starting XI
  const handleToggleStarting = (playerId: string) => {
    setSquad((prev) =>
      prev.map((p) =>
        p.id === playerId ? { ...p, isStarting: !p.isStarting } : p,
      ),
    );
  };

  // Buy Player from Transfer Market
  const handleBuyPlayer = async (listingId: string) => {
    if (!club) return;
    try {
      await ApiClient.buyListing(listingId, club.id);
      await refreshAppData();
    } catch (err: any) {
      alert(`Futbolchini sotib olishda xatolik: ${err.message}`);
    }
  };

  // List Player for Sale
  const handleListPlayer = async (player: Player, priceEur: number) => {
    try {
      await ApiClient.createListing(player.id, priceEur);
      await refreshAppData();
    } catch (err: any) {
      alert(`Sotuvga qo'yishda xatolik: ${err.message}`);
    }
  };

  // Buy Legend Player
  const handleBuyLegend = async (legend: LegendPlayer) => {
    if (!club) return;
    try {
      await ApiClient.buyListing(legend.id, club.id);
      await refreshAppData();
    } catch (err: any) {
      alert(`Afsonani sotib olishda xatolik: ${err.message}`);
    }
  };

  // Top Up Transfer Budget Request
  const handleTopUpBudget = async (eurAmount: number) => {
    if (!club || !leagueId) return;
    try {
      const pkgId = eurAmount === 10_000_000 ? 'tbp_10m' : 'tbp_50m';
      await ApiClient.requestPackage(leagueId, club.id, pkgId);
      alert(
        'Transfer budjeti so‘rovi muvaffaqiyatli yuborildi! Admin tasdiqlagach budjet oshadi.',
      );
      await refreshAppData();
    } catch (err: any) {
      alert(`So‘rov yuborishda xatolik: ${err.message}`);
    }
  };

  // Finish Round Simulation
  const handleCloseMatchModal = async (
    _homeScore: number,
    _awayScore: number,
  ) => {
    setShowMatchModal(false);
    if (!leagueId) return;
    try {
      await ApiClient.executeRound(leagueId);
      await refreshAppData();
    } catch (err: any) {
      alert(`Tur o'yinini yakunlashda xatolik: ${err.message}`);
    }
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-[#0c0924] flex items-center justify-center text-white font-heading text-xl">
        <div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-cyan-400 mr-3" />
        Yuklanmoqda...
      </div>
    );
  }

  if (!isAuthenticated || showAuthModal) {
    return (
      <AuthModal
        onSuccess={() => {
          setIsAuthenticated(true);
          setShowAuthModal(false);
          refreshAppData();
        }}
      />
    );
  }

  const activeClub: Club = club || {
    id: 'default-club',
    name: 'Real Madrid',
    slug: 'real-madrid',
    shortCode: 'RMA',
    reputation: 85,
    balanceEur: 100_000_000,
    stadiumCapacity: 60000,
  };

  return (
    <div className="min-h-screen bg-[#0c0924] text-slate-100 pb-20 md:pb-12">
      {/* Top Header */}
      <Navbar
        currentTab={currentTab}
        onSelectTab={setCurrentTab}
        club={activeClub}
        userSession={{
          username,
          managerName,
          clubName: activeClub.name,
          isAdmin,
        }}
        onLogout={handleLogout}
        onOpenAuthModal={() => setShowAuthModal(true)}
      />

      {/* Main View Container */}
      <main className="mx-auto max-w-7xl px-3 sm:px-6">
        {currentTab === 'dashboard' && (
          <LeagueView
            standings={standings}
            currentRound={currentRound}
            dailyRoundsUsed={dailyRoundsUsed}
            maxDailyRounds={3}
            leagueName={leagueName}
            leagueMode={leagueMode}
            invitationCode={invitationCode}
            onRunRound={() => setShowMatchModal(true)}
            onCreateLeague={handleCreateLeague}
            onJoinLeague={handleJoinLeague}
            onDeleteSoloLeague={handleDeleteSoloLeague}
          />
        )}

        {currentTab === 'squad' && (
          <SquadView squad={squad} onToggleStarting={handleToggleStarting} />
        )}

        {currentTab === 'transfers' && (
          <TransferView
            listings={transfers}
            squad={squad}
            club={activeClub}
            onBuyPlayer={handleBuyPlayer}
            onListPlayer={handleListPlayer}
          />
        )}

        {currentTab === 'legends' && (
          <LegendView
            legends={legends}
            club={activeClub}
            onBuyLegend={handleBuyLegend}
          />
        )}

        {currentTab === 'finances' && (
          <FinanceView
            finances={finances}
            club={activeClub}
            onTopUpBudget={handleTopUpBudget}
          />
        )}

        {currentTab === 'sponsor' && <SponsorView />}

        {currentTab === 'profile' && (
          <ProfileView
            userSession={{
              managerId,
              username,
              managerName,
              isAdmin,
              isTelegramLinked,
              telegramUserId,
            }}
            onLogout={handleLogout}
          />
        )}

        {currentTab === 'admin' && isAdmin && (
          <AdminView
            onApproveOrder={async (requestId) => {
              try {
                await ApiClient.approveOrder(requestId);
                await refreshAppData();
              } catch (err: any) {
                alert(`Tasdiqlashda xatolik: ${err.message}`);
              }
            }}
            onForceRound={() => setShowMatchModal(true)}
          />
        )}
      </main>

      {/* Mobile Touch Bottom Navigation */}
      <MobileBottomNav
        currentTab={currentTab}
        onSelectTab={setCurrentTab}
        isAdmin={isAdmin}
      />

      {/* Live Match Simulation Modal */}
      {showMatchModal && (
        <MatchSimulatorModal
          roundNumber={currentRound}
          onClose={handleCloseMatchModal}
        />
      )}
    </div>
  );
};
