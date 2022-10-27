#!/usr/bin/bash

IFILE=$1
OFILE=$2
VBR=$3
OPTIONS=${VBR:='-V2'}

ART=${IFILE%%/*}/front.jpg
if [ -f "$ART" ]; then
    OPTIONS="$OPTIONS --ti $ART"
fi

echo "Options: $OPTIONS"

TAGS=$(~/src/tag/tag $IFILE)
IFS=, 
read TITLE ARTIST ALBUM YEAR COMMENT TRACK GENRE <<<$TAGS
#Verify the result
echo $TITLE $ARTIST $ALBUM $COMMENT $TRACK $GENRE

lame $OPTIONS $IFILE $OFILE