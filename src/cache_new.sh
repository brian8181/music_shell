#!/bin/bash
FILE='src/cacahe_new.sh'
VERSION='0.1.1'
FILE_DATE='Wed Jul 10 12:07:23 PM CDT 2024'

HOME="${1}"
STORE_PREFIX="${2}"
CONFIG_PREFIX="${3}"
TIME_STAMP="$(date.sh)"
CACHE_PATH="${4}"

echo "searching \"${STORE_PREFIX}\", writing cache too \"${CACHE_PATH}\" ..."
find "${STORE_PREFIX}" -iregex '^.*\.\(\(mp3\)\|\(flac\)\|\(ogg\)|\(wma\)\)$' > "${CACHE_PATH}"
echo "finished writing cache too \"${CACHE_PATH}\" ..."

# trim off root                                             # replace delimiter   # create date & album columns
sed 's/\/mnt\/music\/music-lib\///' "${CACHE_PATH}" | sed s/\\//\|/g | sed s/' - '/\|/ | sed s/\\.[[:space:]]/\|/ > "${CACHE_PATH}.tmp"
# add disc column                                           # seperate disc & track
sed -E "s/(\|[[:digit:]][[:digit:]]\|)/\|\1/" "${CACHE_PATH}.tmp" | sed -E "s/([[:digit:]]+)\\./\1\|/" > "${CACHE_PATH}"
