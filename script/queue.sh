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
mkfifo queue_fifo
touch RUNNING

while [ ! -f "exit" ]; 
do
    item=$(cat queue_fifo)
    if [ $item = "exit" ]; then 
      exit 0;
    fi
    echo $item | tee -a $QUEUE    
done

# remove playing flag
echo "exit $1 ..."

# usage: ffplay [options] input_file

# While playing:
# q, ESC              quit
# f                   toggle full screen
# p, SPC              pause
# m                   toggle mute
# 9, 0                decrease and increase volume respectively
# /, *                decrease and increase volume respectively
# a                   cycle audio channel in the current program
# v                   cycle video channel
# t                   cycle subtitle channel in the current program
# c                   cycle program
# w                   cycle video filters or show modes
# s                   activate frame-step mode
# left/right          seek backward/forward 10 seconds or to custom interval if -seek_interval is set
# down/up             seek backward/forward 1 minute
# page down/page up   seek backward/forward 10 minutes
# right mouse click   seek to percentage in file corresponding to fraction of width
# left double-click   toggle full screen

# Main options:
# -L                  show license
# -h topic            show help
# -? topic            show help
# -help topic         show help
# --help topic        show help
# -version            show version
# -buildconf          show build configuration
# -formats            show available formats
# -muxers             show available muxers
# -demuxers           show available demuxers
# -devices            show available devices
# -codecs             show available codecs
# -decoders           show available decoders
# -encoders           show available encoders
# -bsfs               show available bit stream filters
# -protocols          show available protocols
# -filters            show available filters
# -pix_fmts           show available pixel formats
# -layouts            show standard channel layouts
# -sample_fmts        show available audio sample formats
# -dispositions       show available stream dispositions
# -colors             show available color names
# -loglevel loglevel  set logging level
# -v loglevel         set logging level
# -report             generate a report
# -max_alloc bytes    set maximum size of a single allocated block
# -sources device     list sources of the input device
# -sinks device       list sinks of the output device
# -x width            force displayed width
# -y height           force displayed height
# -fs                 force full screen
# -an                 disable audio
# -vn                 disable video
# -sn                 disable subtitling
# -ss pos             seek to a given position in seconds
# -t duration         play  "duration" seconds of audio/video
# -bytes val          seek by bytes 0=off 1=on -1=auto
# -seek_interval seconds  set seek interval for left/right keys, in seconds
# -nodisp             disable graphical display
# -noborder           borderless window
# -alwaysontop        window always on top
# -volume volume      set startup volume 0=min 100=max
# -f fmt              force format
# -window_title window title  set window title
# -af filter_graph    set audio filters
# -showmode mode      select show mode (0 = video, 1 = waves, 2 = RDFT)
# -i input_file       read specified file
# -codec decoder_name  force decoder
# -autorotate         automatically rotate video

# Advanced options:
# -cpuflags flags     force specific cpu flags
# -cpucount count     force specific cpu count
# -hide_banner hide_banner  do not show program banner
# -ast stream_specifier  select desired audio stream
# -vst stream_specifier  select desired video stream
# -sst stream_specifier  select desired subtitle stream
# -stats              show status
# -fast               non spec compliant optimizations
# -genpts             generate pts
# -drp                let decoder reorder pts 0=off 1=on -1=auto
# -lowres             
# -sync type          set audio-video sync. type (type=audio/video/ext)
# -autoexit           exit at the end
# -exitonkeydown      exit on key down
# -exitonmousedown    exit on mouse down
# -loop loop count    set number of times the playback shall be looped
# -framedrop          drop frames when cpu is too slow
# -infbuf             don't limit the input buffer size (useful with realtime streams)
# -left x pos         set the x position for the left of the window
# -top y pos          set the y position for the top of the window
# -vf filter_graph    set video filters
# -rdftspeed msecs    rdft speed
# -acodec decoder_name  force audio decoder
# -scodec decoder_name  force subtitle decoder
# -vcodec decoder_name  force video decoder
# -find_stream_info   read and decode the streams to fill missing information with heuristics
# -filter_threads     number of filter threads per graph


