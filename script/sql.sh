#!/usr/bin/bash

SQL=$1
sqlite3 ~/db/music.db "$SQL"
