#!/bin/bash

./settings

MUSIC_PATH='/mnt/music/music-lib'
NAME=$1

#find "$MUSIC_PATH" -iname "*.mp3" > /home/brian/$NAME
find "$MUSIC_PATH" -regex "mp3" > "$HOME/my_regex_find.txt"