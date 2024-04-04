#!/bin/bash

./settings.sh

INSERT=$2
LINE_NUMBER=$1

tail -"$LINE_NUMBER $HOME/.music_shell/queue > queue_tail
head -"$LINE_NUMBER $HOME/.music_shell/queue > $HOME/.music_shell/queue
echo $INSERT >> $HOME/.music_shell/queue
cat queue_tail >> $HOME/.music_shell/queue
rm queue_tail