// Сервис логирования

// Многострочные сообщения должны быть разделены
// символом \r(carriage return), но не \n(line feed).При использовании 
// последнего каждая строка отправляется отдельным сообщением и 
// отображается в журнале отдельно.

export class LoggerService {
  static logActiveMusic(audioStatus: { artist: string; title: string; owner_id: number; id: number }): void {
    const fullId = `${audioStatus.owner_id}_${audioStatus.id}`;
    console.log(`[INFO] Active music detected: ${audioStatus.artist} - ${audioStatus.title} (${fullId})`);
  }

  static logSessionCreated(fullId: string): void {
    console.log(`[INFO] New session created for: ${fullId}`);
  }

  static logSessionUpdated(fullId: string): void {
    console.log(`[INFO] Session updated for: ${fullId}`);
  }

  static logAllSessionsFinished(): void {
    console.log(`[INFO] All active sessions finished`);
  }

  static logNoActiveMusic(reason: string): void {
    console.log(`[INFO] No active music: ${reason}`);
  }

  static logSessionError(error: unknown, context: string = 'session'): void {
    console.log(`[ERROR] Session error in ${context}: ${error}`);
  }

  static logInvalidAudioStatus(status: unknown): void {
    const statusString = JSON.stringify(status, null, 2).replace(/\n/g, '\r');
    console.log(`[INFO] Invalid audio status received: ${statusString}`);
  }

  static logPollingError(error: unknown): void {
    console.log(`[ERROR] Polling error: ${error}`);
  }

  static logAudioValidation(audioStatus: unknown, isValid: boolean): void {
    const hasId = audioStatus && typeof audioStatus === 'object' && 'id' in audioStatus;
    const hasOwnerId = audioStatus && typeof audioStatus === 'object' && 'owner_id' in audioStatus;
    const hasArtist = audioStatus && typeof audioStatus === 'object' && 'artist' in audioStatus;
    const hasTitle = audioStatus && typeof audioStatus === 'object' && 'title' in audioStatus;

    console.log(`[DEBUG] Audio validation: isValid=${isValid}, hasId=${hasId}, hasOwnerId=${hasOwnerId}, hasArtist=${hasArtist}, hasTitle=${hasTitle}`);
  }

  static logDatabaseResult(operation: string, result: unknown): void {
    const resultString = JSON.stringify(result, null, 2).replace(/\n/g, '\r');
    console.log(`[DEBUG] Database ${operation} result: ${resultString}`);
  }

  static logSessionCheck(fullId: string, hasActiveSession: boolean): void {
    console.log(`[DEBUG] Session check: fullId=${fullId}, hasActiveSession=${hasActiveSession}`);
  }

  static logErrorDetails(error: unknown, context: string): void {
    console.error(`[ERROR] ${context}: errorType=${error?.constructor?.name}, errorMessage=${error instanceof Error ? error.message : 'Unknown'}, fullError=${LoggerService.formatError(error)}`);
  }

  private static formatError(error: unknown): string {
    if (error instanceof Error) return error.message;
    if (typeof error === 'object') return JSON.stringify(error, null, 2).replace(/\n/g, '\r');
    return String(error);
  }
} 