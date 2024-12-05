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
        ROWID = 0x0001,
        LOCATION = 0x0002,
        YEAR = 0x0004,
        ARTIST = 0x0008,
        ALBUM = 0x0010,
        ALBUM_ARTIST = 0x0020,
        DISC = 0x0040,
        TRACK = 0x0080,
        TITLE = 0x0100,
        FILE = 0x0200,
        HASH = 0x0400,
        INSERT_TS = 0x0800,
        UPDATE_TS = 0x1000
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
};


#endif