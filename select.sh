#! /usr/bin/bash

FILE=./mcache.csv
FIELDS='1 2 3 4 5 6 7'

if [ $# < 2 ]; then
	echo $#
	FILE=$2
fi

# echo $FIELDS
if [ $FIELDS == 0 ]; then
# 	echo Testing
	FIELDS='1 2 3 4 5 6 7'
fi

cut -d',' -f "$FIELDS" $FILE

