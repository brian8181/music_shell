#!/bin/bash

settings.sh

SEARCH_TERM=$1
IGNORE_CASE=$2
CACHE_NAME="cache.m3u"

search.sh "$SEARCH_TERM" "${CONFIG_PREFIX}/cache/$CACHE_NAME" "$IGNORE_CASE"

#echo -e "Match Count: \e[31m$(cat "${CONFIG_PREFIX}/queue" | wc -l) / $(cat "${CONFIG_PREFIX}/cache/$CACHE_NAME" | wc -l)\e[0m ... searching for -> \e[31m\""$SEARCH_TERM"\"\e[0m"
