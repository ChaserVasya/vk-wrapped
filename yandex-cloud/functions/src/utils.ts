// Утилиты для VK Wrapped

export function getCurrentTimestamp(): string {
  return new Date().toISOString();
}

// Формирует id который является аргументом для audio.getById
export function createFullId(ownerId: number, trackId: number): string {
  return `${ownerId}_${trackId}`;
}

export function createSession(fullId: string): { full_id: string; start: Date; end: Date } {
  const now = new Date();
  return {
    full_id: fullId,
    start: now,              // start = Date объект
    end: now                 // end = Date объект
  };
} 