#!/usr/bin/bash

MUSIC_PATH='/media/brian/Music 2015 Backup/music-lib'
PROJECT_PATH='/home/brian/src/music_shell'

find "$MUSIC_PATH" -iname "*.mp3" > $PROJECT_PATH/music_cache.txt
find "$MUSIC_PATH" -iname "*.ogg" >> $PROJECT_PATH/music_cache.txt
find "$MUSIC_PATH" -iname "*.flac" >> $PROJECT_PATH/music_cache.txt
