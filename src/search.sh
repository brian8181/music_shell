#!/bin/bash
FILE='src/search.sh'
VERSION='0.1.2'
FILE_DATE='Thu Jul 11 07:03:20 PM CDT 2024'

CONFIG_PREFIX="$HOME/.music_shell"
SEARCH_TERM="$1"
PLAYLIST=${CONFIG_PREFIX}/${3:-queue}
CACHE="${CONFIG_PREFIX}/cache/${3:-cache.m3u}"
IGNORE_CASE="$4"

function SEARCH
{
    # check parmaters
    if [[ -z "$SEARCH_TERM" ]]; then
        echo "Error: no "SEARCH_TERM" specified ..."
        exit
    fi
    cat "$CACHE" | egrep --color=always "$SEARCH_TERM" | tee "$PLAYLIST"
}

SEARCH "$SEARCH_TERM" "$CACHE" "$PLAYLIST"
./search_footer.sh "$SEARCH_TERM" "$CACHE" "$PLAYLIST"