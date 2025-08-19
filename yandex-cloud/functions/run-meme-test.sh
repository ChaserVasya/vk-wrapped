#!/bin/bash

echo "[INFO] Локальный запуск meme-db с тестовыми данными..."

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

# Тестируем получение мема дня
echo "[INFO] Тестирование получения мема дня..."
node -e "
const request = {
  httpMethod: 'GET',
  path: '/',
  queryStringParameters: {},
  headers: {},
  body: ''
};

require('./dist/meme-db.js').handler(request)
  .then(r => {
    console.log('✅ Мем дня получен:');
    console.log('Status Code:', r.statusCode);
    console.log('Body:', r.body);
  })
  .catch(e => {
    console.error('❌ Ошибка получения мема дня:', e.message);
    process.exit(1);
  })
"

# Тестируем получение конкретного мема
echo "[INFO] Тестирование получения конкретного мема..."
node -e "
const request = {
  httpMethod: 'GET',
  path: '/',
  queryStringParameters: { meme_id: '10' },
  headers: {},
  body: ''
};

require('./dist/meme-db.js').handler(request)
  .then(r => {
    console.log('✅ Конкретный мем получен:');
    console.log('Status Code:', r.statusCode);
    console.log('Body:', r.body);
  })
  .catch(e => {
    console.error('❌ Ошибка получения конкретного мема:', e.message);
    process.exit(1);
  })
"

# Тестируем получение списка лайков
echo "[INFO] Тестирование получения списка лайков..."
node -e "
const request = {
  httpMethod: 'GET',
  path: '/',
  queryStringParameters: { action: 'likes' },
  headers: {},
  body: ''
};

require('./dist/meme-db.js').handler(request)
  .then(r => {
    console.log('✅ Список лайков получен:');
    console.log('Status Code:', r.statusCode);
    console.log('Body:', r.body);
  })
  .catch(e => {
    console.error('❌ Ошибка получения списка лайков:', e.message);
    process.exit(1);
  })
"

# Тестируем добавление лайка
echo "[INFO] Тестирование добавления лайка..."
node -e "
const request = {
  httpMethod: 'POST',
  path: '/',
  queryStringParameters: { meme_id: '15' },
  headers: {},
  body: ''
};

require('./dist/meme-db.js').handler(request)
  .then(r => {
    console.log('✅ Лайк добавлен:');
    console.log('Status Code:', r.statusCode);
    console.log('Body:', r.body);
  })
  .catch(e => {
    console.error('❌ Ошибка добавления лайка:', e.message);
    process.exit(1);
  })
"

echo "[INFO] Тестирование завершено"
