#!/bin/bash

# FILE: delete_dups.sh
# VERSION: 0.1.1
# FILE_DATE: Fri Nov  8 01:15:49 AM CST 202
# INFO: delete duplicate line in list (file)

FILE=$1
sort $FILE | uniq
