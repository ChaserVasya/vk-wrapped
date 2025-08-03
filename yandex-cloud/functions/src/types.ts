// Строго типизированные интерфейсы для автоматической валидации

export interface VKStatus {
  status_audio?: AudioStatus;
}

export interface AudioStatus {
  id: number;
  owner_id: number;
  artist: string;
  title: string;
}

export interface TrackSession {
  full_id: string;
  first_observed: Date;
  last_seen: Date;
}

export interface CompletedSession {
  full_id: string;
  first_observed: Date;
  last_seen: Date;
}

// Простые валидаторы для runtime проверки
export class DataValidator {
  static validateAudioStatus(data: unknown): data is AudioStatus {
    if (!data || typeof data !== 'object') return false;

    const audioStatus = data as Record<string, unknown>;

    return (
      typeof audioStatus.id === 'number' &&
      typeof audioStatus.owner_id === 'number' &&
      typeof audioStatus.artist === 'string' &&
      typeof audioStatus.title === 'string' &&
      audioStatus.artist.trim() !== '' &&
      audioStatus.title.trim() !== ''
    );
  }

  static validateTrackSession(data: unknown): data is TrackSession {
    if (!data || typeof data !== 'object') return false;

    const session = data as Record<string, unknown>;

    return (
      typeof session.full_id === 'string' &&
      session.full_id.trim() !== '' &&
      session.first_observed instanceof Date &&
      !isNaN(session.first_observed.getTime()) &&
      session.last_seen instanceof Date &&
      !isNaN(session.last_seen.getTime())
    );
  }
} 