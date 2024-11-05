UPDATE song set hash=\'\1\' where song.id==\2

"s/^([^\|]*)\|([^\|]*)\|([^\|]*)$/UPDATE song set hash=\'\1\' where song.id==\2/g"

001162|albums|2004|Interpol|Antics|||03|Narc|mp3|"albums/Interpol/2004 - Antics/03. Narc.mp3"|null|20241102184745|20241102184745
"s/(^[^\|]*\|[^\|]*\|[^\|]*\|[^\|]*\|[^\|]*\|[^\|]*\|[^\|]*\|[^\|]*\|[^\|]*\|[^\|]*\)|([^\|]*)\|([^\|]*\|[^\|]*)/\1<hash>\3/g"