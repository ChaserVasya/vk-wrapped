# VK Wrapped Function

Yandex Cloud Function для отслеживания прослушивания музыки в VK.

## Описание

Функция автоматически опрашивает VK API каждую минуту для получения статуса прослушивания музыки пользователем и сохраняет данные о сессиях в Yandex Database.

## Структура проекта

```
functions/
├── src/
│   ├── services/
│   │   ├── database.ts      # Работа с Yandex Database
│   │   ├── logger.ts        # Логирование
│   │   ├── status-processor.ts  # Обработка статуса
│   │   └── vk-api.ts        # VK API клиент
│   ├── types.ts             # Типы данных
│   └── index.ts             # Основная функция
├── read-db-universal.ts     # Локальный скрипт для чтения БД
├── env                      # Переменные окружения
└── deploy.sh               # Скрипт деплоя
```

## Локальный скрипт для чтения БД

### Назначение

Скрипт `read-db-universal.ts` предназначен для локального чтения данных из Yandex Database без необходимости деплоя отдельной функции. Это позволяет:

- ✅ Тестировать и отлаживать данные локально
- ✅ Проверять активные и завершенные сессии
- ✅ Анализировать данные без доступа к логам функции
- ✅ Использовать тот же код, что и в основной функции

### Использование

1. **Убедитесь, что токен актуален:**

   ```bash
   yc iam create-token
   ```

2. **Обновите токен в файле .env:**

   ```bash
   sed -i '' 's/YDB_TOKEN=.*/YDB_TOKEN=НОВЫЙ_ТОКЕН/' .env
   ```

3. **Запустите скрипт:**

   ```bash
   ts-node read-db-universal.ts
   ```

### Что показывает скрипт

- 📊 **Активные сессии** - текущие сессии прослушивания
- 📊 **Завершенные сессии** - завершенные сессии с датами и длительностью
- ⏱️ **Длительность сессий** - в минутах
- 📅 **Даты начала и окончания** - в локальном времени

### Пример вывода

```
🔍 Starting universal database reader...
📊 Environment check:
  Endpoint: grpcs://ydb.serverless.yandexcloud.net:2135
  Database: /ru-central1/b1gs9ka9aldijuamlfr7/etn3k2hemgr6nk2h3l4m
  Token: ✅ Found
⏳ Waiting for driver to be ready...
✅ Driver is ready
📊 Reading current sessions...
✅ Found 0 current sessions
📊 Reading completed sessions...
✅ Found 0 completed sessions

📋 Current Sessions:
  No active sessions found

📋 Completed Sessions:
  No completed sessions found
✅ Database reading completed successfully
```

## Деплой

```bash
./deploy.sh
```

## Мониторинг

- **Логи функции:** `yc serverless function logs vk-wrapped-poller`
- **Тестирование функции:** `yc serverless function invoke vk-wrapped-poller`
- **Статус функции:** `yc serverless function get vk-wrapped-poller`

## Конфигурация

Основные переменные окружения в файле `env`:

- `USER_ID` - ID пользователя VK для отслеживания
- `SERVICE_TOKEN` - токен VK API
- `YDB_ENDPOINT` - endpoint Yandex Database
- `YDB_DATABASE_PATH` - путь к базе данных
- `YDB_TOKEN` - токен для локального доступа к БД
