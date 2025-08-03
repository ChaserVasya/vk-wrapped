import { DatabaseService } from './services/database';
import { LoggerService } from './services/logger';
import { StatusProcessorService } from './services/status-processor';
import { VKApiService } from './services/vk-api';

interface SuccessResponse {
  statusCode: number;
  headers: Record<string, string>;
  body: string;
}

interface ErrorResponse {
  statusCode: number;
  headers: Record<string, string>;
  body: string;
}

export async function handler(): Promise<SuccessResponse | ErrorResponse> {
  LoggerService.logPollingStart();

  try {
    const databaseService = new DatabaseService();
    const vkApiService = new VKApiService();
    const statusProcessor = new StatusProcessorService(databaseService);

    const status = await vkApiService.getStatus();
    await statusProcessor.processStatus(status);

    LoggerService.logPollingComplete();
    return createSuccessResponse({ status: 'success' });
  } catch (error) {
    LoggerService.logErrorDetails(error, 'Main Handler');
    return createErrorResponse(error);
  }
}

function createSuccessResponse(status: { status: string }): SuccessResponse {
  return {
    statusCode: 200,
    headers: {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    },
    body: JSON.stringify(status)
  };
}

function createErrorResponse(error: unknown): ErrorResponse {
  const errorMessage = error instanceof Error ? error.message : String(error);

  return {
    statusCode: 500,
    headers: {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    },
    body: JSON.stringify({
      error: 'Internal Server Error',
      message: errorMessage
    })
  };
} 