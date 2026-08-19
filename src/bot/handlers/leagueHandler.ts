import {
  buildSoloLeagueDeleteConfirmation1Message,
  buildSoloLeagueDeleteConfirmation2Message,
  buildSoloLeagueDeleteBlockedMessage,
  buildSoloLeagueDeleteSuccessMessage,
  formatDailyRoundLimitMessage,
} from '../messages/templates.js';
import {
  buildSoloLeagueDeleteStep1Keyboard,
  buildSoloLeagueDeleteStep2Keyboard,
} from '../keyboards/menus.js';

export function handleSoloLeagueDeleteStep1(
  leagueId: string,
  leagueName: string,
  humanCount: number,
) {
  if (humanCount > 1) {
    return {
      text: buildSoloLeagueDeleteBlockedMessage(),
      keyboard: [
        [{ text: '⬅️ Orqaga', callback_data: `league_menu:${leagueId}` }],
      ],
    };
  }

  const text = buildSoloLeagueDeleteConfirmation1Message(leagueName);
  const keyboard = buildSoloLeagueDeleteStep1Keyboard(leagueId);
  return { text, keyboard };
}

export function handleSoloLeagueDeleteStep2(
  leagueId: string,
  leagueName: string,
  clubName: string,
) {
  const text = buildSoloLeagueDeleteConfirmation2Message(leagueName, clubName);
  const keyboard = buildSoloLeagueDeleteStep2Keyboard(leagueId);
  return { text, keyboard };
}

export function handleSoloLeagueDeleteSuccess(leagueName: string) {
  const text = buildSoloLeagueDeleteSuccessMessage(leagueName);
  const keyboard = [[{ text: '🏠 Bosh menyu', callback_data: 'main_menu' }]];
  return { text, keyboard };
}

export function handleDailyRoundLimitReached(nextAvailableTimeStr?: string) {
  const text = formatDailyRoundLimitMessage(nextAvailableTimeStr);
  return { text };
}
