#!/bin/bash

./settings.sh

LINE_NUMBER=$1
INSERT=$2
LIST_NAME=$3
LEN=$(cat "$HOME/.music_shell/$LIST_NAME" | wc -l)
TAIL_N=$(($LEN - $LINE_NUMBER))

tail -$TAIL_N "$HOME/.music_shell/$LIST_NAME" > queue_tail
head -$LINE_NUMBER "$HOME/.music_shell/$LIST_NAME" > $HOME/.music_shell/queue_head
rm "$HOME/.music_shell/$LIST_NAME";
mv $HOME/.music_shell/queue_head "$HOME/.music_shell/$LIST_NAME"
echo "$INSERT" >> "$HOME/.music_shell/$LIST_NAME"
cat queue_tail >> "$HOME/.music_shell/$LIST_NAME"
rm queue_tail