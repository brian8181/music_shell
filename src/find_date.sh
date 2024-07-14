#!/bin/bash

# FILE: 'src/find_album.sh'
# VERSION: '0.0.1'
# FILE_DATE: 'Fri Jul 12 07:03:30 AM CDT 2024'
# INFO: find album

DATE=$1
CACHE=$2
REXP="^albums\\,[A-Za-z0-9]+\\,$DATE\\,[A-Za-z0-9]+\\,.*$"

cat $CACHE | egrep "$REXP" | tee playing
#./search $REXP "$(date.sh)${ALBUM}.m3u"
