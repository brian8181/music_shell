#!/bin/bash

# FILE 'config.sh'
# VERSION '0.1.1'
# FILE_DATE 'Wed Jul 10 12:07:23 PM CDT 2024'
# INFO: get/find value by key
# RETURN: if exist key mapped value otherwise "null"

KEY=$1
# read config file pairs
while read line; do
    CUR_KEY=${line%%=*}  # gets
    if [[ $CUR_KEY == $KEY ]]; then
      echo "${line##*=}"
      exit 0
    fi
done < $HOME/.music_shell/config

echo "null"
exit 0
