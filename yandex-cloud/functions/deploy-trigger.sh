#!/bin/bash

# Константы
TRIGGER_NAME="vk-wrapped-timer"
FUNCTION_NAME="vk-wrapped-poller"
SERVICE_ACCOUNT_NAME="vk-wrapped-sa"
CRON_EXPRESSION="0/1 * * * ? *"

echo "[INFO] Starting trigger deployment process..."

# Проверяем что функция существует
echo "[INFO] Checking if function exists..."
FUNCTION_ID=$(yc serverless function get --name=$FUNCTION_NAME --format=json | jq -r '.id')
if [ $? -ne 0 ] || [ "$FUNCTION_ID" == "null" ]; then
  echo "[ERROR] Function $FUNCTION_NAME not found"
  exit 1
fi

echo "[INFO] Function found with ID: $FUNCTION_ID"

# Проверяем что Service Account существует
echo "[INFO] Checking if service account exists..."
SA_ID=$(yc iam service-account get --name=$SERVICE_ACCOUNT_NAME --format=json | jq -r '.id')
if [ $? -ne 0 ] || [ "$SA_ID" == "null" ]; then
  echo "[ERROR] Service account $SERVICE_ACCOUNT_NAME not found"
  exit 1
fi

echo "[INFO] Service account found with ID: $SA_ID"

# Удаляем старый триггер если он существует
echo "[INFO] Checking for existing trigger..."
if yc serverless trigger get --name=$TRIGGER_NAME >/dev/null 2>&1; then
  echo "[INFO] Found existing trigger $TRIGGER_NAME, deleting..."
  yc serverless trigger delete --name=$TRIGGER_NAME
  echo "[INFO] Old trigger deleted"
else
  echo "[INFO] No existing trigger found"
fi

# Создаем новый триггер
echo "[INFO] Creating new timer trigger..."

yc serverless trigger create timer $TRIGGER_NAME \
  --cron-expression="$CRON_EXPRESSION" \
  --invoke-function-name=$FUNCTION_NAME \
  --invoke-function-tag=\$latest \
  --invoke-function-service-account-name=$SERVICE_ACCOUNT_NAME

if [ $? -eq 0 ]; then
  echo "[INFO] Trigger deployment completed successfully!"
  echo "[INFO] Trigger will invoke function every minute"
else
  echo "[ERROR] Trigger deployment failed"
  exit 1
fi

# Проверяем что триггер создался
echo "[INFO] Verifying trigger creation..."
TRIGGER_STATUS=$(yc serverless trigger get --name=$TRIGGER_NAME --format=json | jq -r '.status')
if [ "$TRIGGER_STATUS" == "ACTIVE" ]; then
  echo "[INFO] Trigger is ACTIVE and ready to work"
else
  echo "[WARNING] Trigger status is: $TRIGGER_STATUS"
fi

echo "[INFO] Trigger deployment process completed!" 