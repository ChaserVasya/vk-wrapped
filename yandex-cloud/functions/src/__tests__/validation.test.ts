// Мокаем модули перед импортом
jest.mock('../services/vk-api');
jest.mock('../services/database');

import { handler } from '../index';
import { createMockServices, setupMockImplementations, MockServices } from './test-utils';

describe('Validation Tests', () => {
  let mocks: MockServices;

  beforeEach(() => {
    jest.clearAllMocks();
    
    // Создаем моки сервисов
    mocks = createMockServices();
    setupMockImplementations(mocks);
  });

  describe('Валидация данных VK API', () => {
    test('Валидные данные - создается активная сессия', async () => {
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
      mocks.databaseService.createActiveSession.mockResolvedValue();

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

      expect(mocks.databaseService.getActiveSession).toHaveBeenCalledWith('456240381_456240381');
      expect(mocks.databaseService.createActiveSession).toHaveBeenCalledWith('456240381_456240381');
    });

    test('Невалидные данные - завершаются все активные сессии', async () => {
      // Arrange
      const mockStatus: any = {
        status_audio: {
          id: 'not_a_number',
          owner_id: 456240381,
          artist: 'The Weeknd',
          title: 'Blinding Lights'
        }
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
      expect(responseBody.status).toBeNull();

      expect(mocks.databaseService.getActiveSession).not.toHaveBeenCalled();
      expect(mocks.databaseService.createActiveSession).not.toHaveBeenCalled();
      expect(mocks.databaseService.finishAllActiveSessions).toHaveBeenCalledTimes(1);
    });

    test('Отсутствует id - завершаются все активные сессии', async () => {
      // Arrange
      const mockStatus: any = {
        status_audio: {
          owner_id: 456240381,
          artist: 'The Weeknd',
          title: 'Blinding Lights'
        }
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
      expect(responseBody.status).toBeNull();

      expect(mocks.databaseService.getActiveSession).not.toHaveBeenCalled();
      expect(mocks.databaseService.createActiveSession).not.toHaveBeenCalled();
      expect(mocks.databaseService.finishAllActiveSessions).toHaveBeenCalledTimes(1);
    });

    test('Отсутствует owner_id - завершаются все активные сессии', async () => {
      // Arrange
      const mockStatus: any = {
        status_audio: {
          id: 456240381,
          artist: 'The Weeknd',
          title: 'Blinding Lights'
        }
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
      expect(responseBody.status).toBeNull();

      expect(mocks.databaseService.getActiveSession).not.toHaveBeenCalled();
      expect(mocks.databaseService.createActiveSession).not.toHaveBeenCalled();
      expect(mocks.databaseService.finishAllActiveSessions).toHaveBeenCalledTimes(1);
    });

    test('id не является числом - завершаются все активные сессии', async () => {
      // Arrange
      const mockStatus: any = {
        status_audio: {
          id: 'abc',
          owner_id: 456240381,
          artist: 'The Weeknd',
          title: 'Blinding Lights'
        }
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
      expect(responseBody.status).toBeNull();

      expect(mocks.databaseService.getActiveSession).not.toHaveBeenCalled();
      expect(mocks.databaseService.createActiveSession).not.toHaveBeenCalled();
      expect(mocks.databaseService.finishAllActiveSessions).toHaveBeenCalledTimes(1);
    });

    test('owner_id не является числом - завершаются все активные сессии', async () => {
      // Arrange
      const mockStatus: any = {
        status_audio: {
          id: 456240381,
          owner_id: 'def',
          artist: 'The Weeknd',
          title: 'Blinding Lights'
        }
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
      expect(responseBody.status).toBeNull();

      expect(mocks.databaseService.getActiveSession).not.toHaveBeenCalled();
      expect(mocks.databaseService.createActiveSession).not.toHaveBeenCalled();
      expect(mocks.databaseService.finishAllActiveSessions).toHaveBeenCalledTimes(1);
    });
  });
}); 