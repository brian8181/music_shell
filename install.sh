#!/bin/bash

if [ -e "~/.music_shell/cache" ]
    md -p ~/.music_shell/cache
fi

if [ -e "~/bin" ]; then
    md ~/bin
fi

cp -rf ../src/* ~/bin

ln ./def_search.sh s
touch ~/.music_shell/queue
touch ~/.music_shell/config.txt