create schema music;
create table song (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    location TEXT,
    date NUMERIC,
    artist TEXT,
    album TEXT,
    track INT,
    disc INIT,
    title TEXT,
    ext TEXT
);

create table music(
    location TEXT,
    artist TEXT,
    date NUMERIC,
    album TEXT,
    track INT,
    disc INIT,
    title TEXT,
    ext
);

.import --csv .cache.csv song