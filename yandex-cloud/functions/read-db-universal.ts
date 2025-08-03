import * as dotenv from 'dotenv';
import { TokenAuthService } from 'ydb-sdk';
import { DatabaseService } from './src/services/database';

// Загружаем переменные окружения
dotenv.config();

async function main() {
    console.log('🔍 Starting universal database reader...');

    // Проверяем переменные окружения
    console.log('📊 Environment check:');
    console.log(`  Endpoint: ${process.env.YDB_ENDPOINT}`);
    console.log(`  Database: ${process.env.YDB_DATABASE_PATH}`);
    console.log(`  Token: ${process.env.YDB_TOKEN ? '✅ Found' : '❌ Not found'}`);

    if (!process.env.YDB_TOKEN) {
        console.error('❌ Error: YDB_TOKEN is required for local environment');
        return;
    }

    try {
        // Создаем authService для локальной среды
        const authService = new TokenAuthService(process.env.YDB_TOKEN);

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
        console.log('\n📋 Current Sessions:');
        if (currentSessions.length === 0) {
            console.log('  No active sessions found');
        } else {
            currentSessions.forEach((session, index) => {
                const firstObserved = session.first_observed;
                const lastSeen = session.last_seen;
                const duration = Math.round((lastSeen.getTime() - firstObserved.getTime()) / 60000);

                console.log(`  ${index + 1}. ${session.full_id}`);
                console.log(`     Started: ${firstObserved.toLocaleString()}`);
                console.log(`     Last seen: ${lastSeen.toLocaleString()}`);
                console.log(`     Duration: ${duration} minutes`);
                console.log('');
            });
        }

        console.log('📋 Completed Sessions:');
        if (completedSessions.length === 0) {
            console.log('  No completed sessions found');
        } else {
            completedSessions.forEach((session, index) => {
                const firstObserved = session.first_observed;
                const lastSeen = session.last_seen;
                const duration = Math.round((lastSeen.getTime() - firstObserved.getTime()) / 60000);

                console.log(`  ${index + 1}. ${session.full_id}`);
                console.log(`     Started: ${firstObserved.toLocaleString()}`);
                console.log(`     Ended: ${lastSeen.toLocaleString()}`);
                console.log(`     Duration: ${duration} minutes`);
                console.log('');
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