// Сервис логирования

export class LoggerService {
  static logActiveMusic(artist: string, title: string, fullId: string): void {
    console.log('[INFO] Active music:', `${artist} - ${title} (${fullId})`);
  }

  static logSessionSaved(): void {
    console.log('[INFO] Session saved to database');
  }

  static logSessionCreated(fullId: string): void {
    console.log('[INFO] New session created for:', fullId);
  }

  static logSessionUpdated(fullId: string): void {
    console.log('[INFO] Session updated for:', fullId);
  }

  static logAllSessionsFinished(): void {
    console.log('[INFO] All active sessions finished');
  }

  static logSessionError(error: any): void {
    console.error('[ERROR] Error saving session:', LoggerService.formatError(error));
  }

  static logNoActiveMusic(reason: string): void {
    console.log('[INFO] No active music:', reason);
  }

  static logInvalidAudioStatus(status: any): void {
    console.warn('[WARN] Invalid audio status format:', JSON.stringify(status));
  }

  static logPollingStart(): void {
    console.log('[INFO] Starting VK status polling...');
  }

  static logPollingComplete(): void {
    console.log('[INFO] VK status polling completed');
  }

  static logPollingError(error: any): void {
    console.error('[ERROR] Error in VK status polling:', LoggerService.formatError(error));
  }

  private static formatError(error: any): string {
    if (error instanceof Error) return error.message;
    if (typeof error === 'object') return JSON.stringify(error, null, 2);
    return String(error);
  }
} 