#!/bin/bash
PATH=$1
SEARCH_TERM=$2

find "$PATH" -printf "%p : %s : %Y : %U : %n : %M : %Bk \n" -iname "$SEARCH_TERM"
