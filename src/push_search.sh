#!/bin/bash

ITEM=$1
HASH=$(md5sum ${ITEM})

mv $ITEM ./${HASH%$ITEM}
