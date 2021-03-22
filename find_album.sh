#!/usr/bin/bash

#OPTS=$1
ALBUM=$1
CACHE=$2
#REXP="^albums\\,[A-Za-z0-9[:space:]]+\\,[0-9]+\\,.*$ALBUM.*\\,[A-Za-z0-9]+\\,[A-Za-z0-9]+\\,[A-Za-z0-9[:space:]]+\\.[A-Za-z0-9]+$"
REXP="^albums\\,[A-Za-z0-9[:space:]]+\\,[0-9]+\\,.*$ALBUM.*\\,[0-9]+\\,[0-9]+\\,[A-Za-z0-9[:space:]]+\\.[A-Za-z0-9]+\\,$"

#echo "$#"
#echo "$@"

#echo $DATE
#echo $CACHE
#echo $REXP
#echo "$REXP"
#echo '$REXP'

cat $CACHE | egrep -i "$REXP" | tee playing
