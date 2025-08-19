import { Driver, IAuthService } from 'ydb-sdk';
import { TrackSession } from '../types';
import { LoggerService } from './logger';

// Константы для названий таблиц и полей
const TABLES = {
  CURRENT_SESSIONS: process.env.CURRENT_SESSIONS_TABLE || 'current_sessions',
  COMPLETED_SESSIONS: process.env.COMPLETED_SESSIONS_TABLE || 'completed_sessions'
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
        LoggerService.debug('Invalid row structure: missing items or insufficient length');
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
        LoggerService.debug('Invalid row data', { fullId, firstObservedTimestamp, lastSeenTimestamp });
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
      LoggerService.error('Failed to map row to TrackSession', error);
      return null;
    }
  }

  // Получение активной сессии по full_id
  async getActiveSession(fullId: string): Promise<TrackSession | null> {
    const operation = 'get_active_session';
    LoggerService.debug(`Starting ${operation}`, { fullId });

    try {
      const timeout = 10000;
      if (!(await this.driver.ready(timeout))) {
        throw new Error(`Driver has not become ready in ${timeout}ms!`);
      }

      const query: string = `
        SELECT ${FIELDS.FULL_ID}, ${FIELDS.FIRST_OBSERVED}, ${FIELDS.LAST_SEEN}
        FROM ${TABLES.CURRENT_SESSIONS}
        WHERE ${FIELDS.FULL_ID} = "${fullId}"
      `;

      const result = await this.driver.tableClient.withSession(async (session) => {
        return await session.executeQuery(query);
      });

      if (!result.resultSets || result.resultSets.length === 0) {
        LoggerService.debug(`No result sets for ${operation}`);
        return null;
      }

      const rows = result.resultSets[0].rows;
      LoggerService.debug(`Rows count for ${operation}`, { rowsCount: rows?.length || 0 });

      if (!rows || rows.length === 0) {
        LoggerService.debug(`No rows found for ${operation}`);
        return null;
      }

      const activeSession = this.mapRowToTrackSession(rows[0]);

      if (activeSession) {
        LoggerService.debug(`Created active session for ${operation}`, {
          fullId: activeSession.full_id,
          firstObserved: activeSession.first_observed,
          lastSeen: activeSession.last_seen,
        });
      } else {
        LoggerService.debug(`Failed to create active session for ${operation}`);
      }

      return activeSession;

    } catch (error: unknown) {
      LoggerService.error(`Database error in ${operation}`, error);
      throw error;
    }
  }

  // Создание новой активной сессии
  async createActiveSession(fullId: string): Promise<void> {
    LoggerService.debug('Starting create_active_session', { fullId });

    try {
      const timeout = 10000;
      if (!(await this.driver.ready(timeout))) {
        throw new Error(`Driver has not become ready in ${timeout}ms!`);
      }

      const now = Math.floor(Date.now() / 1000);
      const query: string = `
        UPSERT INTO ${TABLES.CURRENT_SESSIONS} (${FIELDS.FULL_ID}, ${FIELDS.FIRST_OBSERVED}, ${FIELDS.LAST_SEEN})
        VALUES ("${fullId}", ${now}, ${now})
      `;

      await this.driver.tableClient.withSession(async (session) => {
        return await session.executeQuery(query);
      });

      LoggerService.debug('Active session created successfully', { fullId });
    } catch (error: unknown) {
      LoggerService.logErrorDetails(error, 'Database Query Execution');
      throw error;
    }
  }

  // Обновление времени последнего обновления активной сессии
  async updateActiveSession(fullId: string): Promise<void> {
    LoggerService.debug('Starting update_active_session', { fullId });

    try {
      const timeout = 10000;
      if (!(await this.driver.ready(timeout))) {
        throw new Error(`Driver has not become ready in ${timeout}ms!`);
      }

      const now = Math.floor(Date.now() / 1000);
      const query: string = `
        UPDATE ${TABLES.CURRENT_SESSIONS} 
        SET ${FIELDS.LAST_SEEN} = ${now}
        WHERE ${FIELDS.FULL_ID} = "${fullId}"
      `;

      await this.driver.tableClient.withSession(async (session) => {
        return await session.executeQuery(query);
      });

      LoggerService.debug('Active session updated successfully', { fullId });
    } catch (error: unknown) {
      LoggerService.logErrorDetails(error, 'Database Query Execution');
      throw error;
    }
  }

  // Завершение всех активных сессий (при отсутствии музыки)
  async finishAllActiveSessions(): Promise<void> {
    LoggerService.debug('Starting finish_all_active_sessions');

    try {
      const timeout = 10000;
      if (!(await this.driver.ready(timeout))) {
        throw new Error(`Driver has not become ready in ${timeout}ms!`);
      }

      // Сначала получаем все активные сессии
      LoggerService.debug('About to call getAllCurrentSessions');
      const activeSessions = await this.getAllCurrentSessions();
      LoggerService.debug('Found active sessions to finish', { count: activeSessions.length });
      LoggerService.debug('Active sessions', activeSessions);

      if (activeSessions.length > 0) {
        // Перемещаем активные сессии в completed_sessions
        const now = Math.floor(Date.now() / 1000);
        const insertQuery: string = `
          UPSERT INTO ${TABLES.COMPLETED_SESSIONS} (${FIELDS.FULL_ID}, ${FIELDS.FIRST_OBSERVED}, ${FIELDS.LAST_SEEN})
          VALUES ${activeSessions.map(session =>
          `("${session.full_id}", ${Math.floor(session.first_observed.getTime() / 1000)}, ${now})`
        ).join(', ')}
        `;

        await this.driver.tableClient.withSession(async (session) => {
          return await session.executeQuery(insertQuery);
        });

        LoggerService.debug('Moved sessions to completed_sessions', { count: activeSessions.length });
      }

      // Теперь удаляем все из current_sessions
      const deleteQuery: string = `
        DELETE FROM ${TABLES.CURRENT_SESSIONS}
      `;

      await this.driver.tableClient.withSession(async (session) => {
        return await session.executeQuery(deleteQuery);
      });

      LoggerService.debug('All active sessions finished successfully');
    } catch (error: unknown) {
      LoggerService.logErrorDetails(error, 'Database Query Execution');
      throw error;
    }
  }

  // Получение всех активных сессий
  async getAllCurrentSessions(limit?: number): Promise<TrackSession[]> {
    const operation = 'get_all_active_sessions';
    LoggerService.debug(`Starting ${operation}`);

    try {
      const timeout = 10000;
      if (!(await this.driver.ready(timeout))) {
        throw new Error(`Driver has not become ready in ${timeout}ms!`);
      }

      const limitClause = limit ? `LIMIT ${limit}` : '';
      const query: string = `
        SELECT ${FIELDS.FULL_ID}, ${FIELDS.FIRST_OBSERVED}, ${FIELDS.LAST_SEEN}
        FROM ${TABLES.CURRENT_SESSIONS}
        ORDER BY ${FIELDS.LAST_SEEN} DESC
        ${limitClause}
      `;

      const result = await this.driver.tableClient.withSession(async (session) => {
        return await session.executeQuery(query);
      });

      if (!result.resultSets || result.resultSets.length === 0) {
        LoggerService.debug(`No result sets for ${operation}`);
        return [];
      }

      const rows = result.resultSets[0].rows;
      LoggerService.debug(`Rows count for ${operation}`, { rowsCount: rows?.length || 0 });

      if (!rows || rows.length === 0) {
        LoggerService.debug(`No rows found for ${operation}`);
        return [];
      }

      const sessions: TrackSession[] = rows
        .map((row: unknown) => this.mapRowToTrackSession(row))
        .filter((session): session is TrackSession => session !== null);

      LoggerService.debug(`Created active sessions for ${operation}`, { count: sessions.length });
      return sessions;

    } catch (error: unknown) {
      LoggerService.error(`Database error in ${operation}`, error);
      throw error;
    }
  }

  // Получение завершенных сессий
  async getCompletedSessions(limit?: number): Promise<TrackSession[]> {
    const operation = 'get_completed_sessions';
    LoggerService.debug(`Starting ${operation}`);

    try {
      const timeout = 10000;
      if (!(await this.driver.ready(timeout))) {
        throw new Error(`Driver has not become ready in ${timeout}ms!`);
      }

      const limitClause = limit ? `LIMIT ${limit}` : '';
      const query: string = `
        SELECT ${FIELDS.FULL_ID}, ${FIELDS.FIRST_OBSERVED}, ${FIELDS.LAST_SEEN}
        FROM ${TABLES.COMPLETED_SESSIONS}
        ORDER BY ${FIELDS.LAST_SEEN} DESC
        ${limitClause}
      `;

      const result = await this.driver.tableClient.withSession(async (session) => {
        return await session.executeQuery(query);
      });

      if (!result.resultSets || result.resultSets.length === 0) {
        LoggerService.debug(`No result sets for ${operation}`);
        return [];
      }

      const rows = result.resultSets[0].rows;
      LoggerService.debug(`Rows count for ${operation}`, { rowsCount: rows?.length || 0 });

      if (!rows || rows.length === 0) {
        LoggerService.debug(`No rows found for ${operation}`);
        return [];
      }

      const sessions: TrackSession[] = rows
        .map((row: unknown) => this.mapRowToTrackSession(row))
        .filter((session): session is TrackSession => session !== null);

      LoggerService.debug(`Created completed sessions for ${operation}`, { count: sessions.length });
      return sessions;

    } catch (error: unknown) {
      LoggerService.error(`Database error in ${operation}`, error);
      throw error;
    }
  }



  // Методы для работы с лайками мемов
  async isMemeLiked(memeId: string): Promise<boolean> {
    const operation = 'is_meme_liked';
    LoggerService.debug(`Starting ${operation}`, { memeId });

    try {
      const timeout = 10000;
      if (!(await this.driver.ready(timeout))) {
        throw new Error(`Driver has not become ready in ${timeout}ms!`);
      }

      const query = `
        SELECT meme_id 
        FROM meme_likes 
        WHERE meme_id = "${memeId}"
        LIMIT 1
      `;

      const result = await this.driver.tableClient.withSession(async (session) => {
        return await session.executeQuery(query);
      });

      const hasLikes = (result.resultSets[0]?.rows?.length ?? 0) > 0;
      LoggerService.debug(`Completed ${operation}`, { memeId, hasLikes });
      return hasLikes;

    } catch (error: unknown) {
      LoggerService.error(`Database error in ${operation}`, error);
      return false;
    }
  }

  async addMemeLike(memeId: string): Promise<void> {
    const operation = 'add_meme_like';
    LoggerService.debug(`Starting ${operation}`, { memeId });

    try {
      const timeout = 10000;
      if (!(await this.driver.ready(timeout))) {
        throw new Error(`Driver has not become ready in ${timeout}ms!`);
      }

      const query = `
        UPSERT INTO meme_likes (meme_id) 
        VALUES ("${memeId}")
      `;

      await this.driver.tableClient.withSession(async (session) => {
        return await session.executeQuery(query);
      });

      LoggerService.debug(`Completed ${operation}`, { memeId });

    } catch (error: unknown) {
      LoggerService.error(`Database error in ${operation}`, error);
      throw error;
    }
  }

  async removeMemeLike(memeId: string): Promise<void> {
    const operation = 'remove_meme_like';
    LoggerService.debug(`Starting ${operation}`, { memeId });

    try {
      const timeout = 10000;
      if (!(await this.driver.ready(timeout))) {
        throw new Error(`Driver has not become ready in ${timeout}ms!`);
      }

      const query = `
        DELETE FROM meme_likes 
        WHERE meme_id = "${memeId}"
      `;

      await this.driver.tableClient.withSession(async (session) => {
        return await session.executeQuery(query);
      });

      LoggerService.debug(`Completed ${operation}`, { memeId });

    } catch (error: unknown) {
      LoggerService.error(`Database error in ${operation}`, error);
      throw error;
    }
  }

  async getLikedMemeIds(): Promise<string[]> {
    const operation = 'get_liked_meme_ids';
    LoggerService.debug(`Starting ${operation}`);

    try {
      const timeout = 10000;
      if (!(await this.driver.ready(timeout))) {
        throw new Error(`Driver has not become ready in ${timeout}ms!`);
      }

      const query = `
        SELECT meme_id 
        FROM meme_likes
      `;

      const result = await this.driver.tableClient.withSession(async (session) => {
        return await session.executeQuery(query);
      });

      const memeIds: string[] = [];

      if (result.resultSets[0]?.rows) {
        for (const row of result.resultSets[0].rows) {
          if (row.items?.[0]) {
            const value = row.items[0];
            LoggerService.info(`Raw value from DB: ${JSON.stringify(value)}`);
            if (typeof value === 'string') {
              memeIds.push(value);
            } else if (value && typeof value === 'object' && 'text' in value) {
              memeIds.push((value as { text: string }).text);
            } else if (value && typeof value === 'object' && 'bytesValue' in value) {
              const bytesValue = (value as { bytesValue: unknown }).bytesValue;
              LoggerService.info(`bytesValue type: ${typeof bytesValue}, value: ${JSON.stringify(bytesValue)}`);

              // Если bytesValue это объект с полем text
              if (bytesValue && typeof bytesValue === 'object' && 'text' in bytesValue) {
                const textValue = (bytesValue as { text: string }).text;
                LoggerService.info(`Text value: ${textValue}`);
                memeIds.push(textValue);
              }
              // Если bytesValue это строка (base64)
              else if (typeof bytesValue === 'string') {
                const decodedValue = Buffer.from(bytesValue, 'base64').toString('utf-8');
                LoggerService.info(`Decoded value: ${decodedValue}`);
                memeIds.push(decodedValue);
              }
              // Если bytesValue это объект с числовыми ключами (массив как объект)
              else if (bytesValue && typeof bytesValue === 'object') {
                LoggerService.info(`Checking if it's a Buffer object...`);
                LoggerService.info(`Has 'type' field: ${'type' in bytesValue}`);
                LoggerService.info(`Has 'data' field: ${'data' in bytesValue}`);

                if ('type' in bytesValue && 'data' in bytesValue) {
                  LoggerService.info(`Processing Buffer object`);
                  const bufferData = (bytesValue as { type: string; data: number[] }).data;
                  if (Array.isArray(bufferData)) {
                    const decodedValue = String.fromCharCode(...bufferData);
                    LoggerService.info(`Decoded Buffer value: ${decodedValue}`);
                    memeIds.push(decodedValue);
                  } else {
                    LoggerService.info(`Buffer data is not an array: ${JSON.stringify(bufferData)}`);
                  }
                } else {
                  LoggerService.info(`Not a Buffer object, checking if it's an array-like object...`);
                  // Проверяем, есть ли числовые ключи (как у массива)
                  const keys = Object.keys(bytesValue as object);
                  const numericKeys = keys.filter(k => !isNaN(Number(k)));
                  if (numericKeys.length > 0) {
                    LoggerService.info(`Found numeric keys: ${numericKeys.join(', ')}`);
                    // Преобразуем в массив и декодируем
                    const arrayData = numericKeys.map(k => (bytesValue as Record<string, number>)[k]);
                    const decodedValue = String.fromCharCode(...arrayData);
                    LoggerService.info(`Decoded array-like value: ${decodedValue}`);
                    memeIds.push(decodedValue);
                  } else {
                    LoggerService.info(`No numeric keys found`);
                  }
                }
              } else {
                LoggerService.info(`Unexpected bytesValue type: ${typeof bytesValue}`);
              }
            } else {
              LoggerService.info(`Unexpected value type: ${typeof value}, value: ${JSON.stringify(value)}`);
              memeIds.push(String(value));
            }
          }
        }
      }

      LoggerService.debug(`Completed ${operation}`, { count: memeIds.length });
      return memeIds;

    } catch (error: unknown) {
      LoggerService.error(`Database error in ${operation}`, error);
      return [];
    }
  }

  // Закрытие соединения с базой данных
  async close(): Promise<void> {
    await this.driver.destroy();
  }
} 