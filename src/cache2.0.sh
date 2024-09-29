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

#find "${STORE_PREFIX}" -iregex '^.*\.\(\(mp3\)\|\(flac\)\|\(ogg\)|\(m4a\)|\(wma\)\)$' > "${CACHE}" # all

find "${STORE_PREFIX}" -iregex '^.*\.\(\(mp3\)\|\(flac\)\|\(ogg\)|\(ogg\)|\(wma\)\)$' | grep -E albums/ > $CACHE # albums only

echo "finished writing csv too \"${CACHE}\" ..."
echo 'transforming csv ...'

# remove prefix
sed -E -i "s/^.*music-lib\///g" ${CACHE}
# normalize, double quote all field values
sed -E -i 's/^(albums)\/(.*)\/([0-9]{4}) - (.*)\/(([0-9]{1,2}).)?([0-9]{2})\. (.*)\.(.*)$/"\1"\/"\3"\/"\2"\/"\4"\/"\6"\/"\7"\/"\8"\/"\9"\/""\/""\/""\/""\/""\/""\/""\/""\/""\/""/g' ${CACHE}
       
# 1:location/2:artist/3:album/4:date/5:title/6:encoding
# /10:disc_count/11:track_count/12:genre/13:lyrics/14:file/15:file_size:16:bitrate/17:art/18:create_ts/19:update_ts

# echo "searching for singles ..."

TIME_STAMP="$(date.sh)"
CACHE="${CONFIG_PREFIX}/${TIME_STAMP}_cache.m3u"
find "${STORE_PREFIX}" -iregex '^.*\.\(\(mp3\)\|\(flac\)\|\(ogg\)|\(ogg\)|\(wma\)\)$' | grep -E singles/ > ${CACHE}

# # remove prefix
sed -E -i "s/^.*music-lib\///g" ${CACHE}
sed -E -i 's/^(singles)\/(.*) - (.*) (\([0-9]{4}\)) - (.*)\.(.*)$/"\1"\/"\2"\/"\3"\/"\4"\/"\5"\/"\6"\/""\/""\/""\/""\/""\/""\/""\/""\/""\/""\/""\/""\/""/g' ${CACHE}

# singles
# "1:location/2:date - 3:album/4:artist - (5:date) - 6:disc.7:track 8:title.9:encoding "

# sed -E -i      's/^(misc|sountrack)\/(.*)\/([0-9]{4}) - (.*)\/(([0-9]{1,2}).)?([0-9]{2})\. (.*)\.(.*)$/"\1"\/"\3"\/"\2"\/"\4"\/"\6"\/"\7"\/"\8"\/"\9"\/""\/""/g' ${CACHE}


echo "finished writing (csv \ cache) too \"${CACHE}\" ..."
