#!/usr/bin/bash

#echo $1

# play song
#mpg123 --list './songs'
#if $(diff playing playing.last | wc -l) == 0

#elif
rm playing.last
cp playing playing.last
mpg123 --list playing
