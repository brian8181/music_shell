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
cp ${PLAYLIST_PATH} ${DEST_PATH}/${PLAYLIST_NAME}

#iter rate lines copy each file
copy_file.sh ${SRC_FILE} ${DEST_FILE}