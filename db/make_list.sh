#!/bin/bash

FILE=$1
LIST=

while read line; do
	LIST="'$line', $LIST"
done < "$FILE"

echo $LIST