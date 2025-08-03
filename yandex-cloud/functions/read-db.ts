import * as dotenv from 'dotenv';
import { Driver, TokenAuthService } from 'ydb-sdk';

// Загружаем переменные окружения
dotenv.config();

// Константы для названий таблиц и полей
const TABLES = {
    CURRENT_SESSIONS: 'current_sessions',
    COMPLETED_SESSIONS: 'completed_sessions'
} as const;

const FIELDS = {
    FULL_ID: 'full_id',
    FIRST_OBSERVED: 'first_observed',
    LAST_SEEN: 'last_seen'
} as const;

interface TrackSession {
    full_id: string;
    first_observed: number;
    last_seen: number;
}

class DatabaseReader {
    private driver: Driver;

    constructor() {
        const token = process.env.YDB_TOKEN;
        if (!token) {
            throw new Error('YDB_TOKEN not found in environment variables');
        }

        const authService = new TokenAuthService(token);
        this.driver = new Driver({
            endpoint: process.env.YDB_ENDPOINT || '',
            database: process.env.YDB_DATABASE_PATH || '',
            authService
        });
    }

    async getAllCurrentSessions(): Promise<TrackSession[]> {
        const query = `
      SELECT ${FIELDS.FULL_ID}, ${FIELDS.FIRST_OBSERVED}, ${FIELDS.LAST_SEEN}
      FROM ${TABLES.CURRENT_SESSIONS}
      ORDER BY ${FIELDS.LAST_SEEN} DESC
    `;

        const result = await this.driver.tableClient.withSession(async (session) => {
            return await session.executeQuery(query);
        });

        if (result.resultSets && result.resultSets.length > 0) {
            const rows = result.resultSets[0].rows;
            if (rows) {
                return rows.map((row: any) => ({
                    full_id: row[0]?.toString() || '',
                    first_observed: row[1]?.uint32Value || row[1]?.value || 0,
                    last_seen: row[2]?.uint32Value || row[2]?.value || 0
                }));
            }
        }

        return [];
    }

    async getAllCompletedSessions(): Promise<TrackSession[]> {
        const query = `
      SELECT ${FIELDS.FULL_ID}, ${FIELDS.FIRST_OBSERVED}, ${FIELDS.LAST_SEEN}
      FROM ${TABLES.COMPLETED_SESSIONS}
      ORDER BY ${FIELDS.LAST_SEEN} DESC
      LIMIT 100
    `;

        const result = await this.driver.tableClient.withSession(async (session) => {
            return await session.executeQuery(query);
        });

        if (result.resultSets && result.resultSets.length > 0) {
            const rows = result.resultSets[0].rows;
            if (rows) {
                return rows.map((row: any) => ({
                    full_id: row[0]?.toString() || '',
                    first_observed: row[1]?.uint32Value || row[1]?.value || 0,
                    last_seen: row[2]?.uint32Value || row[2]?.value || 0
                }));
            }
        }

        return [];
    }

    async close(): Promise<void> {
        await this.driver.destroy();
    }
}

async function main() {
    console.log('🔍 Starting database reader...');

    try {
        // Проверяем переменные окружения
        console.log('📊 Environment check:');
        console.log(`  Endpoint: ${process.env.YDB_ENDPOINT}`);
        console.log(`  Database: ${process.env.YDB_DATABASE_PATH}`);
        console.log(`  Token: ${process.env.YDB_TOKEN ? '✅ Found' : '❌ Not found'}`);

        if (!process.env.YDB_TOKEN) {
            throw new Error('YDB_TOKEN is required');
        }

        const reader = new DatabaseReader();

        // Ждем готовности драйвера
        console.log('⏳ Waiting for driver to be ready...');
        const timeout = 10000;
        if (!(await (reader as any).driver.ready(timeout))) {
            throw new Error(`Driver has not become ready in ${timeout}ms!`);
        }
        console.log('✅ Driver is ready');

        // Читаем данные
        console.log('📊 Reading current sessions...');
        const currentSessions = await reader.getAllCurrentSessions();
        console.log(`✅ Found ${currentSessions.length} current sessions`);

        console.log('📊 Reading completed sessions...');
        const completedSessions = await reader.getAllCompletedSessions();
        console.log(`✅ Found ${completedSessions.length} completed sessions`);

        await reader.close();

        // Выводим результаты
        console.log('\n📋 Current Sessions:');
        if (currentSessions.length === 0) {
            console.log('  No active sessions found');
        } else {
            currentSessions.forEach((session, index) => {
                const firstDate = new Date(session.first_observed * 1000);
                const lastDate = new Date(session.last_seen * 1000);
                const duration = Math.floor((session.last_seen - session.first_observed) / 60);

                console.log(`  ${index + 1}. ${session.full_id}`);
                console.log(`     Started: ${firstDate.toLocaleString()}`);
                console.log(`     Last seen: ${lastDate.toLocaleString()}`);
                console.log(`     Duration: ${duration} minutes`);
                console.log('');
            });
        }

        console.log('📋 Completed Sessions:');
        if (completedSessions.length === 0) {
            console.log('  No completed sessions found');
        } else {
            completedSessions.slice(0, 10).forEach((session, index) => {
                const firstDate = new Date(session.first_observed * 1000);
                const lastDate = new Date(session.last_seen * 1000);
                const duration = Math.floor((session.last_seen - session.first_observed) / 60);

                console.log(`  ${index + 1}. ${session.full_id}`);
                console.log(`     Started: ${firstDate.toLocaleString()}`);
                console.log(`     Ended: ${lastDate.toLocaleString()}`);
                console.log(`     Duration: ${duration} minutes`);
                console.log('');
            });

            if (completedSessions.length > 10) {
                console.log(`  ... and ${completedSessions.length - 10} more sessions`);
            }
        }

        console.log('✅ Database reading completed successfully');

    } catch (error) {
        console.error('❌ Error reading database:', error);
        process.exit(1);
    }
}

// Запускаем скрипт
main().catch(console.error); 