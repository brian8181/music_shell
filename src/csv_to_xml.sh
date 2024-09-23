#!/bin/bash

SRC_FILE="$1"
DST_FILE="${SRC_FILE%*.csv}.xml"
FORMAT="location,artist,album,title"
COMMENT="$2"
CURRENT_DATETIME=$(date)

if [[ !(-f "$SRC_FILE") ]]; then
    echo "Error Not File Found: source file "\"$SRC_FILE\"" found ..."
    exit 1
fi

if [[ -e "$DST_FILE" ]]; then
     echo "Error: destination "\"$DST_FILE\"" already exist ..."
     exit 1
fi

# todo
# SRC_FILE_TMP=TMP.csv
# tail -n $(($(cat $SRC_FILE | wc -l)-1)) > $SRC_FILE_TMP

PATTERN='^\"(.*)\",\"(.*)\",\"(.*)\",\"(.*)\"$'
REPLACE_PATTERN='\t<song>\n\t\t<location>\1<\/location>\n\t\t<artist>\2<\/artist>\n\t\t<album>\3<\/album>\n\t\t<title>\4<\/title>\n\t<\/song>'

# check format
LEN_ORG=$(cat "$SRC_FILE" | wc -l)
LEN_CUR=$(cat "$SRC_FILE" | grep -E "$PATTERN" | wc -l)

if [[ $LEN_ORG != $LEN_CUR ]]; then
    echo "Error File Format: source file \"$SRC_FILE\" wrong format... \n\t\"$FORMAT\""
    exit 1
fi

# xml header
echo '<?xml version="1.0"?>' > "$DST_FILE"
echo "<!-- FILE_DATE: ${COMMENT:=${CURRENT_DATETIME}} -->" >> "$DST_FILE"
echo -e "<songs>" >> "$DST_FILE"

cat $SRC_FILE | sed -E "s/${PATTERN}/${REPLACE_PATTERN}/g" >> "$DST_FILE"

# close element
echo -e "</songs>" >> "$DST_FILE"