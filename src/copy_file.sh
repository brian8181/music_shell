#!/bin/bash

# load export settings
./settings.sh

# command line options
OPTIONS=NULL
SRC_PATH=$1
DEST_PATH=$2
DEST_FILE=$3

# copy file
mkdir -p ${DEST_PATH}
copy_file.sh ${SRC_FILE} ${DEST_FILE}
