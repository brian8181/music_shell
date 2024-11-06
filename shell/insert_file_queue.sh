#!/bin/bashSRC_FILEINDEX

# FILE: 'insert_file_at.sh'
# VERSION: '0.0.1'
# FILE_DATE: 'Fri Jul 12 07:03:30 AM CDT 2024'
# INFO: insert <src_file> contents in <dst_file> @ <index>

CONFIG_PREFIX="$HOME/.music_shell"
QUEUE="$CONFIG_PREFIX/.QUEUE"

INDEX=${1}
SRC_FILE=${2}
DST_FILE=${3:-${QUEUE}}

#  get length of file
LEN=$(cat "$DST_FILE" | wc -l)
LEN_TAIL=$(($LEN - $INDEX))

# get head and tail @ line number
head -$INDEX "$DST_FILE" > dst_head.tmp
tail -$LEN_TAIL "$DST_FILE" > dst_tail.tmp

# append <src_file> to <dst_file> head
# append <dst_file>'s tail to <dst_head>
cat "$SRC_FILE" >> dst_head.tmp
cat dst_tail.tmp >> dst_head.tmp
# rename
mv dst_head.tmp $DST_FILE

# remove tmp files
#rm dst_head.tmp
rm dst_tail.tmp