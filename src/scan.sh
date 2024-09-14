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
echo "finished writing cache too \"${CACHE}\" ..."

echo 'transforming ...'

IDX='.0' 
CACHE_INDEXED="${CONFIG_PREFIX}/${TIME_STAMP}_cache${IDX}.m3u"
cat ${CACHE} > ${CACHE_INDEXED}

IDX='.1'
CACHE=${CACHE_INDEXED}
CACHE_INDEXED="${CONFIG_PREFIX}/${TIME_STAMP}_cache${IDX}.m3u"
# replace forward slash '/', with vbar '|'
cat ${CACHE} | sed 's/\//|/g' > ${CACHE_INDEXED}

IDX='.2'
CACHE=${CACHE_INDEXED}
CACHE_INDEXED="${CONFIG_PREFIX}/${TIME_STAMP}_cache${IDX}.m3u"
# TODO what about multipule dots? should not replcae all
# replace dot '.', with vbar '|' 
cat ${CACHE} | sed 's/\./|/g' > ${CACHE_INDEXED}

# delete leading spaces in fields 
IDX='.3'
CACHE=${CACHE_INDEXED}
CACHE_INDEXED="${CONFIG_PREFIX}/${TIME_STAMP}_cache${IDX}.m3u"
cat ${CACHE} | sed 's/|[[:space:]]/|/g' > ${CACHE_INDEXED}

IDX='.4'
CACHE=${CACHE_INDEXED}
CACHE_INDEXED="${CONFIG_PREFIX}/${TIME_STAMP}_cache${IDX}.m3u"
# delete prefix '|mnt|music|music-lib|'
cat ${CACHE} | sed 's/|mnt|music|music-lib|//g' > ${CACHE_INDEXED}

echo "finished writing cache too \"${CACHE_INDEXED}\" ..."
echo "finished."

# trim off root                                             # replace delimiter   # create date & album columns
#sed 's/\/mnt\/music\/music-lib\///' "${CACHE}" | sed s/\\//\|/g | sed s/' - '/\|/ | sed s/\\.[[:space:]]/\|/ > "${CACHE}.tmp"
# add disc column                                           # seperate disc & track
#sed -E "s/(\|[[:digit:]][[:digit:]]\|)/\|\1/" "${CACHE}.tmp" | sed -E "s/([[:digit:]]+)\\./\1\|/" > "${CACHE}"

# remove tmp
# rm "${STORE_PREFIX}/${CACHE}.tmp"

# nomalize date, album, disc, & track fields
#1 's/\/mnt\/music\/music-lib\///'
#2 sed s/\\//\|/g | sed s/' - '/\|/ | sed s/\\.[[:space:]]/\|/
# "date - album"
#3 's/\([[:digit:]]\{4\}\) - /\1|/g'
# "disc.track. "  "1.01., 2.01."
#4 's/\(|\(\([[:digit:]]\)\.\)\([[:digit:]][[:digit:]]\)\. \)\|\(|\([[:digit:]][[:digit:]]\)\. \)/|\3|\4\6|/g'
# file, ext
#5 "s/\\.\\([[:alpha:]][[:alpha:]][[:alpha:]]\\)$/|\1|/g"
