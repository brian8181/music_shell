#!/usr/bin/bash
FIELDS=${1:-*}

sqlite3 ~/db/music10120.db "select $FIELDS from song"