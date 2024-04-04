#!/bin/bash

SEARCH_TERM=$1
IGNORE_CASE=$2
CACHE_NAME='cache.txt'

./search.sh "$SEARCH_TERM" "$CACHE_NAME" $IGNORE_CASE
