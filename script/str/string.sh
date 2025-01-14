#!/bin/bash

# src, dst, src_idx, src_len, dst_idx, dst_len
function INSERT 
{
    SRC=$1 # src file
    DST=$2 # dst file
    SRC_IDX=$3
    SRC_LEN=$4
    DST_IDX=$5
    DST_LEN=$6

    #  get length of file
    DST_FILE_LEN=$(cat "$DST" | wc -l)
    SRC_FILE_LEN=$(cat "$SRC" | wc -l)

    # get src lines
    tail -$(($SRC_FILE_LEN - $SRC_IDX)) | head -$SRC_LEN > $SRC.swp

    # get head and tail @ line number
    head -$SRC_IDX "$DST" > dst_head.swp
    tail -(($DST_FILE_LEN-($SRC_IDX+$SRC_LEN))) "$DST" > dst_tail.swp

    # make head to destination
    rm "$DST"
    mv dst_head.swp $DST

    # insert after head
    cat "$SRC.swp" >> $DST
    # append tail
    cat dst_tail.swp >> $DST

    # remove tmp file
    rm dst_tail.swp
}