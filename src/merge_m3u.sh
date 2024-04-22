#!/bin/bash

SRC=$1
DEST=$2

# append to dest
cp "${DEST}" "${DEST}".swp
cat "${SRC}" >> "${DEST}".swp
# sort & remove duplicates
cat "${DEST}".swp | sort -u > "${DEST}"
#rm "${DEST}".swp