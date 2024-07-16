#!/bin/bash

# FILE: delete_cache_item.sh
# VERSION: 0.1.1
# FILE_DATE: Sat Jul 13 09:02:28 PM CDT 2024
# INFO: delete item from queue by index

CONFIG_PREFIX="$HOME/.music_shell"
FILE="${CONFIG_PREFIX}/cache/cache.m3u"
INDEX="$1"

if [[ "$(whoami)" != root ]]; then
  echo "Only user root can run this script."
  exit 1
fi

./delete_items.sh $FILE $INDEX

exit 0
