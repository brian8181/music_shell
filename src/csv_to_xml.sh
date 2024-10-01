#!/bin/bash

SRC_FILE="$1"
DST_FILE="${SRC_FILE%*.csv}.xml"
FORMAT="location,artist,album,title"
COMMENT="$2"
CURRENT_DATETIME=$(date)

OPTSTRING=":ab"

while getopts ${OPTSTRING} opt; do
  case ${opt} in
    a)
      echo "Option -a was triggered."
      ;;
    b)
      echo "Option -b was triggered."
      ;;
    ?)
      echo "Invalid option: -${OPTARG}."
      exit 1
      ;;
  esac
done

if [[ !(-f "$SRC_FILE") ]]; then
    echo "Error Not File Found: source file "\"$SRC_FILE\"" found ..."
    exit 1
fi

if [[ -e "$DST_FILE" ]]; then
     echo "Error: destination "\"$DST_FILE\"" already exist ..."
     exit 1
fi

# remove header line
SRC_FILE_TMP="${SRC_FILE%*.csv}.tmp"
cat "$SRC_FILE" > "$SRC_FILE_TMP"
sed -i 1d "$SRC_FILE_TMP"

# remove header line
# SRC_FILE_TMP="${SRC_FILE%*.csv}.tmp"
# LEN=$(cat "$SRC_FILE" | wc -l)
# cat  "$SRC_FILE" | tail -n $((LEN-1)) > "$SRC_FILE_TMP"

# get header from src, use to create xml elements
# HEADERS=$(head -n 1 "$SRC_FILE")
# HEADER_PATTERN='^(.*),(.*),(.*),(.*)$'
# echo $HEADERS | sed -E "s/$HEADER_PATTERN/\4 \3 \2 \1/g"


#PATTERN='^\"(.*)\",\"(.*)\",\"(.*)\",\"(.*)\"$'
PATTERN='^\"(.*)\"\/\"(.*)\"\/\"(.*)\"\/\"(.*)\"$'
REPLACE_PATTERN='\t<song>\n\t\t<location>\1<\/location>\n\t\t<artist>\2<\/artist>\n\t\t<album>\3<\/album>\n\t\t<title>\4<\/title>\n\t<\/song>'

# check format
LEN_ORG=$(cat "$SRC_FILE_TMP" | wc -l)
LEN_CUR=$(cat "$SRC_FILE_TMP" | grep -E "$PATTERN" | wc -l)

diff $
# if [[ $LEN_ORG != $LEN_CUR ]]; then
#     echo -e "Error File Format: source file \"$SRC_FILE\" wrong format... \n\t\"$FORMAT\""
#     exit 1
# fi

# xml headers
echo '<?xml version = "1.0" encoding = "UTF-8" standalone = "no" ?>' > "$DST_FILE"
echo "<!-- FILE_DATE: ${COMMENT:=${CURRENT_DATETIME}} -->" >> "$DST_FILE"
echo -e "<songs>" >> "$DST_FILE"

# replace xml entities
cat "${$SRC_FILE_TMP}" | sed -E -i 's/&/&amp;/g' | sed -E 's/</&lt;/g' | sed -E 's/>/&gt;/g' | sed -E "s/'/&apos;/g" | sed -E "s/\\\"/&quot;/g" > dst_tmp~
mv -f dst_tmp~ "${$SRC_FILE_TMP}"

cat "$SRC_FILE_TMP" | sed -E "s/${PATTERN}/${REPLACE_PATTERN}/g" >> "$DST_FILE"
rm "$SRC_FILE_TMP"

# xml header close
echo -e "</songs>" >> "$DST_FILE"