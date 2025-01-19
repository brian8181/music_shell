#!/bin/bash

# FILE: 'get_cache_len.sh'
# VERSION: '0.0.1'
# FILE_DATE: 'Fri Jul 12 07:03:30 AM CDT 2024'
# INFO: get cache len/size

CONFIG_PREFIX="$HOME/.music_shell"
LEN=$(cat "$CONFIG_PREFIX/cache/cache.m3u" | wc -l)
echo $LEN