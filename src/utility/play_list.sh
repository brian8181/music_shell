#!/usr/bin/bash

#echo $1

# play song
#mpg123 --list './songs'
rm playing.last
cp playing playing.last
#!/bin/bash

#mpg123 --list playing

mpg123 -q  -f@playing