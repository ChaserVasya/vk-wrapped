import { DataValidator, VKStatus } from '../types';
import { DatabaseService } from './database';
import { LoggerService } from './logger';

export class StatusProcessorService {
  constructor(private dbService: DatabaseService) { }

  // Обработка статуса
  async processStatus(status: VKStatus): Promise<void> {

    // Логируем валидацию аудио статуса
    const hasAudioStatus = !!status.status_audio;
    const isValidAudio = hasAudioStatus && DataValidator.validateAudioStatus(status.status_audio);

    LoggerService.logAudioValidation(status.status_audio, isValidAudio);

    if (hasAudioStatus && isValidAudio && status.status_audio) {
      await this.handleActiveMusic(status.status_audio);
    } else {
      const reason = !hasAudioStatus ? 'status_audio is null/undefined' : 'status_audio is invalid';
      await this.handleNoActiveMusic(reason);
    }


  }

  private async handleActiveMusic(audioStatus: { id: number; owner_id: number; artist: string; title: string }): Promise<void> {
    const fullId = `${audioStatus.owner_id}_${audioStatus.id}`;

    LoggerService.logActiveMusic(audioStatus);

    // Проверяем есть ли активная сессия для этого трека
    const activeSession = await this.dbService.getActiveSession(fullId);
    LoggerService.logSessionCheck(fullId, !!activeSession);

    // Проверяем валидность активной сессии
    const isValidSession = activeSession && DataValidator.validateTrackSession(activeSession);

    if (isValidSession) {
      // Если есть валидная активная сессия - обновляем её (продолжение прослушивания)
      await this.dbService.updateActiveSession(fullId);
      LoggerService.logSessionUpdated(fullId);
    } else {
      // Если нет активной сессии или она невалидна - создаем новую (новое прослушивание)
      // Проверяем есть ли другие активные сессии (смена трека)
      const allActiveSessions = await this.dbService.getAllCurrentSessions();

      if (allActiveSessions.length > 0) {
        // Есть другие активные сессии - завершаем их (смена трека)
        await this.dbService.finishAllActiveSessions();
      }

      // Создаем новую сессию для текущего трека
      await this.dbService.createActiveSession(fullId);
      LoggerService.logSessionCreated(fullId);
    }
  }

  private async handleNoActiveMusic(reason: string): Promise<void> {
    LoggerService.logNoActiveMusic(reason);

    // Завершаем все активные сессии при отсутствии музыки
    await this.dbService.finishAllActiveSessions();
    LoggerService.logAllSessionsFinished();
  }
} 