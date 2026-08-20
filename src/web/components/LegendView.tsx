import React, { useState } from 'react';
import { LegendPlayer, Club } from '../types.js';
import { Award, Crown, CheckCircle, AlertCircle } from 'lucide-react';

interface LegendViewProps {
  legends: LegendPlayer[];
  club: Club;
  onBuyLegend: (legend: LegendPlayer) => void;
}

export const LegendView: React.FC<LegendViewProps> = ({
  legends,
  club,
  onBuyLegend,
}) => {
  const [notification, setNotification] = useState<string | null>(null);

  const handleBuy = (legend: LegendPlayer) => {
    if (club.balanceEur < legend.priceEur) {
      setNotification(
        `Xatolik: Transfer budjeti yetarli emas (€${(club.balanceEur / 1_000_000).toFixed(1)}M mavjud)`,
      );
      setTimeout(() => setNotification(null), 3000);
      return;
    }

    onBuyLegend(legend);
    setNotification(
      `Legenda: ${legend.fullName} jamoangizga muvaffaqiyatli qo‘shildi!`,
    );
    setTimeout(() => setNotification(null), 4000);
  };

  return (
    <div className="space-y-6">
      {/* Legend Banner */}
      <div className="glass-panel relative overflow-hidden p-6 md:p-8 border-amber-500/30">
        <div className="absolute -right-10 -top-10 h-64 w-64 rounded-full bg-amber-500/10 blur-3xl" />
        <div className="relative z-10 flex flex-wrap items-center justify-between gap-6">
          <div className="space-y-2">
            <div className="inline-flex items-center gap-2 rounded-full bg-amber-500/10 px-3 py-1 text-xs font-bold text-amber-400 border border-amber-500/30">
              <Crown size={14} /> Eksklyuziv Afsonalar Bozori
            </div>
            <h2 className="font-heading text-3xl font-extrabold text-white md:text-4xl">
              Futbol Tarixidagi Eng Buyuk Afsonalar
            </h2>
            <p className="max-w-xl text-sm text-slate-300">
              Cristiano Ronaldo, Lionel Messi, Zidane, R9 kabi afsonaviy
              futbolchilarni jamoangizga taklif qiling.
            </p>
          </div>
        </div>
      </div>

      {/* Notification Toast */}
      {notification && (
        <div
          className={`rounded-xl p-3 text-xs font-bold flex items-center gap-2 ${
            notification.includes('Xatolik')
              ? 'bg-rose-500/20 text-rose-300 border border-rose-500/40'
              : 'bg-amber-500/20 text-amber-300 border border-amber-500/40'
          }`}
        >
          {notification.includes('Xatolik') ? (
            <AlertCircle size={16} />
          ) : (
            <CheckCircle size={16} />
          )}
          <span>{notification}</span>
        </div>
      )}

      {/* Legend Cards Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {legends.map((legend) => (
          <div
            key={legend.id}
            className="glass-panel p-6 space-y-4 relative border-amber-500/20 hover:border-amber-500/60 transition-all flex flex-col justify-between"
          >
            <div className="space-y-3">
              <div className="flex items-center justify-between">
                <span className="badge-ovr badge-gold text-xs">
                  {legend.overallRating} OVR
                </span>
                <span className="rounded-full bg-amber-500/20 px-2.5 py-0.5 text-[10px] font-bold text-amber-400 border border-amber-500/30">
                  {legend.primaryPosition}
                </span>
              </div>

              <div>
                <h3 className="font-heading text-xl font-extrabold text-white flex items-center gap-2">
                  <Award size={18} className="text-amber-400 shrink-0" />
                  <span>{legend.fullName}</span>
                </h3>
                <div className="text-xs text-amber-400/90 font-medium mt-0.5">
                  {legend.era}
                </div>
                <div className="text-xs text-slate-400 mt-1">
                  Davlat: {legend.nationality}
                </div>
              </div>

              {/* Mini Attributes */}
              <div className="grid grid-cols-3 gap-2 pt-1 text-[11px] font-mono">
                <div className="rounded bg-slate-900/60 p-1.5 text-center border border-slate-800">
                  <span className="text-slate-400 block text-[9px]">PAC</span>
                  <span className="font-bold text-white">
                    {legend.attributes.pace}
                  </span>
                </div>
                <div className="rounded bg-slate-900/60 p-1.5 text-center border border-slate-800">
                  <span className="text-slate-400 block text-[9px]">SHO</span>
                  <span className="font-bold text-white">
                    {legend.attributes.shooting}
                  </span>
                </div>
                <div className="rounded bg-slate-900/60 p-1.5 text-center border border-slate-800">
                  <span className="text-slate-400 block text-[9px]">PAS</span>
                  <span className="font-bold text-white">
                    {legend.attributes.passing}
                  </span>
                </div>
              </div>
            </div>

            <div className="pt-4 border-t border-slate-800 flex items-center justify-between">
              <div>
                <div className="text-[10px] text-slate-400">Transfer Narxi</div>
                <div className="font-heading text-lg font-extrabold text-amber-400">
                  €{(legend.priceEur / 1_000_000).toFixed(0)} mln
                </div>
              </div>

              <button
                onClick={() => handleBuy(legend)}
                className="btn-gold py-1.5 px-4 text-xs"
              >
                Sotib Olish
              </button>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};
