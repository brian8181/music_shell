#!/bin/bash
FILE='install.sh'
VERSION='0.0.1'
FILE_DATE='Tue Apr 23 01:36:23 AM CDT 2024'

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

settings.sh

if [ -e "$HOME/.music_shell/cache" ]; then
      mkdir -p $HOME/.music_shell/cache
#     touch ~/.music_shell/queue
#     touch ~/.music_shell/config.txt
    else
    PRINT_DEBUG "error: writing config ..."
fi

# copy all music_shell/src to $HOME/bin
if [ -d "$HOME/bin" ]; then
    PRINT_INFO "copy all to $HOME/bin ..."
    cp -rf "$HOME/src/music_shell/src/*" "$HOME/bin/"
fi

PRINT_INFO "creating soft/link to def_search.sh, \"s\" ..."

# check for sym links, and delete
# check for links not file !
# if [ -f "$HOME/bin/s" ]; then
#     rm s
# fi

# if [ -f "$HOME/bin/search" ]; then
#     rm search
# fi

# make sym links
# just remove for now
rm "$HOME/bin/s"
rm "$HOME/bin/search"
ln -s "$HOME/bin/search.sh" search
ln -s "$HOME/bin/search.sh" s

PRINT_INFO "Finished installing scripts."
##{ END YOUR CODE  }##
PRINT_INFO "$FILE -> Exiting.   @ $DATE"
