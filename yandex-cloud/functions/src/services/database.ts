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

  /**
 * Преобразует строку YDB в TrackSession
 * @param row - строка из YDB с полями full_id, first_observed, last_seen
 * @returns TrackSession или null если данные некорректны
 */
  private mapRowToTrackSession(row: unknown): TrackSession | null {
    try {
      // Приводим к типу с items
      const typedRow = row as { items?: unknown[] };
      if (!typedRow.items || typedRow.items.length < 3) {
        console.log(`[DEBUG] Invalid row structure: missing items or insufficient length`);
        return null;
      }

      // YDB возвращает данные в формате items с bytesValue и uint32Value
      const fullIdItem = typedRow.items[0] as { bytesValue?: string };
      const firstObservedItem = typedRow.items[1] as { uint32Value?: number };
      const lastSeenItem = typedRow.items[2] as { uint32Value?: number };

      // Декодируем base64 для строки
      const fullId = fullIdItem?.bytesValue ? Buffer.from(fullIdItem.bytesValue, 'base64').toString() : '';
      const firstObservedTimestamp = firstObservedItem?.uint32Value || 0;
      const lastSeenTimestamp = lastSeenItem?.uint32Value || 0;

      if (!fullId || firstObservedTimestamp === 0 || lastSeenTimestamp === 0) {
        console.log(`[DEBUG] Invalid row data: fullId="${fullId}", firstObservedTimestamp=${firstObservedTimestamp}, lastSeenTimestamp=${lastSeenTimestamp}`);
        return null;
      }

      const firstObserved = new Date(firstObservedTimestamp * 1000);
      const lastSeen = new Date(lastSeenTimestamp * 1000);

      return {
        full_id: fullId,
        first_observed: firstObserved,
        last_seen: lastSeen
      };
    } catch (error) {
      console.log(`[ERROR] Failed to map row to TrackSession: ${error}`);
      return null;
    }
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

      const activeSession = this.mapRowToTrackSession(rows[0]);

      if (activeSession) {
        console.log(`[DEBUG] Created active session for ${operation}: fullId="${activeSession.full_id}", firstObserved="${activeSession.first_observed}", lastSeen="${activeSession.last_seen}"`);
      } else {
        console.log(`[DEBUG] Failed to create active session for ${operation}`);
      }

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

      const sessions: TrackSession[] = rows
        .map((row: unknown) => this.mapRowToTrackSession(row))
        .filter((session): session is TrackSession => session !== null);

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

      const sessions: TrackSession[] = rows
        .map((row: unknown) => this.mapRowToTrackSession(row))
        .filter((session): session is TrackSession => session !== null);

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