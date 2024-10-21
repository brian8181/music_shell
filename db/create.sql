-- music schema
create table song 
(
    id INT PRIMARY KEY,               -- 1
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

CREATE TRIGGER song_insert AFTER INSERT 
ON song
BEGIN
   UPDATE song SET insert_ts = datetime() update_ts = datetime() where id = new.id;
END;

CREATE TRIGGER song_insert AFTER UPDATE 
ON song
BEGIN
   UPDATE song SET update_ts = datetime() where id = new.id;
END;

create table artist 
(
    id INT PRIMARY KEY,
    artist TEXT,
    update_ts TIMESTAMP,
    insert_ts TIMESTAMP
); 

CREATE TRIGGER artist_insert AFTER INSERT 
ON artist
BEGIN
   UPDATE artist SET insert_ts = datetime() update_ts = datetime() where id = new.id;
END;

CREATE TRIGGER artist_insert AFTER UPDATE 
ON artist
BEGIN
   UPDATE artist SET update_ts = datetime() where id = new.id;
END;

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

CREATE TRIGGER album_insert AFTER INSERT 
ON album
BEGIN
   UPDATE album SET insert_ts = datetime() update_ts = datetime() where id = new.id;
END;

CREATE TRIGGER song_insert AFTER UPDATE 
ON album
BEGIN
   UPDATE album SET update_ts = datetime() where id = new.id;
END;

-- .import cache.csv song
-- .mode csv
-- .separator "/"
-- select * from song;
-- select count(*) from song;
-- select rowid from song;
-- select id from song;
