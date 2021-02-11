#!/usr/bin/bash

#echo $1

# play song
#mpg123 --list './songs'
mpg123 --list $(cat song_list.txt)
