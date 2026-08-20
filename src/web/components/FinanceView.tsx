import React, { useState } from 'react';
import { LedgerItem, Club } from '../types.js';
import { TrendingUp, ShoppingCart, Send, CheckCircle } from 'lucide-react';

interface FinanceViewProps {
  finances: LedgerItem[];
  club: Club;
  onTopUpBudget: (eurAmount: number) => void;
}

export const FinanceView: React.FC<FinanceViewProps> = ({
  finances,
  club,
  onTopUpBudget,
}) => {
  const [selectedPackage, setSelectedPackage] = useState<{
    eur: number;
    uzs: string;
    code: string;
  } | null>(null);

  const budgetPackages = [
    { eur: 10_000_000, uzs: "5 000 so'm", label: 'Kichik Paket' },
    { eur: 50_000_000, uzs: "20 000 so'm", label: 'Standart Paket' },
    { eur: 100_000_000, uzs: "35 000 so'm", label: 'Katta Paket' },
    { eur: 250_000_000, uzs: "75 000 so'm", label: 'VIP Paket' },
    { eur: 500_000_000, uzs: "125 000 so'm", label: 'Ultra Legend Paket' },
  ];

  const handleCreateOrder = (pkg: { eur: number; uzs: string }) => {
    const orderCode = `TBP-${Math.random().toString(36).substring(2, 8).toUpperCase()}`;
    setSelectedPackage({ ...pkg, code: orderCode });
    onTopUpBudget(pkg.eur);
  };

  return (
    <div className="space-y-6">
      {/* Top Summary Banner */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <div className="glass-panel p-6 space-y-2 border-emerald-500/30">
          <div className="text-xs font-semibold text-slate-400">
            Joriy Klub Balansi
          </div>
          <div className="font-heading text-3xl font-extrabold text-emerald-400">
            €{(club.balanceEur / 1_000_000).toFixed(1)} mln
          </div>
          <p className="text-[11px] text-slate-400">
            Transferlar va maoshlar uchun tayyor resurs
          </p>
        </div>

        <div className="glass-panel p-6 space-y-2">
          <div className="text-xs font-semibold text-slate-400">
            Stadion Sig‘imi & Tushumi
          </div>
          <div className="font-heading text-2xl font-extrabold text-white">
            {club.stadiumCapacity.toLocaleString()} tomoshabin
          </div>
          <p className="text-[11px] text-slate-400">
            Har bir uy o‘yinida: +€1.5M tushum
          </p>
        </div>

        <div className="glass-panel p-6 space-y-2">
          <div className="text-xs font-semibold text-slate-400">
            Avtomatik Homiy Daromadi
          </div>
          <div className="font-heading text-2xl font-extrabold text-cyan-400">
            €2.5 mln / tur
          </div>
          <p className="text-[11px] text-slate-400">
            Kanal obunasi tasdiqlanganda
          </p>
        </div>
      </div>

      {/* Main Grid: Budget Top-up Shop (Left) + Financial Ledger (Right) */}
      <div className="grid grid-cols-1 lg:grid-cols-12 gap-6">
        {/* Budget Shop (7 cols) */}
        <div className="glass-panel p-6 space-y-4 lg:col-span-7">
          <h3 className="font-heading text-xl font-bold text-white flex items-center gap-2 border-b border-slate-800 pb-3">
            <ShoppingCart size={20} className="text-emerald-400" /> 💰 Transfer
            Budjetini Oshirish Do‘koni
          </h3>

          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
            {budgetPackages.map((pkg) => (
              <div
                key={pkg.eur}
                className="rounded-xl bg-slate-900/60 p-4 border border-slate-800 hover:border-emerald-500/50 transition-all flex flex-col justify-between space-y-3"
              >
                <div>
                  <div className="text-[10px] uppercase font-bold text-emerald-400">
                    {pkg.label}
                  </div>
                  <div className="font-heading text-2xl font-extrabold text-white">
                    €{(pkg.eur / 1_000_000).toFixed(0)} mln
                  </div>
                  <div className="text-xs text-amber-400 font-semibold mt-1">
                    {pkg.uzs}
                  </div>
                </div>

                <button
                  onClick={() => handleCreateOrder(pkg)}
                  className="btn-primary w-full justify-center text-xs py-2"
                >
                  Xarid Qilish
                </button>
              </div>
            ))}
          </div>

          {/* Order Confirmation Deep Link Modal */}
          {selectedPackage && (
            <div className="rounded-xl bg-emerald-950/40 p-4 border border-emerald-500/50 space-y-3">
              <div className="flex items-center gap-2 text-emerald-400 font-bold text-sm">
                <CheckCircle size={18} /> Buyurtma Shakllantirildi!
              </div>
              <p className="text-xs text-slate-300">
                Buyurtma kodi:{' '}
                <span className="font-mono font-bold text-amber-400">
                  {selectedPackage.code}
                </span>{' '}
                | Paket: €{(selectedPackage.eur / 1_000_000).toFixed(0)}M (
                {selectedPackage.uzs})
              </p>
              <a
                href={`https://t.me/diyorbek_anorboyev?text=${encodeURIComponent(`Buyurtma kodi: ${selectedPackage.code}\nPaket: €${selectedPackage.eur / 1_000_000}M\nKlub: ${club.name}`)}`}
                target="_blank"
                rel="noreferrer"
                className="btn-gold py-2 px-4 text-xs w-full justify-center"
              >
                <Send size={14} /> Admin Bilan Telegram’da Bog‘lanish
                (@diyorbek_anorboyev)
              </a>
            </div>
          )}
        </div>

        {/* Financial Ledger Timeline (5 cols) */}
        <div className="glass-panel p-6 space-y-4 lg:col-span-5">
          <h3 className="font-heading text-xl font-bold text-white flex items-center gap-2 border-b border-slate-800 pb-3">
            <TrendingUp size={20} className="text-cyan-400" /> Moliya Jurnali
          </h3>

          <div className="space-y-3 max-h-96 overflow-y-auto pr-1">
            {finances.map((item) => (
              <div
                key={item.id}
                className="rounded-xl bg-slate-900/60 p-3 border border-slate-800/80 flex items-center justify-between"
              >
                <div className="space-y-0.5">
                  <div className="text-xs font-semibold text-white">
                    {item.description}
                  </div>
                  <div className="text-[10px] text-slate-400">{item.date}</div>
                </div>
                <div className="font-heading font-bold text-sm text-emerald-400">
                  +€{(item.amountEur / 1_000_000).toFixed(2)}M
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
};
