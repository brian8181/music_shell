#!/bin/bash

# FILE: 'cache2.0.sh'
# VERSION: '0.0.1'
# FILE_DATE: 'Fri Jul 12 07:03:30 AM CDT 2024'
# INFO: builds a new cache.sh

STORE_PREFIX=${1:-"/mnt/music/music-lib"}
CONFIG_PREFIX="$HOME/.music_shell"
TIME_STAMP="$(date.sh)"
CACHE="${CONFIG_PREFIX}/${TIME_STAMP}_cache.m3u"

echo "searching \"${STORE_PREFIX}\", writing cache too \"${CACHE}\" ..."
find "${STORE_PREFIX}" -iregex '^.*\.\(\(mp3\)\|\(flac\)\|\(ogg\)|\(wma\)\)$' > "${CACHE}"

echo "finished writing csv too \"${CACHE}\" ..."
echo 'transforming csv ...'

echo PREFIX=$STORE_PREFIX
#cat ${CACHE} | sed -E "s/${STORE_PREFIX}//g" > "${CONFIG_PREFIX}/${TIME_STAMP}_cache.tmp"

# delete leading spaces in fields 
# cat ${CACHE} | sed 's/|[[:space:]]/|/g' > ${CACHE_INDEXED}

# replace xml entities
# cat ${CACHE} | sed -E 's/&/&amp;/g' | sed -E 's/</&lt;/g' | sed -E 's/>/&gt;/g' \ 
# 	| sed -E "s/'/&apos;/g" | sed -E "s/\\\"/&quot;/g" > ${CACHE_INDEXED}

echo "finished writing (csv \ cache) too \"${CACHE}\" ..."
