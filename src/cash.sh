#!/bin/bash

# FILE:      'cash.sh'
# VERSION:   '0.0.1'
# FILE_DATE: 'Mon Sep 30 10:03:59 PM CDT 2024'
# INFO:      'builds a new cash.m3u'

FILE='cash.sh'
VERSION='0.0.1'
FILE_DATE='Mon Sep 30 10:03:59 PM CDT 2024'

FMT_FG_RED='\e[31m'
FMT_FG_GREEN='\e[32m'
FMT_RESET='\e[0m'
PRINT_RED_DEBUG=${FMT_FG_RED}DEBUG${FMT_RESET}
PRINT_GREEN_INFO=${FMT_FG_GREEN}INFO${FMT_RESET}
DATE=$(date "+%H:%M:%S:%s")

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

STORE_PREFIX="/mnt/music/music-lib"
STORE_PREFIX='/run/media/brian/da8a7464-b3e2-4de2-8bf6-7c9951aa3ade/brian/music_backup/music-lib'
CONFIG_PREFIX="$HOME/.music_shell"
TIME_STAMP="$(date.sh)"
CACHE="${CONFIG_PREFIX}/${TIME_STAMP}_cache.txt"

OPTSTRING=":p:vb"

while getopts ${OPTSTRING} opt; do
  case ${opt} in
    p)
        echo "argument -p called with parameter $OPTARG" >&2
       ;;
    v)
      echo "version 0.0.1"
      ;;
    d)
      echo "Option -d (delimiter), was triggered."
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

PRINT_INFO "searching \"${STORE_PREFIX}\", writing cache --> \"${CACHE}\" ..."



### albums! ################################################################################################
PRINT_INFO "searching for albums ......."
find "$STORE_PREFIX" -iregex '^.*\.\(\(mp3\)\|\(flac\)\|\(ogg\)|\(ogg\)|\(wma\)|\(m4a\)\)$' > "$CACHE"
# remove prefix
sed -E -i "s/^.*music-lib//g" "$CACHE"

cat "$CACHE" | grep -E --color=never "/albums/" > "$CACHE"_ALBUMS # albums only

# normalize, double quote all field values
# <(1):location>/<(2):artist>/<(3):date> - <(4):<album>/<(6):disc>.<(7):track>. <(8):title>.<(9):encoding>
#             (1 )  (2 )  (3       )   (4 )  (5(6        ) ) (7       )   (8 )  (9 ) | 1                                        15
sed -E -i 's/^(.*)\/(.*)\/([0-9]{4}) - (.*)\/(([0-9]{1,2}).)?([0-9]{2})\. (.*)\.(.*)$/\1\/\2\/\3\/\4\/\6\/\7\/\8\/\9\/\/\/\/\/\/\//g' "$CACHE"_ALBUMS
##############################################################################################################



### misc! ####################################################################################################
PRINT_INFO "searching for misc ........."
cat "$CACHE" | grep -E --color=never "/misc/" > "$CACHE"_MISC

# # <(1):location>/<(2):year> - <(3):album>/<(4):disc>.<(5):track>. - <(6):artist> - <(7):title>.<(8):encoding>
# #           (1 )  (2       )   (3 )  (4(5        )   (6       )   (7 )   (  )  (9 ) | 1                                        15
sed -E -i 's/^(.*)\/([0-9]{4}) - (.*)\/(([0-9]{1,2}).)?([0-9]{2})\. (.*) - (.*)\.(.*)$/\1\/\2\/\3\/\5\/\6\/\7\/\8\/\9\/\/\/\/\/\/\//g' "$CACHE"_MISC
cat "$CACHE"_MISC | grep -E --color=never "/misc/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)" > "$CACHE"_MISC~
mv "$CACHE"_MISC~ "$CACHE"_MISC
##############################################################################################################



### soundtrack! ##############################################################################################
PRINT_INFO "searching for soundtrack ........."
cat "$CACHE" | grep -E --color=never "/soundtrack/" > "$CACHE"_SOUNDTRACK

# # <(1):location>/<(2):year> - <(3):album>/<(4):disc>.<(5):track>. - <(6):artist> - <(7):title>.<(8):encoding>
# #           (1 )  (2       )   (3 )  (4(5        )   (6       )   (7 )   (  )  (9 ) | 1 
sed -E -i 's/^(.*)\/([0-9]{4}) - (.*)\/(([0-9]{1,2}).)?([0-9]{2})\. (.*) - (.*)\.(.*)$/\1\/\2\/\3\/\5\/\6\/\7\/\8\/\9\/\/\/\/\/\/\//g' "$CACHE"_SOUNDTRACK
cat "$CACHE"_SOUNDTRACK | grep -E --color=never "/soundtrack/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)" > "$CACHE"_SOUNDTRACK~
mv "$CACHE"_SOUNDTRACK~ "$CACHE"_SOUNDTRACK
##############################################################################################################

# ### albums, singles, misc, sondtrack ###
cat "$CACHE"_ALBUMS "$CACHE"_MISC "$CACHE"_SOUNDTRACK > "$CACHE"

PRINT_INFO "writing   \"${STORE_PREFIX}\", (csv / cache) --> \"${CACHE}\" ..."

PRINT_INFO "$FILE -> Exiting.   @ $DATE"
