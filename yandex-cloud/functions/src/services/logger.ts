// Сервис логирования

export class LoggerService {
  static logActiveMusic(artist: string, title: string, fullId: string): void {
    console.log(`🎵 Active music: ${artist} - ${title} (${fullId})`);
  }

  static logSessionSaved(): void {
    console.log('✅ Session saved to database');
  }

  static logSessionError(error: any): void {
    console.error('❌ Error saving session:', error);
  }

  static logNoActiveMusic(reason: string): void {
    console.log(`⏳ No active music (${reason})`);
  }

  static logInvalidAudioStatus(status: any): void {
    console.log('⚠️ Invalid audio status format:', JSON.stringify(status));
  }

  static logPollingStart(): void {
    console.log('🔄 Starting VK status polling...');
  }

  static logPollingComplete(): void {
    console.log('✅ VK status polling completed');
  }

  static logPollingError(error: any): void {
    console.error('❌ Error in VK status polling:', error);
  }
} 