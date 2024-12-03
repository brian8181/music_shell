/* 
 * Compile with:
 *  gcc -o gtk_ex2 gtk_ex2.c `pkg-config --cflags --libs gtk+-2.0`
 *
 */
#include <stdio.h>
#include <sqlite3.h> 
#include <gtk/gtk.h>

enum
{
  COL_NAME = 0,
  COL_AGE,
  NUM_COLS
} ;

static GtkTreeModel* create_and_fill_model (void)
{
    sqlite3 *db;
    char *zErrMsg = 0;
    int rc;

    // if( argc!=3 )
    // {
    //   fprintf(stderr, "Usage: %s DATABASE SQL-STATEMENT\n", argv[0]);
    //   return(1);
    // }
    rc = sqlite3_open("~/db/msuic.db", &db);
    if( rc )
    {
       fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
       sqlite3_close(db);
       //return(1);
    }
    else
    {
        fprintf(stderr, "Opened database successfully!\n");
    }

    // rc = sqlite3_exec(db, "select * FROM cash;", callback, 0, &zErrMsg);
    // if( rc != SQLITE_OK )
    // {
    //    fprintf(stderr, "SQL error: %s\n", zErrMsg);
    //    sqlite3_free(zErrMsg);
    // }
    sqlite3_close(db);

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

  GtkCellRenderer     *renderer;
  GtkTreeModel        *model;
  GtkWidget           *view = gtk_tree_view_new ();

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


int main (int argc, char **argv)
{
   sqlite3 *db;
   int rc = sqlite3_open("music.db", &db);
   if( rc )
   {
      fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
      return(0);
   }
   else
   {
      fprintf(stderr, "Opened database successfully\n");
   }
   sqlite3_close(db);

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
