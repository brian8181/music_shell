#!/bin/bash

CNAME=$2

./search.sh $1 ./cache/cache.txt | cut -d'|' -f$CNAME