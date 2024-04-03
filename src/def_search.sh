#!/bin/bash

SEARCH_TERM=$1
IGNORE_CASE=$2

./search.sh "$SEARCH_TERM"  "cache.txt" $IGNORE_CASE
