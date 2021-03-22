#!/usr/bin/bash

MUSIC_PATH=$1
PROJECT_PATH=$2
NAME=$3

find $MUSIC_PATH -iname "*.mp3" > $PROJECT_PATH/$NAME
find $MUSIC_PATH -iname "*.ogg" >> $PROJECT_PATH/$NAME
find $MUSIC_PATH -iname "*.flac" >> $PROJECT_PATH/$NAME


sed 's/\/media\/brian\/Music 2015 Backup\/music-lib\///' music_cache.txt > mc.tx
sed s/\\//\|/g mc.txt > mc3.txt
sed s/' - '/\|/ mc3.txt > mc4.txt
sed s/\\.[[:space:]]/\|/ mc4.txt > mc5.txt