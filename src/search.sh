#!/bin/bash

FILE='src/search.sh'
VERSION='0.1.1'
FILE_DATE='Wed Jul 10 12:07:23 PM CDT 2024'

HOME="/home/brian"
CONFIG_PREFIX="$HOME/.music_shell"
CACHE_PATH="${CONFIG_PREFIX}/cache"

SEARCH_TERM="$1"
CACHE_NAME="${CACHE_PATH}/${2:-cache.m3u}"
PLAYLIST_NAME="${3:-${CONFIG_PREFIX}/queue}"
IGNORE_CASE="${4:-i}" # not used

function SEARCH
{
    # check parmaters
    if [[ -z "$SEARCH_TERM" ]]; then
        echo "Error: no "SEARCH_TERM" specified ..."
        exit
    fi
    cat "$CACHE_NAME" | egrep --color=always "$SEARCH_TERM" | tee "$PLAYLIST_NAME"
}

SEARCH "$SEARCH_TERM" "$CACHE_NAME" "$PLAYLIST_NAME"
./search_footer.sh "$SEARCH_TERM" "$CACHE_NAME" "$PLAYLIST_NAME"