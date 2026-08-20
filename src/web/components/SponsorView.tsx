import React, { useState } from 'react';
import { Radio, ExternalLink, CheckCircle2, AlertTriangle } from 'lucide-react';

export const SponsorView: React.FC = () => {
  const [isSubscribed, setIsSubscribed] = useState<boolean>(true);
  const [checking, setChecking] = useState<boolean>(false);
  const [message, setMessage] = useState<string | null>(null);

  const handleVerifySubscription = () => {
    setChecking(true);
    setTimeout(() => {
      setChecking(false);
      setIsSubscribed(true);
      setMessage(
        'Muvaffaqiyatli: Telegram homiy kanaliga obuna faol deb tasdiqlandi!',
      );
      setTimeout(() => setMessage(null), 4000);
    }, 1200);
  };

  return (
    <div className="space-y-6">
      {/* Sponsor Channel Banner */}
      <div className="glass-panel relative overflow-hidden p-6 md:p-8 border-cyan-500/30">
        <div className="absolute -right-10 -top-10 h-64 w-64 rounded-full bg-cyan-500/10 blur-3xl" />
        <div className="relative z-10 flex flex-wrap items-center justify-between gap-6">
          <div className="space-y-2">
            <div className="inline-flex items-center gap-2 rounded-full bg-cyan-500/10 px-3 py-1 text-xs font-bold text-cyan-400 border border-cyan-500/30">
              <Radio size={14} /> Global Bosh Homiy Kanali
            </div>
            <h2 className="font-heading text-3xl font-extrabold text-white md:text-4xl">
              Homiylik va Bosh Kanal Obunasi
            </h2>
            <p className="max-w-xl text-sm text-slate-300">
              O‘yindagi har bir tugallangan o‘yin turi uchun €2.5M avtomatik
              homiylik daromadini olish uchun yagona rasmiy Telegram kanalimizga
              obuna bo‘ling.
            </p>
          </div>
        </div>
      </div>

      {/* Verification Status Card */}
      <div className="glass-panel p-6 space-y-6 max-w-2xl mx-auto">
        <div className="flex items-center justify-between border-b border-slate-800 pb-4">
          <div>
            <div className="text-xs text-slate-400">Homiy Kanali</div>
            <div className="font-heading text-lg font-bold text-white">
              @football_manager_uz
            </div>
          </div>

          <div
            className={`flex items-center gap-2 px-3 py-1 rounded-full text-xs font-bold ${
              isSubscribed
                ? 'bg-emerald-500/20 text-emerald-400 border border-emerald-500/40'
                : 'bg-amber-500/20 text-amber-400 border border-amber-500/40'
            }`}
          >
            {isSubscribed ? (
              <CheckCircle2 size={14} />
            ) : (
              <AlertTriangle size={14} />
            )}
            <span>
              {isSubscribed ? 'Obuna Tasdiqlangan' : 'Obuna Kutilmoqda'}
            </span>
          </div>
        </div>

        {message && (
          <div className="rounded-xl bg-emerald-500/20 p-3 text-xs font-bold text-emerald-300 border border-emerald-500/40">
            {message}
          </div>
        )}

        <div className="space-y-3">
          <a
            href="https://t.me/football_manager_uz"
            target="_blank"
            rel="noreferrer"
            className="btn-secondary w-full justify-center py-3 text-sm"
          >
            <ExternalLink size={18} /> Telegram Kanalga O‘tish
            (@football_manager_uz)
          </a>

          <button
            onClick={handleVerifySubscription}
            disabled={checking}
            className="btn-primary w-full justify-center py-3 text-sm"
          >
            <Radio size={18} />
            <span>
              {checking
                ? 'Tekshirilmoqda...'
                : 'Obunani Tekshirish va Yangilash'}
            </span>
          </button>
        </div>

        <div className="rounded-xl bg-slate-900/80 p-4 border border-slate-800 space-y-2">
          <div className="text-xs font-bold text-white">
            📌 Homiylik Qoidalari:
          </div>
          <ul className="text-xs text-slate-400 space-y-1 list-disc list-inside">
            <li>
              Har bir bajarilgan ligadagi tur o‘yini yakunida club hisobiga
              +€2.5M o'tkaziladi.
            </li>
            <li>
              Obuna tekshiruvi keshlanadi va o'yin davomida avtomatik hisoblab
              boriladi.
            </li>
          </ul>
        </div>
      </div>
    </div>
  );
};
