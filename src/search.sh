#!/usr/bin/bash
TEE_OPTION=$3
cat $2 | egrep --color=always -i "$1"  | tee ${TEE_OPTION} playing
echo -e "Match Count: \e[31m$(cat "playing" | wc -l)/$(cat "$2" | wc -l)\e[0m ... searching for -> \e[31m\"$1\"\e[0m"
