#!/bin/bash

# FILE: 'select_with_fields.sh'
# VERSION: '0.0.1'
# FILE_DATE: 'Sun Jul 14 09:11:03 PM CDT 2024'
# INFO: search queue

CONFIG_PREFIX="$HOME/.music_shell"
SEARCH_TERM="$1"
PLAYLIST=${CONFIG_PREFIX}/queue
CACHE=${CONFIG_PREFIX}/cache/cache.m3u
#IGNORE_CASE="$4"
FIELDS=$2

FOLDER=1
ARTIST=2
ALBUM_ARTIST=
DATE=3
ALBUM=4
DISC=5
TRACK=6
TITLE=7
LYRICS=
NOTES=
IMAGE=
IMAGE_TYPE=
IMAGE_PATH=
EXT=8

#IMAGE_TYPES={COVER, BACK, MEDIA}

FOLDER_EXP='albums'
ARTIST_EXP="[-'[:alpha:][:space:]]+"
DATE_EXP='[0-9]{4}' # "([1][89][0-9]{2})|([2][0][0-2][0-9])"
ALBUM_EXP="[-.\(\),&'_:?[:alnum:][:space:]]+"
DISC_EXP='[0-9]?'
TRACK_EXP='[0-9]{2}' # "[0-9][1-9]"
TITLE_EXP="[-'\)\(,.&[:alnum:][:space:]]+"
EXT_EXP='[[:alnum:]]{1,4}'
NULL=""
EXPR="[\|](${FOLDER_EXP})[\|](${ARTIST_EXP})[\|](${DATE_EXP})[\|](${ALBUM_EXP})[\|](${DISC_EXP})[\|](${TRACK_EXP})[\|](${TITLE_EXP})[\|](${EXT_EXP})[\|]"
FIELDS_DEFAULT=":\\${FOLDER}:\\${ARTIST}:\\${DATE}:\\${ALBUM}:\\${DATE}:\\${TRACK}:\\${TITLE}:\\${EXT}"

file=$1 # DEBUG
cat $file | sed -E "s/${EXPR}/${FIELDS:-${FIELDS_DEFAULT}}/g" #DEBUG
#DEBUG #cat "$CACHE" | egrep --color=never "$SEARCH_TERM" | tee $PLAYLIST.tmp
#DEBUG #cat $CONFIG_PREFIX/$PLAYLIST.tmp | sed -E "s/${EXPR}/${FIELDS:-${FIELDS_DEFAULT}}/g" | tee $PLAYLIST

# HISTORY
# cat ~/final_2 | sed -E  "s/[\|](albums)[\|]([-'[:alpha:][:space:]]+)[\|]([0-9]{4})[\|]([-')([:alnum:][:space:]]+)[\|]([0-9]?)[\|]([0-9]{2})[\|]([-'\)\(,.&[:alnum:][:space:]]+)[\|]([[:alnum:]]{1,4})[\|]/:\1:\2:\3:\4:\5:\6:\7:\8/g"
# matched
# select_with_fields.sh  ~/final_2 | grep --color=always '|albums|' | wc -l
# unmatched
# select_with_fields.sh  ~/final_2 | grep -v --color=always '|albums|' | wc -l
# total
# select_with_fields.sh  ~/final_2 | wc -l

#  |^(1)FOLDER       |(2)ARTIST     |(3)DATE     |(4)ALBUM      |(5)Disc     |(6)TRACK     |(7)TITLE      .(8)EXT$|
