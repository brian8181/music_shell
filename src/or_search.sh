#!/bin/bash

# load export settings
./settings.sh

SEARCH_TERM1=$1
SEARCH_TERM2=$2
CACHE_NAME="$HOME/.music_shell/cache/$3"
IGNORE_CASE=$4

echo "$SEARCH_TERM1 <OR> $SEARCH_TERM2 $IGNORE_CASE" >> /home/brian/.music_shell/cache/search_history_all
cat "$CACHE_NAME" | egrep --color=always $IGNORE_CASE "$SEARCH_TERM1" | tee /home/brian/.music_shell/queue
cat "$CACHE_NAME" | egrep --color=always $IGNORE_CASE "$SEARCH_TERM2" | sort -u | tee -a /home/brian/.music_shell/queue
