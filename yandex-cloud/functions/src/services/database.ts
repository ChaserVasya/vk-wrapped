import { Driver, IAuthService } from 'ydb-sdk';
import { TrackSession } from '../types';
import { LoggerService } from './logger';

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

export class DatabaseService {
  private driver: Driver;

  constructor(authService: IAuthService) {
    // Создаем драйвер с инжектированным authService
    this.driver = new Driver({
      endpoint: process.env.YDB_ENDPOINT || '',
      database: process.env.YDB_DATABASE_PATH || '',
      authService
    });
  }

  // Получение активной сессии по full_id
  async getActiveSession(fullId: string): Promise<TrackSession | null> {
    const operation = 'get_active_session';
    console.log(`[DEBUG] Starting ${operation}: fullId="${fullId}"`);

    try {
      const timeout = 10000;
      if (!(await this.driver.ready(timeout))) {
        throw new Error(`Driver has not become ready in ${timeout}ms!`);
      }
      console.log(`[DEBUG] Driver ready for ${operation}`);

      const query: string = `
        SELECT ${FIELDS.FULL_ID}, ${FIELDS.FIRST_OBSERVED}, ${FIELDS.LAST_SEEN}
        FROM ${TABLES.CURRENT_SESSIONS}
        WHERE ${FIELDS.FULL_ID} = "${fullId}"
      `;

      console.log(`[DEBUG] Executing query for ${operation}: "${query}"`);

      const result = await this.driver.tableClient.withSession(async (session) => {
        return await session.executeQuery(query);
      });

      console.log(`[DEBUG] Query executed for ${operation}, resultSets count: ${result.resultSets.length}`);

      if (!result.resultSets || result.resultSets.length === 0) {
        console.log(`[DEBUG] No result sets for ${operation}`);
        return null;
      }

      const rows = result.resultSets[0].rows;
      console.log(`[DEBUG] Rows count for ${operation}: ${rows?.length || 0}`);

      if (!rows || rows.length === 0) {
        console.log(`[DEBUG] No rows found for ${operation}`);
        return null;
      }

      const sessionFullId: string = (rows[0] as unknown as { toString?: () => string })?.toString?.() || '';

      // Детальное логирование для отладки парсинга дат
      const rawFirstObserved = rows[1];
      const rawLastSeen = rows[2];

      console.log(`[DEBUG] Raw data from YDB: fullId="${sessionFullId}", firstObserved="${rawFirstObserved}", lastSeen="${rawLastSeen}"`);

      // Правильное извлечение числовых значений из YDB объектов
      const firstObservedTimestamp = (rawFirstObserved as unknown as { uint32Value?: number; value?: number; toString?: () => string })?.uint32Value ||
        (rawFirstObserved as unknown as { uint32Value?: number; value?: number; toString?: () => string })?.value ||
        parseInt((rawFirstObserved as unknown as { uint32Value?: number; value?: number; toString?: () => string })?.toString?.() || '0');

      const lastSeenTimestamp = (rawLastSeen as unknown as { uint32Value?: number; value?: number; toString?: () => string })?.uint32Value ||
        (rawLastSeen as unknown as { uint32Value?: number; value?: number; toString?: () => string })?.value ||
        parseInt((rawLastSeen as unknown as { uint32Value?: number; value?: number; toString?: () => string })?.toString?.() || '0');

      console.log(`[DEBUG] Parsed timestamps: firstObserved=${firstObservedTimestamp}, lastSeen=${lastSeenTimestamp}`);

      const firstObserved = new Date(firstObservedTimestamp * 1000);
      const lastSeen = new Date(lastSeenTimestamp * 1000);

      console.log(`[DEBUG] Parsed dates: firstObserved=${firstObserved}, lastSeen=${lastSeen}`);
      console.log(`[DEBUG] Date validation: firstObserved.isValid=${!isNaN(firstObserved.getTime())}, lastSeen.isValid=${!isNaN(lastSeen.getTime())}`);

      if (isNaN(firstObserved.getTime()) || isNaN(lastSeen.getTime())) {
        console.log(`[DEBUG] Invalid dates found, returning null`);
        return null;
      }

      const activeSession: TrackSession = {
        full_id: sessionFullId,
        first_observed: firstObserved,
        last_seen: lastSeen
      };

      console.log(`[DEBUG] Created active session for ${operation}: fullId="${activeSession.full_id}", firstObserved="${activeSession.first_observed}", lastSeen="${activeSession.last_seen}"`);

      return activeSession;

    } catch (error: unknown) {
      console.log(`[ERROR] Database error in ${operation}: ${error}`);
      throw error;
    }
  }

