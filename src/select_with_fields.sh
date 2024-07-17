#!/bin/bash

# FILE: 'select_with_fields.sh'
# VERSION: '0.0.1'
# FILE_DATE: 'Sun Jul 14 09:11:03 PM CDT 2024'
# INFO: search queue

SEARCH=
file=$1
FIELDS=$2
FOLDER=1
ARTIST=2
DATE=3
ALBUM=4
DISC=5
TRACK=6
TITLE=7
EXT=8

# EXP="\([a-z]\+\)|\([A-Za-z ]\+\)|\([0-9]\{4\}\)|\([A-Za-z ]\+\)|\([0-9]\?\)|\([0-9]\+\)|\([-A-Za-z_ ]\+\).\([A-Za-z0-9]\{1,4\}\)|"
# #EXP="\|\([a-z]+\)\|\([^\|]+\)\|\([0-9]\{4\}\)\|\([^\|]+\)\|\([0-9]?\)\|\([0-9]+\)\|\([^\|]+\)\|\([A-Za-z0-9]\{1,4\}\)\|"
# EXP2="|\([[:lower:]]\+\)|\([[:alpha:][:space:]]\+\)|\([:digit:]\{4\}\)|\([[:alpha:][:space:]]\+\)|\([:digit:]\?\)|\([:digit:]\+\)|\([-[:alpha:]_[:blank:]]\+\).\([[:alnum:]]\{1,4\}\)|"

FOLDER_EXP='albums'
ARTIST_EXP="[-'[:alpha:][:space:]]+"
DATE_EXP='[0-9]{4}' # "([1][89][0-9]{2})|([2][0][0-2][0-9])"
ALBUM_EXP="[-.\(\),&'_:?[:alnum:][:space:]]+"
DISC_EXP='[0-9]?'
TRACK_EXP='[0-9]{2}' # "[0-9][1-9]"
TITLE_EXP="[-'\)\(,.&[:alnum:][:space:]]+"
EXT_EXP='[[:alnum:]]{1,4}'
NULL=""
EXP_ALL="[\|](${FOLDER_EXP})[\|](${ARTIST_EXP})[\|](${DATE_EXP})[\|](${ALBUM_EXP})[\|](${DISC_EXP})[\|](${TRACK_EXP})[\|](${TITLE_EXP})[\|](${EXT_EXP})[\|]"
FIELD_FMTS=':\1:\2:\3:\4:\5:\6:\7:\8'
# cat "$file" | sed -E "s/${EXP_ALL}/${FIELDS_FMTS}/g"

# FMT="[Location: \"\\${FOLDER}\"], [Artist: \"\\${ARTIST}\"], [Date: \"\\${DATE}\"], [Album: \"\\${ALBUM}\"], [Disc: \"\\${DISC}\"], [Track: \"\\${TRACK}\"], [Title: \"\\${TITLE}\"], [Ext: \"\\${EXT}\"]"
# cat "$file" | sed -E "s/${EXP}/${FIELDS:-${FMT}}/g"

# # FMT="\\${ARTIST} : \\${ALBUM} : \\${DATE} : \\${DISC} : \\${TRACK} \\${TITLE}"
# # cat ~/final_2 | sed "s/${EXP}/${FIELDS:-${FMT}}/g"

# cat ~/final_2 | sed -E  "s/[\|](albums)[\|]([-'[:alpha:][:space:]]+)[\|]([0-9]{4})[\|]([-')([:alnum:][:space:]]+)[\|]([0-9]?)[\|]([0-9]{2})[\|]([-'\)\(,.&[:alnum:][:space:]]+)[\|]([[:alnum:]]{1,4})[\|]/:\1:\2:\3:\4:\5:\6:\7:\8/g"
EX="s/${EXP_ALL}/${FIELDS_FMTS}/g"
cat $file | sed -E "${EX}"

# matched
# select_with_fields.sh  ~/final_2 | grep --color=always '|albums|' | wc -l
# unmatched
# select_with_fields.sh  ~/final_2 | grep -v --color=always '|albums|' | wc -l
# total
# select_with_fields.sh  ~/final_2 | wc -l
