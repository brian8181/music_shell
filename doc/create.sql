create table song 
(
    id INT PRIMARY KEY,                 -- 1
    location TEXT,                      -- 2
    year TEXT,                          -- 3
    artist TEXT,                        -- 4
    album TEXT,                         -- 5
    track INT,                          -- 7
    track_count INT,                    -- 8
    disc INT,                           -- 9
    title TEXT,                         -- 10
    lyrics TEXT,                        -- 11
    genre TEXT,                         -- 12
    file TEXT,                          -- 13
    bitrate INT,                        -- 14
    encoder TEXT,                       -- 15
    hash    TEXT,                       -- 16
    update_ts TIMESTAMP,                -- 16
    insert_ts TIMESTAMP                 -- 18
);

create table artist 
(
    id INT PRIMARY KEY,
    artist TEXT,
    update_ts TIMESTAMP,
    insert_ts TIMESTAMP
); 

create table album 
(
    id INT PRIMARY KEY,
    album TEXT,
    album_artist,
    disc_count INT,
    track_count INT,                     
    update_ts TIMESTAMP,
    insert_ts TIMESTAMP
); 

CREATE TRIGGER song_insert AFTER INSERT 
ON song
BEGIN
   INSERT INTO AUDIT(update_ts, insert_ts_ts) VALUES (datetime('now'), datetime('now'));
END;

CREATE TRIGGER song_update AFTER UPDATE 
ON song
BEGIN
   INSERT INTO AUDIT(update_ts) VALUES (datetime('now'));
END;

-- .import --csv .cache.csv song
-- .mode csv
-- .separator "/"
-- select * from song;
-- select count(*) from song;
-- select rowid from song;
-- select id from song;
