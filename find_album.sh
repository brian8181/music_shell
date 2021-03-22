#!/usr/bin/bash

ALBUM=$1
CACHE=$2
REXP="^albums\\,[A-Za-z0-9]+\\,[0-9]+\\,$ALBUM\\,.*$"

#echo $DATE
#echo $CACHE
#echo $REXP
#echo "$REXP"
#echo '$REXP'

cat $CACHE | egrep "$REXP" | tee playing
