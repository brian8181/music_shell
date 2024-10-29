CREATE TRIGGER song_insert AFTER INSERT 
ON song
BEGIN
   UPDATE song SET insert_ts = datetime() update_ts = datetime() where id = new.id;
END;

CREATE TRIGGER song_update AFTER UPDATE 
ON song
BEGIN
   UPDATE song SET update_ts = datetime() where id = new.id;
END;


