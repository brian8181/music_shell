#!/bin/bash

# FILE: create_m3u.sh
# VERSION: 0.0.1
# FILE_DATE: Mon Dec  2 03:27:12 PM CST 2024
# INFO: create play list in db 

NAME=$1
EXP=$2
PLAYLIST_ID=
SONG_ID=

PLAYLIST_ID=$(sqlite3 $HOME/db/music.db "INSERT INTO playlist (playlist) VALUES ('$NAME'); SELECT last_insert_rowid() playlist;")
echo $PLAYLIST_ID

sqlite3 $HOME/db/music.db "SELECT rowid FROM cash WHERE $EXP;" > "playlist.tmp"

while read line; do
    SONG_ID=${line}
	sqlite3 $HOME/db/music.db "INSERT INTO playlist_song (playlist_rowid, song_rowid) VALUES ('$PLAYLIST_ID', '$SONG_ID');"
done < "playlist.tmp"

sqlite3 $HOME/db/music.db "select file from playlist join playlist_song on playlist.rowid==playlist_song.playlist_rowid join cash on playlist_song.song_rowid==cash.rowid where playlist.playlist=='$NAME';"