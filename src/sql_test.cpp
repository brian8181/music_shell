
#include <iostream>
#include <cstring>
#include <string>
#include <unistd.h>         /* for STDIN_FILENO */
#include <sys/select.h>     /* for pselect   */
#include <string>
#include <getopt.h>
#include <sqlite3.h>


bool query()
{
    int rc;
    rc = sqlite3_initialize();   // Initializes the library. If the library has already been initialized it has no effect.
    if ( rc != SQLITE_OK )
    {
        return false;
    }
    sqlite3 * db =0;   // This is a pointer to an sqlite3 database
    const char* vfs = 0;  // vfs stands for virtual file system which we are not using

    // Note the filespec is a C style string and the second parameter &db is a pointer to a pointer
    rc = sqlite3_open_v2( databaseFilespec.c_str(), &db, SQLITE_OPEN_READONLY, vfs );
    if ( rc != SQLITE_OK )
    {
        sqlite3_close( db );
        return false;
    }

    // Now we create an SQL command which is stored in an sqlite3_stmt data structure.
    // Note symColName_ is a member of EquityDataLocator
    sqlite3_stmt * stmt = 0;
    std::string s = "SELECT * FROM " + tableName + " WHERE " + symColName_ + " = '" + eds.symbol_ + "';";
    rc = sqlite3_prepare_v2( db, s.c_str(), s.size() + 1, &stmt, 0 );
    if ( rc != SQLITE_OK )
    {
        sqlite3_finalize( stmt );
        sqlite3_close( db );
        return false;
    }

    // Now we retrieve the row
    rc = sqlite3_step( stmt );
    if ( rc == SQLITE_ROW )
    {
        // Here we get a pointer to the location text ( stored in the second column of the table )
        // The 1 in sqlite3_column_text( stmt, 1 ) is the column number (zero based).
        // sqlite3_column_text( sqlite_stmt* stmt, int cidx ) returns const unsigned char* so the casts are necessary.
        void* p  = const_cast< unsigned char* > ( sqlite3_column_text( stmt, 1 ) );
        eds.filespec_ = static_cast< const char* > ( p );
    }
    else
    {
        sqlite3_finalize( stmt );
        sqlite3_close( db );
        return false;
    }

    sqlite3_finalize( stmt );
    sqlite3_close( db );

    return true;
}

int parse_options(int argc, char* argv[])
{

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
