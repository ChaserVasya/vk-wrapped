// Мокаем модули перед импортом
jest.mock('../services/vk-api');
jest.mock('../services/database');

import { handler } from '../index';
import { createMockServices, setupMockImplementations, MockServices } from './test-utils';

describe('Error Handling Tests', () => {
  let mocks: MockServices;

  beforeEach(() => {
    jest.clearAllMocks();
    
    // Создаем моки сервисов
    mocks = createMockServices();
    setupMockImplementations(mocks);
  });

  describe('Обработка ошибок', () => {
    test('Ошибка VK API - функция возвращает 500', async () => {
      // Arrange
      mocks.vkApiService.getStatus.mockRejectedValue(new Error('Network Error'));

      // Act
      const result = await handler({}, {});

      // Assert
      expect(result.statusCode).toBe(500);
      const responseBody = JSON.parse(result.body);
      expect(responseBody.success).toBe(false);
      expect(responseBody.error).toBe('Network Error');
      expect(responseBody.timestamp).toBeDefined();

      expect(mocks.vkApiService.getStatus).toHaveBeenCalledTimes(1);
      expect(mocks.databaseService.getActiveSession).not.toHaveBeenCalled();
      expect(mocks.databaseService.createActiveSession).not.toHaveBeenCalled();
    });

    test('Ошибка создания активной сессии - функция не падает, но логируется ошибка', async () => {
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
      mocks.databaseService.getActiveSession.mockResolvedValue(null);
      mocks.databaseService.createActiveSession.mockRejectedValue(new Error('DB Connection Error'));

      // Act
      const result = await handler({}, {});

      // Assert
      expect(result.statusCode).toBe(200);
      const responseBody = JSON.parse(result.body);
      expect(responseBody.success).toBe(true);
      expect(responseBody.hasActiveMusic).toBe(true);
      expect(responseBody.status).toEqual({
        artist: 'The Weeknd',
        title: 'Blinding Lights',
        fullId: '456240381_456240381'
      });

      expect(mocks.vkApiService.getStatus).toHaveBeenCalledTimes(1);
      expect(mocks.databaseService.getActiveSession).toHaveBeenCalledWith('456240381_456240381');
      expect(mocks.databaseService.createActiveSession).toHaveBeenCalledWith('456240381_456240381');
    });
  });
}); 