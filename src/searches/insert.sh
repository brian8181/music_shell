#!/bin/bash

SEARCH_TERM=$1
CACHE_NAME=$2
IGNORE_CASE=$3
LINE_NUMBER=$4

echo "$SEARCH_TERM $IGNORE_CASE" >> cache/search_history_all
head -"$LINE_NUMBER queue > queue
cat "$CACHE_NAME" | egrep --color=always $IGNORE_CASE "$SEARCH_TERM" >> queue
