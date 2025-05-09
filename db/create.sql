-- music schema
create table song
(
    rowid INT PRIMARY KEY ASC,          -- 1
    location TEXT,                      -- 2
    year TEXT,                          -- 3
    artist_id INT,                      -- 4 todo
    album_id INT,                       -- 5 todo
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
   rowid INT PRIMARY KEY ASC,
   name TEXT,
   -- triggered
   update_ts TIMESTAMP,
   insert_ts TIMESTAMP
);

create table album
(
    rowid INT PRIMARY KEY ASC,
    year TEXT,
    album TEXT,       -- name
    album_artist TEXT,
    disc_count TEXT,
    track_count TEXT,
    -- triggered
     user_id INT,
    update_ts TIMESTAMP,
    insert_ts TIMESTAMP
);

create table user
(
   rowid INT PRIMARY KEY ASC,
   user TEXT,          -- name
   password_hash TEXT, -- passwords hash, does not store actual pass
   -- triggered
   update_ts TIMESTAMP,
   insert_ts TIMESTAMP
);

CREATE TABLE playlist
(
   rowid INTEGER PRIMARY KEY AUTOINCREMENT,
   user_id INT DEFAULT NULL,
   playlist TEXT,
   -- triggered
   update_ts TIMESTAMP,
   insert_ts TIMESTAMP
);

create table playlist_song
(
   rowid INT PRIMARY KEY ASC,
   playlist_id INT,
   song_id INT,
   -- triggered
   update_ts TIMESTAMP,
   insert_ts TIMESTAMP
);

CREATE TABLE tag
(
    rowid INTEGER PRIMARY KEY AUTOINCREMENT,
    tag TEXT,
    insert_ts TIMESTAMP,
    update_ts TIMESTAMP
);

create table tag_song
(
   rowid INT PRIMARY KEY ASC,
   tag_id INTEGER,
   song_id INTEGER,
   -- triggered
   insert_ts TIMESTAMP,
   update_ts TIMESTAMP
);

create table audit_row
(
   rowid INT PRIMARY KEY ASC,
   table_id int,
   table_name TEXT,
   type enum,  -- create, delete, insert, update, drop
   insert_ts TIMESTAMP,
   update_ts TIMESTAMP
);

create table audit_col
{
   rowid INT PRIMARY KEY ASC,
   auto_row_id INT,
   col_name TEXT,
   update_ts TIMESTAMP,
   insert_ts TIMESTAMP
};

create table cash
(
    rowid INT PRIMARY KEY ASC,          -- 1
    location TEXT,                      -- 2
    year TEXT,                          -- 3
    artist TEXT,                        -- 4
    album TEXT,                         -- 5
    album_artist TEXT,                  -- 6
    disc INT,                           -- 7
    track INT,                          -- 8
    title TEXT,                         -- 9
    encoder TEXT,                       -- 10
    file TEXT,                          -- 11
    hash    TEXT,                       -- 12
    -- triggered
    insert_ts TIMESTAMP,               -- 14
    update_ts TIMESTAMP                -- 13
);

CREATE TRIGGER song_insert AFTER INSERT
ON song
BEGIN
   UPDATE song SET insert_ts = datetime(), update_ts = datetime() where rowid = new.rowid;
END;

CREATE TRIGGER song_update AFTER UPDATE
ON song
BEGIN
   UPDATE song SET update_ts = datetime() where rowid = new.rowid;
END;

CREATE TRIGGER artist_insert AFTER INSERT
ON artist
BEGIN
   UPDATE artist SET insert_ts = datetime(), update_ts = datetime() where rowid = new.rowid;
END;

CREATE TRIGGER artist_update AFTER UPDATE
ON artist
BEGIN
   UPDATE artist SET update_ts = datetime() where rowid = new.rowid;
END;

CREATE TRIGGER album_insert AFTER INSERT
ON album
BEGIN
   UPDATE album SET insert_ts = datetime(), update_ts = datetime() where rowid = new.rowid;
END;

CREATE TRIGGER album_update AFTER UPDATE
ON album
BEGIN
   UPDATE album SET update_ts = datetime() where rowid = new.rowid;
END;

CREATE TRIGGER user_insert AFTER INSERT
ON user
BEGIN
   UPDATE user SET insert_ts = datetime(), update_ts = datetime() where rowid = new.rowid;
END;

CREATE TRIGGER user_update AFTER UPDATE
ON user
BEGIN
   UPDATE user SET update_ts = datetime() where rowid = new.rowid;
END;

CREATE TRIGGER playlist_insert AFTER INSERT
ON playlist
BEGIN
   UPDATE playlist SET insert_ts = datetime(), update_ts = datetime() where rowid = new.rowid;
END;

CREATE TRIGGER playlist_update AFTER UPDATE
ON playlist
BEGIN
   UPDATE playlist SET update_ts = datetime() where rowid = new.rowid;
END;

CREATE TRIGGER playlist_song_insert AFTER INSERT
ON playlist_song
BEGIN
   UPDATE playlist_song SET insert_ts = datetime(), update_ts = datetime() where rowid = new.rowid;
END;

CREATE TRIGGER playlist_song_update AFTER UPDATE
ON playlist_song
BEGIN
   UPDATE playlist_song SET update_ts = datetime() where rowid = new.rowid;
END;

CREATE TRIGGER tag_insert AFTER INSERT
ON tag
BEGIN
   UPDATE tag SET insert_ts = datetime(), update_ts = datetime() where rowid = new.rowid;
END;

CREATE TRIGGER tag_update AFTER UPDATE
ON tag
BEGIN
   UPDATE tag SET update_ts = datetime() where rowid = new.rowid;
END;

CREATE TRIGGER tag_song_insert AFTER INSERT
ON tag_song
BEGIN
   UPDATE tag_song SET insert_ts = datetime(), update_ts = datetime() where rowid = new.rowid;
END;

CREATE TRIGGER tag_song_update AFTER UPDATE
ON tag_song
BEGIN
   UPDATE tag_song SET update_ts = datetime() where rowid = new.rowid;
END;

CREATE TRIGGER audit_update AFTER UPDATE
ON audit
BEGIN
   UPDATE audit SET update_ts = datetime() where rowid = new.rowid;
END;

CREATE TRIGGER audit_insert AFTER INSERT
ON audit
BEGIN
   UPDATE audit SET insert_ts = datetime() where rowid = new.rowid;
END;

CREATE UNIQUE INDEX index_song_rowid ON song(rowid);
CREATE UNIQUE INDEX index_cash_rowid ON cash(rowid);

INSERT into user (rowid, user, password_hash, update_ts, insert_ts) values (1, 'admin', 'THE_HASH', datetime(), datetime());
