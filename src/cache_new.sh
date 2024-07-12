#!/bin/bash
FILE='src/caahe_new.sh'
VERSION='0.1.1'
FILE_DATE='Wed Jul 10 12:07:23 PM CDT 2024'

STORE_PREFIX="/mnt/music/music-lib"
CONFIG_PREFIX="$HOME/.music_shell"
TIME_STAMP="$(date.sh)"
CACHE="${CONFIG_PREFIX}/${TIME_STAMP}_cache.m3u"

echo "searching \"${STORE_PREFIX}\", writing cache too \"${CACHE}\" ..."
find "${STORE_PREFIX}" -iregex '^.*\.\(\(mp3\)\|\(flac\)\|\(ogg\)|\(wma\)\)$' > "${CACHE}"
echo "finished writing cache too \"${CACHE}\" ..."

# trim off root                                             # replace delimiter   # create date & album columns
sed 's/\/mnt\/music\/music-lib\///' "${CACHE}" | sed s/\\//\|/g | sed s/' - '/\|/ | sed s/\\.[[:space:]]/\|/ > "${CACHE}.tmp"
# add disc column                                           # seperate disc & track
sed -E "s/(\|[[:digit:]][[:digit:]]\|)/\|\1/" "${CACHE}.tmp" | sed -E "s/([[:digit:]]+)\\./\1\|/" > "${CACHE}"

# nomalize date, album, disc, & track fields
# "date - album"
# 's/\([[:digit:]]\{4\}\) - /\1|/g'
# "disc.track. "  "1.01., 2.01."
# 's/\(|\(\([[:digit:]]\)\.\)\([[:digit:]][[:digit:]]\)\. \)\|\(|\([[:digit:]][[:digit:]]\)\. \)/|\3|\4\6|/g'
# file, ext
# "s/\\.\\([[:alpha:]][[:alpha:]][[:alpha:]]\\)$/|\1|/g"
