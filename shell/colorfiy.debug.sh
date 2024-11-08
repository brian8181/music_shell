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


echo "test"
echo "${FMT_FG_GREEN}testing 123...${FMT_RESET}"

V="[^\|]*'
EXP=^($V\)|($V)\|$V\|($V)\|($V)\|($V)\|($V)\|($V)\|$V\|$V\|$V\|$V\|$V\|$V$;

DST_FILE=${FILE%*.???}.fmt.${FILE##*.}

i=$((0))
while read line; do
    i=$((i+1))
    offset=$((32))
    echo $line | sed -E "s/([^\|]*)/\x1B[0m xxx \x1B[$((33+$i))m/$i"
	echo -e "$line"
done < "$DST_FILE"

