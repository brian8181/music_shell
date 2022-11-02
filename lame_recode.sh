#!/bin/bash
IFS='|'

for IFILE in $@;
do
    # check if art exist
    # ART=${$IFILE%%/*}/front.jpg
    # if [ -f "$ART" ]; then
    #     OPTIONS="$OPTIONS --ti $ART"
    # fi

    TAGS=$(./tag "$IFILE")
    ARTIST=${TAGS%,*,*,*}
    ALBUM=${TAGS##*,*,}
    TITLE=${TAGS#*,*,*,*} 

    # lame -V2 "$IFILE" "${IFILE%*.mp3}".mp3
    lame -V2 "$IFILE" "${IFILE}.1"
    # lame -V2 --ti "$ART" --tt "$TITLE" --ta "$ARTIST" --tl "$ALBUM"--ty "$YEAR" --tc "$COMMENT" --tn "$TRACK" --tg "$GENRE" "$IFILE" "~/tmp/$IFILE"
done