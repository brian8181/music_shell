#!/bin/bash

TRACK=$1
CACHE=$2
REXP="^albums\\,[A-Za-z0-9[:space:]]+\\,[0-9]+\\,[A-Za-z0-9[:space:]]+\\,$TRACK\\,[A-Za-z0-9[:space:]]+\\.[A-Za-z0-9]+$"

#echo $DATE
#echo $CACHE
#echo $REXP
#echo "$REXP"
#echo '$REXP'

cat $CACHE | egrep "$REXP" | tee playing
git 