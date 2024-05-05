#!/bin/bash
settings.sh

HOME="/home/brian"
CONFIG_PREFIX="$HOME/.music_shell"
CACHE_PATH="${CONFIG_PREFIX}/cache"

SEARCH_TERM="$1"
PLAYLIST_NAME="${CONFIG_PREFIX}/${2:-new_playlist}"
CACHE_NAME="${CACHE_PATH}/${3:-cache.m3u}"
IGNORE_CASE="${4:-i}"

# check parmaters
if [[ -z "$SEARCH_TERM" ]]; then
    echo "Error: no "SEARCH_TERM" specified ..."
    exit
fi

#echo "$SEARCH_TERM $IGNORE_CASE" >> $HOME/.music_shell/cache/search_history_all
cat "$CACHE_NAME" | egrep --color=always "$SEARCH_TERM" | tee $HOME/.music_shell/queue