sql3 "select format('%02d.%02d. %s', iif(disc, 1, 1), track, title) from cash where location like '%album%' group by album;"
sql3 "select format('%s - %s: %s - %02d.%02d. %s', artist, year, album, iif(disc, 1, 1), track, title) from cash where location like '%album%';"
    FMT="'<song>' || char(10) || char(9) || '<rowid>%s</rowid>' || char(10) || char(9) || '<location>%s</location>' || char(10) || char(9) || '<year>%s</year>' || char(10) || char(9) || '<artist>%s</artist>' || char(10) || char(9) || '<album>%s</album>' || char(10) || char(9) || '<disc>%s</disc>'|| char(10) || char(9) || '<track>%s</track>'|| char(10) || char(9) || '<title>%s</title>'|| char(10) || char(9) || '<encoder>%s</encoder>' || char(10) || '</song>'"
    echo -e "<songs>\n" > ~/tmp.xml
    sql3 "select format($FMT, rowid, location, year, artist, album, disc, track, title, encoder) from cash where location like '%album%';" >> ~/tmp.xml
     echo -e "</songs>" >> ~/tmp.xml
     cat ~/tmp.xml