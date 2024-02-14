#!/usr/bin/bash

# LINK=$(readlink -f sp)
# echo $LINK
# NAME=$(md5sum $LINK)
# echo ${NAME%$LINK}
./search.sh $1 > my_playlist

# rm sp
# ln -s $LINK sp
