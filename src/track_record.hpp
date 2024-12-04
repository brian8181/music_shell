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

    enum Columns
    {
        COL_ROWID = 0x01,
        COL_LOCATION = 0x2,
        COL_ARTIST = 0x04,
        COL_YEAR = 0x08,
        COL_ALBUM = 0x10,
        COL_DISC = 0x20,
        COL_TRACK = 0x40,
        COL_TITLE = 0x80
    };

    track_record();

    track_record(char* cols[]);

    track_record(string rowid, string artist, string year, string album, string disc, string track, string title);

    string rowid;
    string location;
    string artist;
    string year;
    string album;
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