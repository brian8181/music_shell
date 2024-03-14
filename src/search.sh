#!/usr/bin/bash
SEARCH_TERM=$1
PLAYLIST_NAME=$2
TEE_OPTION=$3

cat ../cache.txt | egrep --color=always -i "$SEARCH_TERM"
# echo -e "Match Count: \e[31m$(cat "playing" | wc -l)/$(cat "$1" | wc -l)\e[0m ... searching for -> \e[31m\"../cache.txt\"\e[0m"