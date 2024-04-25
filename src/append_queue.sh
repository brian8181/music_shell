#!/bin/bash

./settings.sh

SRC_LIST=$1

./append.sh "$SRC_LIST" "${CONFIF_PREFIX}/queue"
