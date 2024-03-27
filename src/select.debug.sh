#!/bin/bash

FIELDS=$1

FOLDER=1
ARTIST=2
DATE=3
ALBUM=4
DISC=5
TRACK=6
TITLE=7

# i=1;
# for field in "$@"
# do
#     echo "$i: $field";
#     i=$((i + 1));
# done

ARRAY=($FIELDS)
echo "${ARRAY[@]}"

for i in "${ARRAY[@]}"
do
  :
  # do whatever on $i
  echo $i
done

# for i in $FIELDS
# do
#   :
#   # do whatever on $i
#   echo ${ARRAY[i]}
# done

# echo "1 2 3" | sed "s/\([0-9]\) \([0-9]\)\([0-9]?\)$/\3\2\1/g"
#cut -d"|" -f "$FIELDS" ../test/cache.txt

//VALID_CHARS="[-a-zA-Z0-9'\"~!@#&)(}{][_ ]"
VALID_CHARS="[-a-zA-Z0-9_ ]"
#FOLDER|2       ARTIST          |3        DATE               |4    ALBUM             |5   DISC           |6    TRACK         |7      TITLE           |    EXT        .ENDLINE
RECORD="^\(${VALID_CHARS}*\)\|\([0-9][0-9][0-9][0-9]\)\|\(${VALID_CHARS}*\)\|\([0-9][0-9]\)?\|\([0-9][0-9]\)?\|\(${VALID_CHARS}*\)\.\(mp3|ogg|flac\)$"
RECORD="^\(${VALID_CHARS}*\|\)\\([0-9][0-9][0-9][0-9]\\|\\)\\(${VALID_CHARS}*\\|\\)\\([0-9][0-9]?\\|\\)\\([0-9][0-9]?\\|\\)\\(${VALID_CHARS}*\\)\\.(mp3|ogg|flac)$"
#./show_all.sh | sed "s/^\\(${VALID_CHARS}*\\)\\|\\([0-9][0-9][0-9][0-9]\\)/{\2\1}/g"
cut -d"|" -f "$ARTIST $DATE $ALBUM $DISC $TRACK" cache/cache.txt > s.txt
cat s.txt | sed "s/^\([a-zA-Z ]*\)|\([0-9][0-9][0-9][0-9]\)|\([a-zA-Z ]*\)|\(\)|\([0-9][0-9]\)/\5-\2\1\3/g"

# what the fuck can't seem to get this to match as expected (match the artist) ...
#./show_all.sh | cut -d "|" -f "1 2 5" | sed -E s/[a-zA-Z]*/xxx/g
# another example ...
#echo "Test|123|23" | sed -E s/[a-zA-Z]*/xxx/g
# matches
# xxx|xxx1xxx2xxx3xxx|xxx2xxx3xxx
# what!!!

#oops
#./show_all.sh | sed "s/^\\"^\\(${VALID_CHARS}*\\)\\|\\([0-9][0-9][0-9][0-9]\\)\\|\\(${VALID_CHARS}*\\)\\|\\([0-9][0-9]\\)?\\|\\([0-9][0-9]\\)?\\|\\(${VALID_CHARS}*\\)\\.(mp3|ogg|flac)$"|/{\1}/g"