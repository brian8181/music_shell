#!/bin/bash

# FILE: 'ms_pause.sh'
# VERSION: '0.0.1'
# FILE_DATE: 'Fri Jul 12 07:03:30 AM CDT 2024'
# INFO: player pause

CONFIG_PREFIX="$HOME/.music_shell"

if [ ! -e "$CONFIG_PREFIX/playing" ]; then
	rm "$CONFIG_PREFIX/playing"
	touch "$CONFIG_PREFIX/paused"
fi
# execute pause

exit 0