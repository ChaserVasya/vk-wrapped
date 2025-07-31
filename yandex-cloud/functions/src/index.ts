import axios from 'axios';
import { DatabaseService } from './services/database';
import { VKStatus } from './types';
import { CONFIG } from './config';
import { getCurrentTimestamp, createFullId, createSession } from './utils';

// Инициализация сервиса базы данных
const dbService = new DatabaseService();

// Получение статуса VK
async function getVKStatus(): Promise<VKStatus> {
  try {
    const response = await axios.get('https://api.vk.com/method/users.get', {
      params: {
        user_ids: CONFIG.USER_ID,
        fields: CONFIG.VK_API_FIELDS,
        access_token: CONFIG.SERVICE_TOKEN,
        v: CONFIG.VK_API_VERSION
      },
      headers: {
        'User-Agent': CONFIG.USER_AGENT
      }
    });

    return response.data.response[0];
  } catch (error) {
    console.error('Error getting VK status:', error);
    throw error;
  }
}

// Валидация статуса аудио
function isValidAudioStatus(status: any): boolean {
  return status && 
         typeof status === 'object' &&
         typeof status.id === 'number' &&
         typeof status.owner_id === 'number' &&
         typeof status.artist === 'string' &&
         typeof status.title === 'string' &&
         status.artist.trim() !== '' &&
         status.title.trim() !== '';
}

// Обработка статуса
async function processStatus(status: VKStatus): Promise<void> {
  // Проверяем все возможные случаи
  if (status.status_audio && isValidAudioStatus(status.status_audio)) {
    const { id, owner_id, artist, title } = status.status_audio;
    const fullId = createFullId(owner_id, id);
    
    console.log(`🎵 Active music: ${artist} - ${title} (${fullId})`);
    
    // Сохранение сессии в базу данных
    try {
      const session = createSession(fullId);
      await dbService.saveListeningSession(session);
      console.log('✅ Session saved to database');
      
    } catch (error) {
      console.error('❌ Error saving session:', error);
    }
    
  } else {
    // Обрабатываем все случаи отсутствия музыки
    if (!status.status_audio) {
      console.log('⏳ No active music (status_audio is null/undefined)');
    } else if (!isValidAudioStatus(status.status_audio)) {
      console.log('⚠️ Invalid audio status format:', JSON.stringify(status.status_audio));
    } else {
      console.log('⏳ No active music');
    }
  }
}

// Универсальный handler для timer и HTTP триггеров
export async function handler(event: any, context: any): Promise<any> {
  try {
    console.log('🔄 Starting VK status polling...');
    
    const status = await getVKStatus();
    await processStatus(status);
    
    console.log('✅ VK status polling completed');
    
    // Проверяем валидность для ответа
    const hasValidMusic = status.status_audio && isValidAudioStatus(status.status_audio);
    
    return {
      statusCode: 200,
      body: JSON.stringify({
        success: true,
        timestamp: getCurrentTimestamp(),
        hasActiveMusic: hasValidMusic,
        status: hasValidMusic ? {
          artist: status.status_audio!.artist,
          title: status.status_audio!.title,
          fullId: createFullId(status.status_audio!.owner_id, status.status_audio!.id)
        } : null
      })
    };
    
  } catch (error) {
    console.error('❌ Error in VK status polling:', error);
    
    return {
      statusCode: 500,
      body: JSON.stringify({
        success: false,
        error: error instanceof Error ? error.message : 'Unknown error',
        timestamp: getCurrentTimestamp()
      })
    };
  }
} 