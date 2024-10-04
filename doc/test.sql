create table song 
(
    artist TEXT,
    date   TEXT,
    title TEXT,
    update_ts TEXT,
    insert_ts TEXT
);

CREATE TRIGGER song_insert AFTER INSERT 
ON song
BEGIN
   INSERT INTO song (update_ts, insert_ts) VALUES (datetime('now'), datetime('now'));
END;

CREATE TRIGGER song_update AFTER UPDATE 
ON song
BEGIN
   INSERT INTO song (update_ts) VALUES (datetime('now'));
END;