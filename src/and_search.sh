#!/usr/bin/bash

SEARCH_TERM1=$1
SEARCH_TERM2=$2
CACHE_NAME=$3


cat "$CACHE_NAME" | egrep --color=always -i "$SEARCH_TERM1" | egrep --color=always -i "$SERACH_TERM2"
#echo -e "Match Count: \e[31m$(cat "playing" | wc -l)/$(cat "$1" | wc -l)\e[0m ... searching for -> \e[31m\"../cache.txt\"\e[0m"