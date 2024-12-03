#!/bin/bash

# FILE: display_fmt_all.sh
# VERSION: 0.0.1
# FILE_DATE: Mon Dec  2 03:27:12 PM CST 2024
# INFO: dislay formated text from sqlite

# albums only, sorted
sqlite3 ~/db/music.db "SELECT format('%s : %d - %s : %0d.%02d. %s -> %s', artist, year, album, disc, track, title, file) FROM cash WHERE location=='albums' ORDER BY artist, year, album, disc, track, title;"