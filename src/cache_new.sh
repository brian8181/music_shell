#!/bin/bash

HOME="/home/brian"
STORE_PREFIX="/mnt/music/music-lib"
CONFIG_PREFIX="$HOME/.music_shell"
CACHE_NAME="cache.m3u"
QUEUE_NAME="queue.m3u"
TIME_STAMP="$(date.sh)"

echo "searching \"${STORE_PREFIX}\", wrting cache too \"${CONFIG_PREFIX}/${TIME_STAMP}_${CACHE_NAME}\" ..."
find "${STORE_PREFIX}" -iregex '^.*\.\(\(mp3\)\|\(flac\)\|\(ogg\)|\(wma\)\)\)$' > "${CONFIG_PREFIX}/${TIME_STAMP}_${CACHE_NAME}"
echo "finished writing cache too \"${CONFIG_PREFIX}/${TIME_STAMP}_${CACHE_NAME}\" ..."

# TIMESTAMP=$($HOME/bin/date.sh)
# TMP_NAME="tmp_${TIMESTAMP}.txt"
#CACHE_NAME="${DEST_PATH}/${NAME%.*}_${TIMESTAMP}.txt"

# trim off root                                             # replace delimiter   # create date & album columns
# llsed 's/\/mnt\/music\/music-lib\///' "${CACHE_NAME}" | sed s/\\//\|/g | sed s/' - '/\|/ | sed s/\\.[[:space:]]/\|/ > $TMP_NAME
# # add disc column                                           # seperate disc & track
# sed -E "s/(\|[[:digit:]][[:digit:]]\|)/\|\1/" "$TMP_NAME" | sed -E "s/([[:digit:]]+)\\./\1\|/" > "${CACHE_NAME}"
# echo ${CACHE_NAME}
