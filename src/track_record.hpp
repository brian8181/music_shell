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