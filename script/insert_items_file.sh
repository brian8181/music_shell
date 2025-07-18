#!/bin/bash

# FILE: 'insert.sh'
# VERSION: '0.0.1'
# FILE_DATE: 'Fri Jul 12 07:03:30 AM CDT 2024'
# INFO: insert item at index

CONFIG_PREFIX="$HOME/.music_shell"

LINE_INDEX=$1
SRC_LIST=$2
DST_LIST=$3

#  get length of file
LEN=$(cat "$DST_LIST" | wc -l)
LEN_TAIL=$(($LEN - $LINE_INDEX))

# get head and tail @ line number
head -$LINE_INDEX "$DST_LIST" > dst_head.swp
tail -$LEN_TAIL "$DST_LIST" > dst_tail.swp

# make head to destination
rm "$DST_LIST"
mv dst_head.swp $DST_LIST

# insert after head
cat "$SRC_LIST" >> $DST_LIST
# append tail
cat dst_tail.swp >> $DST_LIST

# remove tmp file
rm dst_tail.swp
