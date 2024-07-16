#!/bin/bash

# FILE: 'ms_play.sh'
# VERSION: '0.0.1'
# FILE_DATE: 'Fri Jul 12 07:03:30 AM CDT 2024'
# INFO: player play

CONFIG_PREFIX="$HOME/.music_shell"

rm "$CONFIG_PREFIX/stopped"
rm "$CONFIG_PREFIX/paused"
touch "$CONFIG_PREFIX/playing"

echo $LEN
exit 0