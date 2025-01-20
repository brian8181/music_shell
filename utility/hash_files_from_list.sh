#!/usr/bin/bash

cat "$@" | while read -r line; do
    printf %b "$(echo $line | md5sum | cut -f1 -d' ') @ $line\n