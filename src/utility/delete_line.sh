#!/bin/bash
FILE='src/delete_line.sh'
VERSION='0.1.1'
FILE_DATE='Wed Jul 10 12:07:23 PM CDT 2024'

# delete line
HOME="/home/brian"
CONFIG_PREFIX="$HOME/.music_shell"
CACHE_PATH="${CONFIG_PREFIX}/cache"

SEARCH_TERM="$1"
DELETE_LINE="$2"

search.sh "$SEARCH_TERM" | sed "$DELETE_LINE"d