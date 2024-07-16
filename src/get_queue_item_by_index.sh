#!/bin/bash

# FILE: 'get_queue_item_by_index.sh'
# VERSION: '0.0.1'
# FILE_DATE: 'Fri Jul 12 07:03:30 AM CDT 2024'
# INFO:

CONFIG_PREFIX="$HOME/.music_shell"
FILE="$CONFIG_PREFIX/queue"
N=$1

LINE=$(head -n $N $FILE | tail -n 1)
echo $LINE
