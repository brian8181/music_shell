#!/bin/bash

file="$1"
prefix="$2"

if [[ -z "$file" || -z "$prefix" ]]; then
    echo "Usage: $0 <file> <prefix>"
    exit 1
fi

# Escape backslashes (and dots/brackets just in case) for sed
escaped_prefix=$(printf '%s\n' "$prefix" | sed 's/[][\.*^$(){}?+|/]/\\&/g')

# Strip Windows \r, remove prefix at start of line, and convert \ to /
sed -e 's/\r$//' \
    -e "s|^${escaped_prefix}||" \
    -e 's|\\|/|g' \
    "$file" > "${file%.*}_mpd.${file##*.}"