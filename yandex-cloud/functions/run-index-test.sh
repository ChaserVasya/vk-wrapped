#!/bin/bash

echo "[INFO] Локальный запуск index с тестовыми данными..."

# Загружаем тестовые переменные окружения
echo "[INFO] Загрузка тестовых переменных окружения..."
export $(grep -v '^#' .test.env | xargs)

# Собираем проект
echo "[INFO] Сборка проекта..."
npm run build

if [ $? -ne 0 ]; then
  echo "[ERROR] Сборка не удалась"
  exit 1
fi

# Запускаем index с тестовыми данными с таймаутом
echo "[INFO] Запуск index..."
timeout 30s node -e "
require('./dist/index.js').handler()
  .then(r => {
    console.log('✅ Index функция выполнена:');
    console.log('Status Code:', r.statusCode);
    console.log('Body:', r.body);
    process.exit(0);
  })
  .catch(e => {
    console.error('❌ Ошибка:', e.message);
    process.exit(1);
  })
"

echo "[INFO] Запуск завершен"
