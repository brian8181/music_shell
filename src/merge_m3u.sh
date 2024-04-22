#!/bin/bash

# merge 2 playlists

SRC=$1
DST=$2

# append to DST
cp "${DST}" "${DST}".swp
cat "${SRC}" >> "${DST}".swp

# sort & remove duplicates
cat "${DST}".swp | sort -u > "${DST}"
rm "${DST}".swp