#!/bin/bash

# FILE: make_list.sh
# VERSION: 0.0.1
# FILE_DATE: Mon Dec  2 03:27:12 PM CST 2024
# INFO: create play list in db 


FILE=$1
LIST=

while read line; do
	LIST="'$line', $LIST"
done < "$FILE"

echo $LIST