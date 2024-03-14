#!/usr/bin/bash
# param 1 & parm 2

cat ../cache.txt | egrep --color=always -i "$1" | egrep --color=always -i "$2"
#echo -e "Match Count: \e[31m$(cat "playing" | wc -l)/$(cat "$1" | wc -l)\e[0m ... searching for -> \e[31m\"../cache.txt\"\e[0m"