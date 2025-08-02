// Общие утилиты для тестов

import { VKApiService } from '../services/vk-api';
import { DatabaseService } from '../services/database';

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
    finishAllActiveSessions: jest.fn()
  } as any;

  return {
    vkApiService: mockVKApiService,
    databaseService: mockDatabaseService
  };
}

export function setupMockImplementations(mocks: MockServices): void {
  const { VKApiService: MockedVKApiService } = require('../services/vk-api');
  const { DatabaseService: MockedDatabaseService } = require('../services/database');
  
  MockedVKApiService.mockImplementation(() => mocks.vkApiService);
  MockedDatabaseService.mockImplementation(() => mocks.databaseService);
} 