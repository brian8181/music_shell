#!/bin/bash

$LIST_NAME
$SEARCH_TERM
$CACHE_NAME


echo -e "Match Count: \e[31m$(cat "${LIST_NAME}" | wc -l) / $(cat "$CACHE_NAME" | wc -l)\e[0m ... searching for -> \e[31m\""$SEARCH_TERM"\"\e[0m"