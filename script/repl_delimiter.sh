#!/usr/bin/bash

# FILE: 'repl_delimiter.sh'
# VERSION: '0.0.1'
# FILE_DATE: 'Fri Jul 12 07:03:30 AM CDT 2024'
# INFO: replace delimiters in src file & write to dst file

SRC=$1
SRC_DLM=$2
DST=$3
DST_DLM=$4

cat $SRC | sed "y/$SRC_DLM/$DST_DLM/" > $DST
