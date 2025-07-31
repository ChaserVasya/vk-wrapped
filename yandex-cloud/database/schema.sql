-- Схема базы данных для VK Wrapped
-- Yandex Database (YDB)

-- Таблица сессий прослушивания
CREATE TABLE listening_sessions (
    full_id String,               -- "owner_id_track_id"
    start Timestamp,              -- время начала сессии (PRIMARY KEY)
    end Timestamp,                -- время окончания сессии
    PRIMARY KEY (start)
); 