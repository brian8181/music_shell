#!/bin/bash

./settings.sh

# ARTIST=2
# DATE=3
# ALBUM=4
# DISC=5
# TRACK=6
# TITLE=7

cut -d"|" -f "$ARTIST $DATE $ALBUM $DISC $TRACK $TITLE" $HOME/.music_shell/cache/cache.m3u