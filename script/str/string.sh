#!/bin/bash

# FILE: 'string.sh'
# VERSION: '0.0.1'
# FILE_DATE: 'Fri Jul 12 07:03:30 AM CDT 2024'
# INFO: string functions


# str, str_idx, str_len
function SUBSTRING
{
    SRC=$1 # src file
    SRC_IDX=$2
    SRC_LEN=$3

    #  get length of file
    SRC_FILE_LEN=$(cat "$SRC" | wc -l)

    # get src lines
    tail -$(($SRC_FILE_LEN - $SRC_IDX)) | head -$SRC_LEN > $SRC.swp

    # print substr
    cat "$SRC.swp"
    # remove tmp
    rm  "$SRC.swp"
}

# src, dst, src_idx, src_len, dst_idx, dst_len
function INSERT_FILE
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

function INSERT_STR
{
    SRC=$1 # src str
    DST=$2 # dst file
    SRC_IDX=$3
    SRC_LEN=$4
    DST_IDX=$5
    DST_LEN=$6

}

# src, dst, src_idx, src_len
function APPEND_FILE
{
    SRC=$1 # src file
    DST=$2 # dst file
    SRC_IDX=$3
    SRC_LEN=$4

    DST_IDX_END=
    DST_IDX=$DST_IDX_END
    DST_LEN=0

    #SUBSTR = $(SUBSTRING $SRC $SRC_IDX $SRC_LEN)
    # insert back
    #INSERT_FILE $SRC $DST $SRC_IDX $SRC_LEN $DST_IDX $DST_LEN
}

function APPEND_STR
{
    SRC=$1 # src str
    DST=$2 # dst file
    SRC_IDX=$3
    SRC_LEN=$4
    DST_IDX=$5
    DST_LEN=$6
}

# src, dst, src_idx, src_len
function PREPEND_FILE
{
    SRC=$1 # src file
    DST=$2 # dst file
    SRC_IDX=$3
    SRC_LEN=$4
    DST_IDX=$5
    DST_LEN=$6

    # insert front
    INSERT $SRC $DST $SRC_IDX $SRC_LEN 0 0
}

function PREPEND_STR
{

}