#!/bin/bash

# check if the session called exactly 'website' exist
if ! tmux has-session -t=website; then
  # if it does not exist
  # create a new session (new -s) called 'website' detached (-d flag)
  tmux new -s website -d

  # split the 0th pane of the 0th window of the 'website' vertically
  tmux split-window -v -t website:0.0
  # split the 1st pane of the 0th window of the 'website' horizontally
  tmux split-window -h -t website:0.1

  # send-keys (change directory command) in the 0th window and 0th pane
  tmux send-keys -t website:0.0 'cd "/home/brian/.music_shell"' Enter
  # run vscode editor in the content/ directory in the target pane website:0.0
  tmux send-keys -t website:0.0 'code .' Enter
  # send-keys (change directory command) in the 1st pane of the 0th window  
  tmux send-keys -t website:0.1 'cd "/home/yury/PROJECTS/PERSONAL/zyrikby_webpage/website/"' Enter
  # run hugo server there
  tmux send-keys -t website:0.1 'hugo serve -e production -D -F' Enter
  # run htop command inside the 2nd pane
  tmux send-keys -t website:0.2 'htop' Enter
fi

# attach to the session called 'website'
tmux a -t=website