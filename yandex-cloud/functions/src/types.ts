// Общие типы для VK Wrapped

export interface ListeningSession {
  full_id: string;         // "owner_id_track_id"
  start: Date;             // время начала сессии (уникальный ключ)
  end: Date;               // время окончания сессии
}

export interface VKStatus {
  status_audio?: {
    id: number;
    owner_id: number;
    artist: string;
    title: string;
  };
} 