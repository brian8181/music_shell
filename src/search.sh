#!/bin/bash

SEARCH_TERM=$1
CACHE_NAME=$2
IGNORE_CASE=$3

echo "$SEARCH_TERM $IGNORE_CASE" >> cache/search_history_all
cat "$CACHE_NAME" | egrep --color=always $IGNORE_CASE "$SEARCH_TERM" | tee queue
cp playing cache/hist_"$(date.sh) \"$SEARCH_TERM\"".txt
