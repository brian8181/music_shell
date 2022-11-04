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
$   
    TAGS=$(./src/tag "$IFILE")
    echo File: "$IFILE"
    echo Tags: "$TAGS"
    #FIRST={TAGS%%,*}
    LAST=${TAGS##*,}
    COMMENT=$LAST
    REMOVE_LAST=${TAGS%,*}
    REMOVE_LAST=${REMOVE_LAST%,*}
    LAST=${TAGS##*,}
    GENRE=$LAST


    echo "OUTPUT: $TRACK | $ARTIST | $ALBUM | $TITLE"
    # lame -V4 "$IFILE" "${IFILE%*.mp3}".mp3
    lame -V4 "$IFILE" "${IFILE}.1"
    # lame -V4 --ti "$ART" --tt "$TITLE" --ta "$ARTIST" --tl "$ALBUM"--ty "$YEAR" --tc "$COMMENT" --tn "$TRACK" --tg "$GENRE" "$IFILE" "~/tmp/$IFILE"
done