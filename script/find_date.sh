#!/bin/bash

# FILE: 'src/find_album.sh'
# VERSION: '0.0.1'
# FILE_DATE: 'Fri Jul 12 07:03:30 AM CDT 2024'
# INFO: find date

CONFIG_PREFIX="$HOME/.music_shell"
CACHE_PATH="${CONFIG_PREFIX}/cache"

FIELD=$1
REXP=$2
PLAYLIST_NAME="$HOME/.music_shell/queue"
CACHE_NAME="${CACHE_PATH}/${2:-cache.m3u}"
IGNORE_CASE="${3:-i}" # not used

./find_by_field.sh $FIELD $REXP
