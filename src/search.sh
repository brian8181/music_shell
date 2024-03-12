#!/usr/bin/bash
SEARCH_TERM=$1

cat ../cache.txt | egrep --color=always -i "$SEARCH_TERM"
