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

DEBUG_MSG="${PRINT_RED_DEBUG}: "
INFO_MSG="${PRINT_GREEN_INFO}: "
VERBOSE=1
DEBUG=
SD__='\/'
DD__='\|'

function PRINT_DEBUG
{
    MSG=${DEBUG_MSG}$1
    echo -e ${DEBUG:+"${MSG}"}
}

function PRINT_INFO
{
    MSG=${INFO_MSG}$1
    echo -e ${VERBOSE:+"${MSG}"}
}

function INFO
{
    echo 
   	echo ${VERBOSE:+"File - ${FILE}"}
	  echo ${VERBOSE:+"Version - ${VERSION}"}
	  echo ${VERBOSE:+"Date - ${FILE_DATE}"}
}

function HELP
{
    INFO
    echo -e "\nUsage: \n" \
              "$> cash.sh [-[a:b:pva:b:]] [SRC [DST]]\n"
    echo -e "$(basename ${0}) - version: ${VERSION} - $(date)\n"
}

# ARGUMENT_LIST=(
#   "arg-one"
#   "arg-two"
#   "arg-three"
# )

# # read arguments
# opts=$(getopt \
#   --longoptions "$(printf "%s:," "${ARGUMENT_LIST[@]}")" \
#   --name "$(basename "$0")" \
#   --options "" \
#   -- "$@"
# )
# eval set --$opts

OPTSTRING="a:b:l:hvs:d:]"
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
      # src delimiter
      SD__=${OPTARG}
     ;;
    b)
      # dst delimiter
      DD__=${OPTARG}
      ;;
    s)
      # src
      SRC=${OPTARG}
      exit 0
      ;;
    d)
      # dst
      DST=${OPTARG}
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
shift $((${OPTIND}-1))

STORE_PREFIX="${1:-/mnt/music/music-lib}"
CONFIG_PREFIX="${2:-$HOME/.music_shell}"
TIME_STAMP="$(date.sh)"
CACHE="${CONFIG_PREFIX}/${TIME_STAMP}_cache.txt"

if [ ! -d ${STORE_PREFIX} ]; then
    echo "${STORE_PREFIX} does not exist."
    exit 1;
fi

FILE_TYPES_RXP='^.*\.\(\(mp3\)\|\(flac\)\|\(ogg\)|\(wma\)|\(m4a\)|\(ape\)\)$'
PRINT_INFO "scanning for file types (mp3, flac, ogg, wma, m4a, ape) ..."
PRINT_INFO "searching \"${STORE_PREFIX}\", writing cache --> \"${CACHE}\" ..."
find "${STORE_PREFIX}" -iregex ${FILE_TYPES_RXP} > "${CACHE}"

PRINT_INFO "tranforming the input ..."
# remove prefix
sed -Ei "s|${STORE_PREFIX}/||g" "${CACHE}"

# regex
TITLE='\8'
ENCODER='\9'
FILE_PATH='\0'
HASH='null'
INSERT_TS=${TIME_STAMP}
UPDATE_TS=${TIME_STAMP}

REPL_END_RXP="${TITLE}${DD__}${ENCODER}${DD__}\"&\"${DD__}${HASH}${DD__}${INSERT_TS}${DD__}${UPDATE_TS}"
#'$LOCATION|$YEAR|$ARTIST|$ALBUM|$ALBUM_ARTIST|$DISC|$TRACK|$TITLE|$ENCODER|$FILE|$HASH|$INSERT_TS|$UPDATE_TS'

LOC_EXP='^(.*)'
YEAR_EXP='([0-9]{4})'
ARTIST_EXP='(.*)'
ALBUM_EXP='(.*)'
ALBUM_ARTIST_EXP='(.*)'
DISC_TRACK_EXP='(([0-9]{1,2}).)?([0-9]{2})'
TITLE_EXP='(.*)\.(.*)$'

# albums
LOCATION='\1'
ARTIST='\2'
YEAR='\3'
ALBUM='\4'
ALBUM_ARTIST='\2'
DISC='\6'
TRACK='\7'

