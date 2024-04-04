#!/bin/bash

input=$1

while read line; do
	NAME=${line%%=*}
    VALUE=${line##*=}
    echo "Name=$NAME Value=$VALUE"
done < "$input"

# get last one
NAME=${line%%=*}
VALUE=${line##*=}
echo "Name=$NAME Value=$VALUE"
