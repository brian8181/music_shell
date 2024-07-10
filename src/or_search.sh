#!/bin/bash

FILE='src/or_saerch.sh'
VERSION='0.0.1'
FILE_DATE='Sat Apr 27 04:26:33 PM CDT 2024'

HOME="/home/brian"
CONFIG_PREFIX="$HOME/.music_shell"
CACHE_PATH="${CONFIG_PREFIX}/cache"

SEARCH_TERM1=$1
SEARCH_TERM2=$2
CACHE_NAME="${CACHE_PATH}/${3:-cache.m3u}"
IGNORE_CASE=$4

# check parmaters
if [[ -z "$SEARCH_TERM1" || -z "$SEARCH_TERM2" || -z "$CACHE_NAME"  ]]; then
    echo "Error: no "SEARCH_TERM1 or SEARCHTERM2 or CACHE_NAME"  specified ..."
    exit
fi

echo "$SEARCH_TERM1 <OR> $SEARCH_TERM2 $IGNORE_CASE" >> ${CONFIG_PREFIX}/cache/search_history_all
cat "$CACHE_NAME" | egrep --color=always "$SEARCH_TERM1" | tee ${CONFIG_PREFIX}/queue
cat "$CACHE_NAME" | egrep --color=always "$SEARCH_TERM2" | sort -u | tee -a ${CONFIG_PREFIX}/queue
