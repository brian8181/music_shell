#!/bin/bash

# FILE 'src/find_artist.sh'
# VERSION '0.0.1'
# FILE_DATE 'Fri Jul 12 07:03:30 AM CDT 2024'
# INFO: find artist

CONFIG_PREFIX="$HOME/.music_shell"
CACHE_PATH="${CONFIG_PREFIX}/cache"

ARTIST="$1"
REXP="^albums|.*$ARTIST.*|.*|$"
PLAYLIST_NAME="$HOME/.music_shell/queue"
CACHE_NAME="${CACHE_PATH}/${2:-cache.m3u}"
IGNORE_CASE="${3:-i}" # not used

function SEARCH
{
    # check parmaters
    if [[ -z "$ARTIST" ]]; then
        echo "Error: no "$ARTIST" specified ..."
        exit
    fi
    cat "$CACHE_NAME" | egrep --color=always "$REXP" | tee $PLAYLIST_NAME
}

SEARCH "$REXP"  $CACHE_NAME
./search_footer.sh "$REXP" "$CACHE_NAME" "$PLAYLIST_NAME"
