import { DatabaseService } from './services/database';
import { LoggerService } from './services/logger';
import { StatusProcessorService } from './services/status-processor';
import { ValidatorService } from './services/validator';
import { VKApiService } from './services/vk-api';
import { createFullId, getCurrentTimestamp } from './utils';

// Универсальный handler для timer и HTTP триггеров
export async function handler(event: any, context: any): Promise<any> {
  const startTime = Date.now();

  try {
    LoggerService.logPollingStart();

    // Создаем сервисы внутри функции для возможности мокирования в тестах
    const vkApiService = new VKApiService();
    const dbService = new DatabaseService();
    const statusProcessor = new StatusProcessorService(dbService);

    // Получаем статус из VK API
    const status = await vkApiService.getStatus();

    // Обрабатываем статус
    await statusProcessor.processStatus(status);

    LoggerService.logPollingComplete();

    // Создаем ответ
    const response = createSuccessResponse(status);

    LoggerService.logPerformance(startTime, 'Total handler execution');

    return response;

  } catch (error) {
    LoggerService.logErrorDetails(error, 'Main Handler');
    LoggerService.logPollingError(error);
    return createErrorResponse(error);
  }
}

// Создание успешного ответа
function createSuccessResponse(status: any): any {
  const hasValidMusic = !!(status.status_audio && ValidatorService.isValidAudioStatus(status.status_audio));

  const timestamp = getCurrentTimestamp();

  const response = {
    statusCode: 200,
    body: JSON.stringify({
      success: true,
      timestamp: timestamp,
      hasActiveMusic: hasValidMusic,
      status: hasValidMusic ? {
        artist: status.status_audio!.artist,
        title: status.status_audio!.title,
        fullId: createFullId(status.status_audio!.owner_id, status.status_audio!.id)
      } : null
    })
  };

  return response;
}

// Создание ответа с ошибкой
function createErrorResponse(error: any): any {
  const timestamp = getCurrentTimestamp();

  const response = {
    statusCode: 500,
    body: JSON.stringify({
      success: false,
      error: error instanceof Error ? error.message : 'Unknown error',
      timestamp: timestamp
    })
  };

  return response;
} 