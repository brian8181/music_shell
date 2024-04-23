#!/bin/bash

# load export settings
settings.sh

# while getopts 'abc:h' opt; do
#   case "$opt" in
#     a)
#       echo "Processing option 'a'"
#       ;;

#     b)
#       echo "Processing option 'b'"
#       ;;

#     c)
#       arg="$OPTARG"
#       echo "Processing option 'c' with '${OPTARG}' argument"
#       ;;

#     ?|h)
#       echo "Usage: $(basename $0) [-a] [-b] [-c arg]"
#       exit 1
#       ;;
#     --default)
#       DEFAULT=YES
#       shift # past argument
#       ;;
#     *)
#       POSITIONAL_ARGS+=("$1") # save positional arg
#       shift # past argument
#       ;;
#   esac
# done
# shift "$(($OPTIND -1))"

# echo "$POSITIONAL_ARGS"

# shift "$(($OPTIND -1))"
# SEARCH_TERM="$OPTARG"
# shift "$(($OPTIND -1))"
# CACHE_NAME="$OPTARG"
# shift "$(($OPTIND -1))"
# IGNORE_CASE="$OPTARG"

#OPTIONS=$1
SEARCH_TERM=$1
CACHE_NAME=$2
IGNORE_CASE=$3

if [ -z "$SEARCH_TERM" ]; then
    echo "Error: no "SEARCH_TERM" specified ..."
    exit
fi

echo "$SEARCH_TERM $IGNORE_CASE" >> $HOME/.music_shell/cache/search_history_all
cat "$CACHE_NAME" | egrep --color=always $IGNORE_CASE "$SEARCH_TERM" | tee $HOME/.music_shell/queue

#cp music_shell/queue music_shell/cache/hist_"$(date.sh) \"$SEARCH_TERM\"".txt
