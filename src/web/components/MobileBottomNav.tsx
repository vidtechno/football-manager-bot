import React from 'react';
import { NavTab } from '../types.js';
import {
  Shield,
  Users,
  ShoppingBag,
  Award,
  CreditCard,
  User,
  ShieldCheck,
} from 'lucide-react';

interface MobileBottomNavProps {
  currentTab: NavTab;
  onSelectTab: (tab: NavTab) => void;
  isAdmin: boolean;
}

export const MobileBottomNav: React.FC<MobileBottomNavProps> = ({
  currentTab,
  onSelectTab,
  isAdmin,
}) => {
  const tabs: { id: NavTab; label: string; icon: React.ReactNode }[] = [
    { id: 'dashboard', label: 'Liga', icon: <Shield size={20} /> },
    { id: 'squad', label: 'Tarkib', icon: <Users size={20} /> },
    { id: 'transfers', label: 'Bozor', icon: <ShoppingBag size={20} /> },
    { id: 'legends', label: 'Afsona', icon: <Award size={20} /> },
    { id: 'finances', label: 'Moliya', icon: <CreditCard size={20} /> },
    { id: 'profile', label: 'Profil', icon: <User size={20} /> },
  ];

  if (isAdmin) {
    tabs.push({
      id: 'admin',
      label: 'Admin',
      icon: <ShieldCheck size={20} className="text-amber-400" />,
    });
  }

  return (
    <nav className="mobile-bottom-nav md:hidden flex items-center justify-around shadow-2xl">
      {tabs.map((tab) => {
        const isActive = currentTab === tab.id;
        return (
          <button
            key={tab.id}
            onClick={() => onSelectTab(tab.id)}
            className={`flex flex-col items-center justify-center py-1 px-2.5 rounded-xl transition-all ${
              isActive
                ? 'text-cyan-400 font-bold bg-cyan-500/10 border border-cyan-500/30'
                : 'text-slate-400 hover:text-slate-200'
            }`}
          >
            {tab.icon}
            <span className="text-[10px] mt-0.5 font-medium">{tab.label}</span>
          </button>
        );
      })}
    </nav>
  );
};
