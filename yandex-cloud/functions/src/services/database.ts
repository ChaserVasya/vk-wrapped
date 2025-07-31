import axios from 'axios';
import { ListeningSession } from '../types';

export class DatabaseService {
  private endpoint: string;
  private databasePath: string;

  constructor() {
    this.endpoint = process.env.YDB_ENDPOINT || '';
    this.databasePath = process.env.YDB_DATABASE_PATH || '';
  }

  // Сохранение сессии прослушивания
  async saveListeningSession(session: ListeningSession): Promise<void> {
    const query = `
      UPSERT INTO listening_sessions (full_id, start, end)
      VALUES ("${session.full_id}", DateTime("${session.start.toISOString()}"), DateTime("${session.end.toISOString()}"))
    `;
    
    await this.executeQuery(query);
  }

  // Получение всех сессий (для анализа)
  async getAllSessions(): Promise<ListeningSession[]> {
    const query = `
      SELECT full_id, start, end
      FROM listening_sessions
    `;
    
    const result = await this.executeQuery(query);
    return result.rows || [];
  }

  // Выполнение запроса к базе данных
  private async executeQuery(query: string): Promise<any> {
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
      
      return response.data;
    } catch (error) {
      console.error('Database query error:', error);
      throw error;
    }
  }
} 