# VK Wrapped - Yandex Cloud Functions

Система для отслеживания прослушивания музыки в VK с использованием Yandex Cloud Functions и Yandex Database.

## Архитектура

### База данных (Yandex Database)

Система использует две таблицы для эффективного отслеживания сессий прослушивания:

#### 1. `listening_sessions` - Завершенные сессии
```sql
CREATE TABLE listening_sessions (
    full_id String,               -- "owner_id_track_id"
    start Timestamp,              -- время начала сессии
    end Timestamp,                -- время окончания сессии
    PRIMARY KEY (start)
);
```

#### 2. `active_sessions` - Активные сессии
```sql
CREATE TABLE active_sessions (
    full_id String PRIMARY KEY,   -- "owner_id_track_id" (уникальный ключ)
    start Timestamp,              -- время начала сессии
    last_updated Timestamp        -- время последнего обновления
);
```

### Логика работы

1. **Пользователь слушает музыку**:
   - Проверяется наличие активной сессии для трека
   - Если нет - создается новая активная сессия в `active_sessions`
   - Если есть - обновляется `last_updated` в существующей сессии

2. **Пользователь перестал слушать**:
   - Все активные сессии из `active_sessions` перемещаются в `listening_sessions`
   - В `listening_sessions` записывается `start` и `end` время сессии
   - `active_sessions` очищается

3. **Смена трека**:
   - Завершаются все активные сессии (перемещаются в `listening_sessions`)
   - Создается новая активная сессия для нового трека

### Преимущества двухтабличной архитектуры

- **Эффективность запросов**: `active_sessions` всегда содержит мало записей
- **Быстрый поиск**: PRIMARY KEY по `full_id` в активных сессиях
- **Чистота данных**: завершенные сессии отделены от активных
- **Масштабируемость**: активные сессии не растут со временем

## Структура проекта

```
yandex-cloud/
├── functions/
│   ├── src/
│   │   ├── services/
│   │   │   ├── database.ts      # Работа с БД
│   │   │   ├── vk-api.ts        # VK API
│   │   │   ├── status-processor.ts # Логика обработки статуса
│   │   │   ├── validator.ts     # Валидация данных
│   │   │   └── logger.ts        # Логирование
│   │   ├── __tests__/           # Тесты
│   │   ├── config.ts            # Конфигурация
│   │   ├── types.ts             # Типы TypeScript
│   │   ├── utils.ts             # Утилиты
│   │   └── index.ts             # Главная функция
│   ├── deploy.sh                # Скрипт деплоя
│   ├── update-env.sh            # Обновление переменных
│   └── .env                     # Переменные окружения
└── database/
    ├── schema.sql               # Схема БД
    └── setup-db.sh              # Настройка БД
```

## Установка и настройка

### 1. Настройка базы данных

```bash
cd yandex-cloud/database
export YDB_ENDPOINT="your-endpoint"
export YDB_DATABASE_PATH="your-database-path"
export YDB_TOKEN="your-token"
chmod +x setup-db.sh
./setup-db.sh
```

### 2. Настройка функции

```bash
cd yandex-cloud/functions
cp .env.example .env
# Отредактируйте .env файл с вашими данными
```

### 3. Деплой функции

```bash
# Деплой с Timer триггером (каждую минуту)
./deploy.sh timer

# Деплой с HTTP триггером (для тестирования)
./deploy.sh http
```

## Переменные окружения

### VK API
- `USER_ID` - ID пользователя VK
- `SERVICE_TOKEN` - Сервисный токен VK
- `VK_API_VERSION` - Версия VK API (5.131)
- `VK_API_FIELDS` - Поля для запроса (status_audio,status)
- `USER_AGENT` - User-Agent для запросов

### Yandex Database
- `YDB_ENDPOINT` - Эндпоинт YDB
- `YDB_DATABASE_PATH` - Путь к базе данных
- `YDB_TOKEN` - Токен доступа к YDB

## Тестирование

```bash
cd yandex-cloud/functions
npm test
```

Тесты покрывают:
- ✅ Создание и обновление активных сессий
- ✅ Смену треков
- ✅ Завершение сессий при отсутствии музыки
- ✅ Валидацию данных VK API
- ✅ Обработку ошибок

## Мониторинг

Функция логирует все действия:
- 🎵 Активная музыка
- ✅ Создание новых сессий
- 🔄 Обновление сессий
- 🏁 Завершение всех сессий
- ⏳ Отсутствие музыки
- ❌ Ошибки

## Стоимость

При использовании 1 минуты поллинга для активного пользователя (12 часов/день):

### Расчет:
- **Вызовов в день**: 720 (12 часов × 60 минут)
- **Вызовов в месяц**: 21,600
- **Yandex Cloud Functions**: Бесплатно (лимит: 1,000,000/месяц)
- **Yandex Database**: ~0.05₽/месяц (50,000 RU)
- **API Gateway**: Не используется (Timer trigger)
- **Cloud Logs**: Бесплатно (лимит: 1 GB/месяц)

**Итого**: ~0.05₽/месяц для активного пользователя

### Масштабирование:
- **10 пользователей**: ~0.5₽/месяц
- **100 пользователей**: ~5₽/месяц
- **1000 пользователей**: ~50₽/месяц

> 💡 Система очень экономична благодаря бесплатным лимитам Yandex Cloud! 