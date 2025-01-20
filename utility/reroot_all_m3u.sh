#!/bin/bash

# FILE: 'utility/reroot_all_m3u.sh'
# VERSION: '0.0.1'
# FILE_DATE: Sun Jan 19 12:21:59 PM CST 2025
# INFO:  for all m3u files in $DIR, for all lines in m3u file replace with prefix with new prefix 

#todo
#DIR=$1
MUSIC_DIR=$HOME/mdrive/music-lib
ls -1 --color=never $MUSIC_DIR/*.m3u > ~/tmp/tmp_m3u_list.tmp

function REROOT_M3U
{
    FILE="$1"
    cat "$FILE" | sed -E "s|(Z\\:\\\mnt\\\music\\\music-lib\\\)(.*)|F:\\\music-lib\\\\\2|g" > "$HOME/tmp/${FILE##*/}"
}

while read -r file; do
    
   REROOT_M3U "$file"

done < ~/tmp/tmp_m3u_list.tmp
