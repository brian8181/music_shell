#!/bin/bash

# FILE: 'colofiy.sh'
# VERSION: '0.0.1'
# FILE_DATE: 'Fri Jul 12 07:03:30 AM CDT 2024'
# INFO: all color to delimted text

FILE=$1
source $HOME/bin/color.sh

COLORS[0]=$FMT_FG_GREEN
COLORS[1]=$FMT_FG_LIGHT_BLUE
COLORS[2]=$FMT_FG_YELLOW
COLORS[3]=$FMT_FG_LIGHT_RED
COLORS[4]=$FMT_FG_MAGENTA
DST_FILE=${FILE%*.???}.fmt.${FILE##*.}

DIVISOR=5
let i=-1
$((++i%DIVISOR))]
cat $FILE | sed -E "s/([^\|]*)/${COLORS[$((++i%DIVISOR))]}\1${FMT_RESET}/1; s/([^\|]*)/${COLORS[$((++i%DIVISOR))]}\1${FMT_RESET}/2; s/([^\|]*)/${COLORS[$((++i%DIVISOR))]}\1${FMT_RESET}/3; \
                    s/([^\|]*)/${COLORS[$((++i%DIVISOR))]}\1${FMT_RESET}/4; s/([^\|]*)/${COLORS[$((++i%DIVISOR))]}\1${FMT_RESET}/5; s/([^\|]*)/${COLORS[$((++i%DIVISOR))]}\1${FMT_RESET}/6; \
                    s/([^\|]*)/${COLORS[$((++i%DIVISOR))]}\1${FMT_RESET}/5; s/([^\|]*)/${COLORS[$((++i%DIVISOR))]}\1${FMT_RESET}/6; s/([^\|]*)/${COLORS[$((++i%DIVISOR))]}\1${FMT_RESET}/7; \
                    s/([^\|]*)/${COLORS[$((++i%DIVISOR))]}\1${FMT_RESET}/8; s/([^\|]*)/${COLORS[$((++i%DIVISOR))]}\1${FMT_RESET}/9; s/([^\|]*)/${COLORS[$((++i%DIVISOR))]}\1${FMT_RESET}/10; \
                    s/([^\|]*)/${COLORS[$((++i%DIVISOR))]}\1${FMT_RESET}/11; s/([^\|]*)/${COLORS[$((++i%DIVISOR))]}\1${FMT_RESET}/12; s/([^\|]*)/${COLORS[$((++i%DIVISOR))]}\1${FMT_RESET}/13; \
                    s/([^\|]*)/${COLORS[$((++i%DIVISOR))]}\1${FMT_RESET}/14" \
                    | tee "$DST_FILE"

s/([^\|]*)/\1/
