-- Скрипт для полной очистки всех данных в Yandex Database
-- Удаляет ВСЕ записи из таблиц VK Wrapped

-- Очищаем таблицу активных сессий прослушивания
DELETE FROM current_sessions;

-- Очищаем таблицу завершенных сессий прослушивания  
DELETE FROM completed_sessions;
