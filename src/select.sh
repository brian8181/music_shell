#!/bin/bash

#$~/src/music_shell/src/utility/fields.sh

FIELDS=$1
echo ${FIELDS}
#FIELDS=$(echo $FIELDS | sed -E "s/([[:digit:]]*)/\\\\1/g")
FOLDER=1
ARTIST=2
DATE=3
ALBUM=4
DISC=5
TRACK=6
TITLE=7
EXT=8

VALID_CHARS="[-a-zA-Z0-9_ ]"
#cut -d"|" -f "$ARTIST $DATE $ALBUM $TRACK $TITLE" cache/cache.txt > s.txt
cut -d"|" -f "1 2 3 4 5 6 7" cache/cache.txt > s.txt

#  ^(1)FOLDER              |(2)ARTIST               |(3)DATE          |(4)ALBUM       |(5)Disc           |(6)TRACK         |(6)TITLE                .(7)EXT$
R="([[:alnum:]]+)\|([[:alnum:][:blank:]]*)\|([[:digit:]]{4})\|([[:alnum:][:blank:]]*)\|([[:digit:]]{2}?)\|([[:digit:]]{2})\|([[:alnum:][:blank:]]*)\.(mp3|ogg|flac)$"
cat cache/cache.txt | sed -E "s/$R/\8\7\6\5\4\3\2\1/g"
