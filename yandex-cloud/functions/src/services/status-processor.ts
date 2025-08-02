import { VKStatus } from '../types';
import { createFullId } from '../utils';
import { DatabaseService } from './database';
import { LoggerService } from './logger';
import { ValidatorService } from './validator';

export class StatusProcessorService {
  constructor(private dbService: DatabaseService) { }

  // Обработка статуса
  async processStatus(status: VKStatus): Promise<void> {
    const startTime = Date.now();

    // Логируем валидацию аудио статуса
    const hasAudioStatus = !!status.status_audio;
    const isValidAudio = hasAudioStatus && ValidatorService.isValidAudioStatus(status.status_audio);

    LoggerService.logAudioValidation(status.status_audio, isValidAudio);

    if (hasAudioStatus && isValidAudio) {
      await this.handleActiveMusic(status.status_audio);
    } else {
      const reason = !hasAudioStatus ? 'status_audio is null/undefined' : 'status_audio is invalid';
      await this.handleNoActiveMusic(reason);
    }

    LoggerService.logPerformance(startTime, 'Status processing');
  }

  private async handleActiveMusic(audioStatus: any): Promise<void> {
    const { id, owner_id, artist, title } = audioStatus;

    const fullId = createFullId(owner_id, id);

    LoggerService.logActiveMusic(artist, title, fullId);

    try {
      // Проверяем, есть ли уже активная сессия для этого трека
      const activeSession = await this.dbService.getActiveSession(fullId);

      LoggerService.logSessionCheck(fullId, !!activeSession);

      if (activeSession) {
        // Обновляем время последнего обновления существующей сессии
        await this.dbService.updateActiveSession(fullId);
        LoggerService.logSessionUpdated(fullId);
      } else {
        // Создаем новую активную сессию
        await this.dbService.createActiveSession(fullId);
        LoggerService.logSessionCreated(fullId);
      }
    } catch (error) {
      LoggerService.logErrorDetails(error, 'Active Music Session Management');
      LoggerService.logSessionError(error);
    }
  }

  private async handleNoActiveMusic(reason: string): Promise<void> {
    LoggerService.logNoActiveMusic(reason);

    try {
      // Завершаем все активные сессии при отсутствии музыки
      await this.dbService.finishAllActiveSessions();
      LoggerService.logAllSessionsFinished();
    } catch (error) {
      LoggerService.logErrorDetails(error, 'No Active Music Session Management');
      LoggerService.logSessionError(error);
    }
  }
} 