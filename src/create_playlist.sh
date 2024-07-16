#!/bin/bash

# FILE: 'create_playlist.sh'
# VERSION: '0.0.1'
# FILE_DATE: 'Fri Jul 12 07:03:30 AM CDT 2024'
# INFO: create a new playlist

CONFIG_PREFIX="$HOME/.music_shell/playlist"
SEARCH_TERM="$1"
CACHE=${CONFIG_PREFIX}/cache/${2:-cache.m3u}
PLAYLIST=${CONFIG_PREFIX}/${3:new_playlist}

search.sh ${SEARCH_TERM} ${CACHE} ${PLAYLIST}.m3u

exit 0