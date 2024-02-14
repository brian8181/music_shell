#!/bin/bash

#!/usr/bin/bash
TEE_OPTION='-a'

# creates a playlist through --> search.sh
# and_search.sh

# TODO ONLY DO INTERSECT !
./search.sh "$1" ../cache.txt '-a'