  // Создание новой активной сессии
  async createActiveSession(fullId: string): Promise<void> {
    console.log(`[DEBUG] Starting create_active_session: fullId="${fullId}"`);

    try {
      const timeout = 10000;
      if (!(await this.driver.ready(timeout))) {
        throw new Error(`Driver has not become ready in ${timeout}ms!`);
      }
      console.log(`[DEBUG] Driver ready for create_active_session`);

      const now = Math.floor(Date.now() / 1000);
      const query: string = `
        UPSERT INTO ${TABLES.CURRENT_SESSIONS} (${FIELDS.FULL_ID}, ${FIELDS.FIRST_OBSERVED}, ${FIELDS.LAST_SEEN})
        VALUES ("${fullId}", ${now}, ${now})
      `;

      console.log(`[DEBUG] Executing query for create_active_session: "${query}"`);

      await this.driver.tableClient.withSession(async (session) => {
        return await session.executeQuery(query);
      });

      console.log(`[DEBUG] Active session created successfully for: ${fullId}`);
    } catch (error: unknown) {
      console.log(`[ERROR] Failed to create active session for ${fullId}: ${error instanceof Error ? error.message : String(error)}`);
      LoggerService.logErrorDetails(error, 'Database Query Execution');
      throw error;
    }
  }

  // Обновление времени последнего обновления активной сессии
  async updateActiveSession(fullId: string): Promise<void> {
    console.log(`[DEBUG] Starting update_active_session: fullId="${fullId}"`);

    try {
      const timeout = 10000;
      if (!(await this.driver.ready(timeout))) {
        throw new Error(`Driver has not become ready in ${timeout}ms!`);
      }
      console.log(`[DEBUG] Driver ready for update_active_session`);

      const now = Math.floor(Date.now() / 1000);
      const query: string = `
        UPSERT INTO ${TABLES.CURRENT_SESSIONS} (${FIELDS.FULL_ID}, ${FIELDS.FIRST_OBSERVED}, ${FIELDS.LAST_SEEN})
        VALUES ("${fullId}", ${now}, ${now})
      `;

      console.log(`[DEBUG] Executing query for update_active_session: "${query}"`);

      await this.driver.tableClient.withSession(async (session) => {
        return await session.executeQuery(query);
      });

      console.log(`[DEBUG] Active session updated successfully for: ${fullId}`);
    } catch (error: unknown) {
      LoggerService.logErrorDetails(error, 'Database Query Execution');
      throw error;
    }
  }

  // Завершение всех активных сессий (при отсутствии музыки)
  async finishAllActiveSessions(): Promise<void> {
    console.log(`[DEBUG] Starting finish_all_active_sessions`);

    try {
      const timeout = 10000;
      if (!(await this.driver.ready(timeout))) {
        throw new Error(`Driver has not become ready in ${timeout}ms!`);
      }
      console.log(`[DEBUG] Driver ready for finish_all_active_sessions`);

      const deleteQuery: string = `
        DELETE FROM ${TABLES.CURRENT_SESSIONS}
      `;

      console.log(`[DEBUG] Executing query for finish_all_active_sessions: "${deleteQuery}"`);

      await this.driver.tableClient.withSession(async (session) => {
        return await session.executeQuery(deleteQuery);
      });

      console.log(`[DEBUG] All active sessions finished successfully`);
    } catch (error: unknown) {
      LoggerService.logErrorDetails(error, 'Database Query Execution');
      throw error;
    }
  }

