#!/bin/bash

ARTIST=$1
CACHE=$2
REXP="^albums\\,.*$ARTIST.*\\,[A-Za-z0-9]+\\,.*$"

#echo $DATE
#echo $CACHE
#echo $REXP
#echo "$REXP"
#echo '$REXP'

cat $CACHE | egrep "$REXP" | tee playing
