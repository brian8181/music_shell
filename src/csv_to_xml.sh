#!/bin/bash

SRC_FILE="$1"
DST_FILE="$2"
DST_FILE="${$DST_FILE:-SRC_FILE%*.csv}.xml"
FORMAT="location,artist,album,title"

if [[! -f "$SRC_FILE" ]]; then
    echo "Error Not File Found: source file "$SRC_FILE" found ..."
    exit 1
fi

if [[ -e "$DST_FILE" ]]; then
    DST_FILE="~${DST_FILE}"
fi

# check format
LEN_ORG=$(cat "$SRC_FILE" | wc -l)
LEN_CUR=$(cat "$SRC_FILE" | grep -E '^\".*\",\".*\",\".*\",\".*\"$' | wc -l)

if [[ $LEN_ORG != $LEN_CUR ]]; then
    echo "Error File Format: source file "$SRC_FILE" wrong format... \n\t"$FORMAT"
    exit 1
fi

cat "$SRC_FILE" | sed -E 's/\"([^,]*)\"/<~~~~\1~~~~>/g' | sed -E 's/<~~~~(.*)~~~~>,<~~~~(.*)~~~~>,<~~~~(.*)~~~~>,<~~~~(.*)~~~~>/<xml>\n\t<song>\n\t\t<location>\1<\/location>\n\t\t<artist>\2<\/artist>\n\t\t<album>\3<\/album>\n\t\t<title>\4<\/title>\n\t<\/song>\n<\/xml>/g' > "$DST_FILE"
