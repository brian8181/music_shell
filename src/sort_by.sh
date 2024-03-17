#!/bin/bash

FIELD=$1

ARTIST=2
DATE=3
ALBUM=4
DISC=5
TRACK=6
TITLE=7

sort -t "|" -k $FIELD ../test/cache.txt

#/search.sh "ZZ Top" ../test/cache.txt | sort -t"|" -k4
#./SELECT $STRING FROM $TABLE SORT_BY $ARTIST