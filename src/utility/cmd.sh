#!/bin/bash

# "Usage: ./select.sh [-d] [-f name.txt] [-s '$date $artist $album']"

FIELDS=$3
DELIMITER=$1
FILE=$2

while getopts ":d:f:s" opt; do
  case ${opt} in
    d ) # process option d
		DELIMITER=$OPTARG
      ;;
    f) # process option t
		FILE=$OPTARG
      ;;
	s) # process option t
		FIELDS=$OPTARG
	  ;;
    \? ) echo "Usage: cmd [-d] [-f name] [-s '1 2 3']"
      ;;
  esac
  shift $((OPTIND -1))
done

if [ "$#" =~ "2" ]; then
	$FILE = cache.txt
fi

if [ "${FIELDS}" =~ 0 ]; then
	FIELDS='1 2 3 4 5 6 7'
fi

cut -d"$DELIMITER" -f "$FIELDS" $FILE
