// Сервис логирования

export class LoggerService {
  // === ОСНОВНЫЕ СОБЫТИЯ ===
  static logActiveMusic(artist: string, title: string, fullId: string): void {
    console.log('[INFO] Active music detected:', `${artist} - ${title} (${fullId})`);
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

  // === ДЕТАЛЬНОЕ ЛОГГИРОВАНИЕ ===
  static logAudioValidation(audioStatus: any, isValid: boolean): void {
    console.log('[DEBUG] Audio validation:', {
      isValid,
      hasId: !!audioStatus?.id,
      hasOwnerId: !!audioStatus?.owner_id,
      hasArtist: !!audioStatus?.artist,
      hasTitle: !!audioStatus?.title,
      audioData: audioStatus
    });
  }

  static logDatabaseResult(operation: string, result: any): void {
    console.log('[DEBUG] Database result:', {
      operation,
      hasRows: !!result.rows,
      rowCount: result.rows?.length || 0,
      firstRow: result.rows?.[0] || null
    });
  }

  static logSessionCheck(fullId: string, hasActiveSession: boolean): void {
    console.log('[DEBUG] Session check:', { fullId, hasActiveSession });
  }

  static logErrorDetails(error: any, context: string): void {
    console.error(`[ERROR] ${context}:`, {
      errorType: error?.constructor?.name,
      errorMessage: error?.message,
      errorStack: error?.stack?.split('\n').slice(0, 3),
      fullError: LoggerService.formatError(error)
    });
  }

  static logPerformance(startTime: number, operation: string): void {
    const duration = Date.now() - startTime;
    console.log(`[PERF] ${operation} completed in ${duration}ms`);
  }

  private static formatError(error: any): string {
    if (error instanceof Error) return error.message;
    if (typeof error === 'object') return JSON.stringify(error, null, 2);
    return String(error);
  }
} 