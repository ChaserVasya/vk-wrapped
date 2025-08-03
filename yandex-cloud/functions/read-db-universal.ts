import * as dotenv from 'dotenv';
import { TokenAuthService } from 'ydb-sdk';
import { DatabaseService } from './src/services/database';

// Загружаем переменные окружения
dotenv.config();

/**
 * Валидирует YDB токен
 * @param token - токен для проверки
 * @returns true если токен валиден, false если нет
 */
function validateYdbToken(token: string | undefined): boolean {
    if (!token) {
        console.error(`
❌ Error: YDB_TOKEN is required for local environment
💡 Run: yc iam create-token
    `);
        return false;
    }

    if (!token.startsWith('t1.')) {
        console.error(`
❌ Error: Invalid token format. Token should start with "t1."
💡 Run: yc iam create-token
    `);
        return false;
    }

    if (token.length < 100) {
        console.error(`
❌ Error: Token seems too short. It might be expired or invalid.
💡 Run: yc iam create-token
    `);
        return false;
    }

    return true;
}

async function main() {
    console.log('🔍 Starting universal database reader...');

    // Проверяем переменные окружения
    console.log(`
📊 Environment check:
  Endpoint: ${process.env.YDB_ENDPOINT}
  Database: ${process.env.YDB_DATABASE_PATH}
  Token: ${process.env.YDB_TOKEN ? '✅ Found' : '❌ Not found'}
  `);

    // Валидируем токен
    if (!validateYdbToken(process.env.YDB_TOKEN)) {
        return;
    }

    console.log('🔐 Token validation passed');

    try {
        // Создаем authService для локальной среды
        const authService = new TokenAuthService(process.env.YDB_TOKEN!);

        // Создаем DatabaseService с инжектированным authService
        const databaseService = new DatabaseService(authService);

        console.log('⏳ Waiting for driver to be ready...');
        const timeout = 10000;
        if (!(await (databaseService as any).driver.ready(timeout))) {
            throw new Error(`Driver has not become ready in ${timeout}ms!`);
        }
        console.log('✅ Driver is ready');

        // Читаем активные сессии
        console.log('📊 Reading current sessions...');
        const currentSessions = await databaseService.getAllCurrentSessions(50);
        console.log(`✅ Found ${currentSessions.length} current sessions`);

        // Читаем завершенные сессии
        console.log('📊 Reading completed sessions...');
        const completedSessions = await databaseService.getCompletedSessions(50);
        console.log(`✅ Found ${completedSessions.length} completed sessions`);

        // Выводим результаты
        console.log(`
📋 Current Sessions:`);
        if (currentSessions.length === 0) {
            console.log('  No active sessions found');
        } else {
            currentSessions.forEach((session, index) => {
                const firstObserved = session.first_observed;
                const lastSeen = session.last_seen;
                const duration = Math.round((lastSeen.getTime() - firstObserved.getTime()) / 60000);

                console.log(`
  ${index + 1}. ${session.full_id}
     Started: ${firstObserved.toLocaleString()}
     Last seen: ${lastSeen.toLocaleString()}
     Duration: ${duration} minutes
        `);
            });
        }

        console.log(`
📋 Completed Sessions:`);
        if (completedSessions.length === 0) {
            console.log('  No completed sessions found');
        } else {
            completedSessions.forEach((session, index) => {
                const firstObserved = session.first_observed;
                const lastSeen = session.last_seen;
                const duration = Math.round((lastSeen.getTime() - firstObserved.getTime()) / 60000);

                console.log(`
  ${index + 1}. ${session.full_id}
     Started: ${firstObserved.toLocaleString()}
     Ended: ${lastSeen.toLocaleString()}
     Duration: ${duration} minutes
        `);
            });
        }

        console.log('✅ Database reading completed successfully');

        // Закрываем соединение
        await databaseService.close();

    } catch (error) {
        console.error('❌ Error reading database:', error);
        process.exit(1);
    }
}

main().catch(console.error); 