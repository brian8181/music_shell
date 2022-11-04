#!/bin/bash

DIR=$1
IFS='|'

# check if art exist
ART=${DIR%/*}/front.jpg
echo $ART
if [ -f "$ART" ]; then
    OPTIONS="$OPTIONS --ti $ART"
fi

for IFILE in $@;
do
    TAGS=$(./src/tag "$IFILE")
    echo File: "$IFILE"
    echo Tags: "$TAGS"
    TRACK=${TAGS%%,*}
    echo TRACK:$TRACK
    ARTIST=${TAGS%,*,*,*}
    ALBUM=${TAGS##*,*,}
    TITLE=${TAGS#*,*,*,*} 
    echo "OUTPUT: $TRACK | $ARTIST | $ALBUM | $TITLE"
    # lame -V4 "$IFILE" "${IFILE%*.mp3}".mp3
    lame -V4 "$IFILE" "${IFILE}.1"
    # lame -V4 --ti "$ART" --tt "$TITLE" --ta "$ARTIST" --tl "$ALBUM"--ty "$YEAR" --tc "$COMMENT" --tn "$TRACK" --tg "$GENRE" "$IFILE" "~/tmp/$IFILE"
done