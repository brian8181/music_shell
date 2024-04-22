#!/bin/bash

LINK=$(readlink -f sp)
echo $LINK
NAME=$(md5sum $LINK)
echo ${NAME%$LINK}
./music_search.sh "$1" $LINK > ${NAME%$LINK}

rm sp
ln -s ${NAME%$LINK} sp