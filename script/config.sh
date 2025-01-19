#!/bin/bash

# FILE 'src/config.sh'
# VERSION '0.1.1'
# FILE_DATE 'Wed Jul 10 12:07:23 PM CDT 2024'

# read in config
FILE=$1
declare -A PAIRS

function read_config_pairs
{
    # read config file pairs
    while read line; do
        NAME=${line%%=*}  # gets name
        VALUE=${line##*=} # gets value
        PAIRS["$NAME"]="$VALUE"
    done < $HOME/.music_shell/config
}

echo values=${PAIRS[@]}
echo keys=${!PAIRS[@]}
echo Len=${#PAIRS[@]}

echo ${PAIRS["QUEUE_PATH"]}

for key in ${!PAIRS[@]}
do
  echo "${key}, ${PAIRS[${key}]}"
done
