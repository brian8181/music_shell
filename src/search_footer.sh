#!/bin/bash
FILE='src/search_footer.sh'
VERSION='0.1.1'
FILE_DATE='Wed Jul 10 12:07:23 PM CDT 2024'

SEARCH_TERM=$1
CACHE_NAME=$2
PLAYLIST_NAME=$3

echo -e "Match Count: \e[32m$(cat "${PLAYLIST_NAME}" | wc -l) / $(cat "$CACHE_NAME" | wc -l)\e[0m ... searching for -> \e[32m\""$SEARCH_TERM"\"\e[0m"