#! /bin/bash

# FILE: 'append_unique_col.sh'
# VERSION: '0.0.1'
# FILE_DATE: 'Thu Oct 31 08:08:03 AM CDT 2024'
# INFO: append md5 column to delimted file

SRC=$1 # source file to append to destination, with prefixed md5 hashes
DST=$2 # destination file, with lines prefixed with md5 hashes

# cat $DST | sed s/$HASH/g
#cat ~/tmp/cage.m3u.md5 | sed 's/8843abd9647f4cc143831b5bf797129d @.*$//g'

cat "$SRC" | while read -r line; do
     HASH=$(echo $line | md5sum | cut -f1 -d' ')
     cat $DST | sed "s/$HASH @.*$//g"
done