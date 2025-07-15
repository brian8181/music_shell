#!/usr/bin/bash

QUEUE="../test/.QUEUE"

# if [[ ! -e $QUEUE ]]; then
#     echo "invalid args (file does not exist )..."
#     exit 1
# fi

# LEN=$(cat $QUEUE | wc -l)
# BEG=${1:-1}
# END=${2:-$LEN}

# if [[ ${BEG} -le 0 || ${BEG} -gt END || $END -gt $LEN ]]; then
#     echo "invalid args (out of range) ..."
#     exit 1
# fi

# cat -n $QUEUE | sed -n "${BEG},${END}p"

#!/bin/bash

# FILE:      'play.sh'
# VERSION:   '0.0.1'
# FILE_DATE: 'Tue Nov  5 04:34:53 PM CST 2024'
# INFO:      'play playlist'

FMT_FG_RED='\e[31m'
FMT_FG_GREEN='\e[32m'
FMT_RESET='\e[0m'
AUTOEXIT="-autoexit -exitonmousedown"

OPTSTRING="vha"
while getopts ${OPTSTRING} opt; do
  case ${opt} in
    v)
      INFO
      echo -e "${FMT_FG_GREEN}${VERSION}${FMT_FG_RED} ${DEBUG:-debug}${FMT_RESET}"
      exit 0
      ;;
    h)
      HELP
      exit 0;
      ;;
    a)
      AUTOEXIT="-autoexit -exitonmousedown"
      exit 0;
      ;;
    :)
      PRINT_DEBUG "Option -${OPTARG} requires an argument."
      exit 1
      ;;
    ?)
      PRINT_DEBUG "Invalid option: -${OPTARG}."
      exit 1
      ;;
  esac
done
shift $(($OPTIND-1))

CONFIG="$HOME/.music_shell"
PREFIX="$HOME/music_backup/music-lib"
PLAYING="$CONFIG/.PLAYING"
QUEUE="$CONFIG/.QUEUE"

# create fifo
mkfifo QUEUE_FIFO
touch RUNNING

while [ ! -f "exit" ]; 
do

    CMD=$(cat QUEUE_FIFO)
    case ${CMD} in
    "PLAY")

        case ${STATE} in
        "PLAYING")
          ;;
        "STOPPED")
          ;;
        "PAUSED")
          ;;
        ?)
          ;;
        esac

      ;;
    "STOP")

        case ${STATE} in
        "PLAYING")
          ;;
        "STOPPED")
          ;;
        "PAUSED")
          ;;
        ?)
          ;;
        esac

      ;;
    "PAUSE")

        case ${STATE} in
        "PLAYING")
          ;;
        "STOPPED")
          ;;
        "PAUSED")
          ;;
        ?)
          ;;
        esac

      ;;
    "EXIT")

      INFO
      echo -e "${FMT_FG_GREEN}${VERSION}${FMT_FG_RED} ${DEBUG:-debug}${FMT_RESET}"
      exit 0
      ;;
    
    :)
      PRINT_DEBUG "Option -${OPTARG} requires an argument."
      exit 1
      ;;

    ?)
      PRINT_DEBUG "Invalid option: -${OPTARG}."
      exit 1
      ;;
  esac

done

 

# remove playing flag
echo "exit $1 ..."
