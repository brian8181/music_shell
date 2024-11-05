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