#        (1     ) /     (2 )  /    (3      )   (4 )  /    ((6          ))   (8       )    /     (9  )   /   (10         ) 
SRC_EXP="${LOC_EXP}${SD__}(.*)${SD__}${YEAR_EXP} - (.*)${SD__}${DISC_TRACK_EXP}\. ${TITLE_EXP}"
#        (1      )  |    (2  )  |    (3    )  |    (4   )  |    (5          )  |    (6  )  |    (7   )  |    (8-14       )
DST_EXP="{$LOCATION}${DD__}${YEAR}${DD__}${ARTIST}${DD__}${ALBUM}${DD__}${ALBUM_ARTIST}${DD__}$DISC${DD__}${TRACK}${DD__}${REPL_END_RXP}"

PRINT_INFO "searching for albums ......."
cat "${CACHE}" | grep -E "albums/" > "${CACHE}"_ALBUMS # albums only
sed -Ei "s/${SRC_EXP}/${DST_EXP}/g" "${CACHE}"_ALBUMS

# misc & soundtrack
ARTIST='\1'
YEAR='\2'
ALBUM='\4'
ALBUM_ARTIST='\7'
DISC='\5'
TRACK='\6'
#        (1     )   /   (2      )   (3 )   /   (4            )   (5 )   (6       )
SRC_EXP="${LOC_EXP}${SD__}${YEAR_EXP} - (.*)${SD__}${DISC_TRACK_EXP}\. (.*) - ${TITLE_EXP}"
#        (1      )  |    (2  )  |    (3    )  |    (4   )  |    (5          )  |    (6  )  |    (7   )  |    (8-14       )
DST_EXP="${LOCATION}${DD__}${YEAR}${DD__}${ARTIST}${DD__}${ALBUM}${DD__}${ALBUM_ARTIST}${DD__}$DISC${DD__}${TRACK}${DD__}${REPL_END_RXP}"

PRINT_INFO "searching for misc & soundtrack ........."
cat "${CACHE}" | grep -E "(misc/)|(soundtrack/)" > "${CACHE}"_MISC
sed -Ei "s/${SRC_EXP}/${DST_EXP}/g" "${CACHE}"_MISC

# singles
ARTIST='\1'
YEAR='\2'
ALBUM='\4'
ALBUM_ARTIST='\7'
DISC='\5'
TRACK='\6'
#         (1      )     (2 )   (3 )  ((5      ))    (6        )  (7 )
SRC_EXP="^(singles)${SD__}(.*) - (.*) \(${YEAR_EXP}\) - ${TITLE_EXP}"
DST_EXP="\1${DD__}\4${DD__}\2${DD__}\3${DD__}\2${DD__}${DD__}${DD__}\5${DD__}\6${DD__}\"&\"${DD__}$HASH${DD__}${INSERT_TS}${DD__}${UPDATE_TS}"

PRINT_INFO "searching for singles ........."
cat "${CACHE}" | grep -E "(singles/)" > "${CACHE}"_SINGLES
sed -Ei "s/${SRC_EXP}/${DST_EXP}/g" "${CACHE}"_SINGLES

# validate cache lines
VALIDATE_RECORD_RXP="(.*)${DD__}(.*)${DD__}(.*)${DD__}(.*)${DD__}(.*)${DD__}(.*)${DD__}(.*)${DD__}(.*)"

# combine into cache
cat "${CACHE}"_ALBUMS "${CACHE}"_MISC "${CACHE}"_SINGLES | grep -E ${VALIDATE_RECORD_RXP} > "${CACHE}"
rm  "${CACHE}"_ALBUMS "${CACHE}"_MISC "{$CACH}E"_SINGLES

# create id column
TMP_SEQUENCE_COL=tmp_$(date.sh).txt
TMP_CACHE=tmp_$(date.sh).txt
cat ${CACHE} > ${TMP_CACHE};
LEN=$(cat ${CACHE} | wc -l)
# begin @ 1111 increment by 3 each time go to $LEN of $CACHE ...
seq -w 001111 3 $((3*${LEN}+1110)) > "${TMP_SEQUENCE_COL}"
# combine id column with other song columns ...
paste -d'|' ${TMP_SEQUENCE_COL} ${TMP_CACHE} > ${CACHE}
rm ${TMP_SEQUENCE_COL} ${TMP_CACHE}

# finished ...
PRINT_INFO "writing   \"${STORE_PREFIX}\", (csv / cache) --> \"${CACHE}\" ..."
