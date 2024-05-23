#!/bin/bash
FILE='src/cache.sh'
VERSION='0.0.1'
FILE_DATE='Thu Apr 25 06:15:37 PM CDT 2024'

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

PRINT_INFO "$FILE -> Running... @ $DATE"
##{ BEGIN YOUR CODE  }##

HOME="/home/brian"
STORE_PREFIX="/mnt/music/music-lib"
CONFIG_PREFIX="$HOME/.music_shell"
CACHE_NAME="cache.m3u"
QUEUE_NAME="queue.m3u"
TIME_STAMP="$(date.sh)"

PRINT_INFO "searching \"${STORE_PREFIX}\", wrting cache too \"${CONFIG_PREFIX}/${TIME_STAMP}_${CACHE_NAME}\" ..."

find "${STORE_PREFIX}" -iname "*.mp3" > "${CONFIG_PREFIX}/${TIME_STAMP}_${CACHE_NAME}"
find "${STORE_PREFIX}" -iname "*.ogg" >> "${CONFIG_PREFIX}/${TIME_STAMP}_${CACHE_NAME}"
find "${STORE_PREFIX}" -iname "*.flac" >> "${CONFIG_PREFIX}/${TIME_STAMP}_${CACHE_NAME}"
find "${STORE_PREFIX}" -iname "*.wma" >> "${CONFIG_PREFIX}/${TIME_STAMP}_${CACHE_NAME}"

PRINT_INFO "finished writing cache too \"${CONFIG_PREFIX}/${TIME_STAMP}_${CACHE_NAME}\" ..."

##{ END YOUR CODE  }##
PRINT_INFO "$FILE -> Exiting.   @ $DATE"
