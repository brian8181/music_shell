#!/usr/bin/bash

FILE="./.SEARCH_TEXT"

if [[ ! -e $FILE ]]; then
    echo "invalid args (file does not exist )..."
    exit 1
fi

LEN=$(cat $FILE | wc -l)
BEG=${1:-1}
END=${2:-$LEN}

if [[ ${BEG} -le 0 || ${BEG} -gt END || $END -gt $LEN ]]; then
    echo "invalid args (out of range) ..."
    exit 1
fi

cat -n $FILE | sed -n "${BEG},${END}p"


