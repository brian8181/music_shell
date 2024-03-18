#!/bin/bash

SEARCH_TERM=$1
CACHE_NAME=$2
IGNORE_CASE=$3

echo "$SEARCH_TERM $IGNORE_CASE" >> cache/search_history_all

cat "$CACHE_NAME" | egrep --color=always $IGNORE_CASE "$SEARCH_TERM" | tee playing
echo -e "Match Count: \e[31m$(cat playing | wc -l) / $(cat "$CACHE_NAME" | wc -l)\e[0m ... searching for -> \e[31m\""$SEARCH_TERM"\"\e[0m"