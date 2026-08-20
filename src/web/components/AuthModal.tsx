import React, { useState } from 'react';
import { ApiClient, setAuthToken } from '../apiClient.js';
import {
  LogIn,
  UserPlus,
  AlertCircle,
  Eye,
  EyeOff,
  Lock,
  User,
  Smartphone,
} from 'lucide-react';

interface AuthModalProps {
  onSuccess: () => void;
}

export const AuthModal: React.FC<AuthModalProps> = ({ onSuccess }) => {
  const [isRegisterMode, setIsRegisterMode] = useState<boolean>(false);
  const [username, setUsername] = useState<string>('');
  const [managerName, setManagerName] = useState<string>('');
  const [password, setPassword] = useState<string>('');
  const [confirmPassword, setConfirmPassword] = useState<string>('');
  const [rememberMe, setRememberMe] = useState<boolean>(true);
  const [showPassword, setShowPassword] = useState<boolean>(false);

  const [loading, setLoading] = useState<boolean>(false);
  const [errorMessage, setErrorMessage] = useState<string | null>(null);

  const handleRegisterSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setErrorMessage(null);

    const cleanUser = username.trim().toLowerCase();
    if (cleanUser.length < 4 || cleanUser.length > 24) {
      setErrorMessage('Username 4 va 24 belgi orasida bo‘lishi shart.');
      return;
    }
    if (!/^[a-z0-9_]+$/.test(cleanUser)) {
      setErrorMessage(
        'Username faqat kichik lotin harflari, raqamlar va _ belgisidan iborat bo‘lishi kerak.',
      );
      return;
    }
    if (managerName.trim().length < 2) {
      setErrorMessage(
        'Menejer ismi kamida 2 ta belgidan iborat bo‘lishi shart.',
      );
      return;
    }
    if (password.length < 8) {
      setErrorMessage('Parol kamida 8 ta belgidan iborat bo‘lishi shart.');
      return;
    }
    if (password !== confirmPassword) {
      setErrorMessage('Kiritilgan parollar bir-biriga mos kelmadi.');
      return;
    }

    setLoading(true);
    try {
      const res = await ApiClient.register(
        cleanUser,
        managerName.trim(),
        password,
        confirmPassword,
      );
      setAuthToken(res.token);
      onSuccess();
    } catch (err: any) {
      setErrorMessage(err.message || 'Ro‘yxatdan o‘tishda xatolik yuz berdi.');
    } finally {
      setLoading(false);
    }
  };

  const handleLoginSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setErrorMessage(null);

    if (!username.trim() || !password) {
      setErrorMessage('Username va parol kiritilishi shart.');
      return;
    }

    setLoading(true);
    try {
      const res = await ApiClient.login(
        username.trim().toLowerCase(),
        password,
        rememberMe,
      );
      setAuthToken(res.token);
      onSuccess();
    } catch (err: any) {
      setErrorMessage(err.message || 'Username yoki parol noto‘g‘ri.');
    } finally {
      setLoading(false);
    }
  };

  const handleTelegramMiniAppLogin = async () => {
    const telegramWebApp = (window as any).Telegram?.WebApp;
    const initData = telegramWebApp?.initData;
    if (!initData) {
      setErrorMessage(
        'Telegram Mini App initData topilmadi. Telegram ilovasidan kiring.',
      );
      return;
    }

    setLoading(true);
    try {
      const res = await ApiClient.login(
        undefined,
        undefined,
        rememberMe,
        initData,
      );
      setAuthToken(res.token);
      onSuccess();
    } catch (err: any) {
      setErrorMessage(err.message || 'Telegram orqali kirishda xatolik.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/85 backdrop-blur-md p-4 animate-fadeIn">
      <div className="glass-panel max-w-md w-full p-6 md:p-8 space-y-6 border-cyan-500/40 shadow-2xl relative">
        {/* Header Logo & Title */}
        <div className="text-center space-y-2">
          <div className="flex h-14 w-14 items-center justify-center rounded-2xl bg-gradient-to-tr from-cyan-500 to-violet-600 font-extrabold text-white text-xl shadow-lg shadow-cyan-900/40 mx-auto">
            FM
          </div>
          <h2 className="font-heading text-2xl font-extrabold text-white">
            Football Manager <span className="text-cyan-400">2026</span>
          </h2>
          <p className="text-xs text-slate-300">
            {isRegisterMode
              ? 'Yangi menejer akkauntini yaratish'
              : 'Xush kelibsiz! Tizimga kirish'}
          </p>
        </div>

        {/* Mode Switcher Tabs */}
        <div className="flex items-center gap-1 rounded-xl bg-slate-900/90 p-1 border border-slate-800">
          <button
            type="button"
            onClick={() => {
              setIsRegisterMode(false);
              setErrorMessage(null);
            }}
            className={`flex-1 py-2 text-xs font-bold rounded-lg transition-all flex items-center justify-center gap-1.5 ${
              !isRegisterMode
                ? 'bg-gradient-to-r from-cyan-500 to-blue-600 text-white shadow-md'
                : 'text-slate-400 hover:text-white'
            }`}
          >
            <LogIn size={14} /> Kirish
          </button>
          <button
            type="button"
            onClick={() => {
              setIsRegisterMode(true);
              setErrorMessage(null);
            }}
            className={`flex-1 py-2 text-xs font-bold rounded-lg transition-all flex items-center justify-center gap-1.5 ${
              isRegisterMode
                ? 'bg-gradient-to-r from-emerald-500 to-teal-600 text-white shadow-md'
                : 'text-slate-400 hover:text-white'
            }`}
          >
            <UserPlus size={14} /> Ro‘yxatdan o‘tish
          </button>
        </div>

        {/* Error Alert */}
        {errorMessage && (
          <div className="rounded-xl bg-rose-500/20 p-3 text-xs font-bold text-rose-300 border border-rose-500/40 flex items-center gap-2">
            <AlertCircle size={16} className="shrink-0" />
            <span>{errorMessage}</span>
          </div>
        )}

        {/* Form Body */}
        {isRegisterMode ? (
          <form onSubmit={handleRegisterSubmit} className="space-y-4">
            <div className="space-y-1">
              <label className="text-xs font-semibold text-slate-300 block">
                Username:
              </label>
              <div className="relative">
                <input
                  type="text"
                  required
                  placeholder="masalan: diyoration"
                  value={username}
                  onChange={(e) => setUsername(e.target.value)}
                  className="w-full rounded-xl bg-slate-900/90 pl-10 pr-4 py-2.5 text-sm font-medium text-white border border-slate-800 focus:border-cyan-500 focus:outline-none"
                />
                <User
                  size={16}
                  className="absolute left-3.5 top-3 text-slate-500"
                />
              </div>
            </div>

            <div className="space-y-1">
              <label className="text-xs font-semibold text-slate-300 block">
                Menejer ismi:
              </label>
              <input
                type="text"
                required
                placeholder="Diyorbek Anorboyev"
                value={managerName}
                onChange={(e) => setManagerName(e.target.value)}
                className="w-full rounded-xl bg-slate-900/90 px-4 py-2.5 text-sm font-medium text-white border border-slate-800 focus:border-cyan-500 focus:outline-none"
              />
            </div>

            <div className="space-y-1">
              <label className="text-xs font-semibold text-slate-300 block">
                Parol (kamida 8 ta belgi):
              </label>
              <div className="relative">
                <input
                  type={showPassword ? 'text' : 'password'}
                  required
                  placeholder="••••••••"
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  className="w-full rounded-xl bg-slate-900/90 pl-10 pr-10 py-2.5 text-sm font-medium text-white border border-slate-800 focus:border-cyan-500 focus:outline-none"
                />
                <Lock
                  size={16}
                  className="absolute left-3.5 top-3 text-slate-500"
                />
                <button
                  type="button"
                  onClick={() => setShowPassword(!showPassword)}
                  className="absolute right-3.5 top-3 text-slate-400 hover:text-white"
                >
                  {showPassword ? <EyeOff size={16} /> : <Eye size={16} />}
                </button>
              </div>
            </div>

            <div className="space-y-1">
              <label className="text-xs font-semibold text-slate-300 block">
                Parolni qayta kiriting:
              </label>
              <input
                type={showPassword ? 'text' : 'password'}
                required
                placeholder="••••••••"
                value={confirmPassword}
                onChange={(e) => setConfirmPassword(e.target.value)}
                className="w-full rounded-xl bg-slate-900/90 px-4 py-2.5 text-sm font-medium text-white border border-slate-800 focus:border-cyan-500 focus:outline-none"
              />
            </div>

            <button
              type="submit"
              disabled={loading}
              className="btn-emerald w-full justify-center py-3 text-sm mt-2 disabled:opacity-50"
            >
              {loading ? (
                <div className="animate-spin rounded-full h-4 w-4 border-2 border-white border-t-transparent" />
              ) : (
                <UserPlus size={18} />
              )}
              <span>Ro‘yxatdan o‘tish</span>
            </button>

            <p className="text-xs text-center text-slate-400 pt-1">
              Akkauntingiz bormi?{' '}
              <button
                type="button"
                onClick={() => setIsRegisterMode(false)}
                className="text-cyan-400 font-bold hover:underline"
              >
                Kirish
              </button>
            </p>
          </form>
        ) : (
          <form onSubmit={handleLoginSubmit} className="space-y-4">
            <div className="space-y-1">
              <label className="text-xs font-semibold text-slate-300 block">
                Username:
              </label>
              <div className="relative">
                <input
                  type="text"
                  required
                  placeholder="Username kiritasiz"
                  value={username}
                  onChange={(e) => setUsername(e.target.value)}
                  className="w-full rounded-xl bg-slate-900/90 pl-10 pr-4 py-2.5 text-sm font-medium text-white border border-slate-800 focus:border-cyan-500 focus:outline-none"
                />
                <User
                  size={16}
                  className="absolute left-3.5 top-3 text-slate-500"
                />
              </div>
            </div>

            <div className="space-y-1">
              <label className="text-xs font-semibold text-slate-300 block">
                Parol:
              </label>
              <div className="relative">
                <input
                  type={showPassword ? 'text' : 'password'}
                  required
                  placeholder="••••••••"
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  className="w-full rounded-xl bg-slate-900/90 pl-10 pr-10 py-2.5 text-sm font-medium text-white border border-slate-800 focus:border-cyan-500 focus:outline-none"
                />
                <Lock
                  size={16}
                  className="absolute left-3.5 top-3 text-slate-500"
                />
                <button
                  type="button"
                  onClick={() => setShowPassword(!showPassword)}
                  className="absolute right-3.5 top-3 text-slate-400 hover:text-white"
                >
                  {showPassword ? <EyeOff size={16} /> : <Eye size={16} />}
                </button>
              </div>
            </div>

            <div className="flex items-center justify-between text-xs pt-1">
              <label className="flex items-center gap-2 cursor-pointer text-slate-300 select-none">
                <input
                  type="checkbox"
                  checked={rememberMe}
                  onChange={(e) => setRememberMe(e.target.checked)}
                  className="rounded bg-slate-900 border-slate-800 text-cyan-500 focus:ring-0"
                />
                <span>Meni eslab qolish (30 kun)</span>
              </label>
            </div>

            <button
              type="submit"
              disabled={loading}
              className="btn-primary w-full justify-center py-3 text-sm mt-2 disabled:opacity-50"
            >
              {loading ? (
                <div className="animate-spin rounded-full h-4 w-4 border-2 border-white border-t-transparent" />
              ) : (
                <LogIn size={18} />
              )}
              <span>Kirish</span>
            </button>

            <button
              type="button"
              onClick={handleTelegramMiniAppLogin}
              className="w-full rounded-xl bg-cyan-500/10 p-2.5 text-xs font-bold text-cyan-400 border border-cyan-500/30 hover:bg-cyan-500/20 transition flex items-center justify-center gap-2"
            >
              <Smartphone size={16} /> Telegram Mini App Orqali Kirish
            </button>

            <p className="text-xs text-center text-slate-400 pt-1">
              Akkauntingiz yo‘qmi?{' '}
              <button
                type="button"
                onClick={() => setIsRegisterMode(true)}
                className="text-emerald-400 font-bold hover:underline"
              >
                Ro‘yxatdan o‘tish
              </button>
            </p>
          </form>
        )}
      </div>
    </div>
  );
};
