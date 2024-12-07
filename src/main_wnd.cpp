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
#include <signal.h> 
#include <wait.h> 
#include "track_record.hpp"

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
    NUM_COLS = 3
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


static GtkTreeModel *create_and_fill_model (void)
{
    GtkListStore  *store;
    GtkTreeIter    iter;
  
    store = gtk_list_store_new (NUM_COLS, G_TYPE_STRING, G_TYPE_STRING, G_TYPE_STRING);

    int len = records.size();
    for(int i = 0; i < len; ++i)
    {
        gtk_list_store_append (store, &iter);
        gtk_list_store_set (store, &iter,
                      COL_ARTIST, records[i].artist.c_str(),
                      COL_YEAR, records[i].year.c_str(),
                      COL_ALBUM, records[i].album.c_str(),
                      -1);
    }

    return GTK_TREE_MODEL (store);
}

static GtkWidget *create_view_and_model (void)
{
  GtkCellRenderer     *renderer;
  GtkTreeModel        *model;
  GtkWidget           *view;

  view = gtk_tree_view_new ();

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

//   renderer = gtk_cell_renderer_text_new ();
//   gtk_tree_view_insert_column_with_attributes (GTK_TREE_VIEW (view),
//                                                -1,      
//                                                "Name",  
//                                                renderer,
//                                                "text", COL_NAME,
//                                                NULL);

  /* --- Column #2 --- */

//   renderer = gtk_cell_renderer_text_new ();
//   gtk_tree_view_insert_column_with_attributes (GTK_TREE_VIEW (view),
//                                                -1,      
//                                                "Age",  
//                                                renderer,
//                                                "text", COL_AGE,
//                                                NULL);

  model = create_and_fill_model ();

  gtk_tree_view_set_model (GTK_TREE_VIEW (view), model);

  /* The tree view has acquired its own reference to the
   *  model, so we can drop ours. That way the model will
   *  be freed automatically when the tree view is destroyed */

  g_object_unref (model);

  return view;
}


static GtkWidget* create_view_and_model_( void )
{
    GtkCellRenderer* renderer;
    GtkTreeModel* model;
    GtkWidget* view = gtk_tree_view_new();
       
    // renderer = gtk_cell_renderer_text_new( );
    // gtk_tree_view_insert_column_with_attributes( GTK_TREE_VIEW (view),
    //                                              -1,      
    //                                              "location",  
    //                                              renderer,
    //                                              IDX_NAME_MAP[track_record::LOCATION], 
    //                                              track_record::LOCATION,
    //                                              NULL );

    renderer = gtk_cell_renderer_text_new();
    gtk_tree_view_insert_column_with_attributes( GTK_TREE_VIEW (view),
                                                 -1,      
                                                 "Artist",  
                                                 renderer,
                                                "text", 
                                                 0,
                                                 NULL );
    
    renderer = gtk_cell_renderer_text_new( );
    gtk_tree_view_insert_column_with_attributes( GTK_TREE_VIEW (view),
                                                 -1,      
                                                 "Year",  
                                                 renderer,
                                                 "text", 
                                                 1,
                                                 NULL );

    // renderer = gtk_cell_renderer_text_new( );
    // gtk_tree_view_insert_column_with_attributes( GTK_TREE_VIEW (view),
    //                                              -1,      
    //                                              "Album",  
    //                                              renderer,
    //                                              "text", 
    //                                              2,
    //                                              NULL );
    // // renderer = gtk_cell_renderer_text_new( );
    // // gtk_tree_view_insert_column_with_attributes( GTK_TREE_VIEW (view),
    //                                              -1,      
    //                                              "Album  Artist",  
    //                                              renderer,
    //                                              IDX_NAME_MAP[track_record::ALBUM_ARTIST], 
    //                                              track_record::ALBUM_ARTIST,
    //                                              NULL );

    // renderer = gtk_cell_renderer_text_new( );
    // gtk_tree_view_insert_column_with_attributes( GTK_TREE_VIEW (view),
    //                                              -1,      
    //                                              "Disc",  
    //                                              renderer,
    //                                              IDX_NAME_MAP[track_record::DISC], 
    //                                              track_record::DISC,
    //                                              NULL );   

    // renderer = gtk_cell_renderer_text_new( );
    // gtk_tree_view_insert_column_with_attributes( GTK_TREE_VIEW (view),
    //                                              -1,      
    //                                              "Track",  
    //                                              renderer,
    //                                              IDX_NAME_MAP[track_record::TRACK], 
    //                                              track_record::TRACK,
    //                                              NULL ); 

    // renderer = gtk_cell_renderer_text_new( );
    // gtk_tree_view_insert_column_with_attributes( GTK_TREE_VIEW (view),
    //                                              -1,      
    //                                              "Title",  
    //                                              renderer,
    //                                              IDX_NAME_MAP[track_record::TITLE], 
    //                                              track_record::TITLE,
    //                                              NULL );  
    // renderer = gtk_cell_renderer_text_new( );
    // gtk_tree_view_insert_column_with_attributes( GTK_TREE_VIEW (view),
    //                                             -1,      
    //                                             "Encoder",  
    //                                             renderer,
    //                                             IDX_NAME_MAP[track_record::ENCODER], track_record::ENCODER,
    //                                             NULL );                              

    // renderer = gtk_cell_renderer_text_new( );
    // gtk_tree_view_insert_column_with_attributes( GTK_TREE_VIEW (view),
    //                                              -1,      
    //                                              "Hash",  
    //                                              renderer,
    //                                              IDX_NAME_MAP[track_record::HASH], track_record::HASH,
    //                                              NULL );                              

    // renderer = gtk_cell_renderer_text_new( );
    // gtk_tree_view_insert_column_with_attributes( GTK_TREE_VIEW (view),
    //                                              -1,      
    //                                              "File",  
    //                                              renderer,
    //                                              IDX_NAME_MAP[track_record::FILE], track_record::FILE,
    //                                              NULL );                              

    // renderer = gtk_cell_renderer_text_new( );
    // gtk_tree_view_insert_column_with_attributes( GTK_TREE_VIEW (view),
    //                                              -1,
    //                                              "Insert Timestamp",  
    //                                              renderer,
    //                                              IDX_NAME_MAP[track_record::INSERT_TS], track_record::INSERT_TS,
    //                                              NULL );       
    // renderer = gtk_cell_renderer_text_new( );
    // gtk_tree_view_insert_column_with_attributes( GTK_TREE_VIEW (view),
    //                                              -1,      
    //                                              "Update Timestamp",  
    //                                              renderer,
    //                                              IDX_NAME_MAP[track_record::UPDATE_TS], track_record::UPDATE_TS,
    //                                              NULL );                                                                                                                                                                                                                                       
    model = create_and_fill_model( );
    gtk_tree_view_set_model( GTK_TREE_VIEW (view), model );

    /* The tree view has acquired its own reference to the
    *  model, so we can drop ours. That way the model will
    *  be freed automatically when the tree view is destroyed */

    g_object_unref( model );
    return view;
}

