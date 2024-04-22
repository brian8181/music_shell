#!/usr/bin/bash

rm playing.last
cp playing playing.last
#mpg123 --list './songs'

mpg123 -q -f@playing