#!/usr/bin/bash

# FILE:      'pick.sh'
# VERSION:   '0.0.1'
# FILE_DATE: 'Tue Nov  5 04:34:53 PM CST 2024'
# INFO:      'pick a range from search text'

FMT_FG_RED='\e[31m'
FMT_FG_GREEN='\e[32m'
FMT_RESET='\e[0m'
# PRINT_RED_DEBUG=${FMT_FG_RED}DEBUG${FMT_RESET}
# PRINT_GREEN_INFO=${FMT_FG_GREEN}INFO${FMT_RESET}

DEBUG_MSG="$PRINT_RED_DEBUG: "
INFO_MSG="$PRINT_GREEN_INFO: "
VERBOSE=1
DEBUG=
PREFIX="$HOME/.music_shell"
DIFF=
APPEND=
NO_DISP=
ENQUEUE=

OPTSTRING="vahdq"
while getopts ${OPTSTRING} opt; do
    case ${opt} in
        v)
            INFO
            echo -e "${FMT_FG_GREEN}${VERSION}${FMT_FG_RED} ${DEBUG:-debug}${FMT_RESET}"
            exit 0
            ;;
        h)
            HELP
            exit 0;
            ;;
        a)
            APPEND="TRUE"
            ;;
        d)
            DIFF="TRUE"
            ;;
        n)
            NO_DISP="TRUE"
            ;;
        q)
            ENQUEUE="TRUE"
            ;;
        :)
            echo "Option -${OPTARG} requires an argument."
            exit 1
            ;;
        ?)
            echo "Invalid option: -${OPTARG}."
            exit 1
            ;;
    esac
done
shift $(($OPTIND-1))

FILE="$PREFIX/.SEARCH_TEXT"
LEN=$(cat $FILE | wc -l)
BEG=${1:-1}
END=${2:-$LEN}

if [[ ! -e $FILE ]]; then
    echo "invalid args (file does not exist )..."
    exit 1
fi

if [[ ${BEG} -le 0 || ${BEG} -gt END || $END -gt $LEN ]]; then
    echo "invalid args (out of range) ..."
    exit 1
fi

if [[ -z $APPEND ]]; then
  cat $FILE | sed -n "${BEG},${END}p" > "$PREFIX/.PICK"
else
  cat $FILE | sed -n "${BEG},${END}p" >> "$PREFIX/.PICK"
fi

if [[ ! -z $ENQUEUE ]]; then
    cat "$PREFIX/.PICK" > "$PREFIX/.QUEUE"
fi

if [[ ! -z $NO_DISP ]]; then
    exit 0
fi

if [[ ! -z $DIFF ]]; then
    diff --color -y $HOME/.music_shell/.SEARCH_TEXT $HOME/.music_shell/.PICK
    exit 0
fi

cat -n $PREFIX/.PICK





