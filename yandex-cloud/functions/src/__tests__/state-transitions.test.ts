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

      const existingActiveSession = {
        full_id: '456240381_456240381',
        first_observed: new Date('2024-01-15T10:15:00Z'),
        last_seen: new Date('2024-01-15T10:15:00Z')
      };

      mocks.vkApiService.getStatus.mockResolvedValue(mockStatus);
      mocks.databaseService.getActiveSession.mockResolvedValue(existingActiveSession);
      mocks.databaseService.updateActiveSession.mockResolvedValue();

      // Act
      const result = await handler();

      // Assert
      expect(result.statusCode).toBe(200);
      const responseBody = JSON.parse(result.body);
      expect(responseBody.status).toBe('success');
      expect(mocks.databaseService.getActiveSession).toHaveBeenCalledWith('456240381_456240381');
      expect(mocks.databaseService.updateActiveSession).toHaveBeenCalledWith('456240381_456240381');
      expect(mocks.databaseService.createActiveSession).not.toHaveBeenCalled();
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
      mocks.databaseService.getActiveSession.mockResolvedValue(null);
      mocks.databaseService.createActiveSession.mockResolvedValue();

      // Act
      const result = await handler();

      // Assert
      expect(result.statusCode).toBe(200);
      const responseBody = JSON.parse(result.body);
      expect(responseBody.status).toBe('success');
      expect(mocks.databaseService.getActiveSession).toHaveBeenCalledWith('789123456_789123456');
      expect(mocks.databaseService.createActiveSession).toHaveBeenCalledWith('789123456_789123456');
      expect(mocks.databaseService.updateActiveSession).not.toHaveBeenCalled();
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