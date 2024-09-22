#!/bin/bash

CSV_FILE=$1
OUT_FILE=${CSV_FILE%.csv}.xml

if [[! -f $CSV_FILE ]]; then
    echo "file, input file $CSV_FILE found ..."
    exit 1
fi

if [[ -e $OUT_FILE ]]; then
    echo "file $OUTPUT exists ..."
    exit 1
fi

# check format
LEN_ORG=$(cat $CSV_FILE | wc -l)
LEN_CUR=$(cat $CSV_FILE | grep -E 's/^\".*\",\".*\",\".*\",\".*\"$//g')

if [[ $LEN_ORG != $LEN_CUR ]]; then
    echo "File format Error ..."
    echo "location,artist,album,title"
    exit 1
fi

cat $CSV_FILE | sed -E 's/\"([^,]*)\"/<~~~~\1~~~~>/g' | sed -E 's/<~~~~(.*)~~~~>,<~~~~(.*)~~~~>,<~~~~(.*)~~~~>,<~~~~(.*)~~~~>/<xml>\n\t<song>\n\t\t<location>\1<\/location>\n\t\t<artist>\2<\/artist>\n\t\t<album>\3<\/album>\n\t\t<title>\4<\/title>\n\t<\/song>\n<\/xml>/g' > $OUT_FILE
