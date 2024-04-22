#!/bin/bash

LINE_NUMBER=$1
SRC_LIST=$2
DST_LIST=$3
LEN=$(cat "$DST_LIST" | wc -l)
TAIL_N=$(($LEN - $LINE_NUMBER))

tail -$TAIL_N "$DST_LIST" > dst_tail
head -$LINE_NUMBER "$DST_LIST" > dst_head
rm "$DST_LIST"
mv dst_head $DST_LIST
cat "$SRC_LIST" >> $DST_LIST
cat dst_tail >> $DST_LIST
rm dst_tail