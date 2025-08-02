import axios from 'axios';
import { CONFIG } from '../config';
import { VKStatus } from '../types';
import { LoggerService } from './logger';

export class VKApiService {
  // Получение статуса VK
  async getStatus(): Promise<VKStatus> {
    try {
      const response = await axios.get('https://api.vk.com/method/users.get', {
        params: {
          user_ids: CONFIG.USER_ID,
          fields: CONFIG.VK_API_FIELDS,
          access_token: CONFIG.SERVICE_TOKEN,
          v: CONFIG.VK_API_VERSION
        }
      });

      if (!response.data.response || !response.data.response[0]) {
        throw new Error('Invalid VK API response: no user data');
      }

      return response.data.response[0];
    } catch (error) {
      LoggerService.logPollingError(error);
      throw error;
    }
  }
} 