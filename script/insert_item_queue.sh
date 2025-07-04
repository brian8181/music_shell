#!/bin/bash

# FILE: 'insert_item.sh'
# VERSION: '0.0.1'
# FILE_DATE: 'Fri Jul 12 07:03:30 AM CDT 2024'
# INFO: insert item <src_index> from file <src_file> into <dst_file> @ <dst_index>

CONFIG_PREFIX="$HOME/.music_shell"
QUEUE="$CONFIG_PREFIX/.QUEUE"

SRC_INDEX=${1}
SRC_FILE=${2}
DST_INDEX=${4}
DST_FILE=${3:-${QUEUE}}

#  get length of file
LEN=$(cat "$DST_FILE" | wc -l)
LEN_TAIL=$(($LEN - $DST_INDEX))

# get head and tail @ line number
head -$DST_INDEX "$DST_FILE" > dst_head.tmp
tail -$LEN_TAIL "$DST_FILE" > dst_tail.tmp

# append <src_file> to <dst_file> head
# append <dst_file>'s tail to <dst_head>
LINE=$(head -$SRC_INDEX $SRC_FILE | tail -n 1)
echo $LINE >> dst_head.tmp
cat dst_tail.tmp >> dst_head.tmp
mv dst_head.tmp $DST_FILE

# remove tmp files
rm dst_head.tmp
rm dst_tail.tmp
