import React, { useState } from 'react';
import { Player } from '../types.js';
import { Users, Shield, RefreshCw, Award, Target } from 'lucide-react';

interface SquadViewProps {
  squad: Player[];
  onToggleStarting: (playerId: string) => void;
}

export const SquadView: React.FC<SquadViewProps> = ({
  squad,
  onToggleStarting,
}) => {
  const [formation, setFormation] = useState<'4-3-3' | '4-4-2' | '3-5-2'>(
    '4-3-3',
  );
  const [selectedPlayer, setSelectedPlayer] = useState<Player | null>(
    squad[0] || null,
  );
  const [captainId, setCaptainId] = useState<string>(squad[0]?.id || '');
  const [penaltyTakerId, setPenaltyTakerId] = useState<string>(
    squad[9]?.id || squad[0]?.id || '',
  );

  const starting11 = squad.filter((p) => p.isStarting);

  const avgOvr =
    starting11.length > 0
      ? Math.round(
          starting11.reduce((sum, p) => sum + p.overallRating, 0) /
            starting11.length,
        )
      : 0;

  return (
    <div className="space-y-6">
      {/* Top Controls Header */}
      <div className="glass-panel p-6 flex flex-wrap items-center justify-between gap-4">
        <div>
          <h2 className="font-heading text-2xl font-bold text-white flex items-center gap-2">
            <Users size={24} className="text-cyan-400" /> Jamoa Tarkibi va
            Taktikasi
          </h2>
          <p className="text-xs text-slate-400 mt-1">
            Asosiy tarkib:{' '}
            <span className="font-bold text-cyan-400">
              {starting11.length} / 11
            </span>{' '}
            | Sig‘im: {squad.length} / 30 futbolchi
          </p>
        </div>

        {/* Formation Switcher & OVR Badge */}
        <div className="flex flex-wrap items-center gap-4">
          <div className="flex items-center gap-1 rounded-xl bg-slate-900/90 p-1 border border-slate-800">
            {(['4-3-3', '4-4-2', '3-5-2'] as const).map((fmt) => (
              <button
                key={fmt}
                onClick={() => setFormation(fmt)}
                className={`px-3 py-1.5 text-xs font-bold rounded-lg transition-all ${
                  formation === fmt
                    ? 'bg-cyan-500 text-white shadow-md'
                    : 'text-slate-400 hover:text-white'
                }`}
              >
                {fmt}
              </button>
            ))}
          </div>

          <div className="flex items-center gap-2 rounded-xl bg-amber-500/10 px-4 py-2 border border-amber-500/30">
            <Shield size={18} className="text-amber-400" />
            <div>
              <div className="text-[10px] uppercase font-bold text-amber-400/80">
                Jamoa OVR
              </div>
              <div className="font-heading text-lg font-extrabold text-amber-400">
                {avgOvr}
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Main Grid: 2D Pitch (Left) + Player Inspector & Roster (Right) */}
      <div className="grid grid-cols-1 gap-6 lg:grid-cols-12">
        {/* 2D Pitch View */}
        <div className="glass-panel p-5 lg:col-span-5 space-y-4">
          <h3 className="font-heading text-lg font-bold text-white flex items-center justify-between border-b border-slate-800 pb-3">
            <span>🏟 Maydon Taktikasi ({formation})</span>
            <span className="text-xs text-cyan-400 font-normal">
              Click player
            </span>
          </h3>

          <div className="pitch-container relative">
            <div className="pitch-lines" />
            <div className="pitch-center-line" />
            <div className="pitch-center-circle" />
            <div className="pitch-penalty-box-top" />
            <div className="pitch-penalty-box-bottom" />

            {starting11.map((p) => {
              const isSelected = selectedPlayer?.id === p.id;
              const isCap = p.id === captainId;
              const isPen = p.id === penaltyTakerId;
              return (
                <button
                  key={p.id}
                  onClick={() => setSelectedPlayer(p)}
                  style={{
                    position: 'absolute',
                    left: `${p.pitchX || 50}%`,
                    top: `${p.pitchY || 50}%`,
                    transform: 'translate(-50%, -50%)',
                  }}
                  className={`group flex flex-col items-center transition-all ${
                    isSelected ? 'scale-110 z-20' : 'hover:scale-105 z-10'
                  }`}
                >
                  <div
                    className={`flex h-10 w-10 items-center justify-center rounded-full font-heading font-extrabold text-xs shadow-lg transition-all relative ${
                      isSelected
                        ? 'bg-amber-400 text-slate-950 ring-4 ring-amber-400/40'
                        : p.primaryPosition === 'GK'
                          ? 'bg-cyan-500 text-white'
                          : 'bg-emerald-500 text-white'
                    }`}
                  >
                    {p.overallRating}
                    {isCap && (
                      <span className="absolute -top-1 -right-1 bg-amber-500 text-slate-950 rounded-full h-4 w-4 text-[9px] font-black flex items-center justify-center border border-amber-300">
                        C
                      </span>
                    )}
                  </div>
                  <div className="mt-1 rounded bg-slate-950/90 px-2 py-0.5 text-[10px] font-bold text-white shadow max-w-[90px] truncate border border-slate-800 flex items-center gap-1">
                    <span>{p.fullName.split(' ').pop()}</span>
                    {isPen && (
                      <Target size={10} className="text-amber-400 shrink-0" />
                    )}
                  </div>
                </button>
              );
            })}
          </div>
        </div>

        {/* Player Inspector & Roster */}
        <div className="space-y-6 lg:col-span-7">
          {/* Selected Player Detail */}
          {selectedPlayer && (
            <div className="glass-panel p-6 space-y-4 border-l-4 border-cyan-400">
              <div className="flex flex-wrap items-center justify-between gap-4 border-b border-slate-800 pb-3">
                <div>
                  <div className="flex items-center gap-2">
                    <span className="badge-ovr badge-cyan">
                      {selectedPlayer.overallRating} OVR
                    </span>
                    <span className="rounded bg-slate-800 px-2 py-0.5 text-xs font-bold text-slate-300">
                      {selectedPlayer.primaryPosition}
                    </span>
                    <span className="text-xs text-slate-400">
                      {selectedPlayer.nationality}
                    </span>
                  </div>
                  <h3 className="font-heading text-2xl font-extrabold text-white mt-1">
                    {selectedPlayer.fullName}
                  </h3>
                </div>

                <div className="flex flex-wrap items-center gap-2">
                  <button
                    onClick={() => setCaptainId(selectedPlayer.id)}
                    className={`btn-secondary py-1.5 px-3 text-xs ${
                      captainId === selectedPlayer.id
                        ? 'bg-amber-500/20 text-amber-400 border-amber-500/40'
                        : ''
                    }`}
                  >
                    <Award size={14} /> Kapitan Qilish
                  </button>
                  <button
                    onClick={() => setPenaltyTakerId(selectedPlayer.id)}
                    className={`btn-secondary py-1.5 px-3 text-xs ${
                      penaltyTakerId === selectedPlayer.id
                        ? 'bg-amber-500/20 text-amber-400 border-amber-500/40'
                        : ''
                    }`}
                  >
                    <Target size={14} /> Penalti Tepuvchi
                  </button>
                  <button
                    onClick={() => onToggleStarting(selectedPlayer.id)}
                    className="btn-primary py-1.5 px-3 text-xs"
                  >
                    <RefreshCw size={14} />
                    {selectedPlayer.isStarting
                      ? 'Zaxiraga o‘tkazish'
                      : 'Asosiy tarkibga qo‘shish'}
                  </button>
                </div>
              </div>

              {/* Attributes Progress Bars */}
              <div className="grid grid-cols-2 sm:grid-cols-3 gap-3 pt-1">
                {Object.entries(selectedPlayer.attributes).map(
                  ([attr, val]) => (
                    <div
                      key={attr}
                      className="rounded-lg bg-slate-900/60 p-2.5 border border-slate-800/80"
                    >
                      <div className="flex justify-between text-xs font-semibold uppercase text-slate-400 mb-1">
                        <span>{attr}</span>
                        <span className="text-white font-bold">{val}</span>
                      </div>
                      <div className="h-1.5 w-full rounded-full bg-slate-800 overflow-hidden">
                        <div
                          className={`h-full rounded-full ${
                            val >= 85
                              ? 'bg-amber-400'
                              : val >= 75
                                ? 'bg-cyan-400'
                                : 'bg-emerald-400'
                          }`}
                          style={{ width: `${val}%` }}
                        />
                      </div>
                    </div>
                  ),
                )}
              </div>
            </div>
          )}

          {/* Roster List */}
          <div className="glass-panel p-6 space-y-4">
            <h3 className="font-heading text-lg font-bold text-white border-b border-slate-800 pb-3">
              Jamoa Futbolchilari Ro‘yxati ({squad.length} / 30)
            </h3>

            <div className="max-h-80 overflow-y-auto space-y-2 pr-1">
              {squad.map((p) => {
                const isSelected = selectedPlayer?.id === p.id;
                const isCap = p.id === captainId;
                const isPen = p.id === penaltyTakerId;
                return (
                  <div
                    key={p.id}
                    onClick={() => setSelectedPlayer(p)}
                    className={`flex items-center justify-between rounded-xl p-3 cursor-pointer transition-all ${
                      isSelected
                        ? 'bg-slate-800/90 border border-cyan-400/50 shadow'
                        : 'bg-slate-900/50 hover:bg-slate-800/50 border border-slate-800/60'
                    }`}
                  >
                    <div className="flex items-center gap-3">
                      <span
                        className={`font-heading font-extrabold text-xs px-2 py-1 rounded ${
                          p.isStarting
                            ? 'bg-cyan-500/20 text-cyan-400'
                            : 'bg-slate-800 text-slate-400'
                        }`}
                      >
                        {p.primaryPosition}
                      </span>
                      <div>
                        <div className="font-semibold text-sm text-white flex items-center gap-1.5">
                          <span>{p.fullName}</span>
                          {isCap && (
                            <span className="rounded bg-amber-500/20 px-1 py-0.2 text-[9px] font-bold text-amber-400 border border-amber-500/30">
                              C
                            </span>
                          )}
                          {isPen && (
                            <Target size={12} className="text-amber-400" />
                          )}
                        </div>
                        <div className="text-xs text-slate-400">
                          €{(p.marketValueEur / 1_000_000).toFixed(1)}M
                        </div>
                      </div>
                    </div>

                    <div className="flex items-center gap-3">
                      <span className="badge-ovr badge-cyan text-xs">
                        {p.overallRating}
                      </span>
                      <button
                        onClick={(e) => {
                          e.stopPropagation();
                          onToggleStarting(p.id);
                        }}
                        className={`text-xs px-2.5 py-1 rounded font-bold transition ${
                          p.isStarting
                            ? 'bg-cyan-500/20 text-cyan-400 hover:bg-cyan-500/30'
                            : 'bg-slate-800 text-slate-300 hover:bg-slate-700'
                        }`}
                      >
                        {p.isStarting ? 'Asosiy' : 'Zaxira'}
                      </button>
                    </div>
                  </div>
                );
              })}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};
