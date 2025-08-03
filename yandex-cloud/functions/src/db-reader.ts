import { Driver, MetadataAuthService } from 'ydb-sdk';
import { TrackSession } from './types';

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

export class DatabaseReader {
    private driver: Driver;

    constructor() {
        const authService = new MetadataAuthService();
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
            return rows.map(row => ({
                full_id: row[0]?.toString() || '',
                first_observed: row[1]?.uint32Value || row[1]?.value || 0,
                last_seen: row[2]?.uint32Value || row[2]?.value || 0
            }));
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
            return rows.map(row => ({
                full_id: row[0]?.toString() || '',
                first_observed: row[1]?.uint32Value || row[1]?.value || 0,
                last_seen: row[2]?.uint32Value || row[2]?.value || 0
            }));
        }

        return [];
    }

    async close(): Promise<void> {
        await this.driver.destroy();
    }
}

export const handler = async (event: any, context: any) => {
    console.log('[INFO] Starting database reader function...');

    try {
        const reader = new DatabaseReader();

        // Ждем готовности драйвера
        const timeout = 10000;
        if (!(await reader.driver.ready(timeout))) {
            throw new Error(`Driver has not become ready in ${timeout}ms!`);
        }

        // Читаем данные
        const currentSessions = await reader.getAllCurrentSessions();
        const completedSessions = await reader.getAllCompletedSessions();

        await reader.close();

        const result = {
            currentSessions: currentSessions.map(session => ({
                fullId: session.full_id,
                firstObserved: session.first_observed,
                lastSeen: session.last_seen,
                duration: Math.floor((session.last_seen - session.first_observed) / 60) // в минутах
            })),
            completedSessions: completedSessions.map(session => ({
                fullId: session.full_id,
                firstObserved: session.first_observed,
                lastSeen: session.last_seen,
                duration: Math.floor((session.last_seen - session.first_observed) / 60) // в минутах
            }))
        };

        console.log(`[INFO] Found ${result.currentSessions.length} current sessions and ${result.completedSessions.length} completed sessions`);

        return {
            statusCode: 200,
            headers: {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*'
            },
            body: JSON.stringify(result)
        };

    } catch (error) {
        console.error('[ERROR] Database reader error:', error);
        return {
            statusCode: 500,
            headers: {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*'
            },
            body: JSON.stringify({
                error: 'Database read failed',
                message: error instanceof Error ? error.message : 'Unknown error'
            })
        };
    }
}; 