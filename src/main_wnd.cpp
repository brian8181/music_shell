/* 
 * Compile with:
 *  gcc -o gtk_ex2 gtk_ex2.c `pkg-config --cflags --libs gtk+-2.0`
 *
 */
#include <stdio.h>
#include <stdlib.h>
#include <sqlite3.h> 
#include <gtk/gtk.h>
#include <numeric>
#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <chrono>
#include <regex>
#include <fstream>
#include <condition_variable>
#include <iostream>
#include <thread>
#include <syncstream>
#include <iomanip>
#include <chrono>
#include <signal.h> 
#include <wait.h> 
#include "utility.hpp"
#include "track_record.hpp"

#define NUMBER_OF_COLUMNS 9

using std::cout;
using std::endl;
using std::string;
using namespace std::chrono_literals;

std::mutex m;
std::condition_variable cv;
std::string data;
bool ready = false;
bool processed = false;

map<int, string> IDX_NAME_MAP = {   { (int)track_record::ROWID, "rowid" }, 
                                    { (int)track_record::LOCATION, "location"  }, 
                                    { (int)track_record::YEAR, "year" }, 
                                    { (int)track_record::ARTIST, "artist" },
                                    { (int)track_record::ALBUM, "album" }, 
                                    { (int)track_record::ALBUM_ARTIST, "album_artist" }, 
                                    { (int)track_record::DISC, "disc" }, 
                                    { (int)track_record::TRACK, "track" }, 
                                    { (int)track_record::TITLE, "title" },
                                    { (int)track_record::FILE, "file" }, 
                                    { (int)track_record::HASH, "hash" }, 
                                    { (int)track_record::UPDATE_TS, "update_ts" }, 
                                    { (int)track_record::INSERT_TS, "insert_ts" }   };
vector<track_record> records;

static GtkTreeModel* set_model_data( void )
{
    GtkListStore* store =  gtk_list_store_new( NUMBER_OF_COLUMNS, G_TYPE_STRING, G_TYPE_STRING, G_TYPE_STRING,  
                                                                  G_TYPE_STRING, G_TYPE_STRING, G_TYPE_STRING,
                                                                  G_TYPE_STRING, G_TYPE_STRING, G_TYPE_STRING );
    GtkTreeIter iter;
    int len = records.size();
    for( int i = 0; i < len; ++i )
    {
        gtk_list_store_append( store, &iter );
        gtk_list_store_set(    store, &iter, 0, records[i].rowid.c_str(),
                                             1, records[i].location.c_str(),
                                             2, records[i].year.c_str(),
                                             3, records[i].artist.c_str(),
                                             4, records[i].album.c_str(),
                                             5, records[i].album_artist.c_str(),
                                             6, records[i].disc.c_str(),  
                                             7, records[i].track.c_str(),
                                             8, records[i].title.c_str(),
                                             -1 );
    }
    return GTK_TREE_MODEL( store );
}

static GtkWidget* create_view( void )
{
    GtkCellRenderer* renderer;
    GtkWidget* view = gtk_tree_view_new( );

    renderer = gtk_cell_renderer_text_new( );
    gtk_tree_view_insert_column_with_attributes(    GTK_TREE_VIEW (view), -1, 
                                                    "Id", renderer, "text", 
                                                    track_record::ROWID, 
                                                    NULL    );
    renderer = gtk_cell_renderer_text_new( );
    gtk_tree_view_insert_column_with_attributes(    GTK_TREE_VIEW (view), -1, 
                                                    "Location", renderer, "text", 
                                                    track_record::LOCATION,
                                                    NULL     );
    renderer = gtk_cell_renderer_text_new( );
    gtk_tree_view_insert_column_with_attributes(    GTK_TREE_VIEW (view), -1, 
                                                    "Year", renderer, "text", 
                                                    track_record::YEAR,
                                                    NULL    );
    renderer = gtk_cell_renderer_text_new( );
    gtk_tree_view_insert_column_with_attributes(    GTK_TREE_VIEW (view), -1, 
                                                    "Artist", renderer, "text", 
                                                    track_record::ARTIST,
                                                    NULL    );
    renderer = gtk_cell_renderer_text_new( );
    gtk_tree_view_insert_column_with_attributes(    GTK_TREE_VIEW (view), -1, 
                                                    "Album", renderer, "text", 
                                                    track_record::ALBUM, 
                                                    NULL    );
    renderer = gtk_cell_renderer_text_new( );
    gtk_tree_view_insert_column_with_attributes(    GTK_TREE_VIEW (view), -1, 
                                                    "Album Artist", renderer, "text", 
                                                    track_record::ALBUM_ARTIST, 
                                                    NULL    );
    renderer = gtk_cell_renderer_text_new( );
    gtk_tree_view_insert_column_with_attributes(    GTK_TREE_VIEW (view), -1, 
                                                    "Disc", renderer, "text", 
                                                    track_record::DISC, 
                                                    NULL    );
    renderer = gtk_cell_renderer_text_new( );
    gtk_tree_view_insert_column_with_attributes(    GTK_TREE_VIEW (view), -1, 
                                                    "Track", renderer, "text", 
                                                    track_record::TRACK, 
                                                    NULL    );
    renderer = gtk_cell_renderer_text_new( );
    gtk_tree_view_insert_column_with_attributes(    GTK_TREE_VIEW (view), -1, 
                                                    "Title", renderer, "text", 
                                                    track_record::TITLE,
                                                    NULL    );

    GtkTreeModel* model = set_model_data( );
    gtk_tree_view_set_model( GTK_TREE_VIEW( view ), model );
    g_object_unref( model );
    return view;
}

