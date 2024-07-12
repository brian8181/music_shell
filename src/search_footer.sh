#!/bin/bash

# FILE 'src/search_footer.sh'
# VERSION '0.0.1'
# FILE_DATE 'Fri Jul 12 07:03:30 AM CDT 2024'

SEARCH_TERM=$1
CACHE=$2
PLAYLIST=$3

echo -e "Match Count: \e[32m$(cat "${PLAYLIST}" | wc -l) / $(cat "$CACHE" | wc -l)\e[0m ... searching for -> \e[32m\""$SEARCH_TERM"\"\e[0m"