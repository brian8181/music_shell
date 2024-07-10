#!/bin/bash

# filter / delete by [filter text]
FILE='src/filter.sh'
VERSION='0.0.1'
FILE_DATE='Sat Apr 27 04:26:33 PM CDT 2024'

HOME="/home/brian"
CONFIG_PREFIX="$HOME/.music_shell"
CACHE_PATH="${CONFIG_PREFIX}/cache"

SEARCH_TERM="$1"
FILTER="$2"

search.sh "$SEARCH_TERM" | sed "/$FILTER/d"
