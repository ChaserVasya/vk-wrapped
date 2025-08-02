import { VKStatus } from '../types';
import { DatabaseService } from './database';
import { ValidatorService } from './validator';
import { LoggerService } from './logger';
import { createFullId } from '../utils';

export class StatusProcessorService {
  constructor(private dbService: DatabaseService) {}

  // Обработка статуса
  async processStatus(status: VKStatus): Promise<void> {
    if (status.status_audio && ValidatorService.isValidAudioStatus(status.status_audio)) {
      await this.handleActiveMusic(status.status_audio);
    } else {
      await this.handleNoActiveMusic();
    }
  }

  private async handleActiveMusic(audioStatus: any): Promise<void> {
    const { id, owner_id, artist, title } = audioStatus;
    const fullId = createFullId(owner_id, id);
    
    LoggerService.logActiveMusic(artist, title, fullId);
    
    try {
      // Проверяем, есть ли уже активная сессия для этого трека
      const activeSession = await this.dbService.getActiveSession(fullId);
      
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
      LoggerService.logSessionError(error);
    }
  }

  private async handleNoActiveMusic(): Promise<void> {
    LoggerService.logNoActiveMusic('status_audio is null/undefined');
    
    try {
      // Завершаем все активные сессии при отсутствии музыки
      await this.dbService.finishAllActiveSessions();
      LoggerService.logAllSessionsFinished();
    } catch (error) {
      LoggerService.logSessionError(error);
    }
  }
} 