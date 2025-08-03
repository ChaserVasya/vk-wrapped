import { DatabaseService } from '../services/database';
import { TrackSession } from '../types';

// Мокаем ydb-sdk
jest.mock('ydb-sdk', () => ({
    Driver: jest.fn().mockImplementation(() => ({
        ready: jest.fn().mockResolvedValue(true),
        tableClient: {
            withSession: jest.fn()
        }
    })),
    MetadataAuthService: jest.fn()
}));

// Мокаем LoggerService
jest.mock('../services/logger');

describe('finishAllActiveSessions Tests', () => {
    let databaseService: DatabaseService;
    let mockSession: any;

    beforeEach(() => {
        jest.clearAllMocks();

        // Создаем мок для session
        mockSession = {
            executeQuery: jest.fn()
        };

        // Мокаем withSession чтобы возвращать наш мок
        const mockDriver = {
            ready: jest.fn().mockResolvedValue(true),
            tableClient: {
                withSession: jest.fn().mockImplementation((callback) => callback(mockSession))
            }
        };

        // Создаем реальный экземпляр DatabaseService с моком драйвера
        databaseService = new DatabaseService({} as any);
        (databaseService as any).driver = mockDriver;
    });

    describe('finishAllActiveSessions - успешные сценарии', () => {
        test('должен корректно завершить одну активную сессию', async () => {
            // Arrange
            const mockActiveSessions: TrackSession[] = [
                {
                    full_id: '206942551_456240388',
                    first_observed: new Date('2025-08-03T19:21:27.000Z'),
                    last_seen: new Date('2025-08-03T19:21:27.000Z')
                }
            ];

            // Мокаем getAllCurrentSessions
            jest.spyOn(databaseService, 'getAllCurrentSessions').mockResolvedValue(mockActiveSessions);

            // Мокаем успешное выполнение запросов
            mockSession.executeQuery.mockResolvedValue({ resultSets: [] });

            // Act
            await databaseService.finishAllActiveSessions();

            // Assert
            expect(databaseService.getAllCurrentSessions).toHaveBeenCalledWith();
            expect(mockSession.executeQuery).toHaveBeenCalledTimes(2);

            // Проверяем UPSERT запрос
            const upsertCall = mockSession.executeQuery.mock.calls[0][0];
            expect(upsertCall).toContain('UPSERT INTO completed_sessions');
            expect(upsertCall).toContain('206942551_456240388');
            // Проверяем что timestamp конвертируется правильно (не Math.floor в строке, а уже вычисленное значение)
            expect(upsertCall).toMatch(/1754248887/);

            // Проверяем DELETE запрос
            const deleteCall = mockSession.executeQuery.mock.calls[1][0];
            expect(deleteCall).toContain('DELETE FROM current_sessions');
        });

        test('должен корректно завершить несколько активных сессий', async () => {
            // Arrange
            const mockActiveSessions: TrackSession[] = [
                {
                    full_id: '206942551_456240388',
                    first_observed: new Date('2025-08-03T19:21:27.000Z'),
                    last_seen: new Date('2025-08-03T19:21:27.000Z')
                },
                {
                    full_id: '206942551_456240389',
                    first_observed: new Date('2025-08-03T19:22:00.000Z'),
                    last_seen: new Date('2025-08-03T19:22:30.000Z')
                }
            ];

            jest.spyOn(databaseService, 'getAllCurrentSessions').mockResolvedValue(mockActiveSessions);
            mockSession.executeQuery.mockResolvedValue({ resultSets: [] });

            // Act
            await databaseService.finishAllActiveSessions();

            // Assert
            expect(mockSession.executeQuery).toHaveBeenCalledTimes(2);

            // Проверяем что в UPSERT запросе есть обе сессии
            const upsertCall = mockSession.executeQuery.mock.calls[0][0];
            expect(upsertCall).toContain('206942551_456240388');
            expect(upsertCall).toContain('206942551_456240389');
        });

        test('должен корректно обработать сессии без активных сессий', async () => {
            // Arrange
            jest.spyOn(databaseService, 'getAllCurrentSessions').mockResolvedValue([]);
            mockSession.executeQuery.mockResolvedValue({ resultSets: [] });

            // Act
            await databaseService.finishAllActiveSessions();

            // Assert
            expect(databaseService.getAllCurrentSessions).toHaveBeenCalledWith();
            expect(mockSession.executeQuery).toHaveBeenCalledTimes(1); // Только DELETE

            // Проверяем что DELETE все равно выполняется
            const deleteCall = mockSession.executeQuery.mock.calls[0][0];
            expect(deleteCall).toContain('DELETE FROM current_sessions');
        });
    });

    describe('finishAllActiveSessions - обработка ошибок', () => {
        test('должен выбросить ошибку при проблемах с драйвером', async () => {
            // Arrange
            const mockDriver = {
                ready: jest.fn().mockResolvedValue(false)
            };
            (databaseService as any).driver = mockDriver;

            // Act & Assert
            await expect(databaseService.finishAllActiveSessions()).rejects.toThrow('Driver has not become ready');
        });

        test('должен выбросить ошибку при проблемах с UPSERT запросом', async () => {
            // Arrange
            const mockActiveSessions: TrackSession[] = [
                {
                    full_id: '206942551_456240388',
                    first_observed: new Date('2025-08-03T19:21:27.000Z'),
                    last_seen: new Date('2025-08-03T19:21:27.000Z')
                }
            ];

            jest.spyOn(databaseService, 'getAllCurrentSessions').mockResolvedValue(mockActiveSessions);
            mockSession.executeQuery.mockRejectedValue(new Error('SQL syntax error'));

            // Act & Assert
            await expect(databaseService.finishAllActiveSessions()).rejects.toThrow('SQL syntax error');
        });

        test('должен выбросить ошибку при проблемах с DELETE запросом', async () => {
            // Arrange
            jest.spyOn(databaseService, 'getAllCurrentSessions').mockResolvedValue([]);

            // DELETE запрос падает
            mockSession.executeQuery.mockRejectedValue(new Error('DELETE failed'));

            // Act & Assert
            await expect(databaseService.finishAllActiveSessions()).rejects.toThrow('DELETE failed');
        });
    });

    describe('mapRowToTrackSession - парсинг данных YDB', () => {
        test('должен корректно парсить валидную строку YDB', () => {
            // Arrange
            const mockRow = {
                items: [
                    { bytesValue: Buffer.from('206942551_456240388').toString('base64') },
                    { uint32Value: 1705312500 },
                    { uint32Value: 1705312560 }
                ]
            };

            // Act
            const result = (databaseService as any).mapRowToTrackSession(mockRow);

            // Assert
            expect(result).toEqual({
                full_id: '206942551_456240388',
                first_observed: new Date(1705312500 * 1000),
                last_seen: new Date(1705312560 * 1000)
            });
        });

        test('должен вернуть null при невалидной структуре строки', () => {
            // Arrange
            const mockRow = { items: [] }; // Недостаточно элементов

            // Act
            const result = (databaseService as any).mapRowToTrackSession(mockRow);

            // Assert
            expect(result).toBeNull();
        });

        test('должен вернуть null при отсутствии bytesValue', () => {
            // Arrange
            const mockRow = {
                items: [
                    { bytesValue: undefined },
                    { uint32Value: 1705312500 },
                    { uint32Value: 1705312560 }
                ]
            };

            // Act
            const result = (databaseService as any).mapRowToTrackSession(mockRow);

            // Assert
            expect(result).toBeNull();
        });

        test('должен вернуть null при отсутствии uint32Value', () => {
            // Arrange
            const mockRow = {
                items: [
                    { bytesValue: Buffer.from('206942551_456240388').toString('base64') },
                    { uint32Value: undefined },
                    { uint32Value: 1705312560 }
                ]
            };

            // Act
            const result = (databaseService as any).mapRowToTrackSession(mockRow);

            // Assert
            expect(result).toBeNull();
        });
    });
}); 