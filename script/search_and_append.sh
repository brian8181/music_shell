#!/bin/bash

# FILE: 'and_search.sh'
# VERSION: '0.0.1'
# FILE_DATE: 'Fri Jul 12 07:03:30 AM CDT 2024'
# INFO: AND search (a AND b)

CONFIG_PREFIX="$HOME/.music_shell"
SEARCH_TERM1="$1"
SEARCH_TERM2="$2"
PLAYLIST="${CONFIG_PREFIX}/${3:-queue}"
CACHE="${CONFIG_PREFIX}/cache/${3:-cache.m3u}"
IGNORE_CASE="$4"

# check parmaters
if [[ -z "$SEARCH_TERM1" || -z "$SEARCH_TERM2" || -z "$CACHE"  ]]; then
    echo "Error: no "SEARCH_TERM1 or SEARCH_TERM2 or CACHE"  specified ..."
    exit
fi

echo "$SEARCH_TERM1 <AND> $SEARCH_TERM2 $IGNORE_CASE" >> ${CONFIG_PREFIX}/cache/search_history_all
cat "$CACHE" | egrep --color=never "$SEARCH_TERM1" | egrep --color=never "$SEARCH_TERM2" | tee -a $PLAYLIST
./search_footer.sh "$SEARCH_TERM1 <and> $SEARCH_TERM2" "$CACHE" "$PLAYLIST"
