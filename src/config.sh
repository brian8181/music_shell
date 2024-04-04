#!/bin/bash

# read in config
./settings.sh

# read config file pairs

while read line; do
	NAME=${line%%=*}  # gets name
    VALUE=${line##*=} # gets value
    echo "Name=$NAME Value=$VALUE"
done < $HOME/.music_shell/config
