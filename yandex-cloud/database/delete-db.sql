-- Скрипт для удаления таблиц в Yandex Database
-- Удаляет таблицы для VK Wrapped

-- Удаляем таблицу завершенных сессий прослушивания
DROP TABLE IF EXISTS listening_sessions;

-- Удаляем таблицу активных сессий прослушивания
DROP TABLE IF EXISTS active_sessions; 