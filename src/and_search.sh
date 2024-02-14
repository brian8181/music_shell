#!/bin/bash

# TODO ONLY DO INTERSECT !
./search.sh "$1" ./cache.txt | ./search.sh "$2" ./cache.txt
