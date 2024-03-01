#!/bin/bash

LIST=$1

echo $LIST | sed -E 's/\|\w+\|\w+\|\w+\|/|/g' > $(date.sh)_cut_2_artist.txt