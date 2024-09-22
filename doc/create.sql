create schema music;

create table song (
    id INT PRIMARY KEY AUTOINCREMENT,
    location TEXT,
    year TEXT,
    artist TEXT,
    album TEXT,
    album_artist TEXT,
    track INT,
    track_count INT,
    disc INT,
    disc_count INT,
    title TEXT,
    lyrics TEXT,
    genre TEXT,
    file_size INT,
    file TEXT,
    bitrate INT,
    encoder TEXT,
    art TEXT,
    ext TEXT,
    update_ts TIMESTAMP,
    insert_ts TIMESTAMP
);

create table art (
	id INT PRIMARY KEY AUTOINCREMENT,
	file TEXT,
	type TEXT,
	hash BLOB,
	description TEXT,
	mime_type TEXT,
	update_ts TIMESTAMP,
	insert_ts TIMESTAMP
); 

create table artist (
	id INT PRIMARY KEY AUTOINCREMENT,
	artist TEXT,
	update_ts TIMESTAMP,
	insert_ts TIMESTAMP
); 

create table album (
	id INT PRIMARY KEY AUTOINCREMENT,
	album TEXT,
	update_ts TIMESTAMP,
	insert_ts TIMESTAMP
); 

.import --csv .cache.csv song
