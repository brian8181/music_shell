<<<<<<< HEAD
#!/bin/bash

# FILE: 'src/settings.sh'
# VERSION: '0.0.1'
# FILE_DATE: 'Fri Jul 12 07:03:30 AM CDT 2024'
# INFO:

export STORE_PREFIX="/run/media/brian/music_usb/music-lib"
export CONFIG_PREFIX="$HOME/.music_shell"
export CACHE_NAME=".CASH"
export QUEUE_NAME=".QUEU"
export $FIFO="QUEUE_FIFO"
export STATE=1

export CURRENT_PLAYLIST=""
export CURRENT_SONG=""
export declare -i QUEUE_IDX=1
export CONTINOUS_PLAY=1
export RANMDON_PLAY=0
export HISTORY_LEN=0
export NOW_PLAYING_LEN=$(cat ../cache/queue | wc -l)

export FOLDER='1'
export ARTIST='2'
export DATE='3'
export ALBUM='4'
export DISC='5'
export TRACK='6'
export TITLE='7'
=======
#!/bin/bash

# FILE: 'src/settings.sh'
# VERSION: '0.0.1'
# FILE_DATE: 'Fri Jul 12 07:03:30 AM CDT 2024'
# INFO:

export STORE_PREFIX="/run/media/brian/music_usb/music-lib"
export CONFIG_PREFIX="$HOME/.music_shell"
export CACHE_NAME=".CASH"
export QUEUE_NAME=".QUEUE"
export $FIFO="QUEUE_FIFO"

export FOLDER='1'
export ARTIST='2'
export DATE='3'
export ALBUM='4'
export DISC='5'
export TRACK='6'
export TITLE='7'

# export STATE=1
# export CURRENT_PLAYLIST=""
# export CURRENT_SONG=""
# export declare -i QUEUE_IDX=1
# export CONTINOUS_PLAY=1
# export RANMDON_PLAY=0
# export HISTORY_LEN=0
# export NOW_PLAYING_LEN=$(cat ../cache/queue | wc -l)
>>>>>>> 9ed053b04aa5d6fce40ea7131c0c89a23dcb5bcb
