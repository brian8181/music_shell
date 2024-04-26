
#!/bin/bash

FILE='src/create_playlist.sh'
VERSION='0.0.1'
FILE_DATE='Fri Apr 26 11:57:48 AM CDT 2024'

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

# load export settings
#./settings.sh

#OPTIONS=NULL
SEARCH_TERM=$1
CACHE_NAME="$HOME/.music_shell/cache/$2"
PLAYLIST_NAME=$3
IGNORE_CASE=$4

# if [[ ! -r "$CACHE_NAME" ]]; then
#     echo "error: $CACHE_NAME does not exists"
#     exit
# fi

if [ -z "$SEARCH_TERM" ]; then
    echo "Error: no "SEARCH_TERM" specified ..."
    exitrm
fi

cat "$CACHE_NAME" | egrep --color=always $IGNORE_CASE "$SEARCH_TERM" | tee -a $HOME/"${PLAYLIST_NAME}.m3u.swp"
cat $HOME/"${PLAYLIST_NAME}.m3u.swp" | sort -u > $HOME/"${PLAYLIST_NAME}.m3u"
rm $HOME/"${PLAYLIST_NAME}.m3u.swp"

##{ END YOUR CODE  }##
PRINT_INFO "\"$FILE\" -> Exiting.   @ $DATE"