static int on_sql_data( void *unused, int argc, char **argv, char **col_name )
{
    std::thread::id this_id = std::this_thread::get_id();
    // wait for ready
    {   
        std::osyncstream(std::cout) << this_id  << " waiting ulock..." << endl;     
        std::unique_lock ulock( m );
        std::osyncstream(std::cout) << this_id  << " got ulock..." << endl;
        std::osyncstream(std::cout) << this_id << " waiting for ready signal..." << endl;
        cv.wait( ulock, []{ return ready; } );
        std::osyncstream(std::cout) << this_id  << " got ready signal..." << endl;
    
        track_record record( argv );
        records.push_back( record );

        // signal finished
        processed = true;
        cv.notify_one();
        std::osyncstream(std::cout) << this_id  << " notify processed ..." << endl;

        std::osyncstream(std::cout) << "* " << record.rowid << "# " << record.artist << " - " << record.year << " - " << record.album  << " - ";
        std::osyncstream(std::cout) << std::setw( 2 ) << std::right << std::setfill( '0' ) << record.track << ". ";
        std::osyncstream(std::cout) << std::setw( 30 ) << std::left << std::setfill( ' ' ) << record.title;
        std::osyncstream(std::cout) << "-->" << " " << "\"" << record.file << "\"" << endl;
        std::osyncstream(std::cout) << this_id  << " releasing ulock..." << endl;         
    }
    std::osyncstream(std::cout) << this_id  << " released ulock..." << endl; 
    
    return 0;
}

void query_db( const string sql_path, const string& sql_stmt )
{   
    sqlite3* db;
    int ret_code = sqlite3_open( sql_path.c_str(), &db );

    if( ret_code )
    {
        std::osyncstream(std::cout) << "Error: " << sqlite3_errmsg(db) << endl;
        sqlite3_close( db );
    }
    else
    {
        char* error_msg = 0;
        ret_code = sqlite3_exec( db, sql_stmt.c_str( ), on_sql_data, 0, &error_msg );
        if( ret_code != SQLITE_OK )
        {
            std::osyncstream(std::cout) << "Error: " << error_msg << endl;
            sqlite3_free( error_msg );
        }
        sqlite3_close( db );
    }
}

// void wait_for_ready()
// {
//     std::unique_lock ulock( m );
//     std::osyncstream(std::cout)<< " waiting for main thread ready ..." << endl;
//     cv.wait( ulock, []{ return ready; } );
//     std::osyncstream(std::cout)<< "main thread ready, sqlite continue ..." << endl;
// }

// void lock_until_ready()
// {
//     std::osyncstream(std::cout)<< "main waiting for glock ..." << endl;
//     std::lock_guard glock( m );
//     std::osyncstream(std::cout)<< "main has glock ..." << endl;
//     ready = true;
// }

// void lock_until_processed()
// {
//     processed = true;
//     cv.notify_one();
// }

// void wait_for_processed()
// {
//     std::osyncstream(std::cout)<< "main waiting for ulock ..." << endl;
//     std::unique_lock ulock( m );
//     std::osyncstream(std::cout)<< "main has ulock, continue ..." << endl;
//     std::osyncstream(std::cout)<< "main waiting for sqlite processed ..." << endl;
//     cv.wait( ulock, []{ return ready; } ); // wait for signal
//     std::osyncstream(std::cout)<< "main got processed, continues ..." << endl;
// }

int main( int argc, char **argv )
{
    string  db_path = argv[1];
    string select_stmt = argv[2];
    std::thread::id this_id = std::this_thread::get_id();
    // block sqlite callback until ready ...
    {
        std::osyncstream(std::cout) << this_id << " waiting for glock ..." << endl;
        std::lock_guard glock( m );
        std::osyncstream(std::cout) << this_id << " got glock ..." << endl;
        ready = true;
        std::osyncstream(std::cout) << this_id << " sleeping...\n";
        std::osyncstream(std::cout) << this_id << "a" << " sleeping..." << endl;
        std::this_thread::sleep_for(3s);
        std::osyncstream(std::cout) << this_id << "a" << " awake..." << endl;
        std::osyncstream(std::cout) << this_id << " releasing glock ..." << endl;
    }
    std::osyncstream(std::cout)<< this_id << " released glock ..." << endl;

    query_db( db_path, select_stmt );
    std::osyncstream(std::cout) << this_id << " notifying ready ..." << endl;
    cv.notify_one(); // signal sqlite, ready!
    std::osyncstream(std::cout) << this_id << " notified ready ..." << endl;
    // now, wait for callback to finish
    {
        std::osyncstream(std::cout) << this_id << "a" << " waiting for ulock ..." << endl;
        std::unique_lock ulock( m );
        std::osyncstream(std::cout) << this_id << "a" << " got ulock ..." << endl;
        std::osyncstream(std::cout) << this_id << "a" << " waiting for processed signal ..." << endl;
        cv.wait( ulock, []{ return processed; } ); // wait for signal
        std::osyncstream(std::cout ) << this_id << " got processed signal ..." << endl;
        std::osyncstream(std::cout) << this_id << "a" << " releasing ulock ..." << endl;
    }
    std::osyncstream(std::cout) << this_id << "a" << " released ulock ..." << endl;

    GtkWidget* window;
    GtkWidget* view;
    gtk_init( &argc, &argv );
    window = gtk_window_new( GTK_WINDOW_TOPLEVEL );
    g_signal_connect( window, "delete_event", gtk_main_quit, NULL );
    view = create_view( );
    gtk_container_add( GTK_CONTAINER( window ), view );
    gtk_widget_show_all( window );
    gtk_main( );

    return 0;
}
