import React from 'react';
import { NavTab, Club } from '../types.js';
import {
  Shield,
  Users,
  ShoppingBag,
  Award,
  CreditCard,
  Radio,
  ShieldCheck,
  LogOut,
  User,
} from 'lucide-react';

export interface UserSession {
  username: string;
  managerName: string;
  clubName?: string;
  isAdmin: boolean;
}

interface NavbarProps {
  currentTab: NavTab;
  onSelectTab: (tab: NavTab) => void;
  club: Club;
  userSession: UserSession;
  onLogout: () => void;
  onOpenAuthModal: () => void;
}

export const Navbar: React.FC<NavbarProps> = ({
  currentTab,
  onSelectTab,
  club,
  userSession,
  onLogout,
}) => {
  const baseTabs: { id: NavTab; label: string; icon: React.ReactNode }[] = [
    { id: 'dashboard', label: 'Bosh Sahifa', icon: <Shield size={18} /> },
    { id: 'squad', label: 'Tarkib & Taktika', icon: <Users size={18} /> },
    {
      id: 'transfers',
      label: 'Transfer Bozori',
      icon: <ShoppingBag size={18} />,
    },
    { id: 'legends', label: 'Afsonalar Bozori', icon: <Award size={18} /> },
    {
      id: 'finances',
      label: 'Moliya & Budjet',
      icon: <CreditCard size={18} />,
    },
    { id: 'sponsor', label: 'Homiylik', icon: <Radio size={18} /> },
    { id: 'profile', label: 'Profil', icon: <User size={18} /> },
  ];

  const tabs = userSession.isAdmin
    ? [
        ...baseTabs,
        {
          id: 'admin' as NavTab,
          label: '⚡️ Admin Panel',
          icon: <ShieldCheck size={18} className="text-amber-400" />,
        },
      ]
    : baseTabs;

  return (
    <header className="glass-panel sticky top-0 z-50 mb-6 border-b border-slate-800/80 px-6 py-4">
      <div className="mx-auto flex max-w-7xl flex-wrap items-center justify-between gap-4">
        {/* Brand & User Profile */}
        <div className="flex items-center gap-4">
          <div className="flex h-12 w-12 items-center justify-center rounded-2xl bg-gradient-to-tr from-cyan-500 via-violet-600 to-emerald-400 font-extrabold text-white text-lg shadow-lg shadow-cyan-900/40">
            FM
          </div>
          <div>
            <h1 className="font-heading text-xl font-extrabold tracking-tight text-white flex items-center gap-2">
              Football Manager <span className="text-cyan-400">2026</span>
              {userSession.isAdmin && (
                <span className="rounded-full bg-amber-500/20 px-2 py-0.5 text-[10px] font-bold text-amber-400 border border-amber-500/40">
                  ADMIN
                </span>
              )}
            </h1>
            <div className="flex items-center gap-2 text-xs font-medium text-slate-300">
              <span className="text-slate-400">Menejer:</span>
              <span className="font-bold text-white">
                {userSession.managerName}
              </span>
              <span className="text-slate-400">(@{userSession.username})</span>
              <span className="text-slate-500">|</span>
              <span className="font-bold text-emerald-400">{club.name}</span>
            </div>
          </div>
        </div>

        {/* Navigation Tabs */}
        <nav className="flex flex-wrap items-center gap-1.5 rounded-xl bg-slate-950/80 p-1.5 border border-slate-800/80">
          {tabs.map((tab) => {
            const isActive = currentTab === tab.id;
            const isAdminTab = tab.id === 'admin';
            return (
              <button
                key={tab.id}
                onClick={() => onSelectTab(tab.id)}
                className={`flex items-center gap-2 rounded-lg px-3.5 py-2 text-xs font-bold transition-all ${
                  isActive
                    ? isAdminTab
                      ? 'bg-gradient-to-r from-amber-500 to-orange-600 text-white shadow-md shadow-amber-900/50'
                      : 'bg-gradient-to-r from-cyan-500 to-blue-600 text-white shadow-md shadow-cyan-900/50'
                    : isAdminTab
                      ? 'text-amber-400 hover:bg-amber-500/10'
                      : 'text-slate-400 hover:bg-slate-800/60 hover:text-slate-200'
                }`}
              >
                {tab.icon}
                <span>{tab.label}</span>
              </button>
            );
          })}
        </nav>

        {/* Club Budget & User Action */}
        <div className="flex items-center gap-3">
          <div className="flex items-center gap-2 rounded-xl bg-slate-900/90 px-3.5 py-2 border border-emerald-500/30 shadow-inner">
            <div className="flex h-7 w-7 items-center justify-center rounded-lg bg-emerald-500/20 text-emerald-400 font-bold text-xs">
              €
            </div>
            <div>
              <div className="text-[9px] font-bold tracking-wider text-slate-400 uppercase">
                Budjet
              </div>
              <div className="font-heading text-base font-extrabold text-emerald-400">
                €{(club.balanceEur / 1_000_000).toFixed(1)}M
              </div>
            </div>
          </div>

          {/* User Account Action */}
          <button
            onClick={onLogout}
            title="Tizimdan chiqish"
            className="flex h-9 w-9 items-center justify-center rounded-xl bg-slate-900/90 text-slate-400 hover:text-rose-400 hover:bg-rose-500/10 border border-slate-800 transition"
          >
            <LogOut size={16} />
          </button>
        </div>
      </div>
    </header>
  );
};
