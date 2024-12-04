/* 
 * Compile with:
 *  gcc -o gtk_ex2 gtk_ex2.c `pkg-config --cflags --libs gtk+-2.0`
 *
 */
#include <stdio.h>
#include <sqlite3.h> 
#include <gtk/gtk.h>
#include <vector>
#include <string>
#include <map>

enum
{
  COL_NAME = 0,
  COL_AGE,
  NUM_COLS
} ;


std::map<std::string, std::string> data_map;
std::vector<std::string> columns;

static int callback(void *NotUsed, int argc, char **argv, char **azColName)
{
   
    int i;
    for(i=0; i<argc; i++)
    {
        printf("%s = %s\n", azColName[i], argv[i] ? argv[i] : "NULL");
      
        std::string s = azColName[i];
        data_map[s] = std::string(argv[i]);
        //columns.push_back(s);
    }
    printf("\n");
    return 0;
}

static GtkTreeModel* create_and_fill_model (void)
{
    GtkListStore* store = gtk_list_store_new (NUM_COLS, G_TYPE_STRING, G_TYPE_UINT);
    GtkTreeIter iter;
        
    /* Append a row and fill in some data */
    gtk_list_store_append (store, &iter);
    gtk_list_store_set (store, &iter,
                        COL_NAME, "",
                        COL_AGE, 51,
                        -1);
    /* append another row and fill in some data */
    gtk_list_store_append (store, &iter);
    gtk_list_store_set (store, &iter,
                        COL_NAME, "Jane Doe",
                        COL_AGE, 23,
                        -1);
    /* ... and a third row */
    gtk_list_store_append (store, &iter);
    gtk_list_store_set (store, &iter,
                        COL_NAME, "Joe Bungop",
                        COL_AGE, 91,
                        -1);
    /* ... and a third row */
    gtk_list_store_append (store, &iter);
    gtk_list_store_set (store, &iter,
                        COL_NAME, "Brian Preston",
                        COL_AGE, 55,
                        -1);
    return GTK_TREE_MODEL (store);
}

static GtkTreeModel* create_and_fill_model2 (void)
{
    GtkListStore* store = gtk_list_store_new (NUM_COLS, G_TYPE_STRING, G_TYPE_UINT);
    GtkTreeIter iter;
        
    /* Append a row and fill in some data */
    gtk_list_store_append (store, &iter);
    gtk_list_store_set (store, &iter,
                        COL_NAME, "Heinz El-Mann",
                        COL_AGE, 51,
                        -1);
    /* append another row and fill in some data */
    gtk_list_store_append (store, &iter);
    gtk_list_store_set (store, &iter,
                        COL_NAME, "Jane Doe",
                        COL_AGE, 23,
                        -1);
    /* ... and a third row */
    gtk_list_store_append (store, &iter);
    gtk_list_store_set (store, &iter,
                        COL_NAME, "Joe Bungop",
                        COL_AGE, 91,
                        -1);
    /* ... and a third row */
    gtk_list_store_append (store, &iter);
    gtk_list_store_set (store, &iter,
                        COL_NAME, "Brian Preston",
                        COL_AGE, 55,
                        -1);
    return GTK_TREE_MODEL (store);
}

static GtkWidget *create_view_and_model (void)
{
  GtkCellRenderer     *renderer;
  GtkTreeModel        *model;
  GtkWidget           *view = gtk_tree_view_new ();


  //gtk_tree_view_column_set_max_width();

  /* --- Column #1 --- */
  renderer = gtk_cell_renderer_text_new ();
  gtk_tree_view_insert_column_with_attributes (GTK_TREE_VIEW (view),
                                               -1,      
                                               "Name",  
                                               renderer,
                                               "text", COL_NAME,
                                               NULL);
  /* --- Column #2 --- */
  renderer = gtk_cell_renderer_text_new ();
  gtk_tree_view_insert_column_with_attributes (GTK_TREE_VIEW (view),
                                               -1,      
                                               "Age",  
                                               renderer,
                                               "text", COL_AGE,
                                               NULL);
  model = create_and_fill_model ();
  gtk_tree_view_set_model (GTK_TREE_VIEW (view), model);

  /* The tree view has acquired its own reference to the
   *  model, so we can drop ours. That way the model will
   *  be freed automatically when the tree view is destroyed */

  g_object_unref (model);



  return view;
}

// std::map<std::string, int> name_to_col[] =
// {
//   {"artist", 1}, {"year", 2}
// };

enum COLS
{
  COL_ARTIST = 0x01,
  COL_YEAR = 0x02,
  COL_ALBUM = 0x04,
  COL_DISC = 0x08,
  COL_TRACK = 0x10,
  COL_TITLE = 0x20
} ;

static GtkWidget *create_view_and_model2 (void)
{
  GtkCellRenderer     *renderer;
  GtkTreeModel        *model;
  GtkWidget           *view = gtk_tree_view_new ();

  auto beg = data_map.begin();
  auto end = data_map.end();

  for(auto iter = beg; iter != beg; ++iter)
  {
      std::string name = (*iter).first;
      std::string value = (*iter).second;

      // renderer = gtk_cell_renderer_text_new ();
      // gtk_tree_view_insert_column_with_attributes (GTK_TREE_VIEW (view),
      //                                          -1,      
      //                                         name,  
      //                                          renderer,
      //                                          value, COL_ARTIST,
      //                                          NULL);
  }

  /* --- Column #1 --- */
  renderer = gtk_cell_renderer_text_new ();
  gtk_tree_view_insert_column_with_attributes (GTK_TREE_VIEW (view),
                                               -1,      
                                               "Name",  
                                               renderer,
                                               "text", COL_ARTIST,
                                               NULL);
  /* --- Column #2 --- */
  renderer = gtk_cell_renderer_text_new ();
  gtk_tree_view_insert_column_with_attributes (GTK_TREE_VIEW (view),
                                               -1,      
                                               "Yaer",  
                                               renderer,
                                               "text", COL_YEAR,
                                               NULL);

   /* --- Column #2 --- */
  renderer = gtk_cell_renderer_text_new ();
  gtk_tree_view_insert_column_with_attributes (GTK_TREE_VIEW (view),
                                               -1,      
                                               "Artist",  
                                               renderer,
                                               "text", COL_ARTIST,
                                               NULL);

   /* --- Column #2 --- */
  renderer = gtk_cell_renderer_text_new ();
  gtk_tree_view_insert_column_with_attributes (GTK_TREE_VIEW (view),
                                               -1,      
                                               "Album",  
                                               renderer,
                                               "text", COL_ALBUM,
                                               NULL);                                    
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
    char* sDb = "/home/brian/db/music.db";
    char* sStmt = "SELECT * FROM cash where artist=='Pink Floyd';";

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
  view = create_view_and_model ();

  gtk_container_add (GTK_CONTAINER (window), view);
  gtk_widget_show_all (window);
  gtk_main ();

  return 0;
}
