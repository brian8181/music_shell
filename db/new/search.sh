#!/usr/bin/bash

QUERY="select file from song where title like '%$1%'" 
sqlite3 music.db "$QUERY" > .SEARCH_TEXT
cat -n .SEARCH_TEXT 
echo "found $(cat .SEARCH_TEXT | wc -l) ..." 
