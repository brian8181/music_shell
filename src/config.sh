#!/bin/bash

# read config file pairs

while read line; do
	NAME=${line%%=*}  # gets name
    VALUE=${line##*=} # gets value
    echo "Name=$NAME Value=$VALUE"
done < $HOME/.music_shell/config

# get last one
# NAME=${line%%=*}
# VALUE=${line##*=}
# echo "Name=$NAME Value=$VALUE"
