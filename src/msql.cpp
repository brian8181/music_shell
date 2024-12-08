#include <iostream>
#include <map>
#include "msql.hpp"

#include "sqlite3.h"
#include "track_record.hpp"

msql::msql()
{

}

msql::~msql()
{

}

int msql::on_sql_data(void *NotUsed, int argc, char **argv, char **azColName)
{
      // wait until main() sends data
    // std::unique_lock lk(m);
    // cv.wait(lk, []{ return ready; });
 
    track_record record ( argv );
    records.push_back ( record );

    cout << "***" << record.rowid << ", " << record.artist << ", " << " " << record.album  << " - " << record.year << " - "
         << record.track << ". " << record.title  << " --> " << record.file << endl;
    cout << "size=" << records.size() << endl;

    //cv.notify_one();
        
    return 0;
}


bool msql::open(string sql_path, string sql_stmt)
{
    sqlite3* db;
    char* error_msg = 0;
    int rc;
    // sql_path = "/home/brian/db/music.db";
    // sql_stmt = "SELECT * FROM cash where artist=='Pink Floyd';";
    
    rc = sqlite3_open(sql_path.c_str(), &db);
    if( rc )
    {
        fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
        sqlite3_close(db);
    }
    else
    {
        fprintf(stderr, "Opened database successfully\n");
        rc = sqlite3_exec(db, sql_stmt.c_str(), on_sql_data, 0, &error_msg);
        if( rc != SQLITE_OK )
        {
            fprintf(stderr, "SQL error: %s\n", error_msg);
            sqlite3_free(error_msg);
        }
        sqlite3_close(db);
    }

    return true;
}


bool msql::query(string query)
{
    return true;
}
