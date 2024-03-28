#!/bin/bash

~/src/music_shell/src/utility/fields.sh

#FIELDS=$1
# FOLDER=1
# ARTIST=2
# DATE=3
# ALBUM=4
# DISC=5
# TRACK=6
# TITLE=7
# EXT=8

# VALID_CHARS="[-a-zA-Z0-9_ ]"
NAME=$(date.sh)_cache.txt
cut -d"|" -f "$ARTIST $DATE $ALBUM $TRACK $TITLE" cache/cache.txt > cache/$NAME

#  ^(1)FOLDER       |(2)ARTIST     |(3)DATE     |(4)ALBUM      |(5)Disc     |(6)TRACK     |(7)TITLE      .(8)EXT$
# REGX="^${FOLDER_EXP}\|${STRING_EXP}\|${DATE_EXP}\|${STRING_EXP}\|${DISC_EXP}\|${TRACK_EXP}\|${STRING_EXP}\.${EXT_EXP}$"
# PUNCT=" ][}{)(~!@#$%^&*_+=,.><:;'\\\""
# STRING_EXP="([[:alnum:][:blank:][ }{][|\~@#$%^&*()-_+=]+)"
# DATE_EXP="([[:digit:]]{4})"
# DISC_EXP="([[:digit:]]{2}?)"
# TRACK_EXP="([[:digit:]]{2})"
# EXT_EXP="((mp3|ogg|flac)|([[:alnum:]]{3}))"

# # PARAMS="s/${REGX}/\\${EXT} \\${ALBUM} \\${ARTIST} \\${DATE} \\${ALBUM} \\${TRACK} \\${TITLE}/g"
# # sed -E "$PARAMS" cache/cxche.txt
sed -E "s/([[:alnum:][:blank:]]*)\|([[:digit:]]{4})\|([[:alnum:][:blank:]]*)\|([[:digit:]]{2})\|([[:alnum:][:blank:]]*)\.(mp3|ogg|flac)/\\2 \\3 \\4 \\5/g" cache/$NAME
