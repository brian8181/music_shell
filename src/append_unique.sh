#! /bin/bash

SRC=$1 # source file to append to destination, with prefixed md5 hashes
DST=$2 # destinatin file, with prefixed md5 hashes
# DST=$(hash_list.sh $DST)
# HASH=""

# cat $DST | sed s/$HASH/g
#cat ~/tmp/cage.m3u.md5 | sed 's/8843abd9647f4cc143831b5bf797129d @.*$//g'

cat "$SRC" | while read -r line; do
     HASH=$(echo $line | md5sum | cut -f1 -d' ')
     cat $DST | sed "s/$HASH @.*$//g"
done