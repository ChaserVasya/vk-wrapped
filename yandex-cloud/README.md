# VK Wrapped - Yandex Cloud Functions

Система для отслеживания прослушивания музыки в VK с использованием Yandex Cloud Functions и Yandex Database.

## 🚀 Текущий статус

**✅ РАЗВЕРНУТО И РАБОТАЕТ**

- Функция: `vk-wrapped-poller` (ACTIVE)
- Таймер: каждую минуту
- HTTP endpoint: `https://functions.yandexcloud.net/d4e386am5oj9e71292k5`
- Тесты: 38/38 проходят
- Мониторинг: активен

## Архитектура

### База данных (Yandex Database)

Система использует две таблицы для эффективного отслеживания сессий прослушивания:

#### 1. `completed_sessions` - Завершенные сессии

```sql
CREATE TABLE completed_sessions (
    full_id String,          
    first_observed Uint32,          
    last_seen Uint32,         
    PRIMARY KEY (full_id, first_observed)
);
```

#### 2. `current_sessions` - Активные сессии

```sql
CREATE TABLE current_sessions (
    full_id String,              -- "owner_id_track_id" (уникальный ключ)
    first_observed Uint32,       -- когда впервые увидели трек
    last_seen Uint32,            -- когда последний раз видели трек
    PRIMARY KEY (full_id)
);
```

### Логика работы

1. **Пользователь слушает музыку**:
   - Проверяется наличие активной сессии для трека
   - Если нет - создается новая активная сессия в `current_sessions`
   - Если есть - обновляется `last_seen` в существующей сессии

2. **Пользователь перестал слушать**:
   - Все активные сессии из `current_sessions` перемещаются в `completed_sessions`
   - В `completed_sessions` записывается `first_observed` и `last_seen` время сессии
   - `current_sessions` очищается

3. **Смена трека**:
   - Завершаются все активные сессии (перемещаются в `completed_sessions`)
   - Создается новая активная сессия для нового трека

### Преимущества двухтабличной архитектуры

- **Эффективность запросов**: `current_sessions` всегда содержит мало записей
- **Быстрый поиск**: PRIMARY KEY по `full_id` в активных сессиях
- **Чистота данных**: завершенные сессии отделены от активных
- **Масштабируемость**: активные сессии не растут со временем

## Структура проекта

```
yandex-cloud/
├── functions/
│   ├── src/
│   │   ├── services/
│   │   │   ├── database.ts          # Работа с YDB
│   │   │   ├── vk-api.ts            # VK API
│   │   │   ├── status-processor.ts  # Логика обработки статуса
│   │   │   └── logger.ts            # Логирование
│   │   ├── __tests__/               # 38 тестов
│   │   │   ├── database.test.ts     # Тесты БД
│   │   │   ├── session-logic.test.ts # Тесты логики сессий
│   │   │   ├── validation.test.ts   # Тесты валидации
│   │   │   ├── error-handling.test.ts # Тесты обработки ошибок
│   │   │   ├── state-transitions.test.ts # Тесты переходов состояний
│   │   │   ├── success-scenarios.test.ts # Тесты успешных сценариев
│   │   │   └── test-utils.ts        # Утилиты для тестов
│   │   ├── config.ts                # Конфигурация
│   │   ├── types.ts                 # Типы TypeScript
│   │   └── index.ts                 # Главная функция
│   ├── deploy.sh                    # Скрипт деплоя
│   ├── env                          # Переменные окружения
│   ├── package.json                 # Зависимости
│   └── jest.config.js               # Конфигурация тестов
└── database/
    ├── setup-db.sql                 # Схема БД
    ├── upgrade-db.sql               # Обновления БД
    ├── delete-db.sql                # Удаление БД
    └── README.md                    # Документация БД
```

## Установка и настройка

### 1. Настройка базы данных

```bash
cd yandex-cloud/database
export YDB_ENDPOINT="grpcs://ydb.serverless.yandexcloud.net:2135"
export YDB_DATABASE_PATH="/ru-central1/b1gs9ka9aldijuamlfr7/etn3k2hemgr6nk2h3l4m"
export YDB_TOKEN="your-token"
# Выполнить SQL скрипты в YDB консоли
```

### 2. Настройка функции

```bash
cd yandex-cloud/functions
# Отредактировать env файл с вашими данными
```

### 3. Деплой функции

```bash
# Деплой с проверками
./deploy.sh
```

## Переменные окружения

### VK API

- `USER_ID` - ID пользователя VK (например: `isaykinvasya`)
- `SERVICE_TOKEN` - Сервисный токен VK
- `VK_API_VERSION` - Версия VK API (5.131)
- `VK_API_FIELDS` - Поля для запроса (status)

### Yandex Database

- `YDB_ENDPOINT` - Эндпоинт YDB
- `YDB_DATABASE_PATH` - Путь к базе данных
- `YDB_TOKEN` - Токен доступа к YDB

## Тестирование

### Локальное тестирование

```bash
cd yandex-cloud/functions
npm test
```

### Тестирование развернутой функции

```bash
# Ручной вызов
yc serverless function invoke vk-wrapped-poller

# HTTP вызов
curl -X GET https://functions.yandexcloud.net/d4e386am5oj9e71292k5

# Просмотр логов
yc serverless function logs vk-wrapped-poller --limit=20
```

Тесты покрывают:

- ✅ Создание и обновление активных сессий
- ✅ Смену треков
- ✅ Завершение сессий при отсутствии музыки
- ✅ Валидацию данных VK API
- ✅ Обработку ошибок
- ✅ Парсинг YDB объектов

## Мониторинг

Функция логирует все действия:

- 🎵 Активная музыка
- ✅ Создание новых сессий
- 🔄 Обновление сессий
- 🏁 Завершение всех сессий
- ⏳ Отсутствие музыки
- ❌ Ошибки

### Команды мониторинга

```bash
# Просмотр логов
yc serverless function logs vk-wrapped-poller

# Статус функции
yc serverless function get vk-wrapped-poller

# Версии функции
yc serverless function version list --function-name=vk-wrapped-poller
```

## Стоимость

При использовании 1 минуты поллинга для активного пользователя (12 часов/день):

### Расчет

- **Вызовов в день**: 720 (12 часов × 60 минут)
- **Вызовов в месяц**: 21,600
- **Yandex Cloud Functions**: Бесплатно (лимит: 1,000,000/месяц)
- **Yandex Database**: ~0.05₽/месяц (50,000 RU)
- **API Gateway**: Не используется (Timer trigger)
- **Cloud Logs**: Бесплатно (лимит: 1 GB/месяц)

**Итого**: ~0.05₽/месяц для активного пользователя

### Масштабирование

- **10 пользователей**: ~0.5₽/месяц
- **100 пользователей**: ~5₽/месяц
- **1000 пользователей**: ~50₽/месяц

> 💡 Система очень экономична благодаря бесплатным лимитам Yandex Cloud!

## 📋 Использование

```bash
# 1. Timer trigger runs automatically every minute
# 2. HTTP trigger for manual testing: curl -X GET $FUNCTION_URL
# 3. Check logs: yc serverless function logs vk-wrapped-poller
# 4. Test function: yc serverless function invoke vk-wrapped-poller
```
