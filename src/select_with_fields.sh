#!/bin/bash

# FILE: 'src/select_with_fields.sh'
# VERSION: '0.0.1'
# FILE_DATE: 'Sun Jul 14 09:11:03 PM CDT 2024'
# INFO: search queue

SEARCH=
FIELDS=$1
FOLDER=1
ARTIST=2
DATE=3
ALBUM=4
DISC=5
TRACK=6
TITLE=7
EXT=8

EXP="|\([a-z]\+\)|\([A-Za-z ]\+\)|\([0-9]\{4\}\)|\([A-Za-z ]\+\)|\([0-9]\?\)|\([0-9]\+\)|\([-A-Za-z_ ]\+\).\([A-Za-z0-9]\{1,4\}\)|"
FMT="[Location: \"\\${FOLDER}\"], [Artist: \"\\${ARTIST}\"], [Date: \"\\${DATE}\"], [Album: \"\\${ALBUM}\"], [Disc: \"\\${DISC}\"], [Track: \"\\${TRACK}\"], [Title: \"\\${TITLE}\"], [Ext: \"\\${EXT}\"]"
cat ~/src/music_shell/test/tmp.txt | sed "s/${EXP}/${FIELDS:-${FMT}}/g"

FMT="\\${ARTIST} : \\${ALBUM} : \\${DATE} : \\${DISC} : \\${TRACK} \\${TITLE}"
cat ~/src/music_shell/test/tmp.txt | sed "s/${EXP}/${FIELDS:-${FMT}}/g"
