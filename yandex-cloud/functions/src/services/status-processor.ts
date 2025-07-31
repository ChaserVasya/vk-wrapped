import { VKStatus } from '../types';
import { DatabaseService } from './database';
import { ValidatorService } from './validator';
import { LoggerService } from './logger';
import { createFullId, createSession } from '../utils';

export class StatusProcessorService {
  constructor(private dbService: DatabaseService) {}

  // Обработка статуса
  async processStatus(status: VKStatus): Promise<void> {
    if (status.status_audio && ValidatorService.isValidAudioStatus(status.status_audio)) {
      await this.handleActiveMusic(status.status_audio);
    } else {
      this.handleNoActiveMusic(status.status_audio);
    }
  }

  private async handleActiveMusic(audioStatus: any): Promise<void> {
    const { id, owner_id, artist, title } = audioStatus;
    const fullId = createFullId(owner_id, id);
    
    LoggerService.logActiveMusic(artist, title, fullId);
    
    try {
      const session = createSession(fullId);
      await this.dbService.saveListeningSession(session);
      LoggerService.logSessionSaved();
    } catch (error) {
      LoggerService.logSessionError(error);
    }
  }

  private handleNoActiveMusic(statusAudio: any): void {
    if (!statusAudio) {
      LoggerService.logNoActiveMusic('status_audio is null/undefined');
    } else if (!ValidatorService.isValidAudioStatus(statusAudio)) {
      LoggerService.logInvalidAudioStatus(statusAudio);
    } else {
      LoggerService.logNoActiveMusic('unknown reason');
    }
  }
} 