create table playlist
(
   rowid INTEGER PRIMARY KEY AUTOINCREMENT,
   user_id INT DEFAULT NULL,
   playlist TEXT,   
   -- triggered                
   update_ts TIMESTAMP,
   insert_ts TIMESTAMP
);