ARTIST='Rolling Stones', 'Pink Floyd', 'Smashing Pumpkins', 'Neu\!', 'Black Sabbath', 'Misfits', 'Rapman', 'Big Black'
ALBUM='Exile on Main Street', 'The Wall', 'Dar Side of the Moon', 'Neu\!', 'Paranoid', 'Legacy of Brutality', 'Two Parks and a Pack Mule' 
sqlite3 $HOME/db/music.db "SELECT format('%s : %d - %s : %0d.%02d. %s, artist, year, album, disc, track, title') FROM cash where artist in ($ARTIST) AND WHERE album not like '%live%';"

SQL="SELECT * FROM cash WHERE where artist IN ("$ARTIST") AND album IN (SELECT album FROM cash where artist in ("$ARTIST"));"
sql3 "SELECT format('%s : %d - %s : %0d.%02d. %s --> \"%s\"', artist, year, album, disc, track, title, file) FROM cash WHERE artist IN ($(cat list.txt));" 