#!/bin/bash

# FILE: 'cache.sh'
# VERSION: '0.0.1'
# FILE_DATE: 'Fri Jul 12 07:03:30 AM CDT 2024'
# INFO: builds a new cache.sh

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

STORE_PREFIX="/mnt/music/music-lib"
CONFIG_PREFIX="$HOME/.music_shell"
TIME_STAMP="$(date.sh)"
CACHE="${CONFIG_PREFIX}/${TIME_STAMP}_cache.m3u"

# HOME="${1}"
# STORE_PREFIX="${2}"
# CONFIG_PREFIX="${3}"
# TIME_STAMP="$(date.sh)"
# CACHE_PATH="${4}"

PRINT_INFO "searching \"${STORE_PREFIX}\", writing cache too \"${CACHE}\" ..."

find "${STORE_PREFIX}" -iname "*.mp3" > "${CACHE}"
find "${STORE_PREFIX}" -iname "*.ogg" >> "${CACHE}"
find "${STORE_PREFIX}" -iname "*.flac" >> "${CACHE}"
find "${STORE_PREFIX}" -iname "*.wma" >> "${CACHE}"

# trim off root                                             # replace delimiter   # create date & album columns
sed 's/\/mnt\/music\/music-lib\///' "${CACHE}" | sed s/\\//\|/g | sed s/' - '/\|/ | sed s/\\.[[:space:]]/\|/ > "${CACHE}.tmp"
# add disc column                                           # seperate disc & track
sed -E "s/(\|[[:digit:]][[:digit:]]\|)/\|\1/" "${CACHE}.tmp" | sed -E "s/([[:digit:]]+)\\./\1\|/" > "${CACHE}"

# remove tmp
# rm "${STORE_PREFIX}/${CACHE}.tmp"

PRINT_INFO "finished writing cache too \"${CACHE}\" ..."
PRINT_INFO "added $(cat ${CACHE} | wc -l) items to cache : $TIME_STAMP"
PRINT_INFO "cache is located @ $CACHE."

function HELP
{
    PRINT_INFO "** HELP **"
    PRINT_INFO "HOME:$HOME STOREPREFIX:$STORE_PREFIX CONFIG+PREFIX:$CONFIG_PREFIX CACHE_NAME:$CACHE_NAME"
}
HELP

##{ END YOUR CODE  }##
PRINT_INFO "$FILE -> Exiting.   @ $DATE"
