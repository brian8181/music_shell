-- music schema
create table song 
(
    id INT PRIMARY KEY,                 -- 1
    location TEXT,                      -- 2
    year TEXT,                          -- 3
    artist TEXT,                        -- 4
    --artist_id INT,                        -- 4 todo
    album TEXT,                         -- 5
    --album_id INT,                         -- 5 todo
    album_artist TEXT,                  -- 6
    disc INT,                           -- 7
    track INT,                          -- 8
    title TEXT,                         -- 9
    encoder TEXT,                       -- 10
    file TEXT,                          -- 11
    hash    TEXT,                       -- 12
    -- triggered
    update_ts TIMESTAMP,                -- 13
    insert_ts TIMESTAMP                 -- 14
);

create table artist 
(
    id INT PRIMARY KEY,
    artist TEXT,      -- name
    -- triggered
    update_ts TIMESTAMP,
    insert_ts TIMESTAMP
); 

create table album 
(
    id INT PRIMARY KEY,
    year TEXT
    album TEXT,       -- name
    album_artist TEXT,
    disc_count INT,
    track_count INT,     
    -- triggered                
    update_ts TIMESTAMP,
    insert_ts TIMESTAMP
); 

create table user
(
   id INT PRIMARY KEY,
   user TEXT,          -- name
   password_hash TEXT, -- passwords hash, does not store actual pass
   -- triggered                
   update_ts TIMESTAMP,
   insert_ts TIMESTAMP  
);

create table playlist
(
   id INT PRIMARY KEY,
   user_id INT, 
   playlist TEXT,    -- name
   -- triggered                
   update_ts TIMESTAMP,
   insert_ts TIMESTAMP
);

create table playlist_song
(
   id INT PRIMARY KEY,
   playlist_id INT,   
   song_id INT,
   -- triggered                
   update_ts TIMESTAMP,
   insert_ts TIMESTAMP
);

CREATE TRIGGER song_insert AFTER INSERT 
ON song
BEGIN
   UPDATE song SET insert_ts = datetime(), update_ts = datetime() where id = new.id;
END;

CREATE TRIGGER song_update AFTER UPDATE 
ON song
BEGIN
   UPDATE song SET update_ts = datetime() where id = new.id;
END;

CREATE TRIGGER artist_insert AFTER INSERT 
ON artist
BEGIN
   UPDATE artist SET insert_ts = datetime(), update_ts = datetime() where id = new.id;
END;

CREATE TRIGGER artist_update AFTER UPDATE 
ON artist
BEGIN
   UPDATE artist SET update_ts = datetime() where id = new.id;
END;

CREATE TRIGGER album_insert AFTER INSERT 
ON album
BEGIN
   UPDATE album SET insert_ts = datetime(), update_ts = datetime() where id = new.id;
END;

CREATE TRIGGER album_update AFTER UPDATE 
ON album
BEGIN
   UPDATE album SET update_ts = datetime() where id = new.id;
END;

CREATE TRIGGER user_insert AFTER INSERT 
ON user
BEGIN
   UPDATE user SET insert_ts = datetime(), update_ts = datetime() where id = new.id;
END;

CREATE TRIGGER user_update AFTER UPDATE 
ON user
BEGIN
   UPDATE user SET update_ts = datetime() where id = new.id;
END;

CREATE TRIGGER playlist_insert AFTER INSERT 
ON playlist
BEGIN
   UPDATE playlist SET insert_ts = datetime(), update_ts = datetime() where id = new.id;
END;

CREATE TRIGGER playlist_update AFTER UPDATE 
ON playlist
BEGIN
   UPDATE playlist SET update_ts = datetime() where id = new.id;
END;

CREATE TRIGGER playlist_song_insert AFTER INSERT 
ON playlist_song
BEGIN
   UPDATE playlist_song SET insert_ts = datetime(), update_ts = datetime() where id = new.id;
END;

CREATE TRIGGER playlist_song_update AFTER UPDATE 
ON playlist_song
BEGIN
   UPDATE playlist_song SET update_ts = datetime() where id = new.id;
END;

INSERT into user (id, user, password_hash, update_ts, insert_ts) values (1, 'admin', 'THE_HASH', datetime(), datetime());
-- .import cache.csv song
-- .mode csv
-- .separator "/"
-- select * from song;
-- select count(*) from song;
-- select rowid from song;
-- select id from song;
