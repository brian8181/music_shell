-- music schema
create table song 
(
    --id INT PRIMARY KEY,               -- 1
    -- current fields
    location TEXT,                      -- 1
    year TEXT,                          -- 2
    artist TEXT,                        -- 3
    album TEXT,                         -- 4
    -- new field
    album_artist TEXT,                  -- 5
    disc INT,                           -- 6
    track INT,                          -- 7
    title TEXT,                         -- 8
    encoder TEXT,                       -- 9
    
    -- empty fields
    file TEXT,                          -- 10
    hash    TEXT,                       -- 11

    -- triggered
    update_ts TIMESTAMP,                -- 12
    insert_ts TIMESTAMP                 -- 13
);

-- create table artist 
-- (
--     id INT PRIMARY KEY,
--     artist TEXT,
--     update_ts TIMESTAMP,
--     insert_ts TIMESTAMP
-- ); 

-- create table album 
-- (
--     id INT PRIMARY KEY,
--     album TEXT,
--     album_artist,
--     disc_count INT,
--     track_count INT,                     
--     update_ts TIMESTAMP,
--     insert_ts TIMESTAMP
-- ); 

-- CREATE TRIGGER song_insert AFTER INSERT 
-- ON song
-- BEGIN
--    INSERT INTO song (update_ts, insert_ts) VALUES (datetime('now'), datetime('now'));
-- END;

-- CREATE TRIGGER song_update AFTER UPDATE 
-- ON song
-- BEGIN
--    INSERT INTO song (update_ts) VALUES (datetime('now'));
-- END;

-- .import --csv .cache.csv song
-- .mode csv
-- .separator "/"
-- select * from song;
-- select count(*) from song;
-- select rowid from song;
-- select id from song;
