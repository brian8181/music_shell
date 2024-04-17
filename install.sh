#!/bin/bash

if [ -e "~/.music_shell/cache" ]
    md -p ~/.music_shell/cache
    touch ~/.music_shell/queue
    touch ~/.music_shell/config.txt
fi

if [ -e "~/bin" ]; then
    md ~/bin
    cp -rf ../src/* ~/bin
fi

if [ -e "./def_search.sh" ]
    ln ./def_search.sh s
fi
