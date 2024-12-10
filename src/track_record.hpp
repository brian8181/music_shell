#ifndef _track_record_HPP
#define _track_record_HPP

#include <vector>
#include <string>
#include <map>

using std::string;
using std::vector;
using std::map;

class track_record
{

public:

    enum columns
    {
        ROWID = 0,
        LOCATION = 1,
        YEAR = 2,
        ARTIST = 3,
        ALBUM = 4,
        ALBUM_ARTIST = 5,
        DISC = 6,
        TRACK = 7,
        TITLE = 8,
        ENCODER = 9,
        FILE = 10,
        HASH = 11,
        INSERT_TS = 12,
        UPDATE_TS = 13
    };

    
    track_record();
    track_record(char* cols[]);
    track_record(string rowid, string artist, string year, string album, string disc, string track, string title);

    string rowid;
    string location;
    string artist;
    string year;
    string album;
    string album_artist;
    string disc;
    string track;
    string title;
    string encoder;
    string file;
    string hash;
    string update_ts;
    string insert_ts;
    
private:
    char** columns;
};


#endif