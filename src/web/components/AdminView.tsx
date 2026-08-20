import React, { useState } from 'react';
import {
  ShieldCheck,
  CheckCircle2,
  XCircle,
  Users,
  Trophy,
  DollarSign,
  Radio,
  Play,
} from 'lucide-react';

interface PendingOrder {
  id: string;
  orderCode: string;
  managerName: string;
  clubName: string;
  packageDisplay: string;
  eurAmount: number;
  uzsPrice: string;
  createdAt: string;
}

interface AdminViewProps {
  onApproveOrder: (requestId: string) => void;
  onForceRound: () => void;
}

export const AdminView: React.FC<AdminViewProps> = ({
  onApproveOrder,
  onForceRound,
}) => {
  const [orders, setOrders] = useState<PendingOrder[]>([
    {
      id: 'ord-101',
      orderCode: 'TBP-ADM991',
      managerName: 'Anvar Aliyev',
      clubName: 'FC Barcelona',
      packageDisplay: '€500 million',
      eurAmount: 500_000_000,
      uzsPrice: "125 000 so'm",
      createdAt: 'Bugun 14:20',
    },
    {
      id: 'ord-102',
      orderCode: 'TBP-ADM992',
      managerName: 'Sardor Karimov',
      clubName: 'Manchester City',
      packageDisplay: '€100 million',
      eurAmount: 100_000_000,
      uzsPrice: "35 000 so'm",
      createdAt: 'Bugun 15:05',
    },
  ]);

  const [sponsorChannel, setSponsorChannel] = useState('@football_manager_uz');
  const [toastMessage, setToastMessage] = useState<string | null>(null);

  const handleApprove = (order: PendingOrder) => {
    onApproveOrder(order.id);
    setOrders((prev) => prev.filter((o) => o.id !== order.id));
    setToastMessage(
      `Tasdiqlandi: ${order.orderCode} buyurtmasi tasdiqlandi va ${order.clubName} hisobiga +€${order.eurAmount / 1_000_000}M o'tkazildi!`,
    );
    setTimeout(() => setToastMessage(null), 4000);
  };

  const handleReject = (order: PendingOrder) => {
    setOrders((prev) => prev.filter((o) => o.id !== order.id));
    setToastMessage(`Rad etildi: ${order.orderCode} buyurtmasi rad etildi.`);
    setTimeout(() => setToastMessage(null), 4000);
  };

  return (
    <div className="space-y-6">
      {/* Admin Title Banner */}
      <div className="glass-panel relative overflow-hidden p-6 md:p-8 border-amber-500/40">
        <div className="absolute -right-10 -top-10 h-64 w-64 rounded-full bg-amber-500/15 blur-3xl" />
        <div className="relative z-10 flex flex-wrap items-center justify-between gap-6">
          <div className="space-y-2">
            <div className="inline-flex items-center gap-2 rounded-full bg-amber-500/20 px-3 py-1 text-xs font-bold text-amber-400 border border-amber-500/40">
              <ShieldCheck size={16} /> Eksklyuziv Admin Paneli (admin_users)
            </div>
            <h2 className="font-heading text-3xl font-extrabold text-white md:text-4xl">
              Boshqaruv va Admin Sozlamalari
            </h2>
            <p className="max-w-xl text-sm text-slate-300">
              Buyurtmalarni tasdiqlash, homiy kanallarini sozlash va liga
              turlarini majburiy yuritish.
            </p>
          </div>

          <button onClick={onForceRound} className="btn-gold text-sm py-3 px-5">
            <Play size={18} className="fill-white" />
            <span>Ligada Turni Majburiy Yurgizish</span>
          </button>
        </div>
      </div>

      {/* Admin Toast */}
      {toastMessage && (
        <div className="rounded-xl bg-amber-500/20 p-3 text-xs font-bold text-amber-300 border border-amber-500/40 flex items-center gap-2">
          <CheckCircle2 size={16} />
          <span>{toastMessage}</span>
        </div>
      )}

      {/* System Stats Widgets */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
        <div className="glass-panel p-5 space-y-1 border-violet-500/30">
          <div className="flex items-center justify-between text-xs text-slate-400">
            <span>Ro‘yxatdan o‘tgan Menejerlar</span>
            <Users size={16} className="text-violet-400" />
          </div>
          <div className="font-heading text-2xl font-extrabold text-white">
            128 ta
          </div>
          <div className="text-[10px] text-emerald-400 font-semibold">
            +12 bugun
          </div>
        </div>

        <div className="glass-panel p-5 space-y-1 border-emerald-500/30">
          <div className="flex items-center justify-between text-xs text-slate-400">
            <span>Kutilayotgan Buyurtmalar</span>
            <DollarSign size={16} className="text-emerald-400" />
          </div>
          <div className="font-heading text-2xl font-extrabold text-amber-400">
            {orders.length} ta
          </div>
          <div className="text-[10px] text-amber-400/80 font-semibold">
            Tasdiqlash kutilmoqda
          </div>
        </div>

        <div className="glass-panel p-5 space-y-1 border-cyan-500/30">
          <div className="flex items-center justify-between text-xs text-slate-400">
            <span>Faol Ligalar</span>
            <Trophy size={16} className="text-cyan-400" />
          </div>
          <div className="font-heading text-2xl font-extrabold text-cyan-400">
            16 ta
          </div>
          <div className="text-[10px] text-slate-400 font-semibold">
            Gigants Liga rejimida
          </div>
        </div>

        <div className="glass-panel p-5 space-y-1 border-amber-500/30">
          <div className="flex items-center justify-between text-xs text-slate-400">
            <span>Homiy Kanali</span>
            <Radio size={16} className="text-amber-400" />
          </div>
          <div className="font-heading text-lg font-bold text-white truncate">
            {sponsorChannel}
          </div>
          <div className="text-[10px] text-emerald-400 font-semibold">
            100% faol
          </div>
        </div>
      </div>

      {/* Pending Orders Approval Section */}
      <div className="glass-panel p-6 space-y-4">
        <h3 className="font-heading text-xl font-bold text-white flex items-center justify-between border-b border-slate-800 pb-3">
          <span>
            💰 Kutilayotgan Transfer Budjeti Buyurtmalari ({orders.length})
          </span>
          <span className="text-xs text-amber-400 font-normal">
            Qo‘lda tasdiqlash paneli
          </span>
        </h3>

        {orders.length === 0 ? (
          <div className="text-center py-8 text-sm text-slate-400 font-medium">
            Hozircha tasdiqlanmagan buyurtmalar mavjud emas.
          </div>
        ) : (
          <div className="overflow-x-auto">
            <table className="w-full text-left text-sm">
              <thead className="bg-slate-900/60 text-xs font-semibold text-slate-400 uppercase">
                <tr>
                  <th className="py-3 px-4 rounded-l-lg">Order Kodi</th>
                  <th className="py-3 px-4">Menejer</th>
                  <th className="py-3 px-4">Klub</th>
                  <th className="py-3 px-4">Paket</th>
                  <th className="py-3 px-4">Narxi (UZS)</th>
                  <th className="py-3 px-4 text-center rounded-r-lg">
                    Amallar
                  </th>
                </tr>
              </thead>
              <tbody className="divide-y divide-slate-800/60 font-medium">
                {orders.map((ord) => (
                  <tr
                    key={ord.id}
                    className="hover:bg-slate-800/40 text-slate-200"
                  >
                    <td className="py-3.5 px-4 font-mono font-bold text-amber-400">
                      {ord.orderCode}
                    </td>
                    <td className="py-3.5 px-4 font-semibold text-white">
                      {ord.managerName}
                    </td>
                    <td className="py-3.5 px-4 text-slate-300">
                      {ord.clubName}
                    </td>
                    <td className="py-3.5 px-4 font-bold text-emerald-400">
                      {ord.packageDisplay}
                    </td>
                    <td className="py-3.5 px-4 font-semibold text-slate-300">
                      {ord.uzsPrice}
                    </td>
                    <td className="py-3.5 px-4 text-center space-x-2">
                      <button
                        onClick={() => handleApprove(ord)}
                        className="btn-emerald py-1 px-3 text-xs"
                      >
                        <CheckCircle2 size={14} /> Tasdiqlash
                      </button>
                      <button
                        onClick={() => handleReject(ord)}
                        className="btn-secondary py-1 px-3 text-xs text-rose-400 hover:text-rose-300"
                      >
                        <XCircle size={14} /> Rad etish
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>

      {/* Global Sponsor Channel Config Section */}
      <div className="glass-panel p-6 space-y-4 max-w-xl">
        <h3 className="font-heading text-lg font-bold text-white flex items-center gap-2 border-b border-slate-800 pb-3">
          <Radio size={18} className="text-cyan-400" /> Bosh Homiy Kanali
          Sozlamasi
        </h3>

        <div className="space-y-3">
          <label className="text-xs font-semibold text-slate-400 block">
            Telegram Kanal Username:
          </label>
          <div className="flex gap-2">
            <input
              type="text"
              value={sponsorChannel}
              onChange={(e) => setSponsorChannel(e.target.value)}
              className="flex-1 rounded-xl bg-slate-900 px-4 py-2 text-xs font-bold text-white border border-slate-800"
            />
            <button
              onClick={() => {
                setToastMessage(
                  `Saqlandi: Homiy kanali ${sponsorChannel} ga o'zgartirildi!`,
                );
                setTimeout(() => setToastMessage(null), 3000);
              }}
              className="btn-primary py-2 px-4 text-xs"
            >
              Saqlash
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};
