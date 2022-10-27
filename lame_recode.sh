#!/usr/bin/bash

IFILE=$1
OFILE=$2
VBR=$3
OPTIONS=${VBR:='-V2'}

# check if art exist
ART=${IFILE%%/*}/front.jpg
if [ -f "$ART" ]; then
    OPTIONS="$OPTIONS --ti $ART"
fi

TAGS=$(~/src/tag/tag $IFILE)
# get comma speerated values
IFS=, 
read TITLE ARTIST ALBUM YEAR COMMENT TRACK GENRE <<<$TAGS
echo $TITLE $ARTIST $ALBUM $COMMENT $TRACK $GENRE

# --tt <title>    audio/song title (max 30 chars for version 1 tag)
# --ta <artist>   audio/song artist (max 30 chars for version 1 tag)
# --tl <album>    audio/song album (max 30 chars for version 1 tag)
# --ty <year>     audio/song year of issue (1 to 9999)
# --tc <comment>  user-defined text (max 30 chars for v1 tag, 28 for v1.1)
# --tn <track[/total]>
#                 audio/song track number (1 to 255, creates v1.1 tag.
#                 adding a total force a version 2 tag)
# --tg <genre>    audio/song genre (name or number in list)
# --ti <file>     audio/song albumArt (jpeg/png/gif file, v2.3 tag)

# call lame encoder
TAGS="--tt "$TITLE" --ta "$ARTIST" --tl "$ALBUM" --ty "$YEAR" --tc "$COMMENT" --tn "$TRACK" --tg "$GENRE""
echo Lame options: $TAGS
echo $OPTIONS

#lame $OPTION  --tt "$TITLE" --ta "$ARTIST" --tl "$ALBUM" --ty "$YEAR" --tc "$COMMENT" --tn "$TRACK" --tg "$GENRE" "$IFILE" "$OFILE"

# this writes the art but the other tags are lost!
lame -V2 --ti "$ART" "$IFILE" "$OFILE"

# this get the title!
lame -V2 --ti "$ART" --tt "$TITLE" "$IFILE" "$OFILE"

# this get the title!
lame -V2 --ti "$ART" --tt "$TITLE" --ta "$ARTIST" "$IFILE" "$OFILE"