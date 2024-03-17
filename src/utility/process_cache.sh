#!/bin/bash

# replace foward slash with comma
sed s/\\//','/g music_cache.txt > music_cache.csv
# get date , album , title
cut -d',' -f '7 8 9' music_cache.csv
