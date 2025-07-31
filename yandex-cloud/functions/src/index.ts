import { VKApiService } from './services/vk-api';
import { DatabaseService } from './services/database';
import { StatusProcessorService } from './services/status-processor';
import { ValidatorService } from './services/validator';
import { LoggerService } from './services/logger';
import { getCurrentTimestamp, createFullId } from './utils';

// Универсальный handler для timer и HTTP триггеров
export async function handler(event: any, context: any): Promise<any> {
  try {
    LoggerService.logPollingStart();
    
    // Создаем сервисы внутри функции для возможности мокирования в тестах
    const vkApiService = new VKApiService();
    const dbService = new DatabaseService();
    const statusProcessor = new StatusProcessorService(dbService);
    
    const status = await vkApiService.getStatus();
    await statusProcessor.processStatus(status);
    
    LoggerService.logPollingComplete();
    
    return createSuccessResponse(status);
    
  } catch (error) {
    LoggerService.logPollingError(error);
    return createErrorResponse(error);
  }
}

// Создание успешного ответа
function createSuccessResponse(status: any): any {
  const hasValidMusic = !!(status.status_audio && ValidatorService.isValidAudioStatus(status.status_audio));
  
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
}

// Создание ответа с ошибкой
function createErrorResponse(error: any): any {
  return {
    statusCode: 500,
    body: JSON.stringify({
      success: false,
      error: error instanceof Error ? error.message : 'Unknown error',
      timestamp: getCurrentTimestamp()
    })
  };
} 