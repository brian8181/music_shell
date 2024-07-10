#!/bin/bash
FILE='src/cache.sh'
VERSION='0.1.1'
FILE_DATE='Wed Jul 10 12:07:23 PM CDT 2024'

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

HOME="${1}"
STORE_PREFIX="${2}"
CONFIG_PREFIX="${3}"
TIME_STAMP="$(date.sh)"
CACHE_PATH="${4}"

PRINT_INFO "searching \"${STORE_PREFIX}\", writing cache too \"${CACHE_PATH}\" ..."

find "${STORE_PREFIX}" -iname "*.mp3" > "${CACHE_PATH}"
find "${STORE_PREFIX}" -iname "*.ogg" >> "${CACHE_PATH}"
find "${STORE_PREFIX}" -iname "*.flac" >> "${CACHE_PATH}"
find "${STORE_PREFIX}" -iname "*.wma" >> "${CACHE_PATH}"

# trim off root                                             # replace delimiter   # create date & album columns
sed 's/\/mnt\/music\/music-lib\///' "${CACHE_PATH}" | sed s/\\//\|/g | sed s/' - '/\|/ | sed s/\\.[[:space:]]/\|/ > "${CACHE_PATH}.tmp"
# add disc column                                           # seperate disc & track
sed -E "s/(\|[[:digit:]][[:digit:]]\|)/\|\1/" "${CACHE_PATH}.tmp" | sed -E "s/([[:digit:]]+)\\./\1\|/" > "${CACHE_PATH}"

PRINT_INFO "finished writing cache too \"${CACHE_PATH}\" ..."
PRINT_INFO "added $(cat ${CACHE_PATH} | wc -l) items to cache : $TIME_STAMP"
PRINT_INFO "cache is located @ $CACHE_PATH."

function HELP
{
    PRINT_INFO "** HELP **"
    PRINT_INFO "HOME:$HOME STOREPREFIX:$STORE_PREFIX CONFIG+PREFIX:$CONFIG_PREFIX CACHE_NAME:$CACHE_NAME"
}
HELP

##{ END YOUR CODE  }##
PRINT_INFO "$FILE -> Exiting.   @ $DATE"
