#!/bin/bash

# FILE 'src/get_queue_len.sh'
# VERSION '0.0.1'
# FILE_DATE 'Fri Jul 12 07:03:30 AM CDT 2024'

CONFIG_PREFIX="$HOME/.music_shell"
LEN=$(cat "$CONFIG_PREFIX/queue" | wc -l)
echo $LEN