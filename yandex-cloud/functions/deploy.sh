#!/bin/bash

echo "🚀 Deploying VK Wrapped Function with Timer and HTTP triggers..."

# Загрузка переменных окружения
if [ -f "env" ]; then
  echo "📋 Loading environment variables from env file..."
  export $(cat env | grep -v '^#' | xargs)
else
  echo "⚠️  env file not found, using default values"
fi

# Сборка проекта
echo "📦 Building project..."
npm run build

# Создание функции (если не существует)
echo "🔧 Creating function..."
yc serverless function create --name=vk-wrapped-poller --description="VK Status Poller with Timer and HTTP triggers" || echo "Function already exists"

# Создание версии функции
echo "📤 Deploying function version..."
yc serverless function version create \
  --function-name=vk-wrapped-poller \
  --runtime nodejs18 \
  --entrypoint dist/index.handler \
  --memory 128m \
  --execution-timeout 30s \
  --source-path . \
  --environment USER_ID=${USER_ID},SERVICE_TOKEN=${SERVICE_TOKEN},VK_API_VERSION=${VK_API_VERSION},VK_API_FIELDS=${VK_API_FIELDS},USER_AGENT=${USER_AGENT}

# Создание timer триггера
echo "⏰ Creating timer trigger..."
yc serverless trigger create timer vk-poller-timer \
  --cron-expression="* * * * *" \
  --function-name=vk-wrapped-poller \
  --function-tag=latest || echo "Timer trigger already exists"

# Получение HTTP URL функции
echo "🔗 Getting function URL..."
FUNCTION_URL=$(yc serverless function get --name=vk-wrapped-poller --format=json | jq -r '.http_invoke_url')

echo "✅ Function deployed successfully with both triggers!"
echo "⏰ Timer trigger: every minute"
echo "🌐 HTTP trigger: $FUNCTION_URL"
echo ""
echo "📋 Usage:"
echo "1. Timer trigger runs automatically every minute"
echo "2. HTTP trigger for manual testing: curl -X GET $FUNCTION_URL"
echo "3. Check logs: yc serverless function logs vk-wrapped-poller"
echo "4. Test function: yc serverless function invoke vk-wrapped-poller" 