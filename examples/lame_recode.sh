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
    echo TEST:"${IFILE%/*}"
    echo TEST:"${IFILE%.*}"
    echo Tags: "$TAGS"

    COMMENT=${TAGS##*|}

    TAGS=${TAGS%|*} # REMOVE_LAST
    GENRE=${TAGS##*|}

    TAGS=${TAGS%|*} # REMOVE_LAST
    TITLE=${TAGS##*|}

    TAGS=${TAGS%|*} # REMOVE_LAST
    YEAR=${TAGS##*|}

    TAGS=${TAGS%|*} # REMOVE_LAST
    ALBUM=${TAGS##*|}

    TAGS=${TAGS%|*} # REMOVE_LAST
    ARTIST=${TAGS##*|}

    TAGS=${TAGS%|*} # REMOVE_LAST
    TRACK=${TAGS##*|}
    echo "OUTPUT: $TRACK | $ARTIST | $ALBUM | $TITLE | $YEAR | $GENRE | $COMMENT"
    

    # lame -V4 "$IFILE" "${IFILE%*.mp3}".mp3
    # lame -V4 --ti "$ART" --tn "$TRACK" --ty "$YEAR" --tt "$TITLE" --ta "$ARTIST" --tl "$ALBUM" --tg "$GENRE" --tc "$COMMENT" "$IFILE" "${IFILE}.mp3"
    mkdir -p TEST
    #lame -V4 "$IFILE" "${IFILE%.*}.copy.mp3"
    #lame -V4 --ti "$ART" --tt $TITLE" --ta "$ARTIST" --tl "$ALBUM" --ty "$YEAR" --tc "$COMMENT" --tn "$TRACK" --tg "$GENRE" "$IFILE" "~/tmp/$IFILE"

    ffmpeg -i "$IFILE" -i $ART -map 0:0 -map 1:0 -c copy -id3v2_version 3 -metadata:s:v title="Album cover" -metadata:s:v comment="Cover (Front)" "${IFILE%.*}.copy.mp3"
    #ffmpeg -i x.mp3 -i x.jpg -map 0:0 -map 1:0 -c copy -id3v2_version 3 -metadata:s:v title="Album cover" -metadata:s:v comment="Cover (Front)" xx.mp3

done