void create_main_wnd(int argc, char **argv)
{
    GtkWidget* window;
    GtkWidget* view;
    gtk_init( &argc, &argv );
    window = gtk_window_new( GTK_WINDOW_TOPLEVEL );
    g_signal_connect( window, "delete_event", gtk_main_quit, NULL );

    // TODO
    view = create_view_and_model();

    gtk_container_add( GTK_CONTAINER(window), view );
    gtk_widget_show_all( window );
    gtk_main( );
}

static int on_sql_data(void *NotUsed, int argc, char **argv, char **azColName)
{
    for (int i = 0; i < argc; i++)
    {
        printf("%s = %s\n", azColName[i], argv[i] ? argv[i] : "NULL");
    }
      
    track_record record ( argv );
    records.push_back ( record );

    // GtkListStore* store = gtk_list_store_new ( 5, G_TYPE_STRING, G_TYPE_UINT );
    // GtkTreeIter iter;

    // /* Append a row and fill in some data */
    // gtk_list_store_append( store, &iter );
    // gtk_list_store_set( store, &iter,
    //                     "rowid", records[0].rowid,
    //                     "location", records[1].location,
    //                     "year", records[2].year,
    //                     "artist", records[3].artist,
    //                     "album", records[4].album,
    //                     "track", records[7].track,
    //                     "title", records[8].title,
    //                     "encoder", records[9].encoder,
    //                     "file", records[9].file,
    //                     "hash", records[9].hash,
    //                     "update_ts", records[4].update_ts,
    //                     "insert_ts", records[9].insert_ts,
    //                     -1 );

    cout << "***" << record.rowid << ", " << record.artist << ", " << " " << record.album  << " - " << record.year << " - "
         << record.track << ". " << record.title  << " --> " << record.file << endl;

    cout << "size=" << records.size() << endl;
    
    
    return 0;
}

void open_db(const char* sql_path, const char* sql_stmt)
{
    sqlite3* db;
    char* error_msg = 0;
    int rc;
    sql_path = "/home/brian/db/music.db";
    sql_stmt = "SELECT * FROM cash where artist=='Pink Floyd';";
    
    rc = sqlite3_open(sql_path, &db);
    if( rc )
    {
        fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
        sqlite3_close(db);
    }
    else
    {
        fprintf(stderr, "Opened database successfully\n");
        rc = sqlite3_exec(db, sql_stmt, on_sql_data, 0, &error_msg);
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
    open_db(0, 0);
    // wait for callback
    // pid_t p; 
    // int status; 
    // if ((p = wait(&status)) > 0) 
    // { 
    //     counter += 4; 
    //     printf("counter = %d\n", counter); 
    //} 
    sleep(1);

    GtkWidget* window;
    GtkWidget* view;
    gtk_init( &argc, &argv );
    window = gtk_window_new( GTK_WINDOW_TOPLEVEL );
    g_signal_connect( window, "delete_event", gtk_main_quit, NULL );


    view = create_view_and_model();

    gtk_container_add( GTK_CONTAINER (window), view );
    gtk_widget_show_all( window );
    gtk_main( );

    return 0;
}
