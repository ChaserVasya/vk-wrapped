import axios from 'axios';
import { VKStatus } from '../types';
import { CONFIG } from '../config';

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
        },
        headers: {
          'User-Agent': CONFIG.USER_AGENT
        }
      });

      return response.data.response[0];
    } catch (error) {
      console.error('Error getting VK status:', error);
      throw error;
    }
  }
} 