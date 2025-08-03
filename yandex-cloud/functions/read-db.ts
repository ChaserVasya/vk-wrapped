import * as dotenv from 'dotenv';
import { TokenAuthService } from 'ydb-sdk';
import { DatabaseService } from './src/services/database';
import { TrackSession } from './src/types';

// Загружаем переменные окружения из файла .local.env
dotenv.config({ path: '.local.env' });

interface DatabaseResponse {
    currentSessions: TrackSession[];
    completedSessions: TrackSession[];
}

/**
 * Валидирует YDB токен
 * @param token - токен для проверки
 * @returns true если токен валиден, false если нет
 */
function validateYdbToken(token: string | undefined): boolean {
    if (!token) {
        return false;
    }

    if (!token.startsWith('t1.')) {
        return false;
    }

    if (token.length < 100) {
        return false;
    }

    return true;
}

async function getDatabaseData(): Promise<DatabaseResponse> {
    // Проверяем переменные окружения
    if (!validateYdbToken(process.env.YDB_TOKEN)) {
        const error = new Error('Invalid or missing YDB_TOKEN');
        (error as any).statusCode = 401;
        throw error;
    }

    try {
        // Создаем authService для локальной среды
        const authService = new TokenAuthService(process.env.YDB_TOKEN!);

        // Создаем DatabaseService с инжектированным authService
        const databaseService = new DatabaseService(authService);

        const timeout = 10000;
        if (!(await (databaseService as any).driver.ready(timeout))) {
            const error = new Error(`Driver has not become ready in ${timeout}ms!`);
            (error as any).statusCode = 500;
            throw error;
        }

        // Читаем активные сессии
        const currentSessions = await databaseService.getAllCurrentSessions(50);

        // Читаем завершенные сессии
        const completedSessions = await databaseService.getCompletedSessions(50);

        // Закрываем соединение
        await databaseService.close();

        return {
            currentSessions: currentSessions,
            completedSessions: completedSessions
        };

    } catch (error) {
        const errorMessage = error instanceof Error ? error.message : String(error);
        const statusCode = (error as any).statusCode || 500;

        const httpError = new Error(errorMessage);
        (httpError as any).statusCode = statusCode;
        throw httpError;
    }
}

async function main() {
    try {
        const data = await getDatabaseData();
        // Выводим JSON в stdout
        console.log(JSON.stringify(data, null, 2));
    } catch (error) {
        const statusCode = (error as any).statusCode || 500;
        const errorMessage = error instanceof Error ? error.message : String(error);

        console.error(JSON.stringify({
            error: errorMessage,
            statusCode: statusCode
        }, null, 2));

        process.exit(1);
    }
}

// Экспортируем функцию для использования в других модулях
export { getDatabaseData };

main().catch((error) => {
    const statusCode = (error as any).statusCode || 500;
    const errorMessage = error instanceof Error ? error.message : String(error);

    console.error(JSON.stringify({
        error: errorMessage,
        statusCode: statusCode
    }, null, 2));
    process.exit(1);
}); 