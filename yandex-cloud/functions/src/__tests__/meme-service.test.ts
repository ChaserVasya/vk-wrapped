import { AuthFactory } from '../services/auth-factory';
import { DatabaseService } from '../services/database';
import { MemeService } from '../services/meme-service';

// Мокаем DatabaseService
jest.mock('../services/database');
jest.mock('../services/auth-factory');

describe('MemeService', () => {
    let memeService: MemeService;
    let mockDatabaseService: jest.Mocked<DatabaseService>;

    beforeEach(() => {
        // Создаем мок для DatabaseService
        mockDatabaseService = {
            close: jest.fn(),
            getActiveSession: jest.fn(),
            createActiveSession: jest.fn(),
            updateActiveSession: jest.fn(),
            finishAllActiveSessions: jest.fn(),
            getActiveSessions: jest.fn(),
            getAllCurrentSessions: jest.fn(),
            getCompletedSessions: jest.fn(),
            isMemeLiked: jest.fn(),
            addMemeLike: jest.fn(),
            removeMemeLike: jest.fn(),
            getLikedMemeIds: jest.fn(),
        } as unknown as jest.Mocked<DatabaseService>;

        // Мокаем AuthFactory
        (AuthFactory.createAuthService as jest.Mock).mockReturnValue({});

        memeService = new MemeService(mockDatabaseService);
    });

    afterEach(() => {
        jest.clearAllMocks();
    });

    describe('getMeme', () => {
        it('should return meme with like status when meme is not liked', async () => {
            // Мокаем что мем не лайкнут
            mockDatabaseService.isMemeLiked.mockResolvedValue(false);

            const result = await memeService.getMeme('1');

            expect(result).toEqual({
                meme_id: '1',
                url: 'https://storage.yandexcloud.net/vk-wrapped/memes/1.jpg',
                is_liked: false
            });

            expect(mockDatabaseService.isMemeLiked).toHaveBeenCalledWith('1');
        });

        it('should return meme with like status when meme is liked', async () => {
            // Мокаем что мем лайкнут
            mockDatabaseService.isMemeLiked.mockResolvedValue(true);

            const result = await memeService.getMeme('1');

            expect(result).toEqual({
                meme_id: '1',
                url: 'https://storage.yandexcloud.net/vk-wrapped/memes/1.jpg',
                is_liked: true
            });
        });
    });

    describe('toggleMemeLike', () => {
        it('should add like when meme is not liked', async () => {
            // Мокаем что мем не лайкнут
            mockDatabaseService.isMemeLiked.mockResolvedValue(false);
            mockDatabaseService.addMemeLike.mockResolvedValue();

            const result = await memeService.toggleMemeLike('1');

            expect(result).toBe(true);
            expect(mockDatabaseService.addMemeLike).toHaveBeenCalledWith('1');
        });

        it('should remove like when meme is already liked', async () => {
            // Мокаем что мем уже лайкнут
            mockDatabaseService.isMemeLiked.mockResolvedValue(true);
            mockDatabaseService.removeMemeLike.mockResolvedValue();

            const result = await memeService.toggleMemeLike('1');

            expect(result).toBe(false);
            expect(mockDatabaseService.removeMemeLike).toHaveBeenCalledWith('1');
        });
    });

    describe('getLikedMemes', () => {
        it('should return list of liked meme IDs', async () => {
            // Мокаем результат запроса
            mockDatabaseService.getLikedMemeIds.mockResolvedValue(['1', '5', '10']);

            const result = await memeService.getLikedMemes();

            expect(result).toEqual(['1', '5', '10']);
            expect(mockDatabaseService.getLikedMemeIds).toHaveBeenCalled();
        });

        it('should return empty array when no memes are liked', async () => {
            mockDatabaseService.getLikedMemeIds.mockResolvedValue([]);

            const result = await memeService.getLikedMemes();

            expect(result).toEqual([]);
        });
    });

    describe('error handling', () => {
        it('should handle database errors gracefully', async () => {
            mockDatabaseService.getLikedMemeIds.mockRejectedValue(new Error('Database error'));

            const result = await memeService.getLikedMemes();

            expect(result).toEqual([]);
        });

        it('should handle error for toggle like when database fails', async () => {
            mockDatabaseService.isMemeLiked.mockRejectedValue(new Error('Database error'));

            const result = await memeService.toggleMemeLike('1');

            expect(result).toBe(true); // isMemeLiked возвращает false при ошибке, поэтому добавляется лайк
        });
    });
});
