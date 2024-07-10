#!/bin/bash

FILE='src/and_search.sh'
VERSION='010.1'
FILE_DATE='Wed Jul 10 12:07:23 PM CDT 2024'

HOME="/home/brian"
CONFIG_PREFIX="$HOME/.music_shell"
CACHE_PATH="${CONFIG_PREFIX}/cache"

SEARCH_TERM1=$1
SEARCH_TERM2=$2
#PLAYLIST_NAME="${CONFIG_PREFIX}/${3:-new_playlist}"
CACHE_NAME="${CACHE_PATH}/${3:-cache.m3u}"
IGNORE_CASE=$4

# check parmaters
if [[ -z "$SEARCH_TERM1" || -z "$SEARCH_TERM2" || -z "$CACHE_NAME"  ]]; then
    echo "Error: no "SEARCH_TERM1 or SEARCH_TERM2 or CACHE_NAME"  specified ..."
    exit
fi

cat "$CACHE_NAME" | egrep --color=always "$SEARCH_TERM1" | egrep --color=always "$SEARCH_TERM2" | tee $HOME/.music_shell/queue
