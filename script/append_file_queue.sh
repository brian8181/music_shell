#!/bin/bash

# FILE: append_queue_items.sh
# VERSION: 0.1.1
# FILE_DATE: Sat Jul 13 09:02:28 PM CDT 2024
# INFO: delete item from queue by index

CONFIG_PREFIX="${HOME}/.music_shell"
#QUEUE="${CONFIG_PREFIX}/.QUEUE"
SRC="$1"

#cat "${SRC}" >> .QUEUE

./append_file $SRC .QUEUE
