// Конфигурация для VK Wrapped

export const CONFIG = {
  USER_ID: process.env.USER_ID!,
  SERVICE_TOKEN: process.env.SERVICE_TOKEN!,
  VK_API_VERSION: process.env.VK_API_VERSION!,
  VK_API_FIELDS: process.env.VK_API_FIELDS!,
  USER_AGENT: process.env.USER_AGENT!
} as const; 