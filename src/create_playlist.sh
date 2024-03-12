#!/usr/bin/bash

SEARCH_TERM=$1
PLAYLIST_NAME=$2
TEE_OPTION=$3


./search.sh "$SEARCH_TERM" | tee "$PLAYLIST_NAME" | ./pub_search.sh