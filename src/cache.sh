#!/bin/bash

# settings.sh
# MUSIC_PATH=${STORE_PREFIX}
# DEST_PATH=${CONFIF_PREFIX}/%CACHE_NAME

MUSIC_PATH='/mnt/music/music-lib'
DEST_PATH='/home/brian/.music_shell'
CACHE_NAME='cache.m3u'
TIME_STAMP="$(date.sh)"

find "${MUSIC_PATH}" -iname "*.mp3" > "${DEST_PATH}/${TIME_STAMP}_${CACHE_NAME}"
find "${MUSIC_PATH}" -iname "*.ogg" >> "${DEST_PATH}/${TIME_STAMP}_${CACHE_NAME}"
find "${MUSIC_PATH}" -iname "*.flac" >> "${DEST_PATH}/${TIME_STAMP}_${CACHE_NAME}"
find "${MUSIC_PATH}" -iname "*.wma" >> "${DEST_PATH}/${TIME_STAMP}_${CACHE_NAME}"
