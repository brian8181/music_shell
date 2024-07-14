#!/bin/bash
FILE='install.sh'
VERSION='0.0.1'
FILE_DATE='Tue May  7 12:03:53 AM CDT 2024'

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

if [ -n $VERBOSE ]; then
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

# load settings
PRINT_INFO "load settings ..."
settings.sh

PREFIX="$HOME/.music_shell"

if [ ! -d "$PREFIX/cache" ]; then
    PRINT_INFO "make directory  \"$HOME/.music_shell/cache\" ..."
    mkdir -p "$HOME/cache"
    touch "$PREFIX/queue"
    touch "$PREFIX/config.txt"
fi

# copy all music_shell/src to $HOME/bin
if [ -d "$HOME/bin" ]; then
    PRINT_INFO "copy all to \"$HOME/bin\" ..."
    cp "${HOME}"/src/music_shell/src/*.sh "$HOME/bin/"
fi

PRINT_INFO "creating soft/link to search.sh, \"s\" ..."

# check for sym links, and delete
if [ -h "$HOME/bin/s" ]; then
    PRINT_INFO "remove link \"$HOME/bin/s\" ..."
    rm "$HOME/bin/s"
fi

# create link
PRINT_INFO "create link \"$HOME/bin/s\" ..."
ln -s "$HOME/bin/search.sh" "$HOME/bin/s"

if [ -h "$HOME/bin/search" ]; then
    PRINT_INFO "remove link \"$HOME/bin/search\" ..."
    rm "$HOME/bin/search"

fi

# create link
PRINT_INFO "create link \"$HOME/bin/search\" ..."
ln -s "$HOME/bin/search.sh" "$HOME/bin/search"

PRINT_INFO "Finished installing scripts."
##{ END YOUR CODE  }##
PRINT_INFO "$FILE -> Exiting.   @ $DATE"
