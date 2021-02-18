#!/usr/bin/bash

#echo $1
cat ./music_cache.txt | egrep "$1" | tee playing



