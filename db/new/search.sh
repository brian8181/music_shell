#!/usr/bin/bash

SEARCH="$1"
SQL="select file from song where title like '%$SEARCH%'" 

sqlite3 music.db "$SQL" > .SEARCH_TEXT
cat -n .SEARCH_TEXT 
echo "found $(cat .SEARCH_TEXT | wc -l) ..." 
