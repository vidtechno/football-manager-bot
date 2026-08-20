import React, { useState } from 'react';
import { ApiClient } from '../apiClient.js';
import {
  User,
  ShieldCheck,
  Smartphone,
  Key,
  LogOut,
  AlertCircle,
  CheckCircle2,
  RefreshCw,
} from 'lucide-react';

interface ProfileViewProps {
  userSession: {
    managerId: string;
    username: string;
    managerName: string;
    isAdmin: boolean;
    isTelegramLinked: boolean;
    telegramUserId: number;
  };
  onLogout: () => void;
}

export const ProfileView: React.FC<ProfileViewProps> = ({
  userSession,
  onLogout,
}) => {
  const [showPasswordModal, setShowPasswordModal] = useState<boolean>(false);
  const [oldPassword, setOldPassword] = useState<string>('');
  const [newPassword, setNewPassword] = useState<string>('');
  const [confirmPassword, setConfirmPassword] = useState<string>('');

  const [toastMessage, setToastMessage] = useState<string | null>(null);
  const [errorMessage, setErrorMessage] = useState<string | null>(null);
  const [loading, setLoading] = useState<boolean>(false);

  const handleLinkTelegram = async () => {
    setErrorMessage(null);
    const telegramWebApp = (window as any).Telegram?.WebApp;
    const initData = telegramWebApp?.initData;

    if (!initData) {
      setErrorMessage(
        'Telegram Mini App initData topilmadi. Telegram ilovasidan ochib ulash tugmasini bosing.',
      );
      return;
    }

    setLoading(true);
    try {
      const res = await ApiClient.linkTelegram(initData);
      setToastMessage(
        res.message || 'Telegram akkaunti muvaffaqiyatli ulandi!',
      );
      setTimeout(() => setToastMessage(null), 4000);
    } catch (err: any) {
      setErrorMessage(err.message || 'Telegram ulashda xatolik.');
    } finally {
      setLoading(false);
    }
  };

  const handleChangePasswordSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setErrorMessage(null);

    if (newPassword.length < 8) {
      setErrorMessage(
        'Yangi parol kamida 8 ta belgidan iborat bo‘lishi shart.',
      );
      return;
    }
    if (newPassword !== confirmPassword) {
      setErrorMessage('Yangi parollar bir-biriga mos kelmadi.');
      return;
    }

    setLoading(true);
    try {
      const res = await ApiClient.changePassword(
        oldPassword,
        newPassword,
        confirmPassword,
      );
      setShowPasswordModal(false);
      setOldPassword('');
      setNewPassword('');
      setConfirmPassword('');
      setToastMessage(res.message || 'Parol o‘zgartirildi.');
      setTimeout(() => setToastMessage(null), 4000);
    } catch (err: any) {
      setErrorMessage(err.message || 'Parol o‘zgartirishda xatolik.');
    } finally {
      setLoading(false);
    }
  };

  const handleLogoutAll = async () => {
    if (!window.confirm('Barcha qurilmalardan chiqishni xohlaysizmi?')) return;
    try {
      await ApiClient.logoutAll();
      onLogout();
    } catch (err: any) {
      alert(`Chiqishda xatolik: ${err.message}`);
    }
  };

  return (
    <div className="space-y-6 max-w-4xl mx-auto">
      {/* Title Header */}
      <div className="glass-panel p-6 border-cyan-500/30 flex flex-wrap items-center justify-between gap-4">
        <div className="flex items-center gap-4">
          <div className="flex h-16 w-16 items-center justify-center rounded-2xl bg-gradient-to-tr from-cyan-500 to-violet-600 font-extrabold text-white text-2xl shadow-lg">
            {userSession.managerName.charAt(0).toUpperCase()}
          </div>
          <div>
            <div className="flex items-center gap-2">
              <h2 className="font-heading text-2xl font-extrabold text-white">
                {userSession.managerName}
              </h2>
              {userSession.isAdmin && (
                <span className="rounded-full bg-amber-500/20 px-2.5 py-0.5 text-xs font-bold text-amber-400 border border-amber-500/40 flex items-center gap-1">
                  <ShieldCheck size={14} /> Admin
                </span>
              )}
            </div>
            <p className="text-xs text-cyan-400 font-mono mt-0.5">
              @{userSession.username}
            </p>
          </div>
        </div>

        <button
          onClick={onLogout}
          className="btn-secondary text-xs text-rose-400 hover:text-rose-300"
        >
          <LogOut size={16} /> Chiqish
        </button>
      </div>

      {/* Messages */}
      {toastMessage && (
        <div className="rounded-xl bg-emerald-500/20 p-3.5 text-xs font-bold text-emerald-300 border border-emerald-500/40 flex items-center gap-2">
          <CheckCircle2 size={16} /> <span>{toastMessage}</span>
        </div>
      )}

      {errorMessage && (
        <div className="rounded-xl bg-rose-500/20 p-3.5 text-xs font-bold text-rose-300 border border-rose-500/40 flex items-center gap-2">
          <AlertCircle size={16} /> <span>{errorMessage}</span>
        </div>
      )}

      {/* Profile Details & Security Settings */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        {/* Account Summary */}
        <div className="glass-panel p-6 space-y-4">
          <h3 className="font-heading text-lg font-bold text-white border-b border-slate-800 pb-3 flex items-center gap-2">
            <User size={18} className="text-cyan-400" /> Profil Ma’lumotlari
          </h3>

          <div className="space-y-3 text-sm">
            <div className="flex justify-between border-b border-slate-800/60 pb-2">
              <span className="text-slate-400">Username:</span>
              <span className="font-bold text-white font-mono">
                @{userSession.username}
              </span>
            </div>
            <div className="flex justify-between border-b border-slate-800/60 pb-2">
              <span className="text-slate-400">Menejer Ismi:</span>
              <span className="font-bold text-white">
                {userSession.managerName}
              </span>
            </div>
            <div className="flex justify-between border-b border-slate-800/60 pb-2">
              <span className="text-slate-400">Telegram Holati:</span>
              <span
                className={`font-bold text-xs px-2 py-0.5 rounded ${userSession.isTelegramLinked ? 'bg-emerald-500/20 text-emerald-400' : 'bg-slate-800 text-slate-400'}`}
              >
                {userSession.isTelegramLinked ? '✅ Ulangan' : '❌ Ulanmagan'}
              </span>
            </div>
          </div>

          {!userSession.isTelegramLinked && (
            <button
              onClick={handleLinkTelegram}
              disabled={loading}
              className="btn-primary w-full justify-center text-xs py-2.5 mt-2"
            >
              <Smartphone size={16} /> Telegram Akkauntini Ulash
            </button>
          )}
        </div>

        {/* Security Controls */}
        <div className="glass-panel p-6 space-y-4">
          <h3 className="font-heading text-lg font-bold text-white border-b border-slate-800 pb-3 flex items-center gap-2">
            <Key size={18} className="text-amber-400" /> Xavfsizlik Sozlamalari
          </h3>

          <div className="space-y-3">
            <button
              onClick={() => setShowPasswordModal(true)}
              className="btn-secondary w-full justify-center text-xs py-2.5"
            >
              <Key size={16} /> Parolni O‘zgartirish
            </button>

            <button
              onClick={handleLogoutAll}
              className="w-full rounded-xl bg-rose-500/10 p-2.5 text-xs font-bold text-rose-400 border border-rose-500/30 hover:bg-rose-500/20 transition flex items-center justify-center gap-2"
            >
              <RefreshCw size={16} /> Barcha Qurilmalardan Chiqish
            </button>
          </div>
        </div>
      </div>

      {/* Change Password Modal */}
      {showPasswordModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/80 backdrop-blur-md p-4">
          <div className="glass-panel max-w-md w-full p-6 space-y-4 border-amber-500/40">
            <h3 className="font-heading text-xl font-bold text-white border-b border-slate-800 pb-3">
              Parolni O‘zgartirish
            </h3>

            <form onSubmit={handleChangePasswordSubmit} className="space-y-3">
              <div className="space-y-1">
                <label className="text-xs font-semibold text-slate-300 block">
                  Joriy Parolingiz:
                </label>
                <input
                  type="password"
                  required
                  value={oldPassword}
                  onChange={(e) => setOldPassword(e.target.value)}
                  className="w-full rounded-xl bg-slate-900 px-4 py-2 text-sm text-white border border-slate-800"
                />
              </div>

              <div className="space-y-1">
                <label className="text-xs font-semibold text-slate-300 block">
                  Yangi Parol (kamida 8 ta belgi):
                </label>
                <input
                  type="password"
                  required
                  value={newPassword}
                  onChange={(e) => setNewPassword(e.target.value)}
                  className="w-full rounded-xl bg-slate-900 px-4 py-2 text-sm text-white border border-slate-800"
                />
              </div>

              <div className="space-y-1">
                <label className="text-xs font-semibold text-slate-300 block">
                  Yangi Parolni Tasdiqlang:
                </label>
                <input
                  type="password"
                  required
                  value={confirmPassword}
                  onChange={(e) => setConfirmPassword(e.target.value)}
                  className="w-full rounded-xl bg-slate-900 px-4 py-2 text-sm text-white border border-slate-800"
                />
              </div>

              <div className="flex justify-end gap-3 pt-2">
                <button
                  type="button"
                  onClick={() => setShowPasswordModal(false)}
                  className="btn-secondary py-1.5 px-4 text-xs"
                >
                  Bekor qilish
                </button>
                <button
                  type="submit"
                  disabled={loading}
                  className="btn-primary py-1.5 px-4 text-xs"
                >
                  O‘zgartirish
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
};
