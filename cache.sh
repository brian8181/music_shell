#!/usr/bin/bash

MUSIC_PATH=$1
PROJECT_PATH=$2
NAME=$3

find "$MUSIC_PATH" -iname "*.mp3" > $PROJECT_PATH/$NAME
find "$MUSIC_PATH" -iname "*.ogg" >> $PROJECT_PATH/$NAME
find "$MUSIC_PATH" -iname "*.flac" >> $PROJECT_PATH/$NAME

# trim off root
sed 's/\/mnt\/music\/music-lib\///' ${PROJECT_PATH}/${NAME} | sed s/\\//\|/g | sed s/' - '/\|/ | sed s/\\.[[:space:]]/\|/ > "${PROJECT_PATH}/L1_${NAME}"

# replace / with |
#x sed s/\\//\|/g mc.txt > mc3.txt

# create date & album columns
#x sed s/' - '/\|/ mc3.txt > mc4.txt


# seperate disc & track
#x sed s/\\.[[:space:]]/\|/ mc4.txt > mc5.txt


# cat mc5.txt | grep album | cut -d\| -f 4 mc5.txt | sed s/\\./,/
# cut -d\| -f '1 2 3 4 5' mc5.txt


# disc ?
# sed -E "s/(\|[[:digit:]]*\|)/\|\1/" mc5.txt

# disc ?
# sed -E "s/(\|[[:digit:]][[:digit:]]\|)/\|\1/" mc5.txt > mc6.txt

# track ?
# sed -E "s/([[:digit:]]*)\\./\1\|/" mc6.txt