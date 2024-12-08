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
#include <condition_variable>
#include <iostream>
#include <thread>
#include <signal.h> 
#include <wait.h> 
#include "track_record.hpp"


std::mutex m;
std::condition_variable cv;
std::string data;
bool ready = false;
bool processed = false;


using std::cout;
using std::endl;
using std::string;

// enum
// {
//     COL_NAME = 0,
//     COL_AGE,
//     NUM_COLS
// };


enum 
{
    // COL_ROWID = 0,
    // COL_LOCATION = 1,
    COL_ARTIST = 0,
    COL_YEAR = 1,
    COL_ALBUM = 2,
    COL_TRACK = 3,
    COL_TITLE = 4,
    NUM_COLS = 5
};

map<int, string> IDX_NAME_MAP = {   { (int)track_record::ROWID, "rowid" }, 
                                    { (int)track_record::LOCATION, "location"  }, 
                                    { (int)track_record::ARTIST, "artist" },
                                    { (int)track_record::YEAR, "year" }, 
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

int argc_;
char** argv_;

static GtkTreeModel* set_model_data(void)
{
    GtkListStore* store =  gtk_list_store_new (NUM_COLS, G_TYPE_STRING, G_TYPE_STRING, G_TYPE_STRING,  G_TYPE_STRING, G_TYPE_STRING);
    GtkTreeIter iter;

    int len = records.size();
    for(int i = 0; i < len; ++i)
    {
        gtk_list_store_append (store, &iter);
        gtk_list_store_set (store, &iter,
                                                COL_ARTIST, records[i].artist.c_str(),
                                                COL_YEAR, records[i].year.c_str(),
                                                COL_ALBUM, records[i].album.c_str(),
                                                COL_TRACK, records[i].track.c_str(),
                                                COL_TITLE, records[i].title.c_str(),
                                                -1);
    }

    return GTK_TREE_MODEL(store);
}

static GtkWidget* create_view(void)
{
    GtkCellRenderer* renderer;
    GtkWidget* view = gtk_tree_view_new();
  
    renderer = gtk_cell_renderer_text_new();
    gtk_tree_view_insert_column_with_attributes( GTK_TREE_VIEW (view),
                                                 -1,      
                                                 "Artist",  
                                                 renderer,
                                                "text", 
                                                COL_ARTIST, 
                                                NULL );
    renderer = gtk_cell_renderer_text_new();
    gtk_tree_view_insert_column_with_attributes( GTK_TREE_VIEW (view),
                                                    -1,      
                                                    "Year",  
                                                    renderer,
                                                    "text", 
                                                    COL_YEAR, 
                                                    NULL );

    renderer = gtk_cell_renderer_text_new();
    gtk_tree_view_insert_column_with_attributes( GTK_TREE_VIEW (view),
                                                    -1,      
                                                    "Album",  
                                                    renderer,
                                                    "text", 
                                                    COL_ALBUM, 
                                                    NULL );

     renderer = gtk_cell_renderer_text_new();
    gtk_tree_view_insert_column_with_attributes( GTK_TREE_VIEW (view),
                                                    -1,      
                                                    "track",  
                                                    renderer,
                                                    "text", 
                                                    COL_TRACK, 
                                                    NULL );

      renderer = gtk_cell_renderer_text_new();
    gtk_tree_view_insert_column_with_attributes( GTK_TREE_VIEW (view),
                                                    -1,      
                                                    "title",  
                                                    renderer,
                                                    "text", 
                                                    COL_TITLE, 
                                                    NULL );

    GtkTreeModel* model = set_model_data();
    gtk_tree_view_set_model(GTK_TREE_VIEW(view), model);

    /* The tree view has acquired its own reference to the
    *  model, so we can drop ours. That way the model will
    *  be freed automatically when the tree view is destroyed */

    g_object_unref(model);
    return view;
}

static int on_sql_data(void *NotUsed, int argc, char **argv, char **azColName)
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

void open_db(const string sql_path, const string& sql_stmt)
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
}

int main (int argc, char **argv)
{
    string  db_path = argv[1];
    string select_stmt = argv[2];

    open_db(db_path, select_stmt);
    //sleep(1);

    // // callback is waiting
    // {
    //     std::lock_guard lk(m);
    //     ready = true;
    //     std::cout << "main() signals data ready for processing\n";
    // }
    // cv.notify_one();
  
    // // wait for callback to finish
    // {
    //     std::cout << "wait for callback ..." << std::endl;
    //     std::unique_lock lk(m);
    //     cv.wait(lk, []{ return ready; });
    // }
    // std::cout << "callback notified, continue .... " << std::endl;

    GtkWidget* window;
    GtkWidget* view;
    gtk_init( &argc, &argv );
    window = gtk_window_new( GTK_WINDOW_TOPLEVEL );
    g_signal_connect( window, "delete_event", gtk_main_quit, NULL );

    view = create_view( );
    gtk_container_add( GTK_CONTAINER (window), view );
    gtk_widget_show_all( window );
    gtk_main( );

    return 0;
}
