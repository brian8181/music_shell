#!/bin/bash

# load export settings
./settings.sh

OPTIONS=NULL
PLAYLIST_PATH=$1
DEST_PATH=$2

if [[ ! -r "$PLAYLIST_PATH" ]]; then
    echo "error: $CACHE_NAME does not exists"
    exit
fi

mkdir -p ${DEST_PATH}
# iter lines copy each file
cp ${SRC_FILE} ${DEST_FILE}