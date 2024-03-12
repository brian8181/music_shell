#!/bin/bash'

# view a playlist
cat lz.m3u | sed -E "s/.*\/albums\///" | sed "s/\(.*\/\)\(.*\)\/\(.*\)\\.\(.*\)\.mp3/Album: \1 Artist: \2 Track \3 Name \4/"
#working on it
