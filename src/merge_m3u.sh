#!/bin/bash

SRC=$1
DEST=$2

# append to source and remove duplicates
cp "${DEST}" "${DEST}".swp
cat "${SRC}" >> "${DEST}".swp
cat "${DEST}".swp | sort -u > "${DEST}"
#rm "${DEST}".swp