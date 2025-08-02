import axios from 'axios';
import { LoggerService } from './logger';

export interface ActiveSession {
  full_id: string;
  start: Date;
  last_updated: Date;
}

export class DatabaseService {
  private endpoint: string;
  private databasePath: string;

  constructor() {
    this.endpoint = process.env.YDB_ENDPOINT || '';
    this.databasePath = process.env.YDB_DATABASE_PATH || '';


  }

  // Получение активной сессии для трека
  async getActiveSession(fullId: string): Promise<ActiveSession | null> {
    const startTime = Date.now();
    const operation = 'get_active_session';

    const query = `
      SELECT full_id, start, last_updated
      FROM active_sessions
      WHERE full_id = "${fullId}"
      LIMIT 1
    `;

    const result = await this.executeQuery(query);
    LoggerService.logDatabaseResult(operation, result);

    const rows = result.rows || [];

    if (rows.length === 0) {
      return null;
    }

    const row = rows[0];
    const session = {
      full_id: row.full_id,
      start: new Date(row.start),
      last_updated: new Date(row.last_updated)
    };

    LoggerService.logPerformance(startTime, operation);

    return session;
  }

  // Создание новой активной сессии
  async createActiveSession(fullId: string): Promise<void> {
    const startTime = Date.now();
    const operation = 'create_active_session';

    const now = new Date();
    const query = `
      UPSERT INTO active_sessions (full_id, start, last_updated)
      VALUES ("${fullId}", DateTime("${now.toISOString()}"), DateTime("${now.toISOString()}"))
    `;

    await this.executeQuery(query);
    LoggerService.logPerformance(startTime, operation);
  }

  // Обновление времени последнего обновления активной сессии
  async updateActiveSession(fullId: string): Promise<void> {
    const startTime = Date.now();
    const operation = 'update_active_session';

    const now = new Date();
    const query = `
      UPDATE active_sessions 
      SET last_updated = DateTime("${now.toISOString()}")
      WHERE full_id = "${fullId}"
    `;

    await this.executeQuery(query);
    LoggerService.logPerformance(startTime, operation);
  }

  // Завершение всех активных сессий (при отсутствии музыки)
  async finishAllActiveSessions(): Promise<void> {
    const startTime = Date.now();
    const operation = 'finish_all_active_sessions';

    // Получаем все активные сессии
    const query = `
      SELECT full_id, start, last_updated
      FROM active_sessions
    `;

    const result = await this.executeQuery(query);
    LoggerService.logDatabaseResult('get_all_active_sessions', result);

    const rows = result.rows || [];

    if (rows.length === 0) {
      return; // Нет активных сессий
    }

    // Завершаем каждую активную сессию
    for (const row of rows) {
      const fullId = row.full_id;
      const start = new Date(row.start);
      const lastUpdated = new Date(row.last_updated);

      // Создаем завершенную сессию
      const insertQuery = `
        UPSERT INTO listening_sessions (full_id, start, end)
        VALUES ("${fullId}", DateTime("${start.toISOString()}"), DateTime("${lastUpdated.toISOString()}"))
      `;

      await this.executeQuery(insertQuery);
    }

    // Удаляем все активные сессии
    const deleteQuery = `
      DELETE FROM active_sessions
    `;

    await this.executeQuery(deleteQuery);

    LoggerService.logPerformance(startTime, operation);
  }

  // Выполнение запроса к базе данных
  private async executeQuery(query: string): Promise<any> {
    const startTime = Date.now();

    try {
      const response = await axios.post(
        `${this.endpoint}/query`,
        {
          yql: query,
          database: this.databasePath
        },
        {
          headers: {
            'Authorization': `Bearer ${process.env.YDB_TOKEN}`,
            'Content-Type': 'application/json'
          }
        }
      );

      LoggerService.logPerformance(startTime, 'database_query');
      return response.data;
    } catch (error) {
      LoggerService.logErrorDetails(error, 'Database Query Execution');
      LoggerService.logSessionError(error);
      throw error;
    }
  }
} 