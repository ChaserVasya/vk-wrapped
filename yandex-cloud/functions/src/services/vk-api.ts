import axios from 'axios';
import { CONFIG } from '../config';
import { VK_CONFIG } from '../config/vk-config';
import { VKStatus } from '../types';
import { LoggerService } from './logger';

export class VKApiService {
  // Получение статуса VK
  async getStatus(): Promise<VKStatus> {

    try {
      const response = await axios.get(`${VK_CONFIG.API_BASE_URL}/users.get`, {
        params: {
          user_ids: CONFIG.USER_ID,
          fields: CONFIG.VK_API_FIELDS,
          access_token: CONFIG.SERVICE_TOKEN,
          v: CONFIG.VK_API_VERSION
        }
      });

      if (!response.data.response || !response.data.response[0]) {
        const error = new Error('Invalid VK API response: no user data');
        LoggerService.logErrorDetails(error, 'VK API Response Validation');
        throw error;
      }

      const status = response.data.response[0];



      return status;
    } catch (error) {
      LoggerService.logErrorDetails(error, 'VK API Request');
      throw error;
    }
  }
} 