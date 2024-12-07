#include "track_record.hpp"

track_record::track_record()
{

}

track_record::track_record(char* cols[])
{
    columns = cols;
    rowid = cols[0];
    location = cols[1];
    year = cols[2];
    artist = cols[3];
    album = cols[4];
    album_artist = cols[5];
    disc = cols[6];
    track = cols[7];
    title = cols[8];
    encoder = cols[9];
    file    = cols[10];
}

track_record::track_record(string rowid, string artist, string year, string album, string disc, string track, string title) 
: rowid(rowid), artist(artist), year(year), album(album), disc(disc), track(track), title(title)
{

}