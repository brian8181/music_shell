#! /bin/bash

cat "$@" | while read -r line; do
    printf %s "$line" | md5sum
done