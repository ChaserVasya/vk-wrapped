-- Скрипт для создания таблиц в Yandex Database
-- Создает таблицы для VK Wrapped

-- Таблица завершенных сессий прослушивания
CREATE TABLE completed_sessions (
    full_id String,          
    first_observed Uint32,          
    last_seen Uint32,         
    PRIMARY KEY (full_id, first_observed)
);  


-- Таблица активных сессий прослушивания
CREATE TABLE current_sessions (
    full_id String,              -- "owner_id_track_id" (уникальный ключ)
    first_observed Uint32,       -- когда впервые увидели трек
    last_seen Uint32,            -- когда последний раз видели трек
    PRIMARY KEY (full_id)
); 

-- Таблица лайков мемов
CREATE TABLE meme_likes (
    meme_id String,              -- ID мема (например: "1", "2", "25")
    PRIMARY KEY (meme_id)
); 


