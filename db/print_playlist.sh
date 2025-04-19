#!/bin/bash

NAME=$1
sql3 "select * from playlist join playlist_song on playlist.rowid==playlist_song.playlist_rowid join cash on playlist_song.song_rowid;"
