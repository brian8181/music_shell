#!/bin/bash

$FILE=$1

NTAB='|| char(10) || char(9) || char(9) || '
FMT="char(9) || '<song>' $NTAB"
FMT="$FMT '<rowid>%s</rowid>' $NTAB"
FMT="$FMT '<location>%s</location>' $NTAB"
FMT="$FMT '<year>%s</year>' $NTAB"
FMT="$FMT '<artist>%s</artist>' $NTAB"
FMT="$FMT '<album>%s</album>' $NTAB"
FMT="$FMT '<disc>%s</disc>' $NTAB"
FMT="$FMT '<track>%s</track>' $NTAB"
FMT="$FMT '<title>%s</title>' $NTAB"
FMT="$FMT '<encoder>%s</encoder>' || char(10) || char(9) ||"
FMT="$FMT '</song>'"
echo -e "<songs>\n" > $FILE
sql3 "select format($FMT, rowid, location, year, artist, album, disc, track, title, encoder) from cash where location like '%album%';" >> ~/tmp.xml
echo -e "</songs>" >> $FILE
cat $FILE