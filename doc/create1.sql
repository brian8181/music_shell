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
    location     TEXT,
    artist       TEXT,
    album        TEXT,
    album_artist TEXT,
    year         INTEGER,
    disc         INTEGER,
    track        INTEGER,
    title        TEXT,
    encoding     TEXT,
    size         INTEGER,
    lenght       INTEGER,
    path         TEXT,
    update_ts    TEXT,
    insert_ts    TEXT
);

create table artist (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	artist TEXT,
	update_ts TIMESTAMP,
	insert_ts TIMESTAMP
); 

create table album (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	album TEXT,
	update_ts TIMESTAMP,
	insert_ts TIMESTAMP
); 


.import --csv $HOME/.music_shell/cache.csv song
.separator "/"
.import 20240927155309_cache.tmp song2
.import quoted_fullpath.txt song

select * from song;

sed -E 's/^(.*)\/(.*)\/([0-9]{4}) - (.*)\/([0-9]{2})\. (.*)\.(.*)$/"\1"\/"\3"\/"\2"\/"\4"\/""\/"\5"\/"\6"\/"\7"/g'