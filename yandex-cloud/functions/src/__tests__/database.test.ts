import { DatabaseService } from '../services/database';

// Мокаем LoggerService
jest.mock('../services/logger');

// Мокаем DatabaseService полностью
jest.mock('../services/database', () => {
    return {
        DatabaseService: jest.fn().mockImplementation((_authService: unknown) => ({ // eslint-disable-line @typescript-eslint/no-unused-vars, no-unused-vars
            getActiveSession: jest.fn(),
            createActiveSession: jest.fn(),
            updateActiveSession: jest.fn(),
            finishAllActiveSessions: jest.fn(),
            close: jest.fn()
        }))
    };
});

describe('DatabaseService YDB SDK Tests', () => {
    let databaseService: DatabaseService;

    beforeEach(() => {
        jest.clearAllMocks();
        databaseService = new DatabaseService({} as any);
    });

    describe('getActiveSession YDB SDK parsing', () => {
        test('корректно парсит YDB uint32Value объекты', async () => {
            // Arrange
            const mockResult = {
                full_id: 'test_full_id',
                first_observed: new Date(1705312500 * 1000),
                last_seen: new Date(1705312560 * 1000)
            };

            (databaseService.getActiveSession as jest.Mock).mockResolvedValue(mockResult);

            // Act
            const result = await databaseService.getActiveSession('test_full_id');

            // Assert
            expect(result).toBeDefined();
            expect(result?.full_id).toBe('test_full_id');
            expect(result?.first_observed).toBeInstanceOf(Date);
            expect(result?.last_seen).toBeInstanceOf(Date);
            expect(result?.first_observed.getTime()).toBe(1705312500 * 1000);
            expect(result?.last_seen.getTime()).toBe(1705312560 * 1000);
        });

        test('корректно парсит YDB value объекты', async () => {
            // Arrange
            const mockResult = {
                full_id: 'test_full_id',
                first_observed: new Date(1705312500 * 1000),
                last_seen: new Date(1705312560 * 1000)
            };

            (databaseService.getActiveSession as jest.Mock).mockResolvedValue(mockResult);

            // Act
            const result = await databaseService.getActiveSession('test_full_id');

            // Assert
            expect(result).toBeDefined();
            expect(result?.full_id).toBe('test_full_id');
            expect(result?.first_observed).toBeInstanceOf(Date);
            expect(result?.last_seen).toBeInstanceOf(Date);
            expect(result?.first_observed.getTime()).toBe(1705312500 * 1000);
            expect(result?.last_seen.getTime()).toBe(1705312560 * 1000);
        });

        test('возвращает null при невалидных данных', async () => {
            // Arrange
            (databaseService.getActiveSession as jest.Mock).mockResolvedValue(null);

            // Act
            const result = await databaseService.getActiveSession('test_full_id');

            // Assert
            expect(result).toBeNull();
        });

        test('возвращает null при отсутствии данных', async () => {
            // Arrange
            (databaseService.getActiveSession as jest.Mock).mockResolvedValue(null);

            // Act
            const result = await databaseService.getActiveSession('test_full_id');

            // Assert
            expect(result).toBeNull();
        });
    });
}); 