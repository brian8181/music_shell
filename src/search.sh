#!/bin/bash

FILE='src/search.sh'
VERSION='0.0.1'
FILE_DATE='Sat Apr 27 04:26:33 PM CDT 2024'

HOME="/home/brian"
CONFIG_PREFIX="$HOME/.music_shell"
CACHE_PATH="${CONFIG_PREFIX}/cache"

SEARCH_TERM="$1"
#PLAYLIST_NAME="${CONFIG_PREFIX}/${2:-new_playlist}"
CACHE_NAME="${CACHE_PATH}/${2:-cache.m3u}"
IGNORE_CASE="${3:-i}" # not used

function SEARCH
{
    # check parmaters
    if [[ -z "$SEARCH_TERM" ]]; then
        echo "Error: no "SEARCH_TERM" specified ..."
        exit
    fi
    cat "$CACHE_NAME" | egrep --color=always "$SEARCH_TERM" | tee $HOME/.music_shell/queue
}

SEARCH $SEARCH_TERM $CACHE_NAME

# hack
PLAYLIST_NAME="$HOME/.music_shell/queue"
./search_footer.sh "$SEARCH_TERM" "$CACHE_NAME" "$PLAYLIST_NAME"