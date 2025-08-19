import { memeHandler } from './meme-handler';

interface Request {
    httpMethod: string;
    path: string;
    queryStringParameters?: Record<string, string>;
    headers?: Record<string, string>;
    body?: string;
}

export async function handler(request: Request): Promise<unknown> {
    return await memeHandler(request);
}
