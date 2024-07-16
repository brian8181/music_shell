#!/bin/bash

# FILE: delete_items.sh
# VERSION: 0.1.1
# FILE_DATE: Sat Jul 13 09:02:28 PM CDT 2024
# INFO: delete item

FILE="$1"
BEG="$2"
END="${3:-${BEG}}"

TIME_STAMP="$(date.sh)"
cp "$FILE" "${FILE}.${TIME_STAMP}"

sed -i "${BEG},${END}d" "${FILE}"