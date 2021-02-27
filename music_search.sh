#!/usr/bin/bash

cat $2 | egrep "$1" | tee playing
