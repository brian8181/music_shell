#!/usr/bin/bash

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

VALID_CHARS="[-a-zA-Z0-9'\"~*#@)(}{_ ]";
RECORD="^\\(${VALID_CHARS}*\\)\\|\\([0-9][0-9][0-9][0-9]\\)\\|\\(${VALID_CHARS}*\\)\\|\\([0-9][0-9]\\)?\\|\\([0-9][0-9]\\)?\\|\\(${VALID_CHARS}*\\)\\.(mp3|ogg|flac)$"
./show_all.sh | sed "s/^\\(${VALID_CHARS}*\\)\\|\\([0-9][0-9][0-9][0-9]\\)/{\2\1}/g"

#oops
#./show_all.sh | sed "s/^\\"^\\(${VALID_CHARS}*\\)\\|\\([0-9][0-9][0-9][0-9]\\)\\|\\(${VALID_CHARS}*\\)\\|\\([0-9][0-9]\\)?\\|\\([0-9][0-9]\\)?\\|\\(${VALID_CHARS}*\\)\\.(mp3|ogg|flac)$"|/{\1}/g"