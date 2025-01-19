#!/bin/bash

# FILE:      'cash.sh'
# VERSION:   '0.0.13'
# FILE_DATE: 'Sun Oct 20 11:52:03 AM CDT 2024'
# INFO:      'builds a new cash.m3u'

FILE="$0"
VERSION='0.0.14'
FILE_DATE='Sun Oct 20 11:52:03 AM CDT 2024'
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
D__='\/'

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
      __D=${OPTARG}
      echo -e "${FMT_FG_GREEN}DELIMITER=${OPTARG}${FMT_RESET}"
      echo -e "${FMT_FG_RED}delimiter function not yet implemented ...${FMT_RESET}"
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

STORE_PREFIX="${1:-/mnt/music/music-lib}"
CONFIG_PREFIX="${2:-$HOME/.music_shell}"
TIME_STAMP="$(date.sh)"
CACHE="${CONFIG_PREFIX}/${TIME_STAMP}_cache.txt"

if [ ! -d $STORE_PREFIX ]; then
    echo "$STORE_PREFIX does not exist."
    exit 1;
fi

FILE_TYPES_RXP='^.*\.\(\(mp3\)\|\(flac\)\|\(ogg\)|\(ogg\)|\(wma\)|\(m4a\)\)$'
PRINT_INFO "scanning for file types (mp3, flac, ogg, wma, m4a) ..."
PRINT_INFO "searching \"$STORE_PREFIX\", writing cache --> \"$CACHE\" ..."
find "$STORE_PREFIX" -iregex $FILE_TYPES_RXP > "$CACHE"

PRINT_INFO "tranforming the input ..."
# remove prefix
sed -Ei "s|$STORE_PREFIX/||g" "$CACHE"

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

# SHARED FRAGMENT
# FIELDS     (1 )  (2       )   (3 )  ((5         ) ) (6       )   (7 ) 
FIELDS_FRAG="(.*)$D__([0-9]{4}) - (.*)$D__(([0-9]{1,2}).)?([0-9]{2})\. (.*)"
#REPL_END_RXP="$TITLE$D__$ENCODER$D__\"&\"$D__$HASH$D__$INSERT_TS$D__$UPDATE_TS"
REPL_END_RXP="$TITLE$D__$ENCODER$D__\"PATH\"$D__$HASH$D__$INSERT_TS$D__$UPDATE_TS"

#### albums! ####
# FIELDS  (1 )   (2-8        )  (9 ) 
SRC_EXP="^(.*)$D__${FIELDS_FRAG}\.(.*)$"
DST_EXP="$LOCATION$D__$YEAR$D__$ARTIST$D__$ALBUM$D__$ARTIST_ALBUM$D__$DISC$D__$TRACK$D__$REPL_END_RXP"
PRINT_INFO "searching for albums ......."
cat "$CACHE" | grep -E "albums/" > "$CACHE"_ALBUMS # albums only
sed -Ei "s/$SRC_EXP/$DST_EXP/g" "$CACHE"_ALBUMS

#### misc & soundtrack! ####
# FIELDS                   (8 )  (9 )
SRC_EXP="^${FIELDS_FRAG} - (.*)\.(.*)$"
DST_EXP="\1$D__\2$D__\1$D__\3$D__\7$D__\5$D__\6$D__$REPL_END_RXP"
PRINT_INFO "searching for misc & soundtrack ........."
cat "$CACHE" | grep -E "(misc/)|(soundtrack/)" > "$CACHE"_MISC
sed -Ei "s/$SRC_EXP/$DST_EXP/g" "$CACHE"_MISC

#### singles! ####
# FIELDS  (1      )  (2 )   (3 )  ((5       ) )   (6 )  (7 )
SRC_EXP="^(singles)$D__(.*) - (.*) \(([0-9]{4})\) - (.*)\.(.*)$"
#DST_EXP="\1$D__\4$D__\2$D__\3$D__\2$D__$D__$D__\5$D__\6$D__\"&\"$D__$HASH$D__$INSERT_TS$D__$UPDATE_TS"
DST_EXP="\1$D__\4$D__\2$D__\3$D__\2$D__$D__$D__\5$D__\6$D__\"PATH\"$D__$HASH$D__$INSERT_TS$D__$UPDATE_TS"
PRINT_INFO "searching for singles ........."
cat "$CACHE" | grep -E "(singles/)" > "$CACHE"_SINGLES
sed -Ei "s/$SRC_EXP/$DST_EXP/g" "$CACHE"_SINGLES

# validate cache lines
VALIDATE_RECORD_RXP='/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)'
#### albums, singles, misc, sondtrack! ####
cat "$CACHE"_ALBUMS "$CACHE"_MISC "$CACHE"_SINGLES | grep -E $VALIDATE_RECORD_RXP > "$CACHE"
rm  "$CACHE"_ALBUMS "$CACHE"_MISC "$CACHE"_SINGLES
#sed -Ei "s/$D__/|/g" "$CACHE"

# create id column
LEN=$(cat $CACHE | wc -l)
seq -w 1111 3 $((3*$LEN+1110)) > tmp1.txt
paste -d'/' tmp1.txt $CACHE > tmp2.txt 
cat tmp2.txt > $CACHE
rm tmp*.txt

#### finished ... ####
PRINT_INFO "writing   \"$STORE_PREFIX\", (csv / cache) --> \"$CACHE\" ..."
