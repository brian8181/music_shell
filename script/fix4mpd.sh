#!/bin/bash

file="$1"
prefix="$2"

if [[ -z "$file" || -z "$prefix" ]]; then
    echo "Usage: $0 <file> <prefix>"
    exit 1
fi  

escaped_prefix="${prefix//\\/\\\\}"
# make back slashes forward slashes and remove prefix
cat "$file" | sed -E "s|${escaped_prefix}||g" | sed -E "s|\\\|/|g" > "${file%.*}_mpd.${file##*.}"

# $> ~/bin/fix4mpd.sh "<file_name>.m3u" "H:\mnt\music\"

# input line ...
# H:\mnt\music\albums\Alice Cooper\1972 - School's Out\01. School's Out.mp3
# output  line ...
# albums/Alice Cooper/1972 - School's Out/01. School's Out.mp3


