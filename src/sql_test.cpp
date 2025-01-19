
#include <iostream>
#include <cstring>
#include <string>
#include <unistd.h>         /* for STDIN_FILENO */
#include <sys/select.h>     /* for pselect   */
#include <string>
#include <getopt.h>
#include <sqlite3.h>
#include <iomanip>
#include "track_record.hpp"

using std::cout;
using std::endl;

bool query(string path, string sql)
{
    int rc;
    rc = sqlite3_initialize(); 
    if ( rc != SQLITE_OK )
    {
        cout << "sqlite3_initialize - failed ..." <<  endl;
        return false;
        
    }
    sqlite3 * db =0;   
    const char* vfs = 0;

    rc = sqlite3_open_v2( path.c_str(), &db, SQLITE_OPEN_READONLY, vfs );
    if ( rc != SQLITE_OK )
    {
        cout << "sqlite3_open_v2 - failed code= " << rc <<  endl;
        cout << "Error: " << sqlite3_errmsg(db) << endl;
        sqlite3_close( db );
        return false;
    }

    sqlite3_stmt * stmt = 0;
    rc = sqlite3_prepare_v2( db, sql.c_str(), sql.size() + 1, &stmt, 0 );
    if ( rc != SQLITE_OK )
    {
        cout << "sqlite3_prepare_v2 - failed ..." <<  endl;
        sqlite3_finalize( stmt );
        sqlite3_close( db );
        return false;
    }

    // retrieve the row
    rc = sqlite3_step( stmt );
    if ( rc == SQLITE_ROW )
    {
        string year = (const char*)sqlite3_column_text( stmt, track_record::YEAR );
        string artist = (const char*)sqlite3_column_text( stmt, track_record::ARTIST );
        string album = (const char*)sqlite3_column_text( stmt, track_record::ALBUM );
        string title = (const char*)sqlite3_column_text( stmt, track_record::TITLE );
        cout << year << ", " << artist << ", " << album << ", " << title << endl;
    }
    else
    {
        cout << "sqlite3_step - failed ..." <<  endl;
        sqlite3_finalize( stmt );
        sqlite3_close( db );
        return false;
    }

    sqlite3_finalize( stmt );
    sqlite3_close( db );

    return true;
}

static int on_sql_data( void *unused, int argc, char **argv, char **col_name )
{        
    track_record record( argv );
    cout << "* " << record.rowid << "# " << record.artist << " - " << record.year << " - " << record.album  << " - ";
    cout << std::setw( 2 ) << std::right << std::setfill( '0' ) << record.track << ". ";
    cout << std::setw( 30 ) << std::left << std::setfill( ' ' ) << record.title;
    cout << "-->" << " " << "\"" << record.file << "\"" << endl;

    return 0;
}

void query_db( const string sql_path, const string& sql_stmt )
{   
    sqlite3* db;
    int ret_code = sqlite3_open( sql_path.c_str(), &db );

    if( ret_code )
    {
        cout << "Error: " << sqlite3_errmsg(db) << endl;
        sqlite3_close( db );
    }
    else
    {
        char* error_msg = 0;
        ret_code = sqlite3_exec( db, sql_stmt.c_str( ), on_sql_data, 0, &error_msg );
        if( ret_code != SQLITE_OK )
        {
            cout << "Error: " << error_msg << endl;
            sqlite3_free( error_msg );
        }
        sqlite3_close( db );
    }
}


int parse_options(int argc, char* argv[])
{
    string  db_path = argv[1];
    string select_stmt = argv[2];
    //query_db( db_path, select_stmt );
    query(argv[1], argv[2]);
    return 0;
}

int stdin_ready (int filedes)
{
	fd_set set;
	// declare/initialize zero timeout 
	struct timespec timeout = { .tv_sec = 0 };
	// initialize the file descriptor set
	FD_ZERO(&set);
	FD_SET(filedes, &set);
	// check stdin_ready is ready on filedes 
	return pselect(filedes + 1, &set, NULL, NULL, &timeout, NULL);
}

int main(int argc, char* argv[])
{
	try
	{
		if(stdin_ready(STDIN_FILENO))
		{
			std::string buffer;
			std::cin >> buffer;
			// add piped buffer to end of argv
			char* argvtmp[sizeof(char*) * argc+1];
			memcpy(argvtmp, argv, sizeof(char*) * argc);
			argvtmp[argc] = &buffer[0];
			argv = argvtmp;
			++argc;
		}
		return parse_options(argc, argv);
	}
	catch(std::logic_error& ex)
	{
	 	std::cout << ex.what() << std::endl;
	}
}
