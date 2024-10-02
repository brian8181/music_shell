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
CONFIG_PREFIX="$HOME/.music_shell"
TIME_STAMP="$(date.sh)"
CACHE="${CONFIG_PREFIX}/${TIME_STAMP}_cache.m3u"

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

echo "searching \"${STORE_PREFIX}\", writing cache --> \"${CACHE}\" ..."

### albums! ###
echo "searching for albums ......."
CASH_TMP="${CONFIG_PREFIX}/TMP_${TIME_STAMP}~"
find "${STORE_PREFIX}" -iregex '^.*\.\(\(mp3\)\|\(flac\)\|\(ogg\)|\(ogg\)|\(wma\)|\(m4a\)\)$' > $CASH_TMP;
cat $CASH_TMP | grep -E --color=never "albums/" > "$CACHE" # albums only

# remove prefix
sed -E -i "s/^.*music-lib\///g" ${CACHE}
# normalize, double quote all field values
# <(1):location>/<(2):artist>/<(3):date> - <(4):<album>/<(5):disc>.<(6):track>. <(7):title.<(8):encoding>
sed -E -i 's/^(albums)\/(.*)\/([0-9]{4}) - (.*)\/(([0-9]{1,2}).)?([0-9]{2})\. (.*)\.(.*)$/"\1"\/"\3"\/"\2"\/"\4"\/"\6"\/"\7"\/"\8"\/"\9"\/""\/""\/""\/""\/""\/""\/""\/""\/""\/""/g' ${CACHE}

### singles! ###
echo "searching for singles ......"
TIME_STAMP="$(date.sh)"
CACHE_SINGLES="${CONFIG_PREFIX}/${TIME_STAMP}_cache_SINGLES.m3u"
cat $CASH_TMP | grep -E --color=never singles/ > ${CACHE_SINGLES}

# remove prefix
sed -E -i "s/^.*music-lib\///g" ${CACHE_SINGLES}
# normalize, double quote all field values
sed -E -i 's/^(singles)\/(.*) - (.*) \(([0-9]{4})\) - (.*)\.(.*)$/"\1"\/"\2"\/"\3"\/"\4"\/"\5"\/"\6"\/""\/""\/""\/""\/""\/""\/""\/""\/""\/""\/""\/""/g' ${CACHE_SINGLES}

# remove bad lines (unmatched)
TMP="${CONFIG_PREFIX}/$(date.sh).tmp"
cat $CACHE_SINGLES | grep -v '^singles\/.*$' > "$TMP"
mv "$TMP" "$CACHE_SINGLES"

### misc! ###
echo "searching for misc ........."
TIME_STAMP="$(date.sh)"
CACHE_MISC="${CONFIG_PREFIX}/${TIME_STAMP}_cache_MISC.m3u"
cat $CASH_TMP | grep -E --color=never "misc/" > "${CACHE_MISC}"

# remove prefix
sed -E -i "s/^.*music-lib\///g" "${CACHE_MISC}"
# normalize, double quote all field values
# <(1):location>/<(2):year> - <(3):album>/<(4):disc>.<(5):track>. - <(6):album_artist> - <(7):title>.<(8):encoding>
sed -E -i 's/^(misc)\/([0-9]{4}) - (.*)\/(([0-9]{1,2}).)?([0-9]{2})\. (.*) - (.*)\.(.*)$/"\1"\/"\3"\/"\2"\/"\4"\/"\6"\/"\7"\/"\8"\/"\9"\/""\/""\/""\/""\/""\/""\/""\/""\/""\/""/g' "${CACHE_MISC}"
                    
# remove bad lines (unmatched)
TMP="${CONFIG_PREFIX}/$(date.sh).tmp"
cat "$CACHE_MISC" | grep -v '^misc\/.*$' > "$TMP"
mv "$TMP" "$CACHE_MISC"

### soundtrack! ###
echo "searching for soundtrack ..."
TIME_STAMP="$(date.sh)"
CACHE_SOUNDTRACK="${CONFIG_PREFIX}/${TIME_STAMP}_cache_SOUNDTRACK.m3u"
cat $CASH_TMP | grep -E --color=never "soundtrack/" > "${CACHE_SOUNDTRACK}"

# remove prefix
sed -E -i "s/^.*music-lib\///g" "${CACHE_SOUNDTRACK}"
# normalize, double quote all field values
# <(1):location>/<(2):year> - <(3):album>/<(4):disc>.<(5):track>. - <(6):album_artist> - <(7):title>.<(8):encoding>
sed -E -i 's/^(soundtrack)\/([0-9]{4}) - (.*)\/(([0-9]{1,2}).)?([0-9]{2})\. (.*) - (.*)\.(.*)$/"\1"\/"\3"\/"\2"\/"\4"\/"\6"\/"\7"\/"\8"\/"\9"\/""\/""\/""\/""\/""\/""\/""\/""\/""\/""/g' "${CACHE_SOUNDTRACK}"

# remove bad lines (unmatched)
TMP="${CONFIG_PREFIX}/$(date.sh).tmp"
cat "$CACHE_SOUNDTRACK" | grep -v '^soundtrack\/.*$' > "$TMP"
mv "$TMP" "$CACHE_SOUNDTRACK"

### albums, singles, misc, sondtrack ###
cat "$CACHE" "$CACHE_SINGLES" "$CACHE_MISC" "$CACHE_SOUNDTRACK" > "${CONFIG_PREFIX}/FULL$(date.sh).txt"
rm  "$CACHE" "$CACHE_SINGLES" "$CACHE_MISC" "$CACHE_SOUNDTRACK"

echo "writing   \"${STORE_PREFIX}\", (csv / cache) --> \"${CACHE}\" ..."

PRINT_INFO "$FILE -> Exiting.   @ $DATE"
