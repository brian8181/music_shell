#!/bin/bash

# FILE: makefile
# VERSION: 0.0.1
# FILE_DATE: Sun Sep  8 04:07:01 PM CDT 2024
# INFO:

CC= gcc
CXX= g++
CXXFLAGS= -std=c++23 -DEBUG -ggdb
LDFLAGS = -ltag -L/usr/local/lib/ -lz
INCLUDES= -I/usr/local/include/taglib/

SRC=src
OBJ=build
BLD=build
CONFIG_PATH=$(HOME)/.music_shell
BIN_PATH=$(HOME)/bin

all: $(BLD)/sqlite_open $(BLD)/sql_test $(BLD)/gtk_ex2 $(BLD)/main_wnd $(BLD)/sig_wait $(BLD)/sig_wait2 $(BLD)/thread_join_ex #$(BLD)/main_wnd2 #$(OBJ)/CXX) $(CXXFLAGS)allegro_play

$(BLD)/sql_test: $(SRC)/sql_test.cpp $(SRC)/track_record.cpp 
	$(CXX) $(CXXFLAGS) $(SRC)/sql_test.cpp $(SRC)/track_record.cpp -lsqlite3 -o $(BLD)/sql_test 

$(BLD)/ex2: $(SRC)/ex2.cpp
	$(CXX) $(CXXFLAGS) -lsqlite3 $(SRC)/ex2.cpp -o $(BLD)/ex2 

$(BLD)/sqlite_open: $(SRC)/sqlite_open.c
	$(CC) -o $(BLD)/sqlite_open $(SRC)/sqlite_open.c -lsqlite3

# $(BLD)/sql_test: $(SRC)/sql_test.c
# 	$(CC) -o $(BLD)/sql_test $(SRC)/sql_test.c -lsqlite3

# $(OBJ)/allegro_play: $(SRC)/allegro_play.cmak
# 	$(CXX) $(CXXFLAGS) $(SRC)/allegro_play.c -o $(BLD)/allegro_play

$(BLD)/allegro_play: $(SRC)/allegro_play.c
	$(CC) $(SRC)/allegro_play.c -o allegro_play $(pkg-config allegro-5 allegro_font-5 --libs --cflags)

$(OBJ)/main.o: $(SRC)/main.cpp
	$(CXX) $(CXXFLAGS) -c $(SRC)/main.cpp -o $(OBJ)/main.o

$(OBJ)/sig_wait: $(SRC)/sig_wait.c
	$(CC) $(SRC)/sig_wait.c -o $(OBJ)/sig_wait

$(OBJ)/sig_wait2: $(SRC)/sig_wait2.c
	$(CC) $(SRC)/sig_wait2.c -o $(OBJ)/sig_wait2

$(BLD)/thread_join_ex: $(SRC)/thread_join_ex.cpp
	$(CXX) $(CXXFLAGS) $(SRC)/thread_join_ex.cpp -o $(BLD)/thread_join_ex

# $(BLD)/main_wnd: $(SRC)/main_wnd.c
# $(BLD)/main_wnd: $(SRC)/main_wnd.c
# 	gcc $(CFLAGS) $(LDFLAGS) -o $(BLD)/main_wnd $(SRC)/main_wnd.c

$(BLD)/gtk_ex2: $(SRC)/gtk_ex2.c
	gcc -o $(BLD)/gtk_ex2 $(SRC)/gtk_ex2.c `pkg-config --cflags --libs gtk+-3.0`

$(BLD)/main_wnd: $(SRC)/main_wnd.cpp $(SRC)/track_record.cpp lib/libutility.a
	$(CXX) $(CXXFLAGS) -o $(BLD)/main_wnd $(SRC)/main_wnd.cpp $(SRC)/track_record.cpp lib/libutility.a `pkg-config --cflags --libs gtk+-3.0` -lsqlite3

# CFLAGS=-I/usr/include/gtk-3.0 -I/usr/include/pango-1.0 -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/cairo \
# 	-I/usr/include/harfbuzz -I/usr/include/freetype2 -I/usr/include/graphene-1.0 -I/usr/lib64/graphene-1.0/include \
# 	-mfpmath=sse -msse -msse2 -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/include/fribidi \
# 	-I/usr/include/webp -I/usr/include/libxml2 -I/usr/include/libpng16 -I/usr/include/pixman-1 -DWITH_GZFILEOP \
# 	-I/usr/include/libmount -I/usr/include/blkid -I/usr/include/sysprof-6 -pthread
	
# LDFLAGS=-lgtk-3 -lpangocairo-1.0 -lpango-1.0 -lharfbuzz -lgdk_pixbuf-2.0 -lcairo-gobject -lcairo -lvulkan -lgraphene-1.0 -lgio-2.0 -lgobject-2.0 -lglib-2.

# $(BLD)/main_wnd2: $(SRC)/main_wnd.cpp $(SRC)/track_record.cpp
# 	g++ -o $(CFLAGS) $(LDFLAGS) S$(BLD)/main_wnd2 $(SRC)/main_wnd.cpp $(SRC)/track_record.cpp `pkg-config --cflags --libs gtk+-2.0` -lsqlite3

.PHONY: install
install:
	echo "Installing from script install.sh"
	-mkdir -p $(CONFIG_PATH)
	-mkdir -p $(CONFIG_PATH)/cache
	-mkdir -p $(CONFIG_PATH)/playlist
	-touch $(CONFIG_PATH)/queue
	-touch $(CONFIG_PATH)/index
	-touch $(CONFIG_PATH)/stopped
	-touch $(CONFIG_PATH)/config.txt
	-touch $(CONFIG_PATH)/cache/cache.m3u
	./install.sh

.PHONY: uninstall
uninstall:
	echo "Uninstalling from script install.sh"
	-rm $(BIN_PATH)/s $(BIN_PATH)/search
	-rm $(BIN_PATH)/cache.sh $(BIN_PATH)/cache2.0.sh
	-rm $(BIN_PATH)/get_*.sh
	-rm $(BIN_PATH)/insert_*.sh
	-rm $(BIN_PATH)/append_*.sh
	-rm $(BIN_PATH)/delete_*.sh
	-rm $(BIN_PATH)/find_*.sh
	-rm $(BIN_PATH)/filter_*.sh
	-rm $(BIN_PATH)/search.sh $(BIN_PATH)/*_search.sh
	-rm $(BIN_PATH)/search_footer.sh
	-rm $(BIN_PATH)/select.sh $(BIN_PATH)/select_with_fields.sh
	-rm $(BIN_PATH)/set_*.sh
	-rm $(BIN_PATH)/settings.sh
	-rm $(BIN_PATH)/run_*.sh
	-rm -rf $(CONFIG_PATH)

.PHONY: clean
clean:
	-rm -f $(OBJ)/*
	-rm -f $(BLD)/*
	-rm -f test/out/*
