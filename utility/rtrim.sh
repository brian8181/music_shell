#!/bin/bash

# FILE: 'rtrim.sh'
# VERSION: '0.0.1'
# FILE_DATE: 'Thu Oct 31 08:08:03 AM CDT 2024'
# INFO: trim space from right

HOME="/home/brian"
CONFIG_PREFIX="$HOME/.music_shell"
CACHE_PATH="${CONFIG_PREFIX}/cache"

SEARCH_TERM="$1"

search.sh "$SEARCH_TERM" | sed s/ *$//
