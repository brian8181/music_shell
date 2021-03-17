#!/usr/bin/bash

NAME=$1
CACHE=$2
REXP="^/.*/music-lib/albums/\\$NAME/.*$"
cat $CACHE | egrep "$REXP" | tee playing
