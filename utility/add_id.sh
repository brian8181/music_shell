#!/usr/bin/bash

# cat "$@" | while read -r line; do
#     printf %s "$line/"
#     printf %s "$line" | md5sum | cut -f1 -d' ' | sed -E 's|^/(.*)/(.*)$|\2/\1|g'
# done

./hash_lines.sh doc/tmp.txt | sed -E 's|^(.*/.*/.*)/(.*)$|\2/\1|g'