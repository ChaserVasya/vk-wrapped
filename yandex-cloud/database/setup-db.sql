-- Скрипт для создания таблиц в Yandex Database
-- Создает таблицы для VK Wrapped

-- Таблица завершенных сессий прослушивания
CREATE TABLE listening_sessions (
    full_id String,          
    start Timestamp,          
    end Timestamp,         
    PRIMARY KEY (start)
);  


-- Таблица активных сессий прослушивания
CREATE TABLE active_sessions (
    full_id String PRIMARY KEY,
    start Timestamp,     
    last_updated Timestamp  
); 


