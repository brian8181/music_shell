#!/bin/bash

SEARCH_TERM=$1
CACHE_NAME="../cache/cache.txt"
PLAYLIST_NAME=$2
TEE_OPTION=$3

if [[ ! -f "$CACHE_NAME" ]]; then
    echo "error: $CACHE_NAME does not exists"
    exit
fi

./create_playlist.sh "$SEARCH_TERM" "$CACHE_NAME" "$PLAYLIST_NAME"