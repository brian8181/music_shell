/* 
 * Compile with:
 *  gcc -o gtk_ex2 gtk_ex2.c `pkg-config --cflags --libs gtk+-2.0`
 *
 */
#include <stdio.h>
#include <sqlite3.h> 
#include <gtk/gtk.h>
#include <iostream>
#include <vector>
#include <string>
#include <map>
#include "track_record.hpp"

using std::cout;
using std::endl;
using std::string;

enum
{
  COL_NAME = 0,
  COL_AGE,
  NUM_COLS
};


map<int, string> IDX_NAME_MAP = {   {(int)track_record::ROWID, "rowid"}, {(int)track_record::LOCATION, "location"  }, {(int)track_record::YEAR, "year"}, {(int)track_record::ARTIST, "artist"},
                              {(int)track_record::ALBUM_ARTIST, "album_artist"}, {(int)track_record::DISC, "disc"}, {(int)track_record::TRACK, "track"}, {(int)track_record::TITLE, "title"},
                              {(int)track_record::FILE, "file"}, {(int)track_record::HASH, "hash"}, {(int)track_record::UPDATE_TS, "update_ts"}, {(int)track_record::INSERT_TS, "insert_ts"}     };

vector<track_record> records(20);

static int callback(void *NotUsed, int argc, char **argv, char **azColName)
{
    int i;
    for(i=0; i<argc; i++)
    {
        printf("%s = %s\n", azColName[i], argv[i] ? argv[i] : "NULL");
    }
      
    track_record record(argv);
    records.push_back(record);

    GtkListStore* store = gtk_list_store_new (5, G_TYPE_STRING, G_TYPE_UINT);
    GtkTreeIter iter;
    /* Append a row and fill in some data */
    gtk_list_store_append (store, &iter);
    gtk_list_store_set (store, &iter,
                                        "rowid", records[0].rowid,
                                        "location", records[1].location,
                                        "year", records[2].year,
                                        "artist", records[3].artist,
                                        "album", records[4].album,
                                        "album_artist", records[5].album_artist,
                                        "disc", records[6].disc,
                                        "track", records[7].track,
                                        "title", records[8].title,
                                        "encoder", records[9].encoder,
                                        "file", records[9].file,
                                        "hash", records[9].hash,
                                        "update_ts", records[4].update_ts,
                                        "insert_ts", records[9].insert_ts,
                                        -1);

    // cout << "***" << record.rowid << ", " << record.artist << ", " << " " << record.album  << " - " << record.year << " - "
    //      << record.track << ". " << record.title  << " --> " << record.file << endl;

    printf("\n");
    return 0;
}

static GtkTreeModel* create_and_fill_model(void)
{
    GtkListStore* store = gtk_list_store_new (NUM_COLS, G_TYPE_STRING, G_TYPE_UINT);
    GtkTreeIter iter;
        
    /* Append a row and fill in some data */
    gtk_list_store_append (store, &iter);
    gtk_list_store_set (store, &iter,
                        track_record::ARTIST, records[1],
                        track_record::YEAR, records[2],
                        track_record::ALBUM, records[3],
                        track_record::TRACK, records[4],
                        track_record::TITLE, records[5],                        
                        -1);

   
    return GTK_TREE_MODEL (store);
}

