#!/usr/bin/bash

./music_search.sh "$1" ./music_cache.txt | ./music_search.sh "$2"