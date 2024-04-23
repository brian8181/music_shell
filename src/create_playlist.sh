#!/bin/bash

# load export settings
./settings.sh

OPTIONS=NULL
SEARCH_TERM=$1
CACHE_NAME="$HOME/.music_shell/cache/$2"
PLAYLIST_NAME=$3
IGNORE_CASE=$4

if [[ ! -r "$CACHE_NAME" ]]; then
    echo "error: $CACHE_NAME does not exists"
    exit
fi

if [ -z "$SEARCH_TERM" ]; then
    echo "Error: no "SEARCH_TERM" specified ..."
    exit
fi

cat "$CACHE_NAME" | egrep --color=always $IGNORE_CASE "$SEARCH_TERM" | tee -a $HOME/"${PLAYLIST_NAME}.m3u.swp"
cat $HOME/"${PLAYLIST_NAME}.m3u.swp" | sort -u > $HOME/"${PLAYLIST_NAME}.m3u"
rm $HOME/"${PLAYLIST_NAME}.m3u.swp"