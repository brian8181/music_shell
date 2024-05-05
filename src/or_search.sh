#!/bin/bash

# load export settings

HOME="~/"
CONFIG_PREFIX="$HOME/.music_shell"
CACHE_PATH="${CONFIG_PREFIX}/cache"

OPTIONS=NULL
SEARCH_TERM1=$1
SEARCH_TERM2=$2
CACHE_NAME=$3
CACHE_PATH="${CONFIG_PREFIX}/cache/$CACHE_NAME"
IGNORE_CASE=$4

# check parmaters
if [[ -z "$SEARCH_TERM1" || -z "$SEARCH_TERM2" || -z "$CACHE_NAME"  ]]; then
    echo "Error: no "SEARCH_TERM1 or SEARCHTERM2 or CACHE_NAME"  specified ..."
    exit
fi

echo "$SEARCH_TERM1 <OR> $SEARCH_TERM2 $IGNORE_CASE" >> ${CONFIG_PREFIX}/cache/search_history_all
cat "$CACHE_PATH" | egrep --color=always $IGNORE_CASE "$SEARCH_TERM1" | tee ${CONFIG_PREFIX}/queue
cat "$CACHE_PATH" | egrep --color=always $IGNORE_CASE "$SEARCH_TERM2" | sort -u | tee -a ${CONFIG_PREFIX}/queue
