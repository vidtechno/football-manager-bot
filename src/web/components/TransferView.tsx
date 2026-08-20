import React, { useState } from 'react';
import { TransferListing, Player, Club } from '../types.js';
import {
  ShoppingBag,
  Search,
  Filter,
  PlusCircle,
  CheckCircle,
  AlertCircle,
} from 'lucide-react';

interface TransferViewProps {
  listings: TransferListing[];
  squad: Player[];
  club: Club;
  onBuyPlayer: (listingId: string) => void;
  onListPlayer: (player: Player, priceEur: number) => void;
}

export const TransferView: React.FC<TransferViewProps> = ({
  listings,
  squad,
  club,
  onBuyPlayer,
  onListPlayer,
}) => {
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedPos, setSelectedPos] = useState<string>('ALL');
  const [showListModal, setShowListModal] = useState(false);
  const [selectedPlayerToList, setSelectedPlayerToList] =
    useState<Player | null>(null);
  const [listPrice, setListPrice] = useState<number>(50_000_000);
  const [notification, setNotification] = useState<string | null>(null);

  const filteredListings = listings.filter((item) => {
    const matchesSearch = item.playerName
      .toLowerCase()
      .includes(searchQuery.toLowerCase());
    const matchesPos =
      selectedPos === 'ALL' || item.position.includes(selectedPos);
    return matchesSearch && matchesPos;
  });

  const handleBuy = (item: TransferListing) => {
    if (club.balanceEur < item.priceEur) {
      setNotification(
        `Xatolik: Transfer budjeti yetarli emas (€${(club.balanceEur / 1_000_000).toFixed(1)}M mavjud)`,
      );
      setTimeout(() => setNotification(null), 3000);
      return;
    }

    onBuyPlayer(item.id);
    setNotification(
      `Muvaffaqiyatli: ${item.playerName} €${(item.priceEur / 1_000_000).toFixed(1)}M ga sotib olindi!`,
    );
    setTimeout(() => setNotification(null), 4000);
  };

  const handleCreateListing = () => {
    if (!selectedPlayerToList) return;
    onListPlayer(selectedPlayerToList, listPrice);
    setShowListModal(false);
    setSelectedPlayerToList(null);
    setNotification(
      `E'lon: ${selectedPlayerToList.fullName} €${(listPrice / 1_000_000).toFixed(1)}M narx bilan bozorga chiqarildi!`,
    );
    setTimeout(() => setNotification(null), 4000);
  };

  return (
    <div className="space-y-6">
      {/* Top Banner & Search Controls */}
      <div className="glass-panel p-6 space-y-4">
        <div className="flex flex-wrap items-center justify-between gap-4">
          <div>
            <h2 className="font-heading text-2xl font-bold text-white flex items-center gap-2">
              <ShoppingBag size={24} className="text-emerald-400" /> Doimiy
              Transfer Bozori
            </h2>
            <p className="text-xs text-slate-400 mt-1">
              Barcha klublar futbolchilarni 24/7 sotish va sotib olishlari
              mumkin.
            </p>
          </div>

          <button
            onClick={() => setShowListModal(true)}
            className="btn-primary"
          >
            <PlusCircle size={18} />
            <span>Futbolchini Sotuvga Qo‘yish</span>
          </button>
        </div>

        {/* Notification Toast */}
        {notification && (
          <div
            className={`rounded-xl p-3 text-xs font-bold flex items-center gap-2 ${
              notification.includes('Xatolik')
                ? 'bg-rose-500/20 text-rose-300 border border-rose-500/40'
                : 'bg-emerald-500/20 text-emerald-300 border border-emerald-500/40'
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

        {/* Filters & Search */}
        <div className="flex flex-wrap items-center gap-3 pt-2">
          <div className="relative flex-1 min-w-[220px]">
            <Search
              size={16}
              className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-400"
            />
            <input
              type="text"
              placeholder="Futbolchi ismini qidirish..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="w-full rounded-xl bg-slate-900/90 pl-9 pr-4 py-2 text-xs font-medium text-white border border-slate-800 focus:border-emerald-500 focus:outline-none"
            />
          </div>

          <div className="flex items-center gap-1 rounded-xl bg-slate-900/90 p-1 border border-slate-800">
            <Filter size={14} className="text-slate-400 ml-2 mr-1" />
            {['ALL', 'GK', 'DEF', 'MID', 'FWD'].map((pos) => (
              <button
                key={pos}
                onClick={() => setSelectedPos(pos)}
                className={`px-3 py-1 text-xs font-bold rounded-lg transition-all ${
                  selectedPos === pos
                    ? 'bg-emerald-500 text-white'
                    : 'text-slate-400 hover:text-white'
                }`}
              >
                {pos}
              </button>
            ))}
          </div>
        </div>
      </div>

      {/* Listings Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
        {filteredListings.map((item) => (
          <div
            key={item.id}
            className="glass-panel p-5 space-y-4 flex flex-col justify-between"
          >
            <div className="space-y-2">
              <div className="flex items-center justify-between">
                <span className="badge-ovr badge-emerald text-xs">
                  {item.overallRating} OVR
                </span>
                <span className="rounded bg-slate-800 px-2 py-0.5 text-[10px] font-bold text-slate-300">
                  {item.position}
                </span>
              </div>
              <h3 className="font-heading text-lg font-bold text-white">
                {item.playerName}
              </h3>
              <p className="text-xs text-slate-400">
                Sotuvchi klub:{' '}
                <span className="text-slate-200 font-semibold">
                  {item.sellerClubName}
                </span>
              </p>
            </div>

            <div className="pt-3 border-t border-slate-800 flex items-center justify-between">
              <div>
                <div className="text-[10px] text-slate-400">Transfer narxi</div>
                <div className="font-heading text-base font-extrabold text-amber-400">
                  €{(item.priceEur / 1_000_000).toFixed(1)} mln
                </div>
              </div>

              <button
                onClick={() => handleBuy(item)}
                className="btn-primary py-1.5 px-3.5 text-xs"
              >
                Sotib Olish
              </button>
            </div>
          </div>
        ))}
      </div>

      {/* List Player Modal */}
      {showListModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/70 backdrop-blur-sm p-4">
          <div className="glass-panel max-w-md w-full p-6 space-y-4">
            <h3 className="font-heading text-xl font-bold text-white border-b border-slate-800 pb-3">
              Futbolchini Sotuvga Qo‘yish
            </h3>

            <div className="space-y-3">
              <label className="text-xs font-semibold text-slate-400 block">
                Futbolchini tanlang:
              </label>
              <select
                onChange={(e) => {
                  const found = squad.find((p) => p.id === e.target.value);
                  setSelectedPlayerToList(found || null);
                  if (found) setListPrice(found.marketValueEur);
                }}
                className="w-full rounded-xl bg-slate-900 p-2.5 text-xs font-medium text-white border border-slate-800"
              >
                <option value="">-- Futbolchi --</option>
                {squad.map((p) => (
                  <option key={p.id} value={p.id}>
                    {p.fullName} ({p.primaryPosition} - {p.overallRating} OVR)
                  </option>
                ))}
              </select>

              {selectedPlayerToList && (
                <div className="space-y-2 pt-2">
                  <label className="text-xs font-semibold text-slate-400 block">
                    Sotuv Narxi (€):
                  </label>
                  <input
                    type="number"
                    value={listPrice}
                    step={1000000}
                    onChange={(e) => setListPrice(Number(e.target.value))}
                    className="w-full rounded-xl bg-slate-900 p-2.5 text-sm font-bold text-amber-400 border border-slate-800"
                  />
                  <p className="text-[10px] text-slate-400">
                    Tavsiya narx: €
                    {(selectedPlayerToList.marketValueEur / 1_000_000).toFixed(
                      1,
                    )}
                    M
                  </p>
                </div>
              )}
            </div>

            <div className="flex items-center justify-end gap-3 pt-3">
              <button
                onClick={() => setShowListModal(false)}
                className="btn-secondary py-1.5 px-4 text-xs"
              >
                Bekor qilish
              </button>
              <button
                disabled={!selectedPlayerToList}
                onClick={handleCreateListing}
                className="btn-primary py-1.5 px-4 text-xs disabled:opacity-50"
              >
                E'lonni e'lon qilish
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};
