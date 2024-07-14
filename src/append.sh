#!/bin/bash

# FILE: 'src/append.sh'
# VERSION: '0.0.1'
# FILE_DATE: 'Fri Jul 12 07:03:30 AM CDT 2024'
# INFO: append items form src_file to dest_file

SRC=$1
DST=$2
cat "$SRC" >> "$DST"
