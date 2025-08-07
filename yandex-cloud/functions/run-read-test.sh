#!/bin/bash

echo "[INFO] Локальный запуск read-db с тестовыми данными..."

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

# Запускаем read-db с тестовыми данными
echo "[INFO] Запуск read-db..."
node -e "
require('./dist/read-db.js').handler()
  .then(r => {
    console.log('✅ Успешно прочитано:');
    console.log('Status Code:', r.statusCode);
    console.log('Body:', r.body);
  })
  .catch(e => {
    console.error('❌ Ошибка:', e.message);
    process.exit(1);
  })
"

echo "[INFO] Запуск завершен"
