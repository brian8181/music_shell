#!/bin/bash

./settings.sh

MUSIC_PATH=$1
CACHE_PATH=$2
# NAME=${CACHE_PATH}
# DEST_PATH=${CACHE_PATH}

# find .. -name "*.flac" -o -name "*.mp3" -o -name "*.wma"
find "$MUSIC_PATH" -iregex '^.*\.\(\(mp3\)\|\(flac\)\|\(ogg\)\)$'

TIMESTAMP=$($HOME/bin/date.sh)
TMP_NAME="tmp_${TIMESTAMP}.txt"
#CACHE_NAME="${DEST_PATH}/${NAME%.*}_${TIMESTAMP}.txt"

# trim off root                                             # replace delimiter   # create date & album columns
# llsed 's/\/mnt\/music\/music-lib\///' "${CACHE_NAME}" | sed s/\\//\|/g | sed s/' - '/\|/ | sed s/\\.[[:space:]]/\|/ > $TMP_NAME
# # add disc column                                           # seperate disc & track
# sed -E "s/(\|[[:digit:]][[:digit:]]\|)/\|\1/" "$TMP_NAME" | sed -E "s/([[:digit:]]+)\\./\1\|/" > "${CACHE_NAME}"
# echo ${CACHE_NAME}
