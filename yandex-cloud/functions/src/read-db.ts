import { MetadataAuthService } from 'ydb-sdk';
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

interface DatabaseResponse {
    currentSessions: TrackSession[];
    completedSessions: TrackSession[];
}

export async function handler(): Promise<SuccessResponse | ErrorResponse> {
    LoggerService.logPollingStart();

    try {
        const authService = new MetadataAuthService();
        const databaseService = new DatabaseService(authService);

        const timeout = 10000;
        if (!(await databaseService['driver'].ready(timeout))) {
            throw new Error(`Driver has not become ready in ${timeout}ms!`);
        }

        // Читаем активные сессии
        const currentSessions = await databaseService.getAllCurrentSessions(50);

        // Читаем завершенные сессии
        const completedSessions = await databaseService.getCompletedSessions(50);

        // Закрываем соединение
        await databaseService.close();

        const response: DatabaseResponse = {
            currentSessions: currentSessions,
            completedSessions: completedSessions
        };

        LoggerService.logPollingComplete();
        return createSuccessResponse(response);
    } catch (error) {
        LoggerService.logErrorDetails(error, 'Read Handler');
        return createErrorResponse(error);
    }
}

function createSuccessResponse(data: DatabaseResponse): SuccessResponse {
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