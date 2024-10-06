#!/bin/bash

# FILE:      'cash.sh'
# VERSION:   '0.0.10'
# FILE_DATE: 'Thu Oct  3 09:59:04 AM CDT 2024'
# INFO:      'builds a new cash.m3u'

FILE='cash.sh'
VERSION='0.0.10'
FILE_DATE='Thu Oct  3 09:59:04 AM CDT 2024'
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
   	echo ${VERBOSE:+"File - $FILE"}
	  echo ${VERBOSE:+"Version - $VERSION"}
	  echo ${VERBOSE:+"Date - $FILE_DATE"}
}

OPTSTRING=":dh:v"

while getopts ${OPTSTRING} opt; do
  case ${opt} in
    v)
      INFO
      echo -e "${FMT_FG_GREEN}version 0.0.1${FMT_FG_RED} ${DEBUG:-debug}${FMT_RESET}"
      exit 0;
      ;;
    d)
      echo "Option -d (delimiter), was triggered."
      ;;
    h)
      echo -e "Usage: \n" \
              "$> cash.sh [-[dhpv]] [SRC [DST]]\n" \
              "version 0.0.1 - $(date)"
              exit 0;
      ;;
    :)
      echo "Option -${OPTARG} requires an argument."
      exit 1
      ;;
    ?)
      PRINT_DEBUG "Invalid option: -${OPTARG}."
      exit 1
      ;;
  esac
done

PRINT_INFO "$FILE -> Running... @ $DATE"

### init shell variabls ####
STORE_PREFIX="/mnt/music/music-lib"
STORE_PREFIX='/run/media/brian/da8a7464-b3e2-4de2-8bf6-7c9951aa3ade/brian/music_backup/music-lib'
CONFIG_PREFIX="$HOME/.music_shell"
TIME_STAMP="$(date.sh)"
CACHE="${CONFIG_PREFIX}/${TIME_STAMP}_cache.txt"


#### regular expressions ####
#  <(1):location>/<(2):year> - <(3):album>/<(4):disc>.<(5):track>. - <(6):artist> - <(7):title>.<(8):encoding>
#        (1 )  ((3 ) (4       )   ) ((6       )   )(7 )  ((9         ) ) (10      )   (11)   (12)  (13)
FIELDS='^(.*)\/((.*)/([0-9]{4}) - )|(([0-9]{4}) - )(.*)\/(([0-9]{1,2}).)?([0-9]{2})\. (.*) - (.*)\.(.*)$'
#                  (1 )  (2 )  (3       )   (4 )  ((6         )   (7       )   (8 )  (9 ) 
ALBUM_FIELDS_RXP='^(.*)\/(.*)\/([0-9]{4}) - (.*)\/(([0-9]{1,2}).)?([0-9]{2})\. (.*)\.(.*)$'
ALBUMS_FIELDS_REPL_RXP='\1\/\2\/\3\/\4\/\6\/\7\/\8\/\9\/\/\/\/\/\/\/'
#            (1 )  (2       )   (3 )  ((5         )   (6       )   (7 )   (8  )  (9 ) 
FIELDS_RXP='^(.*)\/([0-9]{4}) - (.*)\/(([0-9]{1,2}).)?([0-9]{2})\. (.*) - (.*)\.(.*)$'
FIELDS_RXP2='^(.*)\/((.*[^ ])\/)?([0-9]{4}) - (.*)\/(([0-9]{1,2}).)?([0-9]{2})\. (.*) - (.*)\.(.*)$'
FIELDS_REPL_RXP='\1\/\2\/\3\/\5\/\6\/\7\/\8\/\9\/\/\/\/\/\/\/'
VALIDATE_RECORD_RXP='/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)'
FILE_TYPES_RXP='^.*\.\(\(mp3\)\|\(flac\)\|\(ogg\)|\(ogg\)|\(wma\)|\(m4a\)\)$'

PRINT_INFO "searching \"${STORE_PREFIX}\", writing cache --> \"${CACHE}\" ..."
PRINT_INFO "scanning for file types (mp3, flac, ogg, wma, m4a) ..."
find "$STORE_PREFIX" -iregex $FILE_TYPES_RXP > "$CACHE"

PRINT_INFO "tranforming the output ..."
# remove prefix
sed -E -i "s/^.*music-lib\///g" "$CACHE"

### albums! ####
PRINT_INFO "searching for albums ......."
cat "$CACHE" | egrep "albums/" > "$CACHE"_ALBUMS # albums only
sed -E -i "s/$ALBUM_FIELDS_RXP/$ALBUMS_FIELDS_REPL_RXP/g" "$CACHE"_ALBUMS

#### misc! & soundtrack ####
PRINT_INFO "searching for misc & soundtrack ........."
cat "$CACHE" | egrep "(misc/)|(soundtrack/)" > "$CACHE"_MISC
sed -E -i "s/$FIELDS_RXP/$FIELDS_REPL_RXP/g" "$CACHE"_MISC

#### albums, singles, misc, sondtrack! ####
cat "$CACHE"_ALBUMS "$CACHE"_MISC | egrep $VALIDATE_RECORD_RXP > "$CACHE"
rm  "$CACHE"_ALBUMS "$CACHE"_MISC

#### finished ... ####
PRINT_INFO "writing   \"${STORE_PREFIX}\", (csv / cache) --> \"${CACHE}\" ..."
PRINT_INFO "$FILE -> Exiting.   @ $DATE"
