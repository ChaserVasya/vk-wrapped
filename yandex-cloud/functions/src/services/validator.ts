// Сервис валидации данных

export class ValidatorService {
  // Валидация статуса аудио
  static isValidAudioStatus(status: any): boolean {
    return status && 
           typeof status === 'object' &&
           typeof status.id === 'number' &&
           typeof status.owner_id === 'number' &&
           typeof status.artist === 'string' &&
           typeof status.title === 'string' &&
           status.artist.trim() !== '' &&
           status.title.trim() !== '';
  }
} 