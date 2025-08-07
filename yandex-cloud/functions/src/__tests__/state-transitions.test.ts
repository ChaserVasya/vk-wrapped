// Мокаем модули перед импортом
jest.mock('../services/vk-api');
jest.mock('../services/database');

import { handler } from '../index';
import { createMockServices, MockServices, setupMockImplementations } from './test-utils';

describe('State Transitions Tests', () => {
  let mocks: MockServices;

  beforeEach(() => {
    jest.clearAllMocks();

    // Создаем моки сервисов
    mocks = createMockServices();
    setupMockImplementations(mocks);
  });

  describe('Логика состояний и переходов', () => {
    test('Сценарий: Есть музыка → Есть та же музыка (продолжает слушать)', async () => {
      // Arrange
      const mockStatus = {
        status_audio: {
          id: 456240381,
          owner_id: 456240381,
          artist: 'The Weeknd',
          title: 'Blinding Lights'
        }
      };

      mocks.vkApiService.getStatus.mockResolvedValue(mockStatus);
      mocks.databaseService.createActiveSession.mockResolvedValue();
      mocks.databaseService.getAllCurrentSessions.mockResolvedValue([]); // Нет активных сессий

      // Act
      const result = await handler();

      // Assert
      expect(result.statusCode).toBe(200);
      const responseBody = JSON.parse(result.body);
      expect(responseBody.status).toBe('success');
      expect(mocks.databaseService.createActiveSession).toHaveBeenCalledWith('456240381_456240381');
    });

    test('Сценарий: Есть музыка → Есть другая музыка (переключился)', async () => {
      // Arrange
      const mockStatus = {
        status_audio: {
          id: 789123456,
          owner_id: 789123456,
          artist: 'Dua Lipa',
          title: 'Levitating'
        }
      };

      mocks.vkApiService.getStatus.mockResolvedValue(mockStatus);
      mocks.databaseService.getActiveSession.mockResolvedValue(null); // Нет активной сессии для нового трека
      mocks.databaseService.getAllCurrentSessions.mockResolvedValue([
        { full_id: '456240381_456240381', first_observed: new Date(), last_seen: new Date() }
      ]); // Есть другие активные сессии
      mocks.databaseService.finishAllActiveSessions.mockResolvedValue(); // Завершение предыдущих сессий
      mocks.databaseService.createActiveSession.mockResolvedValue(); // Создание новой сессии

      // Act
      const result = await handler();

      // Assert
      expect(result.statusCode).toBe(200);
      const responseBody = JSON.parse(result.body);
      expect(responseBody.status).toBe('success');

      // Проверяем что сначала завершились все активные сессии
      expect(mocks.databaseService.finishAllActiveSessions).toHaveBeenCalled();

      // Затем создалась новая сессия для нового трека
      expect(mocks.databaseService.createActiveSession).toHaveBeenCalledWith('789123456_789123456');

      // Проверяем порядок вызовов
      const finishCallIndex = mocks.databaseService.finishAllActiveSessions.mock.invocationCallOrder[0];
      const createCallIndex = mocks.databaseService.createActiveSession.mock.invocationCallOrder[0];
      expect(finishCallIndex).toBeLessThan(createCallIndex);
    });

    test('Сценарий: Есть музыка → Нет музыки (перестал слушать)', async () => {
      // Arrange
      const mockStatus = {
        status_audio: undefined
      };

      mocks.vkApiService.getStatus.mockResolvedValue(mockStatus);
      mocks.databaseService.finishAllActiveSessions.mockResolvedValue();

      // Act
      const result = await handler();

      // Assert
      expect(result.statusCode).toBe(200);
      const responseBody = JSON.parse(result.body);
      expect(responseBody.status).toBe('success');
      expect(mocks.databaseService.getActiveSession).not.toHaveBeenCalled();
      expect(mocks.databaseService.createActiveSession).not.toHaveBeenCalled();
      expect(mocks.databaseService.finishAllActiveSessions).toHaveBeenCalled();
    });
  });
}); 