import { AuthFactory } from './services/auth-factory';
import { DatabaseService } from './services/database';
import { LoggerService } from './services/logger';
import { TrackSession } from './types';

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

// Конвертирует TrackSession в camelCase формат для Flutter
function convertToCamelCase(session: TrackSession): Record<string, unknown> {
    return {
        fullId: session.full_id,
        firstObserved: session.first_observed.getTime() / 1000, // конвертируем в секунды
        lastSeen: session.last_seen.getTime() / 1000, // конвертируем в секунды
    };
}

export async function handler(): Promise<SuccessResponse | ErrorResponse> {
    LoggerService.logPollingStart();

    try {
        // Используем фабрику для создания правильного authService
        const authService = AuthFactory.createAuthService();
        const databaseService = new DatabaseService(authService);

        const timeout = 10000;
        if (!(await databaseService['driver'].ready(timeout))) {
            throw new Error(`Driver has not become ready in ${timeout}ms!`);
        }

        // Читаем завершенные сессии
        const completedSessions = await databaseService.getCompletedSessions(50);

        // Конвертируем в camelCase
        const convertedSessions = completedSessions.map(convertToCamelCase);

        // Закрываем соединение
        await databaseService.close();

        LoggerService.logPollingComplete();
        return createSuccessResponse(convertedSessions);
    } catch (error) {
        LoggerService.logErrorDetails(error, 'Read Handler');
        return createErrorResponse(error);
    }
}

function createSuccessResponse(data: Record<string, unknown>[]): SuccessResponse {
    return {
        statusCode: 200,
        headers: {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
        },
        body: JSON.stringify(data)
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