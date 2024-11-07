#!/bin/bash

# FILE:      'play.sh'
# VERSION:   '0.0.1'
# FILE_DATE: 'Tue Nov  5 04:34:53 PM CST 2024'
# INFO:      'stop playing'

PLAYING="$HOME/.music_shell/.PLAYING"
rm -f $PLAYING

# todo send stop signal