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

HOME="/home/brian"

while getopts aon option
do
    case "${option}"
        in
        a)  echo "AND";;

            # SEARCH_TERM1=$2
            # SEARCH_TERM2=$3
            # CACHE_NAME="$4"
            # PLAYLIST_NAME=$5
            # CACHE_PATH="$HOME/.music_shell/cache/$CACHE_NAME"
            # IGNORE_CASE=$6

            # # check parmaters
            # if [[ -z "$SEARCH_TERM1" || -z "$SEARCH_TERM2" || -z "$CACHE_NAME"  ]]; then
            #     echo "Error: no "SEARCH_TERM1 or SEARCH_TERM2 or CACHE_NAME"  specified ..."
            #     exit
            # fi

            # #echo "$SEARCH_TERM1 <AND> $SEARCH_TERM2 $IGNORE_CASE" >> $HOME/.music_shell/cache/search_history_all
            # cat "$CACHE_PATH" | egrep --color=always $IGNORE_CASE "$SEARCH_TERM1" | egrep --color=always $IGNORE_CASE "$SEARCH_TERM2" > "${PLAYLIST_NAME}".m3u
            
        o)  echo "OR";;

            # SEARCH_TERM1=$2
            # SEARCH_TERM2=$3
            # CACHE_NAME="$4"
            # PLAYLIST_NAME=$5
            # CACHE_PATH="$HOME/.music_shell/cache/$CACHE_NAME"
            # IGNORE_CASE=$6

            # # check parmaters
            # if [[ -z "$SEARCH_TERM1" || -z "$SEARCH_TERM2" || -z "$CACHE_NAME"  ]]; then
            #     echo "Error: no "SEARCH_TERM1 or SEARCHTERM2 or CACHE_NAME"  specified ..."
            #     exit
            # fi

            # echo "$SEARCH_TERM1 <OR> $SEARCH_TERM2 $IGNORE_CASE" >> ${CONFIF_PREFIX}/cache/search_history_all
            # cat "$CACHE_PATH" | egrep --color=always $IGNORE_CASE "$SEARCH_TERM1" | tee "${PLAYLIST_NAME}".m3u.swp
            # cat "${PLAYLIST_NAME}".m3u.swp | egrep --color=always $IGNORE_CASE "$SEARCH_TERM2" | sort -u | tee -a "${PLAYLIST_NAME}".m3u

        n)  echo "NONE"

            SEARCH_TERM=$2
            CACHE_NAME="$HOME/.music_shell/cache/$3"
            PLAYLIST_NAME=$4
            IGNORE_CASE=$5

            cat "$CACHE_NAME" | egrep "$SEARCH_TERM" > "$HOME/${PLAYLIST_NAME}.m3u.swp"
            #cat "$CACHE_NAME" | egrep --color=always $IGNORE_CASE "$SEARCH_TERM" | tee -a "$HOME/${PLAYLIST_NAME}.m3u.swp"
            cat "$HOME/${PLAYLIST_NAME}.m3u.swp" | sort -u > "$HOME/${PLAYLIST_NAME}.m3u"
            rm $HOME/"${PLAYLIST_NAME}.m3u.swp"

            ;;
    esac
done




PRINT_INFO "finished creating playlist ..."

##{ END YOUR CODE  }##
PRINT_INFO "\"$FILE\" -> Exiting.   @ $DATE"
