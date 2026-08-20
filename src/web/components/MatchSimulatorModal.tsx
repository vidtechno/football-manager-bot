import React, { useState, useEffect } from 'react';
import { Play, CheckCircle2, Award } from 'lucide-react';

interface MatchSimulatorModalProps {
  roundNumber: number;
  onClose: (homeScore: number, awayScore: number) => void;
}

export const MatchSimulatorModal: React.FC<MatchSimulatorModalProps> = ({
  roundNumber,
  onClose,
}) => {
  const [minute, setMinute] = useState(0);
  const [homeScore, setHomeScore] = useState(0);
  const [awayScore, setAwayScore] = useState(0);
  const [events, setEvents] = useState<string[]>([]);
  const [isFinished, setIsFinished] = useState(false);

  useEffect(() => {
    const interval = setInterval(() => {
      setMinute((prev) => {
        if (prev >= 90) {
          clearInterval(interval);
          setIsFinished(true);
          return 90;
        }

        const nextMin = prev + 15;
        // Random goals simulation
        if (nextMin === 15) {
          setHomeScore(1);
          setEvents((e) => [...e, "14' ⚽ GOOL! Kylian Mbappé (Real Madrid)"]);
        } else if (nextMin === 45) {
          setHomeScore(2);
          setEvents((e) => [
            ...e,
            "42' ⚽ GOOL! Vinícius Júnior (Real Madrid)",
          ]);
        } else if (nextMin === 60) {
          setAwayScore(1);
          setEvents((e) => [
            ...e,
            "58' ⚽ GOOL! Robert Lewandowski (FC Barcelona)",
          ]);
        } else if (nextMin === 85) {
          setHomeScore(3);
          setEvents((e) => [
            ...e,
            "84' ⚽ GOOL! Jude Bellingham (Real Madrid)",
          ]);
        }

        return nextMin;
      });
    }, 600);

    return () => clearInterval(interval);
  }, []);

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/80 backdrop-blur-md p-4 animate-fadeIn">
      <div className="glass-panel max-w-xl w-full p-6 md:p-8 space-y-6 border-emerald-500/40 shadow-2xl">
        {/* Match Header */}
        <div className="text-center space-y-1">
          <div className="inline-flex items-center gap-2 rounded-full bg-emerald-500/20 px-3 py-1 text-xs font-bold text-emerald-400 border border-emerald-500/30">
            <Play size={14} className="fill-emerald-400" /> Gigants Liga • Tur{' '}
            {roundNumber} Simulyatsiyasi
          </div>
          <h3 className="font-heading text-2xl font-extrabold text-white">
            {' '}
            Santiago Bernabéu
          </h3>
        </div>

        {/* Live Scoreboard */}
        <div className="rounded-2xl bg-slate-900/90 p-6 border border-slate-800 text-center space-y-4 shadow-inner">
          <div className="flex items-center justify-between gap-4">
            <div className="flex-1">
              <div className="font-heading text-xl font-extrabold text-white">
                Real Madrid
              </div>
              <div className="text-xs text-emerald-400 font-semibold">
                (Uy Jamoasi)
              </div>
            </div>

            <div className="font-heading text-4xl font-black text-amber-400 px-4 py-2 rounded-xl bg-slate-950 border border-amber-500/30">
              {homeScore} : {awayScore}
            </div>

            <div className="flex-1">
              <div className="font-heading text-xl font-extrabold text-slate-300">
                FC Barcelona
              </div>
              <div className="text-xs text-slate-400">(Mehmon)</div>
            </div>
          </div>

          <div className="inline-block rounded-full bg-slate-800 px-4 py-1 text-xs font-bold text-emerald-400 font-mono">
            {isFinished
              ? '90’ MATCh YAKUNLANDI'
              : `${minute}’ DAQIQALAR O‘TMOQDA...`}
          </div>
        </div>

        {/* Match Events Feed */}
        <div className="space-y-2 max-h-40 overflow-y-auto pr-1">
          <div className="text-xs font-bold uppercase text-slate-400 tracking-wider">
            O‘yin Voqealari:
          </div>
          {events.map((ev, i) => (
            <div
              key={i}
              className="rounded-lg bg-slate-900/60 p-2 text-xs font-semibold text-white border border-slate-800"
            >
              {ev}
            </div>
          ))}
        </div>

        {/* Post-match Rewards Breakdown */}
        {isFinished && (
          <div className="rounded-xl bg-emerald-950/40 p-4 border border-emerald-500/50 space-y-2 animate-fadeIn">
            <div className="flex items-center gap-2 text-emerald-400 font-bold text-sm">
              <CheckCircle2 size={18} /> G‘alaba va Daromadlar Hisoblandi!
            </div>
            <div className="grid grid-cols-3 gap-2 text-[11px] font-semibold text-slate-300 text-center">
              <div className="bg-slate-900/80 p-2 rounded border border-slate-800">
                <span className="block text-slate-400">Homiy</span>
                <span className="text-emerald-400 font-bold">+€2.5M</span>
              </div>
              <div className="bg-slate-900/80 p-2 rounded border border-slate-800">
                <span className="block text-slate-400">G‘alaba Bonusi</span>
                <span className="text-emerald-400 font-bold">+€1.5M</span>
              </div>
              <div className="bg-slate-900/80 p-2 rounded border border-slate-800">
                <span className="block text-slate-400">Stadion</span>
                <span className="text-cyan-400 font-bold">+€1.5M</span>
              </div>
            </div>
          </div>
        )}

        {/* Modal Action Button */}
        <div className="pt-2">
          <button
            disabled={!isFinished}
            onClick={() => onClose(homeScore, awayScore)}
            className="btn-primary w-full justify-center py-3 text-sm disabled:opacity-50"
          >
            <Award size={18} />
            <span>
              {isFinished
                ? 'Natijani Qabul Qilish va Yopish'
                : 'O‘yin Simulyatsiya Qilinmoqda...'}
            </span>
          </button>
        </div>
      </div>
    </div>
  );
};
