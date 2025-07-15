#!/bin/bash

MUSIC_DIR=$HOME/mdrive/music-lib
FILE=$1

cat "$FILE" | sed -E "s|(Z\\:\\\mnt\\\music\\\music-lib\\\)(.*)|F:\\\music-lib\\\\\2|g" > "$HOME/tmp/${FILE##*/}"
