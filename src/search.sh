#!/bin/bash

SEARCH_TERM=$1
CACHE_NAME="/home/brian/.music_shell/cache/$2"
IGNORE_CASE=$3

echo "$SEARCH_TERM $IGNORE_CASE" >> /home/brian/.music_shell/cache/search_history_all
cat "$CACHE_NAME" | egrep --color=always $IGNORE_CASE "$SEARCH_TERM" | tee ~/.music_shell/queue
#cp music_shell/queue music_shell/cache/hist_"$(date.sh) \"$SEARCH_TERM\"".txt
