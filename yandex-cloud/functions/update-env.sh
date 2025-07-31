#!/bin/bash

echo "🔄 Updating environment variables for VK Wrapped function..."

# Загрузка переменных окружения
if [ -f "env" ]; then
  echo "📋 Loading environment variables from env file..."
  export $(cat env | grep -v '^#' | xargs)
else
  echo "❌ env file not found!"
  exit 1
fi

# Обновление переменных окружения функции
echo "📤 Updating function environment variables..."
yc serverless function version create \
  --function-name=vk-wrapped-poller \
  --runtime nodejs18 \
  --entrypoint dist/index.handler \
  --memory 128m \
  --execution-timeout 30s \
  --source-path . \
  --environment USER_ID=${USER_ID},SERVICE_TOKEN=${SERVICE_TOKEN},VK_API_VERSION=${VK_API_VERSION},VK_API_FIELDS=${VK_API_FIELDS},USER_AGENT=${USER_AGENT}

echo "✅ Environment variables updated successfully!"
echo "📋 Next steps:"
echo "1. Check function logs: yc serverless function logs vk-wrapped-poller"
echo "2. Test function: yc serverless function invoke vk-wrapped-poller" 