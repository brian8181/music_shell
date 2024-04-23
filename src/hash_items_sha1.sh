#! /bin/bash

cat "$@" | while read -r line; do
    printf %s "$line" | sha1sum | cut -f"1 2 3" -d' '
done