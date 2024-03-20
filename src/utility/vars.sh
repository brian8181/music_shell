#!/bin/bash

export CURRENT_PLAYLIST=$1
export CURRENT_SONG=$2
export CURRENT_POS=$3
export CONTINOUS_PLAY=$4
export RANMDON_PLAY=$5
export HISTORY_LEN=100
export NOW_PLAYING_LEN=$(cat ../cache/playing | wc -l)
