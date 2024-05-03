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
CONFIG_PATH="$HOME/.music_shell"
CACHE_PATH="${CONFIG_PATH}/cache"

while getopts aoihn:c:p: option
do
    case "${option}"
    in
        a)
            PRINT_INFO "AND ..."

            SEARCH_TERM1="$2"
            SEARCH_TERM2="$3"
            PLAYLIST_NAME="${CONFIG_PATH}/${4:=new_playlist}"
            CACHE_NAME="${CACHE_PATH}/${5:-cache.m3u}"
            IGNORE_CASE="$6"
            PRINT_INFO "\"$SEARCH_TERM1\" <AND> \"$SEARCH_TERM2\" $IGNORE_CASE"

            # check parmaters
            if [[ -z "$SEARCH_TERM1" || -z "$SEARCH_TERM2" || -z "$CACHE_NAME"  ]]; then
                echo "Error: no "SEARCH_TERM1 or SEARCH_TERM2 or CACHE_NAME"  specified ..."
                exit
            fi

            rm "${PLAYLIST_NAME}".m3u # todo error file exsit
            cat "${CACHE_NAME}" | egrep --color=always $IGNORE_CASE "$SEARCH_TERM1" | egrep --color=always $IGNORE_CASE "$SEARCH_TERM2" > "${PLAYLIST_NAME}".m3u
            ;;

        o)
            PRINT_INFO "OR ..."

            SEARCH_TERM1="$2"
            SEARCH_TERM2="$3"
            PLAYLIST_NAME="${CONFIG_PATH}/${4:=new_playlist}"
            CACHE_NAME="${CACHE_PATH}/${5:-cache.m3u}"
            IGNORE_CASE="$6"
            PRINT_INFO "\"$SEARCH_TERM1\" <OR> \"$SEARCH_TERM2\" $IGNORE_CASE"

            # check parmaters
            if [[ -z "$SEARCH_TERM1" || -z "$SEARCH_TERM2" || -z "$CACHE_NAME"  ]]; then
                echo "Error: no "SEARCH_TERM1 or SEARCHTERM2 or CACHE_NAME"  specified ..."
                exit
            fi

            rm "${PLAYLIST_NAME}".m3u # todo error file exsit
            cat "${CACHE_NAME}" | egrep --color=always $IGNORE_CASE "$SEARCH_TERM1" > "${PLAYLIST_NAME}".m3u.swp
            cat "${PLAYLIST_NAME}".m3u.swp | egrep --color=always $IGNORE_CASE "$SEARCH_TERM2" | sort -u >> "${PLAYLIST_NAME}".m3u
            rm "${PLAYLIST_NAME}".m3u.swp
            ;;

        n)
            PRINT_INFO "single search term ..."

            SEARCH_TERM="$2"
            PLAYLIST_NAME="${CONFIG_PATH}/${3:=new_playlist}"
            CACHE_NAME="${CACHE_PATH}/${4:-cache.m3u}"
            IGNORE_CASE="$5"

            # check parmaters
            if [[ -z "$SEARCH_TERM" ]]; then
                echo "Error: no "SEARCH_TERM" specified ..."
                exit
            fi

            rm "${PLAYLIST_NAME}".m3u # todo error file exsit
            cat "$CACHE_NAME" | egrep --color=always $IGNORE_CASE "$SEARCH_TERM" > "${PLAYLIST_NAME}.m3u"
            ;;
        h)
            echo
            echo "Usage:"
            echo "create_playlist.sh [-aioh] search_term [search_term] [name=~/.music_shell/new_playlist.m3u] [cache=~/.music_shell/cache/cache.m3u]"
            echo "create_playlist.sh -n \"Pink Floyd\" pink_floyd"
            echo "create_playlist.sh -ni \"Pink Floyd\" pink_floyd # ignore case"
            echo "create_playlist.sh -a \"Pink\" \"Floyd\" pink_floyd # Pink \"and\" Floyd"
            echo "create_playlist.sh -o \"Pink\" \"Floyd\" pink_floyd # Pink \"or\" Floyd"
            echo
            ;;
        c)
            CACHE_NAME="$HOME/.music_shell/cache/$OPTARG";
            #shift 2;
            echo $CACHE_NAME
            ;;
        p)
            PLAYLIST_NAME="$OPTARG";
            #shift 2;
            echo $PLAYLIST_NAME
            ;;
        i)
            IGNORE_CASE='-i';
            shift;
            ;;
        \?)
            PRINT_DEBUG error "Invalid option: -$OPTARG" >&2
            exit 1
            ;;

    esac
done

##{ END YOUR CODE  }##
PRINT_INFO "finished creating playlist ..."
PRINT_INFO "\"$FILE\" -> Exiting.   @ $DATE"
