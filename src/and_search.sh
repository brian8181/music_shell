#!/bin/bash

# load export settings
./settings.sh

SEARCH_TERM1=$1
SEARCH_TERM2=$2
CACHE_NAME="$HOME/.music_shell/cache/$3"
IGNORE_CASE=$4

echo "$SEARCH_TERM1 <AND> $SEARCH_TERM2 $IGNORE_CASE" >> $HOME/.music_shell/cache/search_history_all
cat "$CACHE_NAME" | egrep --color=always $IGNORE_CASE "$SEARCH_TERM1" | egrep --color=always $IGNORE_CASE "$SEARCH_TERM2" | tee $HOME/.music_shell/queue


#cp queue cache/hist_"$date $SEARCH_TERM1_&&_$SEARCH_TERM2".txt
#echo -e "Match Count: \e[31m$(cat playing | wc -l) / $(cat "$CACHE_NAME" | wc -l)\e[0m ... searching for -> \e[31m\""$SEARCH_TERM1 \& $SEARCH_TERM2"\"\e[0m"