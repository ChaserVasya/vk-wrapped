-- Скрипт для обновления структуры таблиц в Yandex Database
-- Удаляет старые таблицы и создает новые с обновленной структурой

-- Удаляем существующие таблицы
DROP TABLE IF EXISTS listening_sessions;
DROP TABLE IF EXISTS active_sessions;

-- Создаем таблицу завершенных сессий прослушивания
CREATE TABLE completed_sessions (
    full_id String,               -- "owner_id_track_id"
    first_observed Uint32,        -- когда впервые увидели трек
    last_seen Uint32,             -- когда последний раз видели трек
    PRIMARY KEY (full_id, first_observed)
);

-- Создаем таблицу активных сессий прослушивания
CREATE TABLE current_sessions (
    full_id String,               -- "owner_id_track_id" (уникальный ключ)
    first_observed Uint32,        -- когда впервые увидели трек
    last_seen Uint32,             -- когда последний раз видели трек
    PRIMARY KEY (full_id)
); 