#!/bin/bash

# FILE: append_queue_items.sh
# VERSION: 0.1.1
# FILE_DATE: Sat Jul 13 09:02:28 PM CDT 2024
# INFO: delete item from queue by index

CONFIG_PREFIX="${HOME}/.music_shell"
CACHE="${CONFIG_PREFIX}/cache/cache.m3u"
SRC="$1"

./append.sh "${SRC}" "${CACHE}"
