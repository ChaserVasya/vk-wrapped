#!/bin/bash

echo "[INFO] Starting deployment process..."

# Проверка ESLint
echo "[INFO] Running ESLint..."
npm run lint
if [ $? -ne 0 ]; then
  echo "[ERROR] ESLint found errors. Fix them before deployment."
  exit 1
fi

# Проверка синтаксиса TypeScript
echo "[INFO] Checking TypeScript syntax..."
npx tsc --noEmit
if [ $? -ne 0 ]; then
  echo "[ERROR] TypeScript compilation failed"
  exit 1
fi

# Запуск тестов
echo "[INFO] Running tests..."
npm test
if [ $? -ne 0 ]; then
  echo "[ERROR] Tests failed"
  exit 1
fi

# Сборка проекта
echo "[INFO] Building project..."
npm run build
if [ $? -ne 0 ]; then
  echo "[ERROR] Build failed"
  exit 1
fi
# https://github.com/yandex-cloud-examples/yc-ydb-connect-from-serverless-function/blob/main/deploy/create-func-ver.sh
# Копируем package.json в dist для правильной работы
echo "[INFO] Copying package.json to dist..."
cp package.json dist/

# Создаем ZIP архив из dist
echo "[INFO] Creating ZIP archive from dist..."
cd dist
zip -r ../func.zip .
cd ..

# Деплой в Yandex Cloud Functions
echo "[INFO] Deploying to Yandex Cloud Functions..."

# Читаем переменные из .prod.env файла
ENV_VARS=$(./parse-env.sh .prod.env)

yc serverless function version create \
  --function-name=vk-wrapped-poller \
  --runtime=nodejs18 \
  --entrypoint=index.handler \
  --memory=128m \
  --execution-timeout=30s \
  --source-path=func.zip \
  --environment="$ENV_VARS" \
  --service-account-id=ajeup5brgovjbs8ok57u

if [ $? -eq 0 ]; then
  echo "[INFO] Deployment completed successfully!"
else
  echo "[ERROR] Deployment failed"
  exit 1
fi 