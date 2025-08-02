// Мокаем модули перед импортом
jest.mock('../services/vk-api');
jest.mock('../services/database');

import { handler } from '../index';
import { createMockServices, setupMockImplementations, MockServices } from './test-utils';

describe('Success Scenarios Tests', () => {
  let mocks: MockServices;

  beforeEach(() => {
    jest.clearAllMocks();
    
    // Создаем моки сервисов
    mocks = createMockServices();
    setupMockImplementations(mocks);
  });

  describe('Успешные сценарии', () => {
    test('Пользователь слушает музыку - создается новая активная сессия', async () => {
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
      mocks.databaseService.getActiveSession.mockResolvedValue(null); // Нет активной сессии
      mocks.databaseService.createActiveSession.mockResolvedValue();

      // Act
      const result = await handler({}, {});

      // Assert
      expect(result.statusCode).toBe(200);
      const responseBody = JSON.parse(result.body);
      expect(responseBody.success).toBe(true);
      expect(responseBody.hasActiveMusic).toBe(true);
      expect(responseBody.timestamp).toBeDefined();
      expect(responseBody.status).toEqual({
        artist: 'The Weeknd',
        title: 'Blinding Lights',
        fullId: '456240381_456240381'
      });

      expect(mocks.vkApiService.getStatus).toHaveBeenCalledTimes(1);
      expect(mocks.databaseService.getActiveSession).toHaveBeenCalledWith('456240381_456240381');
      expect(mocks.databaseService.createActiveSession).toHaveBeenCalledWith('456240381_456240381');
    });

    test('Пользователь не слушает музыку - завершаются все активные сессии', async () => {
      // Arrange
      const mockStatus = {
        status_audio: undefined
      };

      mocks.vkApiService.getStatus.mockResolvedValue(mockStatus);
      mocks.databaseService.finishAllActiveSessions.mockResolvedValue();

      // Act
      const result = await handler({}, {});

      // Assert
      expect(result.statusCode).toBe(200);
      const responseBody = JSON.parse(result.body);
      expect(responseBody.success).toBe(true);
      expect(responseBody.hasActiveMusic).toBe(false);
      expect(responseBody.timestamp).toBeDefined();
      expect(responseBody.status).toBeNull();

      expect(mocks.vkApiService.getStatus).toHaveBeenCalledTimes(1);
      expect(mocks.databaseService.getActiveSession).not.toHaveBeenCalled();
      expect(mocks.databaseService.createActiveSession).not.toHaveBeenCalled();
      expect(mocks.databaseService.finishAllActiveSessions).toHaveBeenCalledTimes(1);
    });
  });
}); 