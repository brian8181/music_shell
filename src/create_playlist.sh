#!/bin/bash

# load export settings
#./settings.sh

#OPTIONS=NULL

HOME="/home/brian"
STORE_PREFIX="/mnt/music/music-lib"
CONFIF_PREFIX="${HOME}/.music_shell"
CACHE_NAME="cache.m3u"
TIME_STAMP="$(date.sh)"

SEARCH_TERM=$1
PLAYLIST_NAME=$2
IGNORE_CASE=$3

# if [[ ! -r "$CACHE_NAME" ]]; then
#     echo "error: ${CONFIF_PREFIX}/$CACHE_NAME does not exists"
#     exit
# fi

if [ -z "$SEARCH_TERM" ]; then
    echo "Error: no "SEARCH_TERM" specified ..."
    exit
fi



echo "NAME=${HOME}/${PLAYLIST_NAME}.m3u"

cat "${CONFIF_PREFIX}/$CACHE_NAME" | egrep --color=always $IGNORE_CASE "$SEARCH_TERM" | tee -a "${HOME}/${PLAYLIST_NAME}.m3u.swp"
cat "${HOME}/${PLAYLIST_NAME}.m3u.swp" | sort -u > "${HOME}/${PLAYLIST_NAME}.m3u"
rm "${HOME}/${PLAYLIST_NAME}.m3u.swp"