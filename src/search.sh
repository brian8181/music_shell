#!/usr/bin/bash

cat $2 | egrep -i "$1" | tee playing
