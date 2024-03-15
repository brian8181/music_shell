#!/usr/bin/bash

SEARCH_TERM=$1
CACHE_NAME=$2

cat "$CACHE_NAME" | egrep --color=always -i "$SEARCH_TERM"
# echo -e "Match Count: \e[31m$(cat "playing" | wc -l)/$(cat "$1" | wc -l)\e[0m ... searching for -> \e[31m\"../cache.txt\"\e[0m"