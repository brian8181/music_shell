#!/bin/bash
FILE='{FILE}'
VERSION='{VERSION}'
FILE_DATE='{DATE}'

FMT_FG_RED='\e[31m'
FMT_RESET='\e[0m'
PRINT_RED_DEBUG=${FMT_FG_RED}DEBUG${FMT_RESET}
DATE=$(date "+%H:%M:%S:%s")

# USER SETTING
DEBUG_MSG="$PRINT_RED_DEBUG: "
VERBOSE=1
DEBUG=1
# END

if [ -n $VERBOSE ]
then
	echo ${VERBOSE:+"File - $FILE"}.
	echo ${VERBOSE:+"Version - $VERSION"}.
	echo ${VERBOSE:+"Date - $FILE_DATE"}.
fi

function PRINT_DEBUG
{
    MSG=${DEBUG_MSG}$1
    echo -e ${DEBUG:+"$MSG"}
}

PRINT_DEBUG "$FILE -> Running... @ $DATE"

##{ BEGIN YOUR CODE  }##

FILES=$@
echo $FILES
# IFILE=$1
# OFILE=$2
# VBR=$3
# OPTIONS=${VBR:='-V2'}

# TAGS=$(~/src/tag/tag $IFILE)
# # get comma speerated values
# IFS=, 
# read TITLE ARTIST ALBUM YEAR COMMENT TRACK GENRE <<<$TAGS
# echo $TITLE $ARTIST $ALBUM $COMMENT $TRACK $GENRE

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
# TAGS="--tt "$TITLE" --ta "$ARTIST" --tl "$ALBUM" --ty "$YEAR" --tc "$COMMENT" --tn "$TRACK" --tg "$GENRE""
# echo Lame options: $TAGS
# echo $OPTIONS

#lame $OPTION  --tt "$TITLE" --ta "$ARTIST" --tl "$ALBUM" --ty "$YEAR" --tc "$COMMENT" --tn "$TRACK" --tg "$GENRE" "$IFILE" "$OFILE"

# this writes the art but the other tags are lost!
#lame -V2 --ti "$ART" "$IFILE" "$OFILE"


IFS='|'
for IFILE in $@;
do
    # check if art exist
    ART=${f%%/*}/front.jpg
    if [ -f "$ART" ]; then
        OPTIONS="$OPTIONS --ti $ART"
    fi

    echo "Processing "$f" file..."
    # this get the title!
    
    # lets got for it
    # lame -V2 --ti "$ART" --tt "$TITLE" --ta "$ARTIST" --tl "$ALBUM"--ty "$YEAR" --tc "$COMMENT" --tn "$TRACK" --tg "$GENRE" "$IFILE" "~/tmp/$IFILE"
    lame -V2 "$IFILE" "${IFILE%*.flac}".mp3

        
done



##{ END YOUR CODE  }##

PRINT_DEBUG "$FILE -> Exiting.   @ $DATE"
