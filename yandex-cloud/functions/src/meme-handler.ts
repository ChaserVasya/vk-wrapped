import { AuthFactory } from './services/auth-factory';
import { DatabaseService } from './services/database';
import { LoggerService } from './services/logger';
import { MemeService } from './services/meme-service';

interface MemeRequest {
    httpMethod: string;
    path: string;
    queryStringParameters?: Record<string, string>;
    headers?: Record<string, string>;
    body?: string;
}

interface MemeResponse {
    statusCode: number;
    headers: Record<string, string>;
    body: string;
}

export async function memeHandler(request: MemeRequest): Promise<MemeResponse> {
    let databaseService: DatabaseService | null = null;

    try {
        LoggerService.info(`[INFO] Meme handler called: ${request.httpMethod} ${request.path}`);

        // Создаем сервисы
        const authService = AuthFactory.createAuthService();
        databaseService = new DatabaseService(authService);

        const timeout = 10000;
        if (!(await databaseService['driver'].ready(timeout))) {
            throw new Error(`Driver has not become ready in ${timeout}ms!`);
        }

        const memeService = new MemeService(databaseService);

        // Обрабатываем разные HTTP методы
        let result: MemeResponse;
        switch (request.httpMethod) {
            case 'GET':
                result = await handleGetMeme(request, memeService);
                break;
            case 'POST':
                result = await handleToggleLike(request, memeService);
                break;
            default:
                result = createErrorResponse(405, 'Method not allowed');
        }

        // Закрываем соединение
        if (databaseService) {
            await databaseService.close();
        }

        return result;
    } catch (error) {
        LoggerService.logErrorDetails(error, 'Meme Handler');

        // Закрываем соединение в случае ошибки
        if (databaseService) {
            try {
                await databaseService.close();
            } catch (closeError) {
                LoggerService.logErrorDetails(closeError, 'Error closing database connection');
            }
        }

        return createErrorResponse(500, 'Internal server error');
    }
}

async function handleGetMeme(
    request: MemeRequest,
    memeService: MemeService
): Promise<MemeResponse> {
    try {
        const memeId = request.queryStringParameters?.meme_id;
        const action = request.queryStringParameters?.action;

        // Если запрашиваем список лайков
        if (action === 'likes') {
            const likedMemeIds = await memeService.getLikedMemes();
            return createSuccessResponse(likedMemeIds);
        }

        if (!memeId) {
            // Если meme_id не указан, возвращаем мем дня
            const today = new Date();
            const dayOfYear = Math.floor((today.getTime() - new Date(today.getFullYear(), 0, 0).getTime()) / (1000 * 60 * 60 * 24));

            // Получаем список доступных мемов из хранилища
            const availableMemeIds = await memeService.getAvailableMemeIds();
            const totalMemes = availableMemeIds.length;

            if (totalMemes === 0) {
                return createErrorResponse(500, 'No memes available in storage');
            }

            const memeIndex = dayOfYear % totalMemes;
            const memeIdOfDay = availableMemeIds[memeIndex];
            const meme = await memeService.getMeme(memeIdOfDay);

            return createSuccessResponse(meme);
        }

        const meme = await memeService.getMeme(memeId);

        return createSuccessResponse(meme);
    } catch (error) {
        LoggerService.logErrorDetails(error, 'handleGetMeme');
        return createErrorResponse(500, 'Failed to get meme');
    }
}

async function handleToggleLike(
    request: MemeRequest,
    memeService: MemeService
): Promise<MemeResponse> {
    try {
        const memeId = request.queryStringParameters?.meme_id;

        if (!memeId) {
            return createErrorResponse(400, 'Missing meme_id parameter');
        }

        const isLiked = await memeService.toggleMemeLike(memeId);

        return createSuccessResponse({
            meme_id: memeId,
            is_liked: isLiked
        });
    } catch (error) {
        LoggerService.logErrorDetails(error, 'handleToggleLike');
        return createErrorResponse(500, 'Failed to toggle like');
    }
}

function createSuccessResponse(data: unknown): MemeResponse {
    return {
        statusCode: 200,
        headers: {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
            'Access-Control-Allow-Headers': 'Content-Type, X-User-Id'
        },
        body: JSON.stringify(data)
    };
}

function createErrorResponse(statusCode: number, message: string): MemeResponse {
    return {
        statusCode,
        headers: {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
            'Access-Control-Allow-Headers': 'Content-Type, X-User-Id'
        },
        body: JSON.stringify({
            error: message
        })
    };
}
