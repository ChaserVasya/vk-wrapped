// Мокаем модули перед импортом
jest.mock('../services/vk-api');
jest.mock('../services/database');

import { handler } from '../index';
import { VKApiService } from '../services/vk-api';
import { DatabaseService } from '../services/database';
import { ValidatorService } from '../services/validator';

const MockedVKApiService = VKApiService as jest.MockedClass<typeof VKApiService>;
const MockedDatabaseService = DatabaseService as jest.MockedClass<typeof DatabaseService>;

describe('Integration Tests', () => {
  let mockVKApiService: jest.Mocked<VKApiService>;
  let mockDatabaseService: jest.Mocked<DatabaseService>;

  beforeEach(() => {
    jest.clearAllMocks();
    
    // Создаем моки сервисов
    mockVKApiService = {
      getStatus: jest.fn()
    } as any;
    
    mockDatabaseService = {
      saveListeningSession: jest.fn()
    } as any;

    // Подменяем инстансы
    MockedVKApiService.mockImplementation(() => mockVKApiService);
    MockedDatabaseService.mockImplementation(() => mockDatabaseService);
  });

  describe('Успешные сценарии', () => {
    test('Пользователь слушает музыку - сессия сохраняется', async () => {
      // Arrange
      const mockStatus = {
        status_audio: {
          id: 456240381,
          owner_id: 456240381,
          artist: 'The Weeknd',
          title: 'Blinding Lights'
        }
      };

      mockVKApiService.getStatus.mockResolvedValue(mockStatus);
      mockDatabaseService.saveListeningSession.mockResolvedValue();

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

      expect(mockVKApiService.getStatus).toHaveBeenCalledTimes(1);
      expect(mockDatabaseService.saveListeningSession).toHaveBeenCalledTimes(1);
      expect(mockDatabaseService.saveListeningSession).toHaveBeenCalledWith({
        full_id: '456240381_456240381',
        start: expect.any(Date),
        end: expect.any(Date)
      });
    });

    test('Пользователь не слушает музыку - сессия не сохраняется', async () => {
      // Arrange
      const mockStatus = {
        status_audio: undefined
      };

      mockVKApiService.getStatus.mockResolvedValue(mockStatus);

      // Act
      const result = await handler({}, {});

      // Assert
      expect(result.statusCode).toBe(200);
      const responseBody = JSON.parse(result.body);
      expect(responseBody.success).toBe(true);
      expect(responseBody.hasActiveMusic).toBe(false);
      expect(responseBody.timestamp).toBeDefined();
      expect(responseBody.status).toBeNull();

      expect(mockVKApiService.getStatus).toHaveBeenCalledTimes(1);
      expect(mockDatabaseService.saveListeningSession).not.toHaveBeenCalled();
    });
  });

  describe('Сценарии с невалидными данными', () => {
    test('status_audio есть, но невалидный формат - сессия не сохраняется', async () => {
      // Arrange
      const mockStatus = {
        status_audio: {
          id: 123,
          owner_id: 456240381,
          artist: '', // пустая строка
          title: 'Blinding Lights'
        }
      };

      mockVKApiService.getStatus.mockResolvedValue(mockStatus);

      // Act
      const result = await handler({}, {});

      // Assert
      expect(result.statusCode).toBe(200);
      const responseBody = JSON.parse(result.body);
      expect(responseBody.success).toBe(true);
      expect(responseBody.hasActiveMusic).toBe(false);
      expect(responseBody.timestamp).toBeDefined();
      expect(responseBody.status).toBeNull();

      expect(mockVKApiService.getStatus).toHaveBeenCalledTimes(1);
      expect(mockDatabaseService.saveListeningSession).not.toHaveBeenCalled();
    });

    test('status_audio есть, но отсутствуют обязательные поля - сессия не сохраняется', async () => {
      // Arrange
      const mockStatus = {
        status_audio: {
          id: 456240381,
          owner_id: 456240381,
          artist: 'The Weeknd',
          title: '' // пустой title
        }
      };

      mockVKApiService.getStatus.mockResolvedValue(mockStatus);

      // Act
      const result = await handler({}, {});

      // Assert
      expect(result.statusCode).toBe(200);
      const responseBody = JSON.parse(result.body);
      expect(responseBody.success).toBe(true);
      expect(responseBody.hasActiveMusic).toBe(false);
      expect(responseBody.timestamp).toBeDefined();
      expect(responseBody.status).toBeNull();

      expect(mockVKApiService.getStatus).toHaveBeenCalledTimes(1);
      expect(mockDatabaseService.saveListeningSession).not.toHaveBeenCalled();
    });
  });

  describe('Сценарии с ошибками', () => {
    test('Ошибка VK API - возвращается 500', async () => {
      // Arrange
      mockVKApiService.getStatus.mockRejectedValue(new Error('VK API Error'));

      // Act
      const result = await handler({}, {});

      // Assert
      expect(result.statusCode).toBe(500);
      const responseBody = JSON.parse(result.body);
      expect(responseBody.success).toBe(false);
      expect(responseBody.error).toBe('VK API Error');
      expect(responseBody.timestamp).toBeDefined();

      expect(mockVKApiService.getStatus).toHaveBeenCalledTimes(1);
      expect(mockDatabaseService.saveListeningSession).not.toHaveBeenCalled();
    });

    test('Ошибка сохранения в БД - функция не падает, но логируется ошибка', async () => {
      // Arrange
      const mockStatus = {
        status_audio: {
          id: 456240381,
          owner_id: 456240381,
          artist: 'The Weeknd',
          title: 'Blinding Lights'
        }
      };

      mockVKApiService.getStatus.mockResolvedValue(mockStatus);
      mockDatabaseService.saveListeningSession.mockRejectedValue(new Error('Database Error'));

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

      expect(mockVKApiService.getStatus).toHaveBeenCalledTimes(1);
      expect(mockDatabaseService.saveListeningSession).toHaveBeenCalledTimes(1);
    });
  });

  describe('Валидация данных', () => {
    test('Проверка валидации всех типов данных', () => {
      // Валидные данные
      expect(ValidatorService.isValidAudioStatus({
        id: 123,
        owner_id: 456,
        artist: 'Artist',
        title: 'Title'
      })).toBe(true);

      // Невалидные данные
      expect(ValidatorService.isValidAudioStatus(null)).toBeFalsy();
      expect(ValidatorService.isValidAudioStatus(undefined)).toBeFalsy();
      expect(ValidatorService.isValidAudioStatus({})).toBeFalsy();
      expect(ValidatorService.isValidAudioStatus({
        id: 'not_a_number',
        owner_id: 456,
        artist: 'Artist',
        title: 'Title'
      })).toBeFalsy();
      expect(ValidatorService.isValidAudioStatus({
        id: 123,
        owner_id: 456,
        artist: '',
        title: 'Title'
      })).toBeFalsy();
      expect(ValidatorService.isValidAudioStatus({
        id: 123,
        owner_id: 456,
        artist: 'Artist',
        title: ''
      })).toBeFalsy();
    });
  });
}); 