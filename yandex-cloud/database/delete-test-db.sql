-- Скрипт для удаления тестовых таблиц в Yandex Database
-- Удаляет тестовые таблицы для VK Wrapped с суффиксом _test

-- Удаление тестовых таблиц
DROP TABLE IF EXISTS completed_sessions_test;
DROP TABLE IF EXISTS current_sessions_test;
