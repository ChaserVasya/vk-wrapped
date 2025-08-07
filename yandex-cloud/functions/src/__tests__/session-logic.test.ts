// Мокаем модули перед импортом
jest.mock('../services/vk-api');
jest.mock('../services/database');

import { handler } from '../index';
import { createMockServices, MockServices, setupMockImplementations } from './test-utils';

describe('Session Logic Tests', () => {
  let mocks: MockServices;

  beforeEach(() => {
    jest.clearAllMocks();

    // Создаем моки сервисов
    mocks = createMockServices();
    setupMockImplementations(mocks);
  });

  describe('Логика создания и обновления активных сессий', () => {
    test('getActiveSession возвращает null - создается новая сессия', async () => {
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
      mocks.databaseService.getAllCurrentSessions.mockResolvedValue([]); // Нет активных сессий

      // Act
      const result = await handler();

      // Assert
      expect(result.statusCode).toBe(200);
      const responseBody = JSON.parse(result.body);
      expect(responseBody.status).toBe('success');
      expect(mocks.databaseService.getActiveSession).toHaveBeenCalledWith('456240381_456240381');
      expect(mocks.databaseService.createActiveSession).toHaveBeenCalledWith('456240381_456240381');
      expect(mocks.databaseService.updateActiveSession).not.toHaveBeenCalled();
    });

    test('getActiveSession возвращает валидный объект - обновляется сессия', async () => {
      // Arrange
      const mockStatus = {
        status_audio: {
          id: 456240381,
          owner_id: 456240381,
          artist: 'The Weeknd',
          title: 'Blinding Lights'
        }
      };

      const activeSession = {
        full_id: '456240381_456240381',
        first_observed: new Date('2024-01-15T10:15:00Z'),
        last_seen: new Date('2024-01-15T10:20:00Z')
      };

      mocks.vkApiService.getStatus.mockResolvedValue(mockStatus);
      mocks.databaseService.getActiveSession.mockResolvedValue(activeSession);
      mocks.databaseService.updateActiveSession.mockResolvedValue();
      mocks.databaseService.getAllCurrentSessions.mockResolvedValue([]); // Нет активных сессий

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

    test('getActiveSession возвращает объект с невалидными датами - создается новая сессия', async () => {
      // Arrange
      const mockStatus = {
        status_audio: {
          id: 456240381,
          owner_id: 456240381,
          artist: 'The Weeknd',
          title: 'Blinding Lights'
        }
      };

      // Объект с невалидными датами - используем NaN значения
      const invalidActiveSession = {
        full_id: '456240381_456240381',
        first_observed: new Date(NaN),
        last_seen: new Date(NaN)
      };

      mocks.vkApiService.getStatus.mockResolvedValue(mockStatus);
      mocks.databaseService.getActiveSession.mockResolvedValue(invalidActiveSession);
      mocks.databaseService.createActiveSession.mockResolvedValue();
      mocks.databaseService.getAllCurrentSessions.mockResolvedValue([]); // Нет активных сессий

      // Act
      const result = await handler();

      // Assert
      expect(result.statusCode).toBe(200);
      const responseBody = JSON.parse(result.body);
      expect(responseBody.status).toBe('success');
      expect(mocks.databaseService.getActiveSession).toHaveBeenCalledWith('456240381_456240381');
      // Проверяем что createActiveSession вызывается вместо updateActiveSession
      expect(mocks.databaseService.createActiveSession).toHaveBeenCalledWith('456240381_456240381');
      expect(mocks.databaseService.updateActiveSession).not.toHaveBeenCalled();
    });
  });

  describe('Логика смены треков', () => {
    test('Смена трека - создается новая активная сессия', async () => {
      // Arrange
      const mockStatus = {
        status_audio: {
          id: 789123456,
          owner_id: 789123456,
          artist: 'Dua Lipa',
          title: 'Levitating'
        }
      };

      // Предыдущая сессия была для другого трека
      mocks.vkApiService.getStatus.mockResolvedValue(mockStatus);
      mocks.databaseService.getActiveSession.mockResolvedValue(null); // Нет активной сессии для нового трека
      mocks.databaseService.createActiveSession.mockResolvedValue();
      mocks.databaseService.getAllCurrentSessions.mockResolvedValue([
        { full_id: '456240381_456240381', first_observed: new Date(), last_seen: new Date() }
      ]); // Есть другие активные сессии
      mocks.databaseService.finishAllActiveSessions.mockResolvedValue(); // Завершение предыдущих сессий

      // Act
      const result = await handler();

      // Assert
      expect(result.statusCode).toBe(200);
      expect(mocks.databaseService.getActiveSession).toHaveBeenCalledWith('789123456_789123456');
      expect(mocks.databaseService.createActiveSession).toHaveBeenCalledWith('789123456_789123456');
      expect(mocks.databaseService.updateActiveSession).not.toHaveBeenCalled();
    });

    test('Возврат к предыдущему треку - создается новая активная сессия', async () => {
      // Arrange
      const mockStatus = {
        status_audio: {
          id: 456240381,
          owner_id: 456240381,
          artist: 'The Weeknd',
          title: 'Blinding Lights'
        }
      };

      // Возвращаемся к первому треку
      mocks.vkApiService.getStatus.mockResolvedValue(mockStatus);
      mocks.databaseService.getActiveSession.mockResolvedValue(null); // Нет активной сессии
      mocks.databaseService.createActiveSession.mockResolvedValue();
      mocks.databaseService.getAllCurrentSessions.mockResolvedValue([
        { full_id: '789123456_789123456', first_observed: new Date(), last_seen: new Date() }
      ]); // Есть другие активные сессии
      mocks.databaseService.finishAllActiveSessions.mockResolvedValue(); // Завершение предыдущих сессий

      // Act
      const result = await handler();

      // Assert
      expect(result.statusCode).toBe(200);
      expect(mocks.databaseService.getActiveSession).toHaveBeenCalledWith('456240381_456240381');
      expect(mocks.databaseService.createActiveSession).toHaveBeenCalledWith('456240381_456240381');
    });
  });

  describe('Завершение сессий при отсутствии музыки', () => {
    test('Нет музыки - завершаются все активные сессии', async () => {
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
      expect(mocks.databaseService.getActiveSession).not.toHaveBeenCalled();
      expect(mocks.databaseService.createActiveSession).not.toHaveBeenCalled();
      expect(mocks.databaseService.updateActiveSession).not.toHaveBeenCalled();
      expect(mocks.databaseService.finishAllActiveSessions).toHaveBeenCalledTimes(1);
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
      expect(mocks.databaseService.getActiveSession).not.toHaveBeenCalled();
      expect(mocks.databaseService.createActiveSession).not.toHaveBeenCalled();
      expect(mocks.databaseService.updateActiveSession).not.toHaveBeenCalled();
      expect(mocks.databaseService.finishAllActiveSessions).toHaveBeenCalledTimes(1);
    });
  });

  describe('Переходы состояний', () => {
    test('Есть музыка → Нет музыки → Есть та же музыка (возврат к треку)', async () => {
      // Arrange - сначала есть музыка
      const mockStatusWithMusic = {
        status_audio: {
          id: 456240381,
          owner_id: 456240381,
          artist: 'The Weeknd',
          title: 'Blinding Lights'
        }
      };

      const mockStatusNoMusic = {
        status_audio: undefined
      };

      // Первый поллинг - есть музыка
      mocks.vkApiService.getStatus.mockResolvedValue(mockStatusWithMusic);
      mocks.databaseService.getActiveSession.mockResolvedValue(null);
      mocks.databaseService.createActiveSession.mockResolvedValue();
      mocks.databaseService.getAllCurrentSessions.mockResolvedValue([]); // Нет активных сессий

      await handler();

      // Второй поллинг - нет музыки
      mocks.vkApiService.getStatus.mockResolvedValue(mockStatusNoMusic);
      mocks.databaseService.finishAllActiveSessions.mockResolvedValue();
      jest.clearAllMocks();

      await handler();

      // Третий поллинг - снова есть та же музыка
      mocks.vkApiService.getStatus.mockResolvedValue(mockStatusWithMusic);
      mocks.databaseService.getActiveSession.mockResolvedValue(null); // Нет активной сессии (завершилась)
      mocks.databaseService.createActiveSession.mockResolvedValue();
      mocks.databaseService.getAllCurrentSessions.mockResolvedValue([]); // Нет активных сессий

      const result = await handler();

      // Assert
      expect(result.statusCode).toBe(200);
      expect(mocks.databaseService.getActiveSession).toHaveBeenCalledWith('456240381_456240381');
      expect(mocks.databaseService.createActiveSession).toHaveBeenCalledWith('456240381_456240381');
    });

    test('Есть музыка → Нет музыки → Есть другая музыка (смена трека)', async () => {
      // Arrange - сначала есть музыка
      const mockStatusFirstMusic = {
        status_audio: {
          id: 456240381,
          owner_id: 456240381,
          artist: 'The Weeknd',
          title: 'Blinding Lights'
        }
      };

      const mockStatusNoMusic = {
        status_audio: undefined
      };

      const mockStatusSecondMusic = {
        status_audio: {
          id: 789123456,
          owner_id: 789123456,
          artist: 'Dua Lipa',
          title: 'Levitating'
        }
      };

      // Первый поллинг - есть музыка
      mocks.vkApiService.getStatus.mockResolvedValue(mockStatusFirstMusic);
      mocks.databaseService.getActiveSession.mockResolvedValue(null);
      mocks.databaseService.createActiveSession.mockResolvedValue();
      mocks.databaseService.getAllCurrentSessions.mockResolvedValue([]); // Нет активных сессий

      await handler();

      // Второй поллинг - нет музыки
      mocks.vkApiService.getStatus.mockResolvedValue(mockStatusNoMusic);
      mocks.databaseService.finishAllActiveSessions.mockResolvedValue();
      jest.clearAllMocks();

      await handler();

      // Третий поллинг - есть другая музыка
      mocks.vkApiService.getStatus.mockResolvedValue(mockStatusSecondMusic);
      mocks.databaseService.getActiveSession.mockResolvedValue(null); // Нет активной сессии
      mocks.databaseService.createActiveSession.mockResolvedValue();
      mocks.databaseService.getAllCurrentSessions.mockResolvedValue([]); // Нет активных сессий

      const result = await handler();

      // Assert
      expect(result.statusCode).toBe(200);
      expect(mocks.databaseService.getActiveSession).toHaveBeenCalledWith('789123456_789123456');
      expect(mocks.databaseService.createActiveSession).toHaveBeenCalledWith('789123456_789123456');
    });

    test('Нет музыки → Есть музыка (начало прослушивания)', async () => {
      // Arrange - сначала нет музыки
      const mockStatusNoMusic = {
        status_audio: undefined
      };

      const mockStatusWithMusic = {
        status_audio: {
          id: 456240381,
          owner_id: 456240381,
          artist: 'The Weeknd',
          title: 'Blinding Lights'
        }
      };

      // Первый поллинг - нет музыки
      mocks.vkApiService.getStatus.mockResolvedValue(mockStatusNoMusic);
      mocks.databaseService.finishAllActiveSessions.mockResolvedValue();

      await handler();

      // Второй поллинг - есть музыка
      mocks.vkApiService.getStatus.mockResolvedValue(mockStatusWithMusic);
      mocks.databaseService.getActiveSession.mockResolvedValue(null); // Нет активной сессии
      mocks.databaseService.createActiveSession.mockResolvedValue();
      mocks.databaseService.getAllCurrentSessions.mockResolvedValue([]); // Нет активных сессий

      const result = await handler();

      // Assert
      expect(result.statusCode).toBe(200);
      expect(mocks.databaseService.getActiveSession).toHaveBeenCalledWith('456240381_456240381');
      expect(mocks.databaseService.createActiveSession).toHaveBeenCalledWith('456240381_456240381');
    });
  });

  describe('Обработка ошибок БД', () => {
    test('Ошибка при получении активной сессии - функция возвращает 500', async () => {
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
      mocks.databaseService.getActiveSession.mockRejectedValue(new Error('DB Error'));
      mocks.databaseService.getAllCurrentSessions.mockResolvedValue([]); // Нет активных сессий

      // Act
      const result = await handler();

      // Assert
      expect(result.statusCode).toBe(500);
      expect(mocks.databaseService.getActiveSession).toHaveBeenCalledWith('456240381_456240381');
      expect(mocks.databaseService.createActiveSession).not.toHaveBeenCalled();
      expect(mocks.databaseService.updateActiveSession).not.toHaveBeenCalled();
    });

    test('Ошибка при создании активной сессии - функция возвращает 500', async () => {
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
      mocks.databaseService.createActiveSession.mockRejectedValue(new Error('DB Error'));
      mocks.databaseService.getAllCurrentSessions.mockResolvedValue([]); // Нет активных сессий

      // Act
      const result = await handler();

      // Assert
      expect(result.statusCode).toBe(500);
      expect(mocks.databaseService.getActiveSession).toHaveBeenCalledWith('456240381_456240381');
      expect(mocks.databaseService.createActiveSession).toHaveBeenCalledWith('456240381_456240381');
    });

    test('Ошибка при завершении всех сессий - функция возвращает 500', async () => {
      // Arrange
      const mockStatus = {
        status_audio: undefined
      };

      mocks.vkApiService.getStatus.mockResolvedValue(mockStatus);
      mocks.databaseService.finishAllActiveSessions.mockRejectedValue(new Error('DB Error'));

      // Act
      const result = await handler();

      // Assert
      expect(result.statusCode).toBe(500);
      expect(mocks.databaseService.finishAllActiveSessions).toHaveBeenCalledTimes(1);
    });
  });
}); 