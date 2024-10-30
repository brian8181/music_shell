#!/bin/bash

HOME="/home/brian" # $1
STORE_PREFIX="/mnt/music/music-lib" # $2
CONFIG_PREFIX="$HOME/.music_shell" # $3
TIME_STAMP="$(date.sh)"
CACHE_PATH="${CONFIG_PREFIX}/${TIME_STAMP}_cache.m3u" # $4

echo "searching \"${STORE_PREFIX}\", writing cache too \"${CACHE_PATH}\" ..."

./cache_new.sh ${HOME} ${STORE_PREFIX} ${CONFIG_PREFIX} ${CACHE_PATH}

echo "finished writing cache too \"${CACHE_PATH}\" ..."

# trim off root                                             # replace delimiter   # create date & album columns
sed 's/\/mnt\/music\/music-lib\///' "${CACHE_PATH}" | sed s/\\//\|/g | sed s/' - '/\|/ | sed s/\\.[[:space:]]/\|/ > "${CACHE_PATH}.tmp"
# add disc column                                           # seperate disc & track
sed -E "s/(\|[[:digit:]][[:digit:]]\|)/\|\1/" "${CACHE_PATH}.tmp" | sed -E "s/([[:digit:]]+)\\./\1\|/" > "${CACHE_PATH}"
