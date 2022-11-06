#!/usr/bin/bash

cat $2 | egrep --color=always -i "$1"  | tee playing 
echo -e "Match Count: \e[31m$(cat "$2" | wc -l)\e[0m ... searching for -> \e[31m\"$1\"\e[0m"
