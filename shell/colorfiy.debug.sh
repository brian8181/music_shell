#!/bin/bash

# FILE: 'colofiy.sh'
# VERSION: '0.0.1'
# FILE_DATE: 'Fri Jul 12 07:03:30 AM CDT 2024'
# INFO: all color to delimted text

FILE=$1

source ./color.sh

COLORS[0]=$FMT_FG_GREEN
COLORS[1]=$FMT_FG_LIGHT_BLUE
COLORS[2]=$FMT_BG_YELLOW
COLORS[3]=$FMT_FG_LIGHT_RED
DST_FILE=${FILE%*.???}.fmt.${FILE##*.}

cat $FILE | sed -E "s/([^\|]*)/$COLORS[$((++i%4))]\1${FMT_RESET}/1; s/([^\|]*)/$COLORS[$((++i%4))]\1${FMT_RESET}/2; s/([^\|]*)/$COLORS[$((++i%4))]\1${FMT_RESET}/3; \
                    s/([^\|]*)/$COLORS[$((++i%4))]\1${FMT_RESET}/4; s/([^\|]*)/$COLORS[$((++i%4))]\1${FMT_RESET}/5; s/([^\|]*)/$COLORS[$((++i%4))]\1${FMT_RESET}/6; \
                    s/([^\|]*)/$COLORS[$((++i%4))]\1${FMT_RESET}/5; s/([^\|]*)/$COLORS[$((++i%4))]\1${FMT_RESET}/6; s/([^\|]*)/$COLORS[$((++i%4))]}\1${FMT_RESET}/7; \
                    s/([^\|]*)/$COLORS[$((++i%4))]\1${FMT_RESET}/8; s/([^\|]*)/$COLORS[$((++i%4))]\1${FMT_RESET}/9; s/([^\|]*)/$COLORS[$((++i%4))]\1${FMT_RESET}/10; \
                    s/([^\|]*)/$COLORS[$((++i%4))]\1${FMT_RESET}/11; s/([^\|]*)/$COLORS[$((++i%4))]\1${FMT_RESET}/12; s/([^\|]*)/$COLORS[$((++i%4))]\1${FMT_RESET}/13; \
                    s/([^\|]*)/$COLORS[$((++i%4))]\1${FMT_RESET}/14" \
                    | tee "$DST_FILE"

# while read line; do
# 	echo -e "$line"
# done < "$DST_FILE"

