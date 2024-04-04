#!/bin/bash

./settings.sh

INSERT=$1
LIST_NAME=$2

echo "$INSERT" >> "$HOME/.music_shell/$LIST_NAME"
