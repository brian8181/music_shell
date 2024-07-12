#!/bin/bash

./settings.sh

#DISC=5
cut -d "|" -f $DISC $HOME/.music_shell/cache/cache.m3u
