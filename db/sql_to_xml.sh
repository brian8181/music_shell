#!/bin/bash

$FILE=$1

NL='char(10)'
TAB='char(9)'

FMT="$TAB||'<song>'||$NL"
FMT="$FMT||$TAB||$TAB||'<rowid>%s</rowid>'||$NL"
FMT="$FMT||$TAB||$TAB||'<location>%s</location>'||$NL"
FMT="$FMT||$TAB||$TAB||'<year>%s</year>'||$NL"
FMT="$FMT||$TAB||$TAB||'<artist>%s</artist>'||$NL"
FMT="$FMT||$TAB||$TAB||'<album>%s</album>'||$NL"
FMT="$FMT||$TAB||$TAB||'<disc>%s</disc>'||$NL"
FMT="$FMT||$TAB||$TAB||'<track>%s</track>'||$NL"
FMT="$FMT||$TAB||$TAB||'<title>%s</title>'||$NL"
FMT="$FMT||$TAB||$TAB||'<encoder>%s</encoder>'||$NL"
FMT="$FMT||$TAB||$TAB||'<file>%s</file>'||$NL"
FMT="$FMT||$TAB||$TAB||'<hash>%s</hash>'||$NL"
FMT="$FMT||$TAB||$TAB||'<update_ts>%s</update_ts>'||$NL"
FMT="$FMT||$TAB||$TAB||'<insert_ts>%s</insert_ts>'||$NL"
FMT="$FMT||$TAB||'</song>'"

echo -e "<table name=\\"cash\\">\n"
sql3 "select format($FMT, rowid, location, year, artist, album, disc, track, title, encoder, file, hash, update_ts, insert_ts) from cash;"
echo -e "</cash>\n"
