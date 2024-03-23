#!/bin/bash
FIELD=$1
ARTIST=2
DATE=3
ALBUM=4
DISC=5
TRACK=6
TITLE=7

cut -d"|" -f "$FIELD" ccahe/cache.txt