#! /usr/bin/bash

FIELDS=$1
#DELIMITER=|
FILE=$2

#if [ "$#" == 2 ]; then
#	echo TWO
#fi

if [ "${FIELDS}" == 0 ]; then
	FIELDS='1 2 3 4 5 6 7'
fi

cut -d'|' -f "$FIELDS" $FILE

