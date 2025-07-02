#!/bin/bash

# FILE: 'src/or_search.sh'
# VERSION: '0.0.1'
# FILE_DATE: 'Fri Jul 12 07:03:30 AM CDT 2024'
# INFO: OR search (a OR b)

CONFIG_PREFIX="$HOME/.music_shell"
SEARCH_TERM1="$1"
SEARCH_TERM2="$2"
PLAYLIST=${CONFIG_PREFIX}/${3:-.QUEUE}
CACHE="${CONFIG_PREFIX}/cache/${4:-cache.m3u}"
IGNORE_CASE="$5"

# check parmaters
if [[ -z "$SEARCH_TERM1" || -z "$SEARCH_TERM2" || -z "$CACHE"  ]]; then
    echo "Error: no "SEARCH_TERM1 or SEARCHTERM2 or CACHE"  specified ..."
    exit
fi

echo "$SEARCH_TERM1 <OR> $SEARCH_TERM2 $IGNORE_CASE" >> ${CONFIG_PREFIX}/cache/search_history_all
cat "$CACHE" | egrep --color=never "$SEARCH_TERM1" | tee -a "$PLAYLIST"
cat "$CACHE" | egrep --color=never "$SEARCH_TERM2" | sort -u | tee -a "$PLAYLIST"

./search_footer.sh "$SEARCH_TERM1 <or> $SEARCH_TERM2" "$CACHE" "$PLAYLIST"
