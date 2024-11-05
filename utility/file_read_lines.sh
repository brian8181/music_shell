#!/bin/bash

# read file line by line and print to stdout

FILE=$1

while read -r line; do
	printf '%b' "$line\n"
done < "$FILE"
