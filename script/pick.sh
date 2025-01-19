#!/usr/bin/bash

# FILE:      'pick.sh'
# VERSION:   '0.0.1'
# FILE_DATE: 'Tue Nov  5 04:34:53 PM CST 2024'
# INFO:      'pick a range from search text'

FMT_FG_RED='\e[31m'
FMT_FG_GREEN='\e[32m'
FMT_RESET='\e[0m'

DEBUG_MSG="$PRINT_RED_DEBUG: "
INFO_MSG="$PRINT_GREEN_INFO: "
VERBOSE=1
DEBUG=
PREFIX="$HOME/.music_shell"
DIFF=
APPEND=
INSERT=
NO_DISP=
ENQUEUE=
SAVE_AS=

OPTSTRING="vahdqp:s:i:"
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
        p)
            if [[ $OPTARG == "last" ]]; then
                cat "$PREFIX/.PICK"
            else
                cat "$PREFIX/$OPTARG"
            fi
            exit 0;
            ;;
        i)
            INSERT="TRUE"
            ;;
        s)
            SAVE_AS=$OPTARG             
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

SRC_FILE="$PREFIX/.SEARCH_TEXT"
DST_FILE="$PREFIX/.PICK"
TMP_FILE="$PREFIX/$(dateN.sh)_PICK"

# if [[ $# -eq 0 ]]; then
#     cat $DST_FILE
#     exit 0;
# fi

# LEN=$(cat $FILE | wc -l)
# BEG=${1:-1}
# END=${2:-$LEN}

# if [[ ! -e $FILE ]]; then
#     echo "invalid args (file does not exist )..."
#     exit 1
# fi

# if [[ ${BEG} -le 0 || ${BEG} -gt END || $END -gt $LEN ]]; then
#     echo "invalid args (out of range) ..."
#     exit 1
# fi


function pick_items
{
    cat $SRC_FILE | sed -n ${CMDS:-p;} > "$DST_FILE"
    cp "$DST_FILE" "$TMP_FILE"
}

CMDS=$(echo $@ | sed -E "s/([0-9]+)( |$)/\1p;/g")
#echo ${CMDS@Q}

if [[ -z $APPEND ]]; then
  pick_items
else
  cat $SRC_FILE | sed -n ${CMDS:-p;} >> "$DST_FILE"
  cp "$DST_FILE" "$TMP_FILE"
fi

if [[ -n $INSERT ]]; then
    pick_items
    insert_file_queue.sh $INDEX $TMP_FILE 
fi

if [[ ! -z $SAVE_AS ]]; then
    cat "$DST_FILE" > "$PREFIX/$SAVE_AS"
fi

if [[ ! -z $ENQUEUE ]]; then
    cat "$DST_FILE" > "$PREFIX/.QUEUE"
fi

if [[ ! -z $NO_DISP ]]; then
    exit 0
fi

if [[ ! -z $DIFF ]]; then
    diff --color -y $SRC_FILE $DST_FILE
    exit 0
fi

cat -n $DST_FILE





