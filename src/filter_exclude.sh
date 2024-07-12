#!/bin/bash

# FILE 'src/exfilter.sh'
# VERSION '0.1.1'
# FILE_DATE 'Wed Jul 10 12:07:23 PM CDT 2024'

# exclusive filter
# filter all but [filter text]
CONFIG_PREFIX="$HOME/.music_shell"
CACHE_PATH="${CONFIG_PREFIX}/cache"

SEARCH_TERM="$1"
FILTER="$2"

search.sh "$SEARCH_TERM" | sed -n "/$FILTER/p"
