import { IAuthService, MetadataAuthService, TokenAuthService } from 'ydb-sdk';

export class AuthFactory {
    static createAuthService(): IAuthService {
        // Если есть токен в переменных окружения, используем TokenAuthService
        if (process.env.YDB_TOKEN) {
            console.log('[DEBUG] Using TokenAuthService for local development');
            return new TokenAuthService(process.env.YDB_TOKEN);
        }

        // Иначе используем MetadataAuthService для облака
        console.log('[DEBUG] Using MetadataAuthService for cloud environment');
        return new MetadataAuthService();
    }
}
