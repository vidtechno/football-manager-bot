// In-memory token storage (NO localStorage / sessionStorage usage)

let inMemoryAccessToken: string | null = null;
let inMemoryCsrfToken: string | null = null;

export function getAuthToken(): string | null {
  return inMemoryAccessToken;
}

export function setAuthToken(token: string | null): void {
  inMemoryAccessToken = token;
}

export function setCsrfToken(token: string | null): void {
  inMemoryCsrfToken = token;
}

function getCsrfCookie(): string | null {
  if (typeof document === 'undefined') return null;
  const match = document.cookie.match(/(?:^|; )_csrf=([^;]*)/);
  return match && match[1] ? decodeURIComponent(match[1]) : null;
}

async function request<T>(
  endpoint: string,
  options: RequestInit = {},
): Promise<T> {
  const token = getAuthToken();
  const csrf = inMemoryCsrfToken || getCsrfCookie();

  const headers: Record<string, string> = {
    'Content-Type': 'application/json',
    ...(options.headers as Record<string, string>),
  };

  if (token) {
    headers['Authorization'] = `Bearer ${token}`;
  }

  const method = (options.method || 'GET').toUpperCase();
  if (!['GET', 'HEAD', 'OPTIONS'].includes(method) && csrf) {
    headers['X-CSRF-Token'] = csrf;
  }

  const response = await fetch(`/api${endpoint}`, {
    ...options,
    credentials: 'include', // Include HttpOnly cookies
    headers,
  });

  const data = await response.json();

  if (data.csrfToken) {
    setCsrfToken(data.csrfToken);
  }

  if (!response.ok) {
    throw new Error(data.error || `HTTP ${response.status}: Request failed`);
  }

  return data as T;
}

export const ApiClient = {
  // Registration
  register: (
    username: string,
    managerName: string,
    password: string,
    confirmPassword: string,
  ) =>
    request<{ token: string; csrfToken: string; manager: any }>(
      '/auth/register',
      {
        method: 'POST',
        body: JSON.stringify({
          username,
          managerName,
          password,
          confirmPassword,
        }),
      },
    ),

  // Login
  login: (
    username?: string,
    password?: string,
    rememberMe = false,
    initData?: string,
  ) =>
    request<{ token: string; csrfToken: string; manager: any }>('/auth/login', {
      method: 'POST',
      body: JSON.stringify({ username, password, rememberMe, initData }),
    }),

  // Session Refresh
  refreshSession: () =>
    request<{ token: string; csrfToken: string }>('/auth/refresh', {
      method: 'POST',
    }),

  // Logout
  logout: () =>
    request<{ success: boolean }>('/auth/logout', { method: 'POST' }),
  logoutAll: () =>
    request<{ success: boolean }>('/auth/logout-all', { method: 'POST' }),

  // Me
  getCurrentUser: () =>
    request<{
      managerId: string;
      username: string;
      managerName: string;
      isAdmin: boolean;
      isTelegramLinked: boolean;
      telegramUserId: number;
      csrfToken: string;
    }>('/auth/me'),

  // Account Linking
  linkTelegram: (initData: string) =>
    request<{ success: boolean; message: string }>('/auth/link-telegram', {
      method: 'POST',
      body: JSON.stringify({ initData }),
    }),

  // Set Credentials
  setCredentials: (username: string, password: string) =>
    request<{ success: boolean; message: string }>('/auth/set-credentials', {
      method: 'POST',
      body: JSON.stringify({ username, password }),
    }),

  // Change Password
  changePassword: (
    oldPassword: string,
    newPassword: string,
    confirmPassword: string,
  ) =>
    request<{ success: boolean; message: string }>('/auth/change-password', {
      method: 'POST',
      body: JSON.stringify({ oldPassword, newPassword, confirmPassword }),
    }),

  // Dashboard
  getDashboard: () => request<any>('/dashboard'),

  // League
  getLeague: () => request<any>('/league'),
  createLeague: (name: string, mode: 'GIGANTRY' | 'SOLO') =>
    request<{ success: boolean; leagueId: string; invitationCode: string }>(
      '/league/create',
      {
        method: 'POST',
        body: JSON.stringify({ name, mode }),
      },
    ),
  joinLeague: (code: string) =>
    request<{ success: boolean; leagueId: string }>('/league/join', {
      method: 'POST',
      body: JSON.stringify({ code }),
    }),
  deleteSoloLeague: (leagueId: string) =>
    request<{ success: boolean; message: string }>('/league/delete-solo', {
      method: 'POST',
      body: JSON.stringify({ leagueId }),
    }),
  executeRound: (leagueId: string) =>
    request<any>('/league/execute-round', {
      method: 'POST',
      body: JSON.stringify({ leagueId }),
    }),

  // Squad
  getSquad: () => request<any>('/squad'),

  // Transfers
  getListings: (position?: string, maxPrice?: number, page?: number) => {
    const params = new URLSearchParams();
    if (position && position !== 'ALL') params.append('position', position);
    if (maxPrice) params.append('maxPrice', String(maxPrice));
    if (page) params.append('page', String(page));
    return request<any>(`/transfers/listings?${params.toString()}`);
  },
  createListing: (leaguePlayerId: string, askingPriceEur: number) =>
    request<any>('/transfers/create', {
      method: 'POST',
      body: JSON.stringify({ leaguePlayerId, askingPriceEur }),
    }),
  buyListing: (listingId: string, buyerClubId: string) =>
    request<any>('/transfers/buy', {
      method: 'POST',
      body: JSON.stringify({ listingId, buyerClubId }),
    }),

  // Legends
  getLegends: () => request<{ legends: any[] }>('/legends'),

  // Finances
  getPackages: () => request<{ packages: any[] }>('/finances/packages'),
  requestPackage: (leagueId: string, leagueClubId: string, packageId: string) =>
    request<any>('/finances/request-package', {
      method: 'POST',
      body: JSON.stringify({ leagueId, leagueClubId, packageId }),
    }),

  // Admin
  getPendingOrders: () => request<{ orders: any[] }>('/admin/orders'),
  approveOrder: (requestId: string) =>
    request<any>('/admin/approve-order', {
      method: 'POST',
      body: JSON.stringify({ requestId }),
    }),
  rejectOrder: (requestId: string) =>
    request<any>('/admin/reject-order', {
      method: 'POST',
      body: JSON.stringify({ requestId }),
    }),
};
