#!/bin/bash

./settings.sh

INSERT=$1

./append.sh "$INSERT" "$HOME/.music_shell/queue"
