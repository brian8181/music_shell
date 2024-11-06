#!/usr/bin/bash

QUEUE="../test/.QUEUE"

if [[ ! -e $QUEUE ]]; then
    echo "invalid args (file does not exist )..."
    exit 1
fi

LEN=$(cat $QUEUE | wc -l)
BEG=${1:-1}
END=${2:-$LEN}

if [[ ${BEG} -le 0 || ${BEG} -gt END || $END -gt $LEN ]]; then
    echo "invalid args (out of range) ..."
    exit 1
fi

cat -n $QUEUE | sed -n "${BEG},${END}p"


