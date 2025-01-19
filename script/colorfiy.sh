#!/bin/bash

# FILE: 'colofiy.sh'
# VERSION: '0.0.1'
# FILE_DATE: 'Fri Jul 12 07:03:30 AM CDT 2024'
# INFO: all color to delimted text

FILE=$1
source $HOME/bin/color.sh

DST_FILE=${FILE%*.???}.fmt.${FILE##*.}
cat $FILE | sed -E "s/([^\|]*)/${FMT_INVERT}${FMT_FG_GREEN}\1${FMT_RESET}/1; s/([^\|]*)/${FMT_INVERT}${FMT_FG_YELLOW}\1${FMT_RESET}/2; s/([^\|]*)/${FMT_INVERT}${FMT_FG_YELLOW}\1${FMT_RESET}/3; \
                    s/([^\|]*)/${FMT_INVERT}${FMT_FG_CYAN}\1${FMT_RESET}/4; s/([^\|]*)/${FMT_INVERT}${FMT_FG_LIGHT_GREY}\1${FMT_RESET}/5; s/([^\|]*)/${FMT_INVERT}${FMT_FG_BLUE}\1${FMT_RESET}/6; \
                    s/([^\|]*)/${FMT_INVERT}${FMT_FG_MAGENTA}\1${FMT_RESET}/5; s/([^\|]*)/${FMT_INVERT}${FMT_FG_RED}\1${FMT_RESET}/6; s/([^\|]*)/${FMT_INVERT}${FMT_FG_WHITE}\1${FMT_RESET}/7; \
                    s/([^\|]*)/${FMT_INVERT}${FMT_FG_LIGHT_RED}\1${FMT_RESET}/8; s/([^\|]*)/${FMT_INVERT}${FMT_FG_LIGHT_BLUE}\1${FMT_RESET}/9; s/([^\|]*)/${FMT_INVERT}${FMT_FG_LIGHT_GREEN}\1${FMT_RESET}/10; \
                    s/([^\|]*)/${FMT_INVERT}${FMT_FG_CYAN}\1${FMT_RESET}/11; s/([^\|]*)/${FMT_INVERT}${FMT_FG_LIGHT_GREY}\1${FMT_RESET}/12; s/([^\|]*)/${FMT_INVERT}${FMT_FG_BLUE}\1${FMT_RESET}/13; \
                    s/([^\|]*)/${FMT_INVERT}${FMT_FG_MAGENTA}\1${FMT_RESET}/14" \
                    | tee "$DST_FILE"

# while read line; do
# 	echo -e "$line"
# done < "$DST_FILE"

