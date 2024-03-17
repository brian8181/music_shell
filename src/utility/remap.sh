#!/bin/bash

FILE_NAME=$1
PREFIX=$2
NEW_PREFIX=$3

#TMP_PREFIX=$(cat $NEW_PREFIX | sed s/\\//x/g)
TMP_PREFIX=$(echo $NEW_PREFIX | sed "s/F/x/g")
# replace delimter backslash with forward slash
EXPR="s/^.*music-lib/'${NEW_PREFIX}'/g"
TEST=xx
#FILE_CONTENTS=$(cat $FILE_NAME | sed 's/\\/\//g'  | sed ${EXPR})
FILE_CONTENTS=$(cat $FILE_NAME | sed 's/\\/\//g'  | sed s/^.*music-lib/${TEST}/g)
echo "FILE_CONTENT:$FILE_CONTENTS"

# testing
echo "PREFIX=$PREFIX"
echo "NEW_PREFIX=$NEW_PREFIX"
echo "TMP_PREFIX=${TMP_PREFIX}"
echo "EXPR=${EXPR}"
echo "FILE_NAME_OUT=${FILE%.*}.txt"
