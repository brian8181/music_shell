#!/bin/bash

# FILE: 'src/search.sh'
# VERSION: '0.0.1'
# FILE_DATE: 'Fri Jul 12 07:03:30 AM CDT 2024'
# INFO: search queue

CONFIG_PREFIX="$HOME/.music_shell"
SEARCH_TERM="$1"
PLAYLIST=${CONFIG_PREFIX}/${3:-.QUEUE}
CACHE=${CONFIG_PREFIX}/cache/${2:-cache.m3u}
IGNORE_CASE="$4"

function SEARCH
{
    # check parmaters
    if [[ -z "$SEARCH_TERM" ]]; then
        echo "Error: no "SEARCH_TERM" specified ..."
        exit 1
    fi
    cat "$CACHE" | egrep --color=never "$SEARCH_TERM" | tee -a "$PLAYLIST"
}

SEARCH "$SEARCH_TERM" "$CACHE" "$PLAYLIST"
search_footer.sh "$SEARCH_TERM" "$CACHE" "$PLAYLIST"

exit 0