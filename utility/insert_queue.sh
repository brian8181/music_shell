#!/bin/bash

./settings.sh

LINE_NUMBER=$1
SRC_LIST=$2

./insert $LINE_NUMBER "$SRC_LIST" "$HOME/.music_shell/$queue"