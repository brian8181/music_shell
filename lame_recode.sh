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

lame $OPTIONS $IFILE $OFILE