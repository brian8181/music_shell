#!/bin/bash

# FILE: delete_queue_item.sh
# VERSION: 0.1.1
# FILE_DATE: Sat Jul 13 09:02:28 PM CDT 2024
# INFO: delete item from queue by index

CONFIG_PREFIX="$HOME/.music_shell"
FILE="${CONFIG_PREFIX}/.QUEUE"
INDEX="$1"

./delete_items.sh $FILE $INDEX
