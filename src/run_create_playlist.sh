#!/bin/bash

./settings.sh

# run with default
SEARCH_TERM=$1
NAME=$2
#IGNORE_CASE=$3
IGNORE_CASE='--ignore_case'

./create_playlist $SEARCH_TERM cache.txt $NAME ${IGNORE_CASE}
