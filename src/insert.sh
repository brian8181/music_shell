#!/bin/bash

./settings.sh

LINE_NUMBER=$1
INSERT=$2
LEN=$(cat $HOME/.music_shell/queue | wc -l)
TAIL_N=$(($LEN - $LINE_NUMBER))

tail -$TAIL_N $HOME/.music_shell/queue > queue_tail
head -$LINE_NUMBER $HOME/.music_shell/queue > $HOME/.music_shell/queue_head
rm $HOME/.music_shell/queue;
mv $HOME/.music_shell/queue_head $HOME/.music_shell/queue
echo $INSERT >> $HOME/.music_shell/queue
cat queue_tail >> $HOME/.music_shell/queue
rm queue_tail