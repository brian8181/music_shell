#!/bin/bash

FILE=$1

DT=$(date.sh)
DIF="$FILE_$DT.dif"
cat "$FILE" | grep -E '(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)/(.*)' > "$DIF"
diff -y "$FILE" "$DIF"
