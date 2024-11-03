#!/usr/bin/bash

# FILE: 'append_sequenced_col.sh'
# VERSION: '0.0.1'
# FILE_DATE: 'Thu Oct 31 08:08:03 AM CDT 2024'
# INFO: append sequence column to delimted file

FILE=$1
BEG=$2;
INC=$3;

TMP_SEQUENCE_COL=tmp_$(date.sh)1.txt
TMP_FILE=tmp_$(date.sh)2.txt
LEN=$(cat $FILE | wc -l)
# begin @ 1111 increment by 3 each time go to $LEN of $CACHE ...
seq -w $BEG $INC $(($INC*$LEN+($BEG-$INC))) > "${TMP_SEQUENCE_COL}"
# combine id column with other song columns ...
paste -d'|' $TMP_SEQUENCE_COL $FILE > $TMP_FILE
#rm $TMP_SEQUENCE_COL