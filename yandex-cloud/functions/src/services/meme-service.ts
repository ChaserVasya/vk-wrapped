import AWS from 'aws-sdk';
import { MemeResponse } from '../types';
import { DatabaseService } from './database';
import { LoggerService } from './logger';

export class MemeService {
    private readonly databaseService: DatabaseService;
    private readonly storageUrl = 'https://storage.yandexcloud.net/vk-wrapped/memes';

    constructor(databaseService: DatabaseService) {
        this.databaseService = databaseService;
    }

    async getMeme(memeId: string): Promise<MemeResponse> {
        try {
            LoggerService.info(`Getting meme ${memeId}`);

            // Проверяем, лайкнут ли этот мем
            const isLiked = await this.isMemeLiked(memeId);

            // Получаем подписанный URL для приватного доступа
            const signedUrl = await this.getSignedUrl(`${memeId}.jpg`);

            return {
                meme_id: memeId,
                url: signedUrl,
                is_liked: isLiked
            };
        } catch (error) {
            LoggerService.logErrorDetails(error, 'MemeService.getMeme');
            throw error;
        }
    }

    private async getSignedUrl(key: string): Promise<string> {
        try {
            const s3 = new AWS.S3({
                endpoint: 'https://storage.yandexcloud.net',
                region: 'ru-central1',
                accessKeyId: process.env.YC_ACCESS_KEY_ID,
                secretAccessKey: process.env.YC_SECRET_ACCESS_KEY,
            });

            const params = {
                Bucket: 'vk-wrapped',
                Key: `memes/${key}`,
                Expires: 3600, // URL действителен 1 час
            };

            const signedUrl = await s3.getSignedUrlPromise('getObject', params);
            LoggerService.info(`Generated signed URL for ${key}`);
            return signedUrl;
        } catch (error) {
            LoggerService.logErrorDetails(error, 'MemeService.getSignedUrl');
            // Fallback к прямому URL если не удалось создать подписанный URL
            return `${this.storageUrl}/${key}`;
        }
    }

    async toggleMemeLike(memeId: string): Promise<boolean> {
        try {
            LoggerService.info(`Toggling meme like: meme=${memeId}`);

            const isCurrentlyLiked = await this.isMemeLiked(memeId);

            if (isCurrentlyLiked) {
                // Удаляем лайк
                await this.removeMemeLike(memeId);
                LoggerService.info(`Removed like for meme ${memeId}`);
                return false;
            } else {
                // Добавляем лайк
                await this.addMemeLike(memeId);
                LoggerService.info(`Added like for meme ${memeId}`);
                return true;
            }
        } catch (error) {
            LoggerService.logErrorDetails(error, 'MemeService.toggleMemeLike');
            throw error;
        }
    }

    private async isMemeLiked(memeId: string): Promise<boolean> {
        try {
            return await this.databaseService.isMemeLiked(memeId);
        } catch (error) {
            LoggerService.logErrorDetails(error, 'MemeService.isMemeLiked');
            return false;
        }
    }

    private async addMemeLike(memeId: string): Promise<void> {
        try {
            await this.databaseService.addMemeLike(memeId);
        } catch (error) {
            LoggerService.logErrorDetails(error, 'MemeService.addMemeLike');
            throw error;
        }
    }

    private async removeMemeLike(memeId: string): Promise<void> {
        try {
            await this.databaseService.removeMemeLike(memeId);
        } catch (error) {
            LoggerService.logErrorDetails(error, 'MemeService.removeMemeLike');
            throw error;
        }
    }

    async getLikedMemes(): Promise<string[]> {
        try {
            LoggerService.info(`Getting all liked memes`);
            return await this.databaseService.getLikedMemeIds();
        } catch (error) {
            LoggerService.logErrorDetails(error, 'MemeService.getLikedMemes');
            return [];
        }
    }

    async getAvailableMemeIds(): Promise<string[]> {
        try {
            LoggerService.info(`Getting available meme IDs from storage`);

            // Пытаемся использовать AWS SDK для работы с Yandex Storage
            try {
                const s3 = new AWS.S3({
                    endpoint: 'https://storage.yandexcloud.net',
                    region: 'ru-central1',
                    accessKeyId: process.env.YC_ACCESS_KEY_ID,
                    secretAccessKey: process.env.YC_SECRET_ACCESS_KEY,
                });

                // Получаем список объектов в папке memes
                const listParams = {
                    Bucket: 'vk-wrapped',
                    Prefix: 'memes/',
                    MaxKeys: 1000
                };

                const result = await s3.listObjectsV2(listParams).promise();

                if (!result.Contents) {
                    LoggerService.info(`No meme files found in storage`);
                    return this.getFallbackMemeIds();
                }

                // Извлекаем ID мемов из имен файлов
                const memeIds = result.Contents
                    .map(obj => obj.Key)
                    .filter(key => key && key.startsWith('memes/') && key.endsWith('.jpg'))
                    .map(key => key!.replace('memes/', '').replace('.jpg', ''))
                    .filter(id => !isNaN(parseInt(id, 10)))
                    .sort((a, b) => parseInt(a, 10) - parseInt(b, 10));

                LoggerService.info(`Found ${memeIds.length} memes in storage: ${memeIds.join(', ')}`);
                return memeIds;
            } catch (storageError) {
                LoggerService.info(`Failed to read from storage: ${storageError}`);
                return this.getFallbackMemeIds();
            }
        } catch (error) {
            LoggerService.logErrorDetails(error, 'MemeService.getAvailableMemeIds');
            return this.getFallbackMemeIds();
        }
    }

    private getFallbackMemeIds(): string[] {
        LoggerService.info(`Using fallback meme list`);
        // Fallback: используем фиксированный список
        const fallbackIds = [];
        for (let i = 1; i <= 25; i++) {
            fallbackIds.push(i.toString());
        }
        LoggerService.info(`Fallback list contains ${fallbackIds.length} memes`);
        return fallbackIds;
    }
}
