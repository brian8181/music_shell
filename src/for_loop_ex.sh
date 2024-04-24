#!/bin/bash

# Define the input file
INFILE=$1

# Read the input file line by line using a for loop
IFS=$'\n' # set the Internal Field Separator to newline
for LINE in $(cat "$INFILE")
do
    echo "$LINE"
done