#!/bin/bash

./settings.sh

MUSIC_PATH=$1
PROJECT_PATH=$2
NAME=$3
DELIMITER=| # todo

# find .. -name "*.flac" -o -name "*.mp3" -o -name "*.wma"
find "$MUSIC_PATH" -iname "*.mp3" > $HOME/.music_shell/$NAME
find "$MUSIC_PATH" -iname "*.ogg" >> $HOME/.music_shell/$NAME
find "$MUSIC_PATH" -iname "*.flac" >> $HOME/.music_shell/$NAME

TIMESTAMP=$($HOME/.music_shell/bin/date.sh)
TMP_NAME="tmp_${TIMESTAMP}.txt"
CACHE_NAME="${PROJECT_PATH}/${NAME%.*}_${TIMESTAMP}.txt"

# trim off root                                             # replace delimiter   # create date & album columns
sed 's/\/mnt\/music\/music-lib\///' "${PROJECT_PATH}/${NAME}" | sed s/\\//\|/g | sed s/' - '/\|/ | sed s/\\.[[:space:]]/\|/ > $TMP_NAME
# add disc column                                           # seperate disc & track
sed -E "s/(\|[[:digit:]][[:digit:]]\|)/\|\1/" "$TMP_NAME" | sed -E "s/([[:digit:]]+)\\./\1\|/" > "${CACHE_NAME}"
echo ${CACHE_NAME}
