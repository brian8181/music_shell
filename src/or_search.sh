#!/bin/bash

SEARCH_TERM1=$1
SEARCH_TERM2=$2
CACHE_NAME=$3

S1=$(cat "$CACHE_NAME" | egrep --color=always -i "$SEARCH_TERM1")
S2=$(cat "$CACHE_NAME" | egrep --color=always -i "$SEARCH_TERM2")

echo $S1 $S2 | tee playing
echo -e "Match Count: \e[31m$(cat playing | wc -l) / $(cat "$CACHE_NAME" | wc -l)\e[0m ... searching for -> \e[31m\""$SEARCH_TERM1 \| $SEARCH_TERM2"\"\e[0m"