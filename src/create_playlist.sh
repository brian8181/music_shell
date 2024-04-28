#!/bin/bash

FILE='src/create_playlist.sh'
VERSION='0.0.1'
FILE_DATE='Sat Apr 27 04:26:33 PM CDT 2024'


FMT_FG_RED='\e[31m'
FMT_FG_GREEN='\e[32m'
FMT_RESET='\e[0m'
PRINT_RED_DEBUG=${FMT_FG_RED}DEBUG${FMT_RESET}
PRINT_GREEN_INFO=${FMT_FG_GREEN}INFO${FMT_RESET}
DATE=$(date "+%H:%M:%S:%s")

# USER SETTING
DEBUG_MSG="$PRINT_RED_DEBUG: "
INFO_MSG="$PRINT_GREEN_INFO: "
VERBOSE=1
DEBUG=1

if [ -n $VERBOSE ]
then
	echo ${VERBOSE:+"File - $FILE"}
	echo ${VERBOSE:+"Version - $VERSION"}
	echo ${VERBOSE:+"Date - $FILE_DATE"}

fi

function PRINT_DEBUG
{
    MSG=${DEBUG_MSG}$1
    echo -e ${DEBUG:+"$MSG"}
}

function PRINT_INFO
{
    MSG=${INFO_MSG}$1
    echo -e ${VERBOSE:+"$MSG"}
}

PRINT_INFO "\"$FILE\" -> Running... @ $DATE"
##{ BEGIN YOUR CODE  }##

PRINT_INFO "creating playlist ..."

while getopts a:o: option
do
    case "${option}"
        in
        a)and=${OPTARG};;
        o)or=${OPTARG};;
    esac
done

HOME="/home/brian"
SEARCH_TERM=$1
CACHE_NAME="$HOME/.music_shell/cache/$2"
PLAYLIST_NAME=$3
IGNORE_CASE=$3

cat "$CACHE_NAME" | egrep "$SEARCH_TERM" > "$HOME/${PLAYLIST_NAME}.m3u.swp"
#cat "$CACHE_NAME" | egrep --color=always $IGNORE_CASE "$SEARCH_TERM" | tee -a "$HOME/${PLAYLIST_NAME}.m3u.swp"
cat "$HOME/${PLAYLIST_NAME}.m3u.swp" | sort -u > "$HOME/${PLAYLIST_NAME}.m3u"
rm $HOME/"${PLAYLIST_NAME}.m3u.swp"


PRINT_INFO "finished creating playlist ..."

##{ END YOUR CODE  }##
PRINT_INFO "\"$FILE\" -> Exiting.   @ $DATE"
