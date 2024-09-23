#!/bin/bash

SRC_FILE="$1"
DST_FILE="${SRC_FILE%*.csv}.xml"
FORMAT="location,artist,album,title"

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

# check format
LEN_ORG=$(cat "$SRC_FILE" | wc -l)
LEN_CUR=$(cat "$SRC_FILE" | grep -E '^\".*\",\".*\",\".*\",\".*\"$' | wc -l)

if [[ $LEN_ORG != $LEN_CUR ]]; then
    echo "Error File Format: source file \"$SRC_FILE\" wrong format... \n\t\"$FORMAT\""
    exit 1
fi

echo '<?xml version="1.0"?>' > "$DST_FILE"
echo "<songs>" >> "$DST_FILE"

# todo
# DELIMITERS='<~~~~\1~~~~>'
# INSERT_DELIMTERS_PATTERN='([^,]*)'

FIND_PATTERN='<~~~~(.*)~~~~>,<~~~~(.*)~~~~>,<~~~~(.*)~~~~>,<~~~~(.*)~~~~>'
REPLACE_PATTERN='<song>\n\t<location>\1<\/location>\n\t<artist>\2<\/artist>\n\t<album>\3<\/album>\n\t<title>\4<\/title>\n<\/song>'
cat $SRC_FILE | sed -E 's/\"([^,]*)\"/<~~~~\1~~~~>/g' | sed -E "s/${FIND_PATTERN}/${REPLACE_PATTERN}/g" >> "$DST_FILE"

echo "</songs>" >> "$DST_FILE"