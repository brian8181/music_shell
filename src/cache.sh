#!/bin/bash

# settings.sh
HOME="/home/brian"
STORE_PREFIX="/mnt/music/music-lib"
CONFIF_PREFIX="${HOME}/.music_shell"
CACHE_NAME="cache.m3u"
TIME_STAMP="$(date.sh)"

find "${STORE_PREFIX}" -iname "*.mp3" > "${CONFIF_PREFIX}/${TIME_STAMP}_${CACHE_NAME}"
find "${STORE_PREFIX}" -iname "*.ogg" >> "${CONFIF_PREFIX}/${TIME_STAMP}_${CACHE_NAME}"
find "${STORE_PREFIX}" -iname "*.flac" >> "${CONFIF_PREFIX}/${TIME_STAMP}_${CACHE_NAME}"
find "${STORE_PREFIX}" -iname "*.wma" >> "${CONFIF_PREFIX}/${TIME_STAMP}_${CACHE_NAME}"
