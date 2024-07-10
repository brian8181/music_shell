#!/bin/bash

SEARCH_TERM=$1
CACHE_NAME=$2
PLAYLIST_NAME=$3

echo -e "Match Count: \e[32m$(cat "${PLAYLIST_NAME}" | wc -l) / $(cat "$CACHE_NAME" | wc -l)\e[0m ... searching for -> \e[32m\""$SEARCH_TERM"\"\e[0m"