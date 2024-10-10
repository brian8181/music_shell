#!/bin/bash

# FILE:      'cash.sh'
# VERSION:   '0.0.12'
# FILE_DATE: 'Sun Oct  6 02:08:37 AM CDT 2024'
# INFO:      'builds a new cash.m3u'

FILE="$0"
VERSION='0.0.10'
FILE_DATE='Sun Oct  6 02:08:37 AM CDT 2024'
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

OPTSTRING="l:hpvs:d:]"
while getopts ${OPTSTRING} opt; do
  case ${opt} in
    v)
      INFO
      echo -e "${FMT_FG_GREEN}${VERSION}${FMT_FG_RED} ${DEBUG:-debug}${FMT_RESET}"
      exit 0
      ;;
    l)
      DELIMITER=${OPTARG}
      echo -e "${FMT_FG_GREEN}DELIMITER=${OPTARG}${FMT_RESET}"
      echo -e "${FMT_FG_RED}delimiter function not yest implented ...${FMT_RESET}"
      exit 0
      ;;
    h)
      INFO 
      echo -e "\nUsage: \n" \
              "$> cash.sh [-[dhpv]] [SRC [DST]]\n"
      echo -e "$(basename ${0}) - version: ${VERSION} - $(date)\n"
      exit 0;
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

#### init shell variabls ####
STORE_PREFIX="${1:-mnt/music/music-lib}"
CONFIG_PREFIX="${2:-$HOME/.music_shell}"
TIME_STAMP="$(date.sh)"
CACHE="${CONFIG_PREFIX}/${TIME_STAMP}_cache.txt"

#### regular expressions ####
# validate file cache
VALIDATE_RECORD_RXP='/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)'
# source search expression
FILE_TYPES_RXP='^.*\.\(\(mp3\)\|\(flac\)\|\(ogg\)|\(ogg\)|\(wma\)|\(m4a\)\)$'
# source expressions
#        (1 )  ((3 ) (4       )   ) ((6       )   )(7 )  ((9         ) ) (10      )   (11)   (12)  (13)
# FIELDS='^(.*)\/((.*)/([0-9]{4}) - )|(([0-9]{4}) - )(.*)\/(([0-9]{1,2}).)?([0-9]{2})\. (.*) - (.*)\.(.*)$'
# FIELDS     (1 )  (2       )   (3 )  ((5         )   (6       )   (7 )   (8  ) (9 ) 
FIELDS_FRAG='(.*)\/([0-9]{4}) - (.*)\/(([0-9]{1,2}).)?([0-9]{2})\. (.*)'
# FIELDS           (1 )   (2-8        )  (9 ) 
ALBUM_FIELDS_RXP="^(.*)\/${FIELDS_FRAG}\.(.*)$"
FIELDS_RXP="^${FIELDS_FRAG} - (.*)\.(.*)$"

# destination expressions
# ALBUMS  1:location/2:artist/3:album/4:date/5:title/6:encoding/10:disc_count/11:track_count/12:genre/13:lyrics/14:file/15:file_size:16:bitrate/17:art/18:create_ts/19:update_ts
# MISC    1:location/2:date - 3:album/4:artist - (5:date) - 6:disc.7:track 8:title.9:encoding 
# SINGLES 1:location/2:date - 3:album/4:artist - (5:date) - 6:disc.7:track 8:title.9:encoding 
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
INSERT_TS=${TIME_STAMP}
UPDATE_TS=${TIME_STAMP}

# 1) location
# 3) album
# 5) disc
# 6) track
# 7) artist
# 8) title
# 9) encoding 
ALBUMS_FIELDS_REPL_RXP="${LOCATION}\/${YEAR}\/${ARTIST}\/${ALBUM}\/${ARTIST_ALBUM}\/${DISC}\/${TRACK}\/${TITLE}\/${ENCODER}\/\"${FILE_PATH}\"\/${HASH}\/${INSERT_TS}\/${UPDATE_TS}"
FIELDS_REPL_RXP='\1\/\2\/\7\/\3\/Various\/\5\/\6\/\8\/\9\/\/\/\/\/'

if [ ! -d $STORE_PREFIX ]; then
    echo "$STORE_PREFIX does not exist."
    exit 1;
fi

PRINT_INFO "scanning for file types (mp3, flac, ogg, wma, m4a) ..."
PRINT_INFO "searching \"${STORE_PREFIX}\", writing cache --> \"${CACHE}\" ..."
find "$STORE_PREFIX" -iregex $FILE_TYPES_RXP > "$CACHE"

#todo fix path hash
# fix file path
#FILE_PATH='\0'
#HASH=$(md5sum ${FILE_PATH} | sed -E 's/^.{32}.*$//g')
echo $HASH

PRINT_INFO "tranforming the input ..."
# remove prefix
#sed -Ei "s/${STORE_PREFIX}\///g" "$CACHE"
sed -Ei "s/^.*music-lib\///g" "$CACHE"

#### albums! ####
PRINT_INFO "searching for albums ......."
cat "$CACHE" | egrep "albums/" > "$CACHE"_ALBUMS # albums only
sed -Ei "s/$ALBUM_FIELDS_RXP/$ALBUMS_FIELDS_REPL_RXP/g" "$CACHE"_ALBUMS

#### misc! & soundtrack ####
PRINT_INFO "searching for misc & soundtrack ........."
cat "$CACHE" | egrep "(misc/)|(soundtrack/)" > "$CACHE"_MISC
sed -Ei "s/$FIELDS_RXP/$FIELDS_REPL_RXP/g" "$CACHE"_MISC

#### albums, singles, misc, sondtrack! ####
cat "$CACHE"_ALBUMS "$CACHE"_MISC | egrep $VALIDATE_RECORD_RXP > "$CACHE"
rm  "$CACHE"_ALBUMS "$CACHE"_MISC

#### finished ... ####
PRINT_INFO "writing   \"${STORE_PREFIX}\", (csv / cache) --> \"${CACHE}\" ..."
