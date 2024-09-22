create schema music;

create table song (
    location TEXT,
    artist TEXT,
    album TEXT,
    title TEXT
);

    .import --csv $HOME/.music_shell/cache.txt song
