#!/bin/bash

file=$1

while read line; do
	NAME=${line%%=*}
    VALUE=${line##*=}
    echo "Name=$NAME Value=$VALUE"
done < "$file"

# get last one
NAME=${line%%=*}
VALUE=${line##*=}
echo "Name=$NAME Value=$VALUE"
