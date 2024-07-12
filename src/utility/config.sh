#!/bin/bash
FILE='src/config.sh'
VERSION='0.1.1'
FILE_DATE='Wed Jul 10 12:07:23 PM CDT 2024'

# read in config
./settings.sh

# read config file pairs
while read line; do
	NAME=${line%%=*}  # gets name
    VALUE=${line##*=} # gets value
    echo "Name=$NAME Value=$VALUE"
done < $HOME/.music_shell/config
