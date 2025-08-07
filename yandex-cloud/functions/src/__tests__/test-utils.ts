// Общие утилиты для тестов

import { DatabaseService } from '../services/database';
import { VKApiService } from '../services/vk-api';

export interface MockServices {
  vkApiService: jest.Mocked<VKApiService>;
  databaseService: jest.Mocked<DatabaseService>;
}

export function createMockServices(): MockServices {
  const mockVKApiService = {
    getStatus: jest.fn()
  } as any;

  const mockDatabaseService = {
    getActiveSession: jest.fn(),
    createActiveSession: jest.fn(),
    updateActiveSession: jest.fn(),
    finishAllActiveSessions: jest.fn(),
    getAllCurrentSessions: jest.fn(),
    close: jest.fn()
  } as any;

  return {
    vkApiService: mockVKApiService,
    databaseService: mockDatabaseService
  };
}

// Мокаем модули
jest.mock('../services/vk-api');
jest.mock('../services/database');

export function setupMockImplementations(mocks: MockServices): void {
  const { VKApiService } = require('../services/vk-api');
  const { DatabaseService } = require('../services/database');

  VKApiService.mockImplementation(() => mocks.vkApiService);
  DatabaseService.mockImplementation(() => mocks.databaseService);
} 