  // Получение всех активных сессий
  async getAllCurrentSessions(limit?: number): Promise<TrackSession[]> {
    const operation = 'get_all_active_sessions';
    console.log(`[DEBUG] Starting ${operation}`);

    try {
      const timeout = 10000;
      if (!(await this.driver.ready(timeout))) {
        throw new Error(`Driver has not become ready in ${timeout}ms!`);
      }
      console.log(`[DEBUG] Driver ready for ${operation}`);

      const limitClause = limit ? `LIMIT ${limit}` : '';
      const query: string = `
        SELECT ${FIELDS.FULL_ID}, ${FIELDS.FIRST_OBSERVED}, ${FIELDS.LAST_SEEN}
        FROM ${TABLES.CURRENT_SESSIONS}
        ORDER BY ${FIELDS.LAST_SEEN} DESC
        ${limitClause}
      `;

      console.log(`[DEBUG] Executing query for ${operation}: "${query}"`);

      const result = await this.driver.tableClient.withSession(async (session) => {
        return await session.executeQuery(query);
      });

      console.log(`[DEBUG] Query executed for ${operation}, resultSets count: ${result.resultSets.length}`);

      if (!result.resultSets || result.resultSets.length === 0) {
        console.log(`[DEBUG] No result sets for ${operation}`);
        return [];
      }

      const rows = result.resultSets[0].rows;
      console.log(`[DEBUG] Rows count for ${operation}: ${rows?.length || 0}`);

      if (!rows || rows.length === 0) {
        console.log(`[DEBUG] No rows found for ${operation}`);
        return [];
      }

      const sessions: TrackSession[] = rows.map((row: any) => {
        const fullId = row[0]?.toString() || '';
        const firstObservedTimestamp = row[1]?.uint32Value || row[1]?.value || 0;
        const lastSeenTimestamp = row[2]?.uint32Value || row[2]?.value || 0;

        return {
          full_id: fullId,
          first_observed: new Date(firstObservedTimestamp * 1000),
          last_seen: new Date(lastSeenTimestamp * 1000)
        };
      });

      console.log(`[DEBUG] Created ${sessions.length} active sessions for ${operation}`);
      return sessions;

    } catch (error: unknown) {
      console.log(`[ERROR] Database error in ${operation}: ${error}`);
      throw error;
    }
  }

  // Получение завершенных сессий
  async getCompletedSessions(limit?: number): Promise<TrackSession[]> {
    const operation = 'get_completed_sessions';
    console.log(`[DEBUG] Starting ${operation}`);

    try {
      const timeout = 10000;
      if (!(await this.driver.ready(timeout))) {
        throw new Error(`Driver has not become ready in ${timeout}ms!`);
      }
      console.log(`[DEBUG] Driver ready for ${operation}`);

      const limitClause = limit ? `LIMIT ${limit}` : '';
      const query: string = `
        SELECT ${FIELDS.FULL_ID}, ${FIELDS.FIRST_OBSERVED}, ${FIELDS.LAST_SEEN}
        FROM ${TABLES.COMPLETED_SESSIONS}
        ORDER BY ${FIELDS.LAST_SEEN} DESC
        ${limitClause}
      `;

      console.log(`[DEBUG] Executing query for ${operation}: "${query}"`);

      const result = await this.driver.tableClient.withSession(async (session) => {
        return await session.executeQuery(query);
      });

      console.log(`[DEBUG] Query executed for ${operation}, resultSets count: ${result.resultSets.length}`);

      if (!result.resultSets || result.resultSets.length === 0) {
        console.log(`[DEBUG] No result sets for ${operation}`);
        return [];
      }

      const rows = result.resultSets[0].rows;
      console.log(`[DEBUG] Rows count for ${operation}: ${rows?.length || 0}`);

      if (!rows || rows.length === 0) {
        console.log(`[DEBUG] No rows found for ${operation}`);
        return [];
      }

      const sessions: TrackSession[] = rows.map((row: any) => {
        const fullId = row[0]?.toString() || '';
        const firstObservedTimestamp = row[1]?.uint32Value || row[1]?.value || 0;
        const lastSeenTimestamp = row[2]?.uint32Value || row[2]?.value || 0;

        return {
          full_id: fullId,
          first_observed: new Date(firstObservedTimestamp * 1000),
          last_seen: new Date(lastSeenTimestamp * 1000)
        };
      });

      console.log(`[DEBUG] Created ${sessions.length} completed sessions for ${operation}`);
      return sessions;

    } catch (error: unknown) {
      console.log(`[ERROR] Database error in ${operation}: ${error}`);
      throw error;
    }
  }

  // Закрытие соединения с базой данных
  async close(): Promise<void> {
    await this.driver.destroy();
  }
} 