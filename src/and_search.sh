#!/usr/bin/bash
# param 1 & parm 2

cat ../cache.txt | egrep --color=always -i "$1" | egrep --color=always -i "$2"
