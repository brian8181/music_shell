#!/usr/bin/bash

SQL=$1
sqlite3 music.db "$SQL"
