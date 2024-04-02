#!/bin/bash

SEARCH_TERM1=$1
SEARCH_TERM2=$2
CACHE_NAME=$3

echo "$SEARCH_TERM1 <OR> $SEARCH_TERM2 $IGNORE_CASE" >> ./.music_shell/cache/search_history_all
cat "$CACHE_NAME" | egrep --color=always -i "$SEARCH_TERM1" | tee ./.music_shell/queue
cat "$CACHE_NAME" | egrep --color=always -i "$SEARCH_TERM2" | tee -a ./.music_shell/queue

# S1=$(cat "$CACHE_NAME" | egrep --color=always -i "$SEARCH_TERM1")
# S2=$(cat "$CACHE_NAME" | egrep --color=always -i "$SEARCH_TERM2")

# echo $S1 $S2 | tee playing
#cp playing cache/hist_"$date $SEARCH_TERM1_||_$SEARCH_TERM2".txt
#echo -e "Match Count: \e[31m$(cat playing | wc -l) / $(cat "$CACHE_NAME" | wc -l)\e[0m ... searching for -> \e[31m\""$SEARCH_TERM1 \| $SEARCH_TERM2"\"\e[0m"