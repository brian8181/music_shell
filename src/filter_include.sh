#!/bin/bash

# FILE 'filter.sh'
# VERSION '0.1.1'
# FILE_DATE 'Wed Jul 10 12:07:23 PM CDT 2024'

# inclusive filter
# filter / delete by [filter text]
CONFIG_PREFIX="$HOME/.music_shell"
CACHE_PATH="${CONFIG_PREFIX}/cache"

SEARCH_TERM="$1"
FILTER="$2"

search.sh "$SEARCH_TERM" | sed "/$FILTER/d"
