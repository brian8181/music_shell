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
	echo ${VERBOSE:+"Version - $VERSION"}+
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

# if [ -e "~/.music_shell/cache" ]
#     md -p ~/.music_shell/cache
#     touch ~/.music_shell/queue
#     touch ~/.music_shell/config.txt
# fi

#if [ -d "~/bin" ]; then
    PRINT_INFO "copy all to ~/bin ..."
    cp -rf ./src/* ~/bin
#fi\

if [ -e "./def_search.sh" ]; then
    ln ./def_search.sh s
fi

chmod +x ~/bin/*.sh

PRINT_INFO "Finished installing scripts."

##{ END YOUR CODE  }##
PRINT_INFO "$FILE -> Exiting.   @ $DATE"
