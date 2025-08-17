// Сервис логирования

// Многострочные сообщения должны быть разделены
// символом \r(carriage return), но не \n(line feed).При использовании 
// последнего каждая строка отправляется отдельным сообщением и 
// отображается в журнале отдельно.

export class LoggerService {
  static debug(message: string, data?: unknown): void {
    if (!LoggerService.shouldLog('DEBUG')) return;
    const suffix = data !== undefined ? `: ${LoggerService.formatData(data)}` : '';
    console.log(`[DEBUG] ${message}${suffix}`);
  }

  static info(message: string, data?: unknown): void {
    if (!LoggerService.shouldLog('INFO')) return;
    const suffix = data !== undefined ? `: ${LoggerService.formatData(data)}` : '';
    console.log(`[INFO] ${message}${suffix}`);
  }

  static error(message: string, error?: unknown): void {
    if (!LoggerService.shouldLog('ERROR')) return;
    const suffix = error !== undefined ? `: ${LoggerService.formatError(error)}` : '';
    console.error(`[ERROR] ${message}${suffix}`);
  }
  static logActiveMusic(audioStatus: { artist: string; title: string; owner_id: number; id: number }): void {
    const fullId = `${audioStatus.owner_id}_${audioStatus.id}`;
    LoggerService.info(`Active music detected: ${audioStatus.artist} - ${audioStatus.title} (${fullId})`);
  }

  static logSessionCreated(fullId: string): void {
    LoggerService.info(`New session created for: ${fullId}`);
  }

  static logSessionUpdated(fullId: string): void {
    LoggerService.info(`Session updated for: ${fullId}`);
  }

  static logAllSessionsFinished(): void {
    LoggerService.info(`All active sessions finished`);
  }

  static logNoActiveMusic(reason: string): void {
    LoggerService.info(`No active music: ${reason}`);
  }

  static logSessionError(error: unknown, context: string = 'session'): void {
    LoggerService.error(`Session error in ${context}`, error);
  }

  static logInvalidAudioStatus(status: unknown): void {
    const statusString = JSON.stringify(status, null, 2).replace(/\n/g, '\r');
    LoggerService.info(`Invalid audio status received: ${statusString}`);
  }

  static logPollingError(error: unknown): void {
    LoggerService.error(`Polling error`, error);
  }

  static logAudioValidation(audioStatus: unknown, isValid: boolean): void {
    const hasId = audioStatus && typeof audioStatus === 'object' && 'id' in audioStatus;
    const hasOwnerId = audioStatus && typeof audioStatus === 'object' && 'owner_id' in audioStatus;
    const hasArtist = audioStatus && typeof audioStatus === 'object' && 'artist' in audioStatus;
    const hasTitle = audioStatus && typeof audioStatus === 'object' && 'title' in audioStatus;

    LoggerService.debug(`Audio validation: isValid=${isValid}, hasId=${String(hasId)}, hasOwnerId=${String(hasOwnerId)}, hasArtist=${String(hasArtist)}, hasTitle=${String(hasTitle)}`);
  }

  static logDatabaseResult(operation: string, result: unknown): void {
    const resultString = JSON.stringify(result, null, 2).replace(/\n/g, '\r');
    LoggerService.debug(`Database ${operation} result: ${resultString}`);
  }

  static logSessionCheck(fullId: string, hasActiveSession: boolean): void {
    LoggerService.debug(`Session check: fullId=${fullId}, hasActiveSession=${hasActiveSession}`);
  }

  static logErrorDetails(error: unknown, context: string): void {
    const errorType = error && typeof error === 'object' && 'constructor' in error && error.constructor?.name ? error.constructor.name : 'Unknown';
    console.error(`[ERROR] ${context}: errorType=${errorType}, errorMessage=${error instanceof Error ? error.message : 'Unknown'}, fullError=${LoggerService.formatError(error)}`);
  }

  private static formatError(error: unknown): string {
    if (error instanceof Error) return error.message;
    if (typeof error === 'object') return JSON.stringify(error, null, 2).replace(/\n/g, '\r');
    return String(error);
  }

  private static shouldLog(level: 'DEBUG' | 'INFO' | 'ERROR'): boolean {
    const threshold = LoggerService.levelToNumber((process.env.LOG_LEVEL || 'INFO').toUpperCase());
    const severity = LoggerService.levelToNumber(level);
    return severity >= threshold;
  }

  private static levelToNumber(level: string): number {
    switch (level) {
      case 'DEBUG':
        return 10;
      case 'INFO':
        return 20;
      case 'ERROR':
        return 30;
      default:
        return 20; // INFO by default
    }
  }

  private static formatData(data: unknown): string {
    if (data instanceof Error) return data.message;
    if (typeof data === 'object') return JSON.stringify(data, null, 2).replace(/\n/g, '\r');
    return String(data);
  }
} 