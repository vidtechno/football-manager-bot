import React, { useState } from 'react';
import { StandingRow } from '../types.js';
import {
  Play,
  Trophy,
  Calendar,
  Zap,
  ChevronRight,
  PlusCircle,
  Key,
  Trash2,
  AlertTriangle,
  CheckCircle2,
} from 'lucide-react';

interface LeagueViewProps {
  standings: StandingRow[];
  currentRound: number;
  dailyRoundsUsed: number;
  maxDailyRounds: number;
  leagueName: string;
  leagueMode: 'GIGANTRY' | 'SOLO';
  invitationCode: string;
  onRunRound: () => void;
  onCreateLeague: (name: string, mode: 'GIGANTRY' | 'SOLO') => void;
  onJoinLeague: (code: string) => void;
  onDeleteSoloLeague: () => void;
}

export const LeagueView: React.FC<LeagueViewProps> = ({
  standings,
  currentRound,
  dailyRoundsUsed,
  maxDailyRounds,
  leagueName,
  leagueMode,
  invitationCode,
  onRunRound,
  onCreateLeague,
  onJoinLeague,
  onDeleteSoloLeague,
}) => {
  const [showCreateModal, setShowCreateModal] = useState(false);
  const [showJoinModal, setShowJoinModal] = useState(false);
  const [showDeleteStep1, setShowDeleteStep1] = useState(false);
  const [showDeleteStep2, setShowDeleteStep2] = useState(false);

  const [newLeagueName, setNewLeagueName] = useState('');
  const [newLeagueMode, setNewLeagueMode] = useState<'GIGANTRY' | 'SOLO'>(
    'SOLO',
  );
  const [inputInviteCode, setInputInviteCode] = useState('');
  const [toastMessage, setToastMessage] = useState<string | null>(null);

  const handleCreateSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!newLeagueName.trim()) return;
    onCreateLeague(newLeagueName, newLeagueMode);
    setShowCreateModal(false);
    setNewLeagueName('');
    setToastMessage(
      `Muvaffaqiyatli: "${newLeagueName}" yangi ligasi yaratildi!`,
    );
    setTimeout(() => setToastMessage(null), 4000);
  };

  const handleJoinSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!inputInviteCode.trim()) return;
    onJoinLeague(inputInviteCode);
    setShowJoinModal(false);
    setInputInviteCode('');
    setToastMessage(
      `Muvaffaqiyatli: ${inputInviteCode.toUpperCase()} kodi bilan ligaga qo‘shildingiz!`,
    );
    setTimeout(() => setToastMessage(null), 4000);
  };

  const handleConfirmDelete = () => {
    onDeleteSoloLeague();
    setShowDeleteStep2(false);
    setShowDeleteStep1(false);
    setToastMessage(
      'Liga muvaffaqiyatli o‘chirildi va siz Gigants Ligaga qaytdingiz.',
    );
    setTimeout(() => setToastMessage(null), 4000);
  };

  return (
    <div className="space-y-6">
      {/* Top Banner & League Control Bar */}
      <div className="glass-panel relative overflow-hidden p-6 md:p-8 border-cyan-500/30">
        <div className="absolute -right-10 -top-10 h-64 w-64 rounded-full bg-cyan-500/15 blur-3xl" />
        <div className="relative z-10 flex flex-wrap items-center justify-between gap-6">
          <div className="space-y-2">
            <div className="flex flex-wrap items-center gap-2">
              <span className="inline-flex items-center gap-1.5 rounded-full bg-cyan-500/20 px-3 py-1 text-xs font-bold text-cyan-400 border border-cyan-500/40">
                <Trophy size={14} /> {leagueName} • Tur {currentRound}
              </span>
              <span className="rounded-full bg-slate-900 px-3 py-1 text-xs font-mono font-bold text-amber-400 border border-amber-500/30 flex items-center gap-1">
                <Key size={12} /> Kod: {invitationCode}
              </span>
              {leagueMode === 'SOLO' && (
                <button
                  onClick={() => setShowDeleteStep1(true)}
                  className="rounded-full bg-rose-500/20 px-3 py-1 text-xs font-bold text-rose-300 border border-rose-500/40 hover:bg-rose-500/30 transition flex items-center gap-1"
                >
                  <Trash2 size={12} /> Ligani O‘chirish
                </button>
              )}
            </div>

            <h2 className="font-heading text-3xl font-extrabold text-white md:text-4xl">
              Turnir Jadvali va O‘yinlar
            </h2>
            <p className="max-w-xl text-sm text-slate-300">
              Gigants Liga hamda Shaxsiy (Solo) liga rejimlarida turni yurgazib,
              homiy va match daromadlarini to‘plang.
            </p>
          </div>

          {/* Action Buttons Hub */}
          <div className="flex flex-col items-end gap-3">
            <div className="flex flex-wrap items-center gap-2">
              <button
                onClick={() => setShowCreateModal(true)}
                className="btn-secondary text-xs py-2 px-3"
              >
                <PlusCircle size={16} /> Yangi Liga Yaratish
              </button>
              <button
                onClick={() => setShowJoinModal(true)}
                className="btn-secondary text-xs py-2 px-3 text-cyan-300"
              >
                <Key size={16} /> Kod Bilan Qo‘shilish
              </button>
            </div>

            <button
              onClick={onRunRound}
              disabled={dailyRoundsUsed >= maxDailyRounds}
              className={`btn-primary text-sm px-6 py-3 ${
                dailyRoundsUsed >= maxDailyRounds
                  ? 'opacity-50 cursor-not-allowed'
                  : ''
              }`}
            >
              <Play size={18} className="fill-white" />
              <span>Tur O‘yinlarini O‘tkazish</span>
              <ChevronRight size={18} />
            </button>
            <div className="flex items-center gap-2 text-xs font-semibold text-slate-400">
              <Zap size={14} className="text-amber-400" />
              <span>
                Kunlik limit: {dailyRoundsUsed} / {maxDailyRounds} tur bajarildi
              </span>
            </div>
          </div>
        </div>
      </div>

      {/* Toast Notification */}
      {toastMessage && (
        <div className="rounded-xl bg-cyan-500/20 p-3 text-xs font-bold text-cyan-300 border border-cyan-500/40 flex items-center gap-2">
          <CheckCircle2 size={16} />
          <span>{toastMessage}</span>
        </div>
      )}

      {/* Standings Table & Next Match Preview */}
      <div className="grid grid-cols-1 gap-6 lg:grid-cols-3">
        {/* Main League Table (2 cols) */}
        <div className="glass-panel overflow-hidden p-6 lg:col-span-2 space-y-4">
          <div className="flex items-center justify-between border-b border-slate-800 pb-4">
            <h3 className="font-heading text-xl font-bold text-white flex items-center gap-2">
              <Trophy size={20} className="text-amber-400" /> Turnir Jadvali (
              {standings.length} Klub)
            </h3>
            <span className="text-xs text-slate-400 font-medium">
              {leagueMode} Rejimi
            </span>
          </div>

          <div className="overflow-x-auto">
            <table className="w-full text-left text-sm">
              <thead className="bg-slate-900/60 text-xs font-semibold text-slate-400 uppercase">
                <tr>
                  <th className="py-3 px-4 rounded-l-lg">#</th>
                  <th className="py-3 px-4">Klub</th>
                  <th className="py-3 px-4 text-center">O‘YN</th>
                  <th className="py-3 px-4 text-center">G‘AL</th>
                  <th className="py-3 px-4 text-center">DUR</th>
                  <th className="py-3 px-4 text-center">MAG‘</th>
                  <th className="py-3 px-4 text-center">T-F</th>
                  <th className="py-3 px-4 text-center rounded-r-lg">OCHKO</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-slate-800/60 font-medium">
                {standings.map((row) => {
                  const isUserClub = row.clubName === 'Real Madrid';
                  return (
                    <tr
                      key={row.clubName}
                      className={`transition-colors ${
                        isUserClub
                          ? 'bg-cyan-950/40 text-cyan-200 font-bold border-l-4 border-cyan-400'
                          : 'hover:bg-slate-800/40 text-slate-200'
                      }`}
                    >
                      <td className="py-3.5 px-4 font-heading font-extrabold text-slate-400">
                        {row.position <= 3 ? (
                          <span className="flex h-6 w-6 items-center justify-center rounded-md bg-amber-500/20 text-amber-400 text-xs font-bold">
                            {row.position}
                          </span>
                        ) : (
                          row.position
                        )}
                      </td>
                      <td className="py-3.5 px-4 font-semibold">
                        <div className="flex items-center gap-2">
                          <span className="rounded bg-slate-800 px-1.5 py-0.5 text-[10px] font-mono text-slate-400">
                            {row.shortCode}
                          </span>
                          <span>{row.clubName}</span>
                          {isUserClub && (
                            <span className="rounded-full bg-cyan-500/20 px-2 py-0.5 text-[10px] font-bold text-cyan-400 border border-cyan-500/30">
                              SIZNING KLUB
                            </span>
                          )}
                        </div>
                      </td>
                      <td className="py-3.5 px-4 text-center text-slate-300">
                        {row.played}
                      </td>
                      <td className="py-3.5 px-4 text-center text-emerald-400 font-semibold">
                        {row.won}
                      </td>
                      <td className="py-3.5 px-4 text-center text-slate-400">
                        {row.drawn}
                      </td>
                      <td className="py-3.5 px-4 text-center text-rose-400">
                        {row.lost}
                      </td>
                      <td className="py-3.5 px-4 text-center text-slate-300 font-mono">
                        {row.goalsFor}:{row.goalsAgainst} (
                        {row.goalDifference > 0
                          ? `+${row.goalDifference}`
                          : row.goalDifference}
                        )
                      </td>
                      <td className="py-3.5 px-4 text-center font-heading text-base font-extrabold text-amber-400">
                        {row.points}
                      </td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          </div>
        </div>

        {/* Fixtures & Rewards Widget (1 col) */}
        <div className="space-y-6">
          <div className="glass-panel p-6 space-y-4">
            <h3 className="font-heading text-lg font-bold text-white flex items-center gap-2 border-b border-slate-800 pb-3">
              <Calendar size={18} className="text-cyan-400" /> Keyingi O‘yin
              (Tur {currentRound})
            </h3>

            <div className="rounded-xl bg-slate-900/80 p-4 border border-slate-800 text-center space-y-3">
              <div className="text-xs font-semibold text-cyan-400 uppercase tracking-wider">
                Stadion: Santiago Bernabéu
              </div>

              <div className="flex items-center justify-between gap-4 py-2">
                <div className="flex-1 text-center">
                  <div className="font-heading font-extrabold text-lg text-white">
                    Real Madrid
                  </div>
                  <div className="text-xs text-cyan-400 font-semibold">
                    (Sizning jamoa)
                  </div>
                </div>

                <div className="rounded-lg bg-cyan-500/20 px-3 py-1.5 font-heading font-bold text-cyan-400 text-sm">
                  VS
                </div>

                <div className="flex-1 text-center">
                  <div className="font-heading font-extrabold text-lg text-slate-200">
                    FC Barcelona
                  </div>
                  <div className="text-xs text-slate-400">(Raqib)</div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Create League Modal */}
      {showCreateModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/80 backdrop-blur-md p-4">
          <div className="glass-panel max-w-md w-full p-6 space-y-4 border-cyan-500/40">
            <h3 className="font-heading text-xl font-bold text-white border-b border-slate-800 pb-3">
              Yangi Liga Yaratish
            </h3>
            <form onSubmit={handleCreateSubmit} className="space-y-4">
              <div className="space-y-1">
                <label className="text-xs font-semibold text-slate-300 block">
                  Liga Nomi:
                </label>
                <input
                  type="text"
                  required
                  placeholder="Masalan: Premier League Uzbek"
                  value={newLeagueName}
                  onChange={(e) => setNewLeagueName(e.target.value)}
                  className="w-full rounded-xl bg-slate-900 px-4 py-2.5 text-sm font-medium text-white border border-slate-800"
                />
              </div>

              <div className="space-y-1">
                <label className="text-xs font-semibold text-slate-300 block">
                  Liga Rejimi:
                </label>
                <select
                  value={newLeagueMode}
                  onChange={(e) => setNewLeagueMode(e.target.value as any)}
                  className="w-full rounded-xl bg-slate-900 px-4 py-2.5 text-xs font-medium text-white border border-slate-800"
                >
                  <option value="SOLO">
                    Solo Liga (Shaxsiy liga va Botlar)
                  </option>
                  <option value="GIGANTRY">
                    Gigants Liga (Barcha top-klublar)
                  </option>
                </select>
              </div>

              <div className="flex justify-end gap-3 pt-2">
                <button
                  type="button"
                  onClick={() => setShowCreateModal(false)}
                  className="btn-secondary py-1.5 px-4 text-xs"
                >
                  Bekor qilish
                </button>
                <button
                  type="submit"
                  className="btn-primary py-1.5 px-4 text-xs"
                >
                  Yaratish
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* Join League Modal */}
      {showJoinModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/80 backdrop-blur-md p-4">
          <div className="glass-panel max-w-md w-full p-6 space-y-4 border-cyan-500/40">
            <h3 className="font-heading text-xl font-bold text-white border-b border-slate-800 pb-3">
              Taklif Kodi Bilan Qo‘shilish
            </h3>
            <form onSubmit={handleJoinSubmit} className="space-y-4">
              <div className="space-y-1">
                <label className="text-xs font-semibold text-slate-300 block">
                  6 Xonali Taklif Kodi:
                </label>
                <input
                  type="text"
                  required
                  maxLength={6}
                  placeholder="ABCDEF"
                  value={inputInviteCode}
                  onChange={(e) =>
                    setInputInviteCode(e.target.value.toUpperCase())
                  }
                  className="w-full rounded-xl bg-slate-900 px-4 py-2.5 text-lg font-mono font-bold text-center text-amber-400 border border-slate-800 tracking-widest uppercase"
                />
              </div>

              <div className="flex justify-end gap-3 pt-2">
                <button
                  type="button"
                  onClick={() => setShowJoinModal(false)}
                  className="btn-secondary py-1.5 px-4 text-xs"
                >
                  Bekor qilish
                </button>
                <button
                  type="submit"
                  className="btn-primary py-1.5 px-4 text-xs"
                >
                  Qo‘shilish
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* 2-Step Solo League Deletion Step 1 */}
      {showDeleteStep1 && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/80 backdrop-blur-md p-4">
          <div className="glass-panel max-w-md w-full p-6 space-y-4 border-rose-500/40">
            <div className="flex items-center gap-2 text-rose-400 font-bold text-lg border-b border-slate-800 pb-3">
              <AlertTriangle size={20} /> Ligani O‘chirish (1-Bosqich)
            </div>
            <p className="text-xs text-slate-300">
              Ushbu Solo ligani o‘chirishni xohlaysizmi? O‘chirilgandan so‘ng
              liga tarixi va ochkolari tiklanmaydi.
            </p>
            <div className="flex justify-end gap-3 pt-2">
              <button
                onClick={() => setShowDeleteStep1(false)}
                className="btn-secondary py-1.5 px-4 text-xs"
              >
                Bekor qilish
              </button>
              <button
                onClick={() => {
                  setShowDeleteStep1(false);
                  setShowDeleteStep2(true);
                }}
                className="btn-primary py-1.5 px-4 text-xs bg-rose-600 hover:bg-rose-700"
              >
                Davom etish ➡️
              </button>
            </div>
          </div>
        </div>
      )}

      {/* 2-Step Solo League Deletion Step 2 */}
      {showDeleteStep2 && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/80 backdrop-blur-md p-4">
          <div className="glass-panel max-w-md w-full p-6 space-y-4 border-rose-500/60">
            <div className="flex items-center gap-2 text-rose-400 font-bold text-lg border-b border-slate-800 pb-3">
              <AlertTriangle size={20} /> QAT'IY TASDIQLASH (2-Bosqich)
            </div>
            <p className="text-xs text-rose-300 font-semibold">
              Haqiqatdan ham ligangizni butunlay o‘chirmoqchimisiz? Bu amalni
              ortga qaytarib bo‘lmaydi!
            </p>
            <div className="flex justify-end gap-3 pt-2">
              <button
                onClick={() => setShowDeleteStep2(false)}
                className="btn-secondary py-1.5 px-4 text-xs"
              >
                Bekor qilish
              </button>
              <button
                onClick={handleConfirmDelete}
                className="btn-primary py-1.5 px-4 text-xs bg-rose-600 hover:bg-rose-700 font-bold"
              >
                🗑 Ha, ligani o‘chirish
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};
