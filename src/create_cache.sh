#!/usr/bin/bash

MUSIC_PATH=$1
PROJECT_PATH=$2
NAME=$3

find $MUSIC_PATH -iname "*.mp3" > $PROJECT_PATH/$NAME
find $MUSIC_PATH -iname "*.ogg" >> $PROJECT_PATH/$NAME
find $MUSIC_PATH -iname "*.flac" >> $PROJECT_PATH/$NAME
le.test_run.mp3 -V3