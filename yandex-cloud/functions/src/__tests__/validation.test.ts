// Мокаем модули перед импортом
jest.mock('../services/vk-api');
jest.mock('../services/database');

import { handler } from '../index';
import { DataValidator } from '../types';
import { createMockServices, MockServices, setupMockImplementations } from './test-utils';

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
      mocks.databaseService.createActiveSession.mockResolvedValue();
      mocks.databaseService.getAllCurrentSessions.mockResolvedValue([]); // Нет активных сессий

      // Act
      const result = await handler();

      // Assert
      expect(result.statusCode).toBe(200);
      const responseBody = JSON.parse(result.body);
      expect(responseBody.status).toBe('success');
      expect(mocks.databaseService.createActiveSession).toHaveBeenCalledWith('456240381_456240381');
      expect(mocks.databaseService.finishAllActiveSessions).not.toHaveBeenCalled();
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
      const result = await handler();

      // Assert
      expect(result.statusCode).toBe(200);
      const responseBody = JSON.parse(result.body);
      expect(responseBody.status).toBe('success');
      expect(mocks.databaseService.getActiveSession).not.toHaveBeenCalled();
      expect(mocks.databaseService.createActiveSession).not.toHaveBeenCalled();
      expect(mocks.databaseService.finishAllActiveSessions).toHaveBeenCalled();
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
      const result = await handler();

      // Assert
      expect(result.statusCode).toBe(200);
      const responseBody = JSON.parse(result.body);
      expect(responseBody.status).toBe('success');
      expect(mocks.databaseService.getActiveSession).not.toHaveBeenCalled();
      expect(mocks.databaseService.createActiveSession).not.toHaveBeenCalled();
      expect(mocks.databaseService.finishAllActiveSessions).toHaveBeenCalled();
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
      const result = await handler();

      // Assert
      expect(result.statusCode).toBe(200);
      const responseBody = JSON.parse(result.body);
      expect(responseBody.status).toBe('success');
      expect(mocks.databaseService.getActiveSession).not.toHaveBeenCalled();
      expect(mocks.databaseService.createActiveSession).not.toHaveBeenCalled();
      expect(mocks.databaseService.finishAllActiveSessions).toHaveBeenCalled();
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
      const result = await handler();

      // Assert
      expect(result.statusCode).toBe(200);
      const responseBody = JSON.parse(result.body);
      expect(responseBody.status).toBe('success');
      expect(mocks.databaseService.getActiveSession).not.toHaveBeenCalled();
      expect(mocks.databaseService.createActiveSession).not.toHaveBeenCalled();
      expect(mocks.databaseService.finishAllActiveSessions).toHaveBeenCalled();
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

  describe('validateTrackSession', () => {
    test('валидный TrackSession', () => {
      const validSession = {
        full_id: '123_456',
        first_observed: new Date('2024-01-15T10:15:00Z'),
        last_seen: new Date('2024-01-15T10:16:00Z')
      };

      expect(DataValidator.validateTrackSession(validSession)).toBe(true);
    });

    test('невалидный TrackSession - пустой full_id', () => {
      const invalidSession = {
        full_id: '',
        first_observed: new Date('2024-01-15T10:15:00Z'),
        last_seen: new Date('2024-01-15T10:16:00Z')
      };

      expect(DataValidator.validateTrackSession(invalidSession)).toBe(false);
    });

    test('невалидный TrackSession - невалидная дата first_observed', () => {
      const invalidSession = {
        full_id: '123_456',
        first_observed: new Date('invalid'),
        last_seen: new Date('2024-01-15T10:16:00Z')
      };

      expect(DataValidator.validateTrackSession(invalidSession)).toBe(false);
    });

    test('невалидный TrackSession - невалидная дата last_seen', () => {
      const invalidSession = {
        full_id: '123_456',
        first_observed: new Date('2024-01-15T10:15:00Z'),
        last_seen: new Date('invalid')
      };

      expect(DataValidator.validateTrackSession(invalidSession)).toBe(false);
    });

    test('невалидный TrackSession - обе даты невалидные', () => {
      const invalidSession = {
        full_id: '123_456',
        first_observed: new Date('invalid'),
        last_seen: new Date('invalid')
      };

      expect(DataValidator.validateTrackSession(invalidSession)).toBe(false);
    });

    test('невалидный TrackSession - null объект', () => {
      expect(DataValidator.validateTrackSession(null)).toBe(false);
    });

    test('невалидный TrackSession - undefined', () => {
      expect(DataValidator.validateTrackSession(undefined)).toBe(false);
    });

    test('невалидный TrackSession - не объект', () => {
      expect(DataValidator.validateTrackSession('not an object')).toBe(false);
    });
  });
}); 