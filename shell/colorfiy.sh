#!/bin/bash

# FILE: 'colofiy.sh'
# VERSION: '0.0.1'
# FILE_DATE: 'Fri Jul 12 07:03:30 AM CDT 2024'
# INFO: all color to delimted text

FILE=$1

FMT_RESET='\x1B[0m'
FMT_RESET_BOLD='\x1B[21m'
FMT_RESET_REVERSE='\x1B[27m'
FMT_BOLD='\x1B[1m'
FMT_REVERSE='\x1B[7m'
FMT_FG_RED='\x1B[31m'
FMT_FG_GREEN='\x1B[32m'
FMT_FG_YELLOW='\x1B[33m'
FMT_FG_BLUE='\x1B[34m'
FMT_FG_MAGENTA='\x1B[35m'
FMT_FG_CYAN='\x1B[36m'
FMT_FG_LIGHT_GREY='\x1B[37m'
FMT_FG_DARK_GREY='\x1B[90m'
FMT_FG_LIGHT_RED='\x1B[91m'
FMT_FG_LIGHT_GREEN='\x1B[92m'
FMT_FG_LIGHT_YELLOW='\x1B[93m'
FMT_FG_LIGHT_BLUE='\x1B[94m'
FMT_FG_LIGHT_MAGENTA='\x1B[95m'
FMT_FG_LIGHT_CYAN='\x1B[96m'
FMT_FG_WHITE='\x1B[97m'
FMT_BG_DEFUALT='\x1B[49m'

DST_FILE=${FILE%*.???}.fmt.${FILE##*.}
cat $FILE | sed -E "s/([^\|]*)/${FMT_FG_GREEN}\1${FMT_RESET}/1; s/([^\|]*)/${FMT_FG_YELLOW}\1${FMT_RESET}/2; s/([^\|]*)/${FMT_FG_YELLOW}\1${FMT_RESET}/3; \
                    s/([^\|]*)/${FMT_FG_CYAN}\1${FMT_RESET}/4; s/([^\|]*)/${FMT_FG_LIGHT_GREY}\1${FMT_RESET}/5; s/([^\|]*)/${FMT_FG_BLUE}\1${FMT_RESET}/6; \
                    s/([^\|]*)/${FMT_FG_MAGENTA}\1${FMT_RESET}/5; s/([^\|]*)/${FMT_FG_RED}\1${FMT_RESET}/6; s/([^\|]*)/${FMT_FG_WHITE}\1${FMT_RESET}/7; \
                    s/([^\|]*)/${FMT_FG_LIGHT_RED}\1${FMT_RESET}/8; s/([^\|]*)/${FMT_FG_LIGHT_BLUE}\1${FMT_RESET}/9; s/([^\|]*)/${FMT_FG_LIGHT_GREEN}\1${FMT_RESET}/10; \
                    s/([^\|]*)/${FMT_FG_CYAN}\1${FMT_RESET}/11; s/([^\|]*)/${FMT_FG_LIGHT_GREY}\1${FMT_RESET}/12; s/([^\|]*)/${FMT_FG_BLUE}\1${FMT_RESET}/13; \
                    s/([^\|]*)/${FMT_FG_MAGENTA}\1${FMT_RESET}/14" \
                    | tee "$DST_FILE"

# while read line; do
# 	echo -e "$line"
# done < "$DST_FILE"

