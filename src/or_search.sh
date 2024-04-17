#!/bin/bash

# load export settings
./settings.sh

OPTIONS=NULL
SEARCH_TERM1=$1
SEARCH_TERM2=$2
CACHE_NAME="$HOME/.music_shell/cache/$3"
IGNORE_CASE=$4

# error ?
#if [ -z "$SEARCH_TERM1" || -z "$SEARCH_TERM2" || -z "$CACHE_NAME"  ]; then
if [ -z "$SEARCH_TERM1" ]; then
    echo "Error: no "SEARCH_TERM1 or SEARCHTERM2 or CACHE_NAME"  specified ..."
    exit
fi

echo "$SEARCH_TERM1 <OR> $SEARCH_TERM2 $IGNORE_CASE" >> $HOME/.music_shell/cache/search_history_all
cat "$CACHE_NAME" | egrep --color=always $IGNORE_CASE "$SEARCH_TERM1" | tee $HOME/.music_shell/queue
cat "$CACHE_NAME" | egrep --color=always $IGNORE_CASE "$SEARCH_TERM2" | sort -u | tee -a $HOME/.music_shell/queue
