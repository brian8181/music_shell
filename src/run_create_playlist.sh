#!/bin/bash

./settings.sh

# run with default
FILTER=$1
NAME=$2
#IGNORE_CASE=$3
IGNORE_CASE='--ignore_case'

./create_playlist $FILTER cache.txt $NAME ${IGNORE_CASE}
