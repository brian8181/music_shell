#!/bin/bash

settings.sh

SEARCH_TERM=$1
IGNORE_CASE=$2
CACHE_NAME="cache.txt"

search.sh "$SEARCH_TERM" "$HOME/.music_shell/cache/$CACHE_NAME" "$IGNORE_CASE"

#echo -e "Match Count: \e[31m$(cat "$HOME/.music_shell/queue" | wc -l) / $(cat "$HOME/.music_shell/cache/$CACHE_NAME" | wc -l)\e[0m ... searching for -> \e[31m\""$SEARCH_TERM"\"\e[0m"
