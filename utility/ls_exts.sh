#!/bin/bash
FILE=$1

cat "$FILE" | sed -E "s/^[^/]*\/.*\.(.*)$/\1/g"  | sort -u
