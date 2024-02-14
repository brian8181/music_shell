#!/usr/bin/bash
TEE_OPTION=$2

# creates a playlist through --> search.sh
./search.sh "$1" ../cache.txt "${TEE_OPTION}"
