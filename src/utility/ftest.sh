#!/bin/bash

FIELDS=$1
FOLDER=1
ARTIST=2
DATE=3
ALBUM=4
DISC=5
TRACK=6
TITLE=7
EXT=8

EXP="|\([a-z]\+\)|\([A-Za-z ]\+\)|\([0-9]\{4\}\)|\([A-Za-z ]\+\)|\([0-9]?\)|\([0-9]\+\)|\([A-Za-z ]\+\).\([A-Za-z0-9]\{1,4\}\)|"
FMT1="[Location: \"\1\"], [Artist: \"\2\"], [Date: \"\3\"], [Album: \"\4\"], [Disc: \"\5\"], [Track: \"\6\"], [Title: \"\7\"], [Ext: \"\8\"]"git 
# FMT2="\${EXT} \${ALBUM} \${ARTIST} \${DATE} \${ALBUM} \${TRACK} \${TITLE}"
# FMT3="\\${EXT} \\${ALBUM} \\${ARTIST} \\${DATE} \\${ALBUM} \\${TRACK} \\${TITLE}"

cat /home/brian/src/music_shell/test/tmp.txt | sed "s/${EXP}/${FMT1}/g"
# echo
# echo
# cat /home/brian/src/music_shell/test/tmp.txt | sed "s/${EXP}/${FMT2}/g"
# echo
# echo
# cat /home/brian/src/music_shell/test/tmp.txt | sed "s/${EXP}/${FMT3}/g"
