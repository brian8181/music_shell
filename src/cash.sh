#!/bin/bash

# FILE: 'cache2.0.sh'
# VERSION: '0.0.1'
# FILE_DATE: 'Fri Jul 12 07:03:30 AM CDT 2024'
# INFO: builds a new cache.sh

STORE_PREFIX=${1:-"/mnt/music/music-lib"}
CONFIG_PREFIX="$HOME/.music_shell"
TIME_STAMP="$(date.sh)"
CACHE="${CONFIG_PREFIX}/${TIME_STAMP}_cache.m3u"

echo "searching \"${STORE_PREFIX}\", writing cache --> \"${CACHE}\" ..."


### albums! ###
echo "searching for albums ......."
find "${STORE_PREFIX}" -iregex '^.*\.\(\(mp3\)\|\(flac\)\|\(ogg\)|\(ogg\)|\(wma\)|\(m4a\)\)$' | grep -E --color=never "albums/" > "$CACHE" # albums only

# remove prefix
sed -E -i "s/^.*music-lib\///g" ${CACHE}
# normalize, double quote all field values
# 1:location/2:artist/3:album/4:date/5:title/6:encoding/10:disc_count/11:track_count/12:genre/13:lyrics/14:file/15:file_size:16:bitrate/17:art/18:create_ts/19:update_ts
sed -E -i 's/^(albums)\/(.*)\/([0-9]{4}) - (.*)\/(([0-9]{1,2}).)?([0-9]{2})\. (.*)\.(.*)$/"\1"\/"\3"\/"\2"\/"\4"\/"\6"\/"\7"\/"\8"\/"\9"\/""\/""\/""\/""\/""\/""\/""\/""\/""\/""/g' ${CACHE}

### singles! ###
echo "searching for singles ......"
TIME_STAMP="$(date.sh)"
CACHE_SINGLES="${CONFIG_PREFIX}/${TIME_STAMP}_cache_SINGLES.m3u"
find "${STORE_PREFIX}" -iregex '^.*\.\(\(mp3\)\|\(flac\)\|\(ogg\)|\(ogg\)|\(wma\)\)$' | grep -E --color=never singles/ > ${CACHE_SINGLES}

# remove prefix
sed -E -i "s/^.*music-lib\///g" ${CACHE_SINGLES}
# remove '-' (dash/minus)
sed -E -i "s/-//g" "${CACHE_SINGLES}"
# normalize, double quote all field values
sed -E -i 's/^(singles)\/(.*) - (.*) (\([0-9]{4}\)) - (.*)\.(.*)$/"\1"\/"\2"\/"\3"\/"\4"\/"\5"\/"\6"\/""\/""\/""\/""\/""\/""\/""\/""\/""\/""\/""\/""\/""/g' ${CACHE_SINGLES}

# remove bad lines (unmatched)
TMP="${CONFIG_PREFIX}/$(date.sh).tmp"
cat $CACHE_SINGLES | grep -v '^singles\/.*$' > "$TMP"
mv "$TMP" "$CACHE_SINGLES"

### misc! ###
echo "searching for misc ........."
TIME_STAMP="$(date.sh)"
CACHE_MISC="${CONFIG_PREFIX}/${TIME_STAMP}_cache_MISC.m3u"
find "${STORE_PREFIX}" -iregex '^.*\.\(\(mp3\)\|\(flac\)\|\(ogg\)|\(ogg\)|\(wma\)\)$' | grep -E --color=never "misc/" > "${CACHE_MISC}"
cp "$CACHE_MISC" ~/c.txt

# remove prefix
sed -E -i "s/^.*music-lib\///g" "${CACHE_MISC}"
# remove '-' (dash/minus)
sed -E -i "s/-//g" "${CACHE_MISC}"
# normalize, double quote all field values
# <(1):location>/<(2):year> - <(3):album>/<(4):disc>.<(5):track>. - <(6):album_artist> - <(7):title>.<8:ext>
sed -E -i 's/^(misc)\/(.*)\/([0-9]{4}) - (.*)\/(([0-9]{1,2}).)?([0-9]{2})\. (.*) - (.*)\.(.*)$/"\1"\/"\3"\/"\2"\/"\4"\/"\6"\/"\7"\/"\8"\/"\9"\/""\/""\/""\/""\/""\/""\/""\/""\/""\/""/g' "${CACHE_MISC}"
                    
# remove bad lines (unmatched)
TMP="${CONFIG_PREFIX}/$(date.sh).tmp"
cat "$CACHE_MISC" | grep -v '^misc\/.*$' > "$TMP"
mv "$TMP" "$CACHE_MISC"

echo "searching for soundtrack ..."
TIME_STAMP="$(date.sh)"
CACHE_SOUNDTRACK="${CONFIG_PREFIX}/${TIME_STAMP}_cache_SOUNDTRACK.m3u"
find "${STORE_PREFIX}" -iregex '^.*\.\(\(mp3\)\|\(flac\)\|\(ogg\)|\(ogg\)|\(wma\)\)$' | grep -E --color=never "soundtrack/" > "${CACHE_SOUNDTRACK}"
cp "$CACHE_SOUNDTRACK" ~/c.txt

# remove prefix
sed -E -i "s/^.*music-lib\///g" "${CACHE_SOUNDTRACK}"
# remove '-' (dash/minus)
sed -E -i "s/-//g" "${CACHE_SOUNDTRACK}"
# normalize, double quote all field values
# <(1):location>/<(2):year> - <(3):album>/<(4):disc>.<(5):track>. - <(6):album_artist> - <(7):title>.<8:ext>
sed -E -i 's/^(soundtrack)\/(.*)\/([0-9]{4}) - (.*)\/(([0-9]{1,2}).)?([0-9]{2})\. (.*) - (.*)\.(.*)$/"\1"\/"\3"\/"\2"\/"\4"\/"\6"\/"\7"\/"\8"\/"\9"\/""\/""\/""\/""\/""\/""\/""\/""\/""\/""/g' "${CACHE_SOUNDTRACK}"

# remove bad lines (unmatched)
TMP="${CONFIG_PREFIX}/$(date.sh).tmp"
cat "$CACHE_SOUNDTRACK" | grep -v '^soundtrack\/.*$' > "$TMP"
mv "$TMP" "$CACHE_SOUNDTRACK"

# TODO! put it all together ...
### albums, singles, misc, sondtrack (missing)?! ###
cat "$CACHE" "$CACHE_SINGLES" "$CACHE_MISC" > "${CONFIG_PREFIX}/ALBUMS_SINGLES_MISC_$(date.sh).txt"

echo "writing   \"${STORE_PREFIX}\", (csv / cache) --> \"${CACHE}\" ..."