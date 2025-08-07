-- Скрипт для создания тестовых таблиц в Yandex Database
-- Создает тестовые таблицы для VK Wrapped с суффиксом _test

-- Таблица завершенных сессий прослушивания (тестовая)
CREATE TABLE completed_sessions_test (
    full_id String,          
    first_observed Uint32,          
    last_seen Uint32,         
    PRIMARY KEY (full_id, first_observed)
);  


-- Таблица активных сессий прослушивания (тестовая)
CREATE TABLE current_sessions_test (
    full_id String,              -- "owner_id_track_id" (уникальный ключ)
    first_observed Uint32,       -- когда впервые увидели трек
    last_seen Uint32,            -- когда последний раз видели трек
    PRIMARY KEY (full_id)
);
