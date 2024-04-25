#!/bin/bash

# load export settings
./settings.sh

OPTIONS=NULL
SEARCH_TERM1=$1
SEARCH_TERM2=$2
CACHE_NAME=$3
CACHE_PATH="${CONFIF_PREFIX}/cache/$CACHE_NAME"
IGNORE_CASE=$4

# check parmaters
if [[ -z "$SEARCH_TERM1" || -z "$SEARCH_TERM2" || -z "$CACHE_NAME"  ]]; then
    echo "Error: no "SEARCH_TERM1 or SEARCHTERM2 or CACHE_NAME"  specified ..."
    exit
fi

echo "$SEARCH_TERM1 <OR> $SEARCH_TERM2 $IGNORE_CASE" >> ${CONFIF_PREFIX}/cache/search_history_all
cat "$CACHE_PATH" | egrep --color=always $IGNORE_CASE "$SEARCH_TERM1" | tee ${CONFIF_PREFIX}/queue
cat "$CACHE_PATH" | egrep --color=always $IGNORE_CASE "$SEARCH_TERM2" | sort -u | tee -a ${CONFIF_PREFIX}/queue
