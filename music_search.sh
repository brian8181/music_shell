#!/usr/bin/bash

#echo $1
cat ./music_cache.txt | egrep "$1" | tee playing

#wc -l

scanpf '/<path>/<track_number>. <title>.<etx>' '<track>. <title>' ./playing > playing.formated


