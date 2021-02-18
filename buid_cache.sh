#!/usr/bin/bash

find . -iname *.mp3 > ~/script/music_cache.txt
find . -iname *.ogg >> ~/script/music_cache.txt
find . -iname *.flac >> ~/script/music_cache.txt


# music cache
#find . -iname *.mp3 > ~/script/music_cache.txt
#cat ~/script/music_cache.txt