#!/bin/bash

# load export settings
./settings.sh

OPTIONS=NULL
SEARCH_TERM=$1
CACHE_NAME="$HOME/.music_shell/cache/$2"
IGNORE_CASE=$3

if [ -z "$SEARCH_TERM" ]; then
    echo "Error: no "SEARCH_TERM" specified ..."
    exit
fi

echo "$SEARCH_TERM $IGNORE_CASE" >> $HOME/.music_shell/cache/search_history_all
cat "$CACHE_NAME" | egrep --color=never $IGNORE_CASE "$SEARCH_TERM" | tee $HOME/.music_shell/queue
#cp music_shell/queue music_shell/cache/hist_"$(date.sh) \"$SEARCH_TERM\"".txt
