#!/bin/bash
FIELD=$1
ARTIST=2
DATE=3
ALBUM=4
DISC=5
TRACK=6
TITLE=7

# exit
if [ -n "$FIELD" ]; then
    cut -d"|" -f "$FIELD" $HOME/.music_shell/cache/cache.m3u
else
    echo "Error: no field specified ..."
    exit
fi