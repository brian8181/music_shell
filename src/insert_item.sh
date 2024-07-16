#!/bin/bash

# FILE: src/delete.sh
# VERSION: 0.1.1
# FILE_DATE: Sat Jul 13 09:02:28 PM CDT 2024
# INFO: delete item

FILE="$1"
INDEX="$2"
ITEM="$3"

TIME_STAMP="$(date.sh)"
cp "$FILE" "${FILE}.${TIME_STAMP}"

sed -i "${INDEX} i ${ITEM}" "${FILE}"