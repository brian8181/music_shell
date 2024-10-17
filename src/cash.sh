#!/bin/bash

# FILE:      'cash.sh'
# VERSION:   '0.0.13'
# FILE_DATE: 'Sat Oct 12 09:22:32 AM CDT 2024'
# INFO:      'builds a new cash.m3u'

FILE="$0"
VERSION='0.0.10'
FILE_DATE='Sat Oct 12 09:22:32 AM CDT 2024'
FMT_FG_RED='\e[31m'
FMT_FG_GREEN='\e[32m'
FMT_RESET='\e[0m'
PRINT_RED_DEBUG=${FMT_FG_RED}DEBUG${FMT_RESET}
PRINT_GREEN_INFO=${FMT_FG_GREEN}INFO${FMT_RESET}
DATE=$(date "+%H:%M:%S:%s")

DEBUG_MSG="$PRINT_RED_DEBUG: "
INFO_MSG="$PRINT_GREEN_INFO: "
VERBOSE=1
DEBUG=
DELIMITER='/'

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

function INFO
{
    echo 
   	echo ${VERBOSE:+"File - $FILE"}
	  echo ${VERBOSE:+"Version - $VERSION"}
	  echo ${VERBOSE:+"Date - $FILE_DATE"}
}

function HELP
{
    INFO
    echo -e "\nUsage: \n" \
              "$> cash.sh [-[dhpv]] [SRC [DST]]\n"
    echo -e "$(basename ${0}) - version: ${VERSION} - $(date)\n"
}

OPTSTRING="l:hvs:d:]"
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
    l)
      DELIMITER=${OPTARG}
      echo -e "${FMT_FG_GREEN}DELIMITER=${OPTARG}${FMT_RESET}"
      echo -e "${FMT_FG_RED}delimiter function not yest implented ...${FMT_RESET}"
      exit 0
      ;;
    s)
      # src
      SRC=$OPTARG
      exit 0
      ;;
    d)
      # dst
      DST=$OPTARG
      INFO 
      exit 0
      ;;
    :)
      PRINT_DEBUG "Option -${OPTARG} requires an argument."
      exit 1
      ;;
    ?)
      PRINT_DEBUG "Invalid option: -${OPTARG}."
      exit 1
      ;;
  esac
done
shift $(($OPTIND-1))

STORE_PREFIX="${1:-mnt/music/music-lib}"
CONFIG_PREFIX="${2:-$HOME/.music_shell}"
TIME_STAMP="$(date.sh)"
CACHE="${CONFIG_PREFIX}/${TIME_STAMP}_cache.txt"

# validate cache lines
VALIDATE_RECORD_RXP='/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)'
FILE_TYPES_RXP='^.*\.\(\(mp3\)\|\(flac\)\|\(ogg\)|\(ogg\)|\(wma\)|\(m4a\)\)$'
# FIELDS     (1 )  (2       )   (3 )  ((5         )   (6       )   (7 ) 
FIELDS_FRAG='(.*)\/([0-9]{4}) - (.*)\/(([0-9]{1,2}).)?([0-9]{2})\. (.*)'
# FIELDS           (1 )   (2-8        )  (9 ) 
ALBUM_FIELDS_RXP="^(.*)\/${FIELDS_FRAG}\.(.*)$"
# FIELDS                      (8 )  (9 )
FIELDS_RXP="^${FIELDS_FRAG} - (.*)\.(.*)$"

LOCATION='\1'
ARTIST='\2'
YEAR='\3'
ALBUM='\4'
ALBUM_ARTIST=''
DISC='\6'
TRACK='\7'
TITLE='\8'
ENCODER='\9'
FILE_PATH='\0'
HASH='null'
INSERT_TS=$TIME_STAMP
UPDATE_TS=$TIME_STAMP

REPL_END_RXP="$TITLE\/$ENCODER\/\"FILE_PATH\"\/$HASH\/$INSERT_TS\/$UPDATE_TS"
ALBUMS_FIELDS_REPL_RXP="$LOCATION\/$YEAR\/$ARTIST\/$ALBUM\/$ARTIST_ALBUM\/$DISC\/$TRACK\/$REPL_END_RXP"
FIELDS_REPL_RXP="\1\/\2\/\1\/\3\/\7\/\5\/\6\/$REPL_END_RXP"
SINGLES_REPL_RXP="\1\/\2\/\5\/\3\/Singles\/$REPL_END_RXP"

if [ ! -d $STORE_PREFIX ]; then
    echo "$STORE_PREFIX does not exist."
    exit 1;
fi

PRINT_INFO "scanning for file types (mp3, flac, ogg, wma, m4a) ..."
PRINT_INFO "searching \"$STORE_PREFIX\", writing cache --> \"$CACHE\" ..."
find "$STORE_PREFIX" -iregex $FILE_TYPES_RXP > "$CACHE"

PRINT_INFO "tranforming the input ..."
# remove prefix
#sed -Ei "s/$STORE_PREFIX\///g" "$CACHE"
sed -Ei "s/^.*music-lib\///g" "$CACHE"

#### albums! ####
PRINT_INFO "searching for albums ......."
cat "$CACHE" | grep -E "albums/" > "$CACHE"_ALBUMS # albums only
sed -Ei "s/$ALBUM_FIELDS_RXP/$ALBUMS_FIELDS_REPL_RXP/g" "$CACHE"_ALBUMS

#### misc & soundtrack! ####
PRINT_INFO "searching for misc & soundtrack ........."
cat "$CACHE" | grep -E "(misc/)|(soundtrack/)" > "$CACHE"_MISC
sed -Ei "s/$FIELDS_RXP/$FIELDS_REPL_RXP/g" "$CACHE"_MISC

#### singles! ####
PRINT_INFO "searching for singles ........."
cat "$CACHE" | grep -E "(singles/)" > "$CACHE"_SINGLES
#           (1      )  (2 )   (3 )  ((5       ) )   (6 )  (7 )
sed -Ei "s/^(singles)\/(.*) - (.*) \(([0-9]{4})\) - (.*)\.(.*)$/\1\/\4\/\2\/\3\/\2\/\/\/\5\/\6\/PATH\/$HASH\/$INSERT_TS\/$UPDATE_TS/g" "$CACHE"_SINGLES

#### albums, singles, misc, sondtrack! ####
cat "$CACHE"_ALBUMS "$CACHE"_MISC "$CACHE"_SINGLES | grep -E $VALIDATE_RECORD_RXP > "$CACHE"
rm  "$CACHE"_ALBUMS "$CACHE"_MISC "$CACHE"_SINGLES

# todo row id
#cat -n "$CACHE" | sed -E "s/([[:space:]]*([0-9]{1,6})[[:space:]]*)(.*)$/\2|\3/g" > tmp.txt

#### finished ... ####
PRINT_INFO "writing   \"$STORE_PREFIX\", (csv / cache) --> \"$CACHE\" ..."
