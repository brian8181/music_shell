#!/bin/bash

FIELDS=$1

FOLDER=1
ARTIST=2
DATE=3
ALBUM=4
DISC=5
TRACK=6
TITLE=7

#VALID_CHARS="[-a-zA-Z0-9'\"~!@#&)(}{][_ ]"
VALID_CHARS="[-a-zA-Z0-9_ ]"
#FOLDER|2       ARTIST          |3        DATE               |4    ALBUM             |5   DISC           |6    TRACK         |7      TITLE           |    EXT        .ENDLINE
RECORD="^\(${VALID_CHARS}*\)\|\([0-9][0-9][0-9][0-9]\)\|\(${VALID_CHARS}*\)\|\([0-9][0-9]\)?\|\([0-9][0-9]\)?\|\(${VALID_CHARS}*\)\.\(mp3|ogg|flac\)$"

cut -d"|" -f "$ARTIST $DATE $ALBUM $TRACK $TITLE" cache/cache.txt > s.txt
#cat s.txt | sed 's/^\([a-zA-Z ]*\)|\([0-9][0-9][0-9][0-9]\)|\([a-zA-Z ]*\)|\([0-9][0-9]\)|\([a-zA-Z ]*\)\..*$/ARTIST:\1 ALBUM:\2-\3 TITLE:\4:\5/g'
#cat s.txt | sed -E "s/(\w*)\|/\1/"


R=
cat s.txt | sed -E s/"([[:alnum:][:blank:]]+)\|([[:digit:]]{4})"/\\2\\1/g
