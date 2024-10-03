-- music schema
create table song 
(
    -- debug, no key! 
    --id INT PRIMARY KEY,                 -- 1

    -- current fields
    location TEXT,                      -- 2
    year TEXT,                          -- 3
    artist TEXT,                        -- 4
    album TEXT,                         -- 5
    -- new field
    album_artist TEXT,                  -- 6
    disc INT,                           -- 7
    track INT,                          -- 8
    title TEXT,                         -- 9
    encoder TEXT,                       -- 10
    
    -- empty fields
    genre TEXT,                         -- 11
    file TEXT,                          -- 12
    hash    TEXT,                       -- 13

    -- triggered
    update_ts TIMESTAMP,                -- 14
    insert_ts TIMESTAMP                 -- 15
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

CREATE TRIGGER song_insert AFTER INSERT 
ON song
BEGIN
   INSERT INTO song (update_ts, insert_ts) VALUES (datetime('now'), datetime('now'));
END;

CREATE TRIGGER song_update AFTER UPDATE 
ON song
BEGIN
   INSERT INTO song (update_ts) VALUES (datetime('now'));
END;

-- .import --csv .cache.csv song
-- .mode csv
-- .separator "/"
-- select * from song;
-- select count(*) from song;
-- select rowid from song;
-- select id from song;
