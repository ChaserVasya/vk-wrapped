-- Скрипт для обновления структуры таблиц в Yandex Database
-- Удаляет старые таблицы и создает новые с обновленной структурой

-- Удаляем существующие таблицы
DROP TABLE IF EXISTS listening_sessions;
DROP TABLE IF EXISTS active_sessions;

-- Создаем таблицу завершенных сессий прослушивания
CREATE TABLE listening_sessions (
    full_id String,               -- "owner_id_track_id"
    start Timestamp,              -- время начала сессии (PRIMARY KEY)
    end Timestamp,                -- время окончания сессии
    PRIMARY KEY (start)
);

-- Создаем таблицу активных сессий прослушивания
CREATE TABLE active_sessions (
    full_id String,               -- "owner_id_track_id" (уникальный ключ)
    start Timestamp,              -- время начала сессии
    last_updated Timestamp,       -- время последнего обновления
    PRIMARY KEY (full_id)
); 