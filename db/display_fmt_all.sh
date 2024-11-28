#!/bin/bash

sqlite3 ~/db/music.db "SELECT format('%s : %d - %s : %0d.%02d. %s', artist, year, album, disc, track, title) FROM cash;"