static GtkWidget* create_view_and_model(void)
{
  GtkCellRenderer     *renderer;
  GtkTreeModel        *model;
  GtkWidget           *view = gtk_tree_view_new ();

  int i = records.size()-1;

  /* --- Column #1 --- */
  renderer = gtk_cell_renderer_text_new ();
  gtk_tree_view_insert_column_with_attributes (GTK_TREE_VIEW (view),
                                               -1,      
                                               "location",  
                                               renderer,
                                               IDX_NAME_MAP[track_record::LOCATION], track_record::LOCATION,
                                               NULL);
  /* --- Column #2 --- */
  renderer = gtk_cell_renderer_text_new ();
  gtk_tree_view_insert_column_with_attributes (GTK_TREE_VIEW (view),
                                               -1,      
                                               "artist",  
                                               renderer,
                                               IDX_NAME_MAP[track_record::ARTIST], track_record::ARTIST,
                                               NULL);
  /* --- Column #3 --- */
  renderer = gtk_cell_renderer_text_new ();
  gtk_tree_view_insert_column_with_attributes (GTK_TREE_VIEW (view),
                                               -1,      
                                               "Year",  
                                               renderer,
                                               IDX_NAME_MAP[track_record::YEAR], track_record::YEAR,
                                               NULL);

   /* --- Column #4 --- */
  renderer = gtk_cell_renderer_text_new ();
  gtk_tree_view_insert_column_with_attributes (GTK_TREE_VIEW (view),
                                               -1,      
                                               "Album",  
                                               renderer,
                                               IDX_NAME_MAP[track_record::ALBUM], track_record::ALBUM,
                                               NULL);
 /* --- Column #5--- */
  renderer = gtk_cell_renderer_text_new ();
  gtk_tree_view_insert_column_with_attributes (GTK_TREE_VIEW (view),
                                               -1,      
                                               "Album  Artist",  
                                               renderer,
                                               IDX_NAME_MAP[track_record::ALBUM_ARTIST], track_record::ALBUM_ARTIST,
                                               NULL);

   /* --- Column #6 --- */
  renderer = gtk_cell_renderer_text_new ();
  gtk_tree_view_insert_column_with_attributes (GTK_TREE_VIEW (view),
                                               -1,      
                                               "Disc",  
                                               renderer,
                                               IDX_NAME_MAP[track_record::DISC], track_record::DISC,
                                               NULL);   

     /* --- Column #7 --- */
  renderer = gtk_cell_renderer_text_new ();
  gtk_tree_view_insert_column_with_attributes (GTK_TREE_VIEW (view),
                                               -1,      
                                               "Track",  
                                               renderer,
                                               IDX_NAME_MAP[track_record::TRACK], track_record::TRACK,
                                               NULL); 

     /* --- Column #8 --- */
  renderer = gtk_cell_renderer_text_new ();
  gtk_tree_view_insert_column_with_attributes (GTK_TREE_VIEW (view),
                                               -1,      
                                               "Title",  
                                               renderer,
                                               IDX_NAME_MAP[track_record::TITLE], track_record::TITLE,
                                               NULL);  
  // todo
                                        

  //    /* --- Column #8 --- */
  // renderer = gtk_cell_renderer_text_new ();
  // gtk_tree_view_insert_column_with_attributes (GTK_TREE_VIEW (view),
  //                                              -1,      
  //                                              "Title",  
  //                                              renderer,
  //                                              IDX_NAME_MAP[track_record::TITLE], track_record::TITLE,
  //                                              NULL);                              
  //                                                 /* --- Column #8 --- */
  // renderer = gtk_cell_renderer_text_new ();
  // gtk_tree_view_insert_column_with_attributes (GTK_TREE_VIEW (view),
  //                                              -1,      
  //                                              "Title",  
  //                                              renderer,
  //                                              IDX_NAME_MAP[track_record::TITLE], track_record::TITLE,
  //                                              NULL);                              
  //                                                 /* --- Column #8 --- */
  // renderer = gtk_cell_renderer_text_new ();
  // gtk_tree_view_insert_column_with_attributes (GTK_TREE_VIEW (view),
  //                                              -1,      
  //                                              "Title",  
  //                                              renderer,
  //                                              IDX_NAME_MAP[track_record::TITLE], track_record::TITLE,
  //                                              NULL);                              
  //                                                 /* --- Column #8 --- */
  // renderer = gtk_cell_renderer_text_new ();
  // gtk_tree_view_insert_column_with_attributes (GTK_TREE_VIEW (view),
  //                                              -1,      
  //                                              "Title",  
  //                                              renderer,
  //                                              IDX_NAME_MAP[track_record::TITLE], track_record::TITLE,
  //                                              NULL);                                                                                                                                                                                                                                       
  model = create_and_fill_model ();
  gtk_tree_view_set_model (GTK_TREE_VIEW (view), model);

  /* The tree view has acquired its own reference to the
   *  model, so we can drop ours. That way the model will
   *  be freed automatically when the tree view is destroyed */

  g_object_unref (model);


  return view;
}

int main (int argc, char **argv)
{
  //  sqlite3 *db;
  //  int rc = sqlite3_open("music.db", &db);
  //  if( rc )
  //  {
  //     fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
  //     return(0);
  //  }
  //  else
  //  {
  //     fprintf(stderr, "Opened database successfully\n");
  //  }
  //  sqlite3_close(db);

     //   int sqlite3_prepare(
    //   sqlite3 *db,            /* Database handle */
    //   const char *zSql,       /* SQL statement, UTF-8 encoded */
    //   int nByte,              /* Maximum length of zSql in bytes. */
    //   sqlite3_stmt **ppStmt,  /* OUT: Statement handle */
    //   const char **pzTail     /* OUT: Pointer to unused portion of zSql */
    // );
    // int sqlite3_prepare_v2(
    //   sqlite3 *db,            /* Database handle */
    //   const char *zSql,       /* SQL statement, UTF-8 encoded */
    //   int nByte,              /* Maximum length of zSql in bytes. */
    //   sqlite3_stmt **ppStmt,  /* OUT: Statement handle */
    //   const char **pzTail     /* OUT: Pointer to unused portion of zSql */
    // );
    // int sqlite3_prepare_v3(
    //   sqlite3 *db,            /* Database handle */
    //   const char *zSql,       /* SQL statement, UTF-8 encoded */
    //   int nByte,              /* Maximum length of zSql in bytes. */
    //   unsigned int prepFlags, /* Zero or more SQLITE_PREPARE_ flags */
    //   sqlite3_stmt **ppStmt,  /* OUT: Statement handle */
    //   const char **pzTail     /* OUT: Pointer to unused portion of zSql */
    // );

    sqlite3 *db;
    char *zErrMsg = 0;
    int rc;
    const char* sDb = "/home/brian/db/music.db";
    const char* sStmt = "SELECT * FROM cash where artist=='Pink Floyd';";

    rc = sqlite3_open(sDb, &db);
    if( rc )
    {
        fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
        sqlite3_close(db);
    }
    else
    {
        fprintf(stderr, "Opened database successfully\n");
        rc = sqlite3_exec(db, sStmt, callback, 0, &zErrMsg);
        if( rc != SQLITE_OK )
        {
            fprintf(stderr, "SQL error: %s\n", zErrMsg);
            sqlite3_free(zErrMsg);
        }
        sqlite3_close(db);
    }

  GtkWidget *window;
  GtkWidget *view;

  gtk_init (&argc, &argv);
  window = gtk_window_new (GTK_WINDOW_TOPLEVEL);
  g_signal_connect (window, "delete_event", gtk_main_quit, NULL); /* dirty */

  // TODO
  //view = create_view_and_model();

  gtk_container_add (GTK_CONTAINER (window), view);
  gtk_widget_show_all (window);
  gtk_main ();

  return 0;
}
