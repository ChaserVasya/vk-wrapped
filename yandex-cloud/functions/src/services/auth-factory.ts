import { IAuthService, MetadataAuthService, TokenAuthService } from 'ydb-sdk';
import { LoggerService } from './logger';

export class AuthFactory {
    static createAuthService(): IAuthService {
        // Если есть токен в переменных окружения, используем TokenAuthService
        if (process.env.YDB_TOKEN) {
            LoggerService.debug('Using TokenAuthService for local development');
            return new TokenAuthService(process.env.YDB_TOKEN);
        }

        // Иначе используем MetadataAuthService для облака
        LoggerService.debug('Using MetadataAuthService for cloud environment');
        return new MetadataAuthService();
    }
}
