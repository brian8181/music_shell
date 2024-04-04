#!/bin/bash

./settings.sh

LINE_NUMBER=$1
INSERT=$2
LIST_NAME=$3

./insert "$INSERT" $HOME/.music_shell/$queue"