// Мокаем модули перед импортом
jest.mock('../services/vk-api');
jest.mock('../services/database');

import { handler } from '../index';
import { createMockServices, MockServices, setupMockImplementations } from './test-utils';

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
      const result = await handler();

      // Assert
      expect(result.statusCode).toBe(500);
      const responseBody = JSON.parse(result.body);
      expect(responseBody.error).toBe('Internal Server Error');
      expect(responseBody.message).toBe('Network Error');

      expect(mocks.vkApiService.getStatus).toHaveBeenCalledTimes(1);
      expect(mocks.databaseService.getActiveSession).not.toHaveBeenCalled();
      expect(mocks.databaseService.createActiveSession).not.toHaveBeenCalled();
    });

    test('Ошибка создания активной сессии - функция возвращает 500', async () => {
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
      const result = await handler();

      // Assert
      expect(result.statusCode).toBe(500);
      const responseBody = JSON.parse(result.body);
      expect(responseBody.error).toBe('Internal Server Error');
      expect(responseBody.message).toBe('DB Connection Error');

      expect(mocks.vkApiService.getStatus).toHaveBeenCalledTimes(1);
      expect(mocks.databaseService.getActiveSession).toHaveBeenCalledWith('456240381_456240381');
      expect(mocks.databaseService.createActiveSession).toHaveBeenCalledWith('456240381_456240381');
    });
  });
}); 