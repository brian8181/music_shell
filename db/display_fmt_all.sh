#!/bin/bash

#sqlite3 ~/db/music.db "SELECT format('%s : %d - %s : %0d.%02d. %s', artist, year, album, disc, track, title) FROM cash;"

# albums only, sorted
sqlite3 ~/db/music.db "SELECT format('%s : %d - %s : %0d.%02d. %s', artist, year, album, disc, track, title) FROM cash WHERE location=='albums' ORDER BY artist, year, album, disc, track, title;"

sqlite3 ~/db/music.db "SELECT format('%s : %d - %s : %0d.%02d. %s -> %s', artist, year, album, disc, track, title, file) FROM cash WHERE location=='albums' ORDER BY artist, year, album, disc, track, title;"