#! /bin/bash

cat "$@" | while read -r line; do
    printf %s "$line" | sha1sum | cut -f1 -d' '
done