#!/usr/bin/bash

FIELDS=$1

# FOLDER=1
# ARTIST=2
# DATE=3
# ALBUM=4
# DISC=5
# TRACK=6
# TITLE=7

./show_all.sh | cut -d "|" -f "$FIELDS"
