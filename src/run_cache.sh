#!/bin/bash

# FILE 'src/run_search.sh'
# VERSION '0.0.1'
# FILE_DATE 'Fri Jul 12 07:03:30 AM CDT 2024'

#!/bin/bash

# FILE: 'src/run_cache.sh'
# VERSION: '0.0.1'
# FILE_DATE: 'Fri Jul 12 07:03:30 AM CDT 2024'
# INFO: run cache.sh with default paramters

STORE_PREFIX="/mnt/music/music-lib"
CONFIG_PREFIX="$HOME/.music_shell"
TIME_STAMP="$(date.sh)"
CACHE_PATH="${CONFIG_PREFIX}/${TIME_STAMP}_cache.m3u"

./cache.sh ${HOME} ${STORE_PREFIX} ${CONFIG_PREFIX} ${CACHE_PATH}
