create schema music;

create table song 
(
    location     TEXT,
    artist       TEXT,
    album        TEXT,
    album_artist TEXT,
    year         TEXT,
    disc         INT,
    track        INT,
    title        TEXT,
    encoding     TEXT,
    size         INT,
    lenght       INT,
    path         TEXT,
    update_ts    TIMESTAMP,
	insert_ts    TIMESTAMP
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

