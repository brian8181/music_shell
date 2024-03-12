#!/usr/bin/bash
# TEE_OPTION=$2
# cat $1 | tee ${TEE_OPTION} playing
cat $1 | tee playing
echo -e "Match Count: \e[31m$(cat "playing" | wc -l)/$(cat "$1" | wc -l)\e[0m ... searching for -> \e[31m\"../cache.txt\"\e[0m"
