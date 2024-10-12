create schema music;

create table song 
(
    location TEXT,
    artist TEXT,
    album TEXT,
    title TEXT
);

.import --csv $HOME/.music_shell/cache.txt song

create table song 
(
    location     TEXT,          -- 1
    artist       TEXT,          -- 2
    album        TEXT,          -- 3
    album_artist TEXT,          -- 4
    year         INTEGER,       -- 5
    disc         INTEGER,       -- 6
    track        INTEGER,       -- 8
    title        TEXT,          -- 9
    encoding     TEXT,          -- 10
    size         INTEGER,       -- 11
    lenght       INTEGER,       -- 12
    path         TEXT,          -- 13
    update_ts    TEXT,          -- 14
    insert_ts    TEXT           -- 15
);

create table artist (
	id INTEGER PRIMARY KEY,
	artist TEXT,
	update_ts TIMESTAMP,
	insert_ts TIMESTAMP
); 

create table album (
	id INTEGER PRIMARY KEY,
	album TEXT,
	update_ts TIMESTAMP,
	insert_ts TIMESTAMP
); 
