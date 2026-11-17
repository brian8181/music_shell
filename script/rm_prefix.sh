#!/bin/bash
file=$1
cat "$file" | sed -E "s|^[^/]+/||g" > "${file%.*}_rm_prefix.${file##*.}"