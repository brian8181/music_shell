#!/bin/bash

# FILE: makefile
# VERSION: 0.0.1
# FILE_DATE: Sun Sep  8 04:07:01 PM CDT 2024
# INFO:

CC = gcc
CXX = g++
CXXFLAGS = -Wall -std=c++17 -DEBUG -ggdb
LDFLAGS = -ltag -L/usr/local/lib/ -lz
INCLUDES= -I/usr/local/include/taglib/

SRC=src
OBJ=build
BLD=build
CONFIG_PATH=$(HOME)/.music_shell
BIN_PATH=$(HOME)/bin

# complie & link
all: $(BLD)/gtk_ex2 $(BLD)/main_wnd $(OBJ)/allegro_play

# $(BLD)/tools: $(OBJ)/tools.o $(OBJ)/main.o 
# 	 $(CXX) $(CXXFLAGS) -L/usr/local/lib64/libfmtd.a $^ -o $@

# $(OBJ)/allegro_play: $(SRC)/allegro_play.c
# 	$(CXX) $(CXXFLAGS) $(SRC)/allegro_play.c -o $(BLD)/allegro_play

$(BLD)/allegro_play: $(SRC)/allegro_play.c
	$(CC) $(SRC)/allegro_play.c -o allegro_play $(pkg-config allegro-5 allegro_font-5 --libs --cflags)

$(OBJ)/main.o: $(SRC)/main.cpp
	$(CXX) $(CXXFLAGS) -c $(SRC)/main.cpp -o $(OBJ)/main.o

# $(BLD)/main_window: $(SRC)/main_window.c
# 	gcc $(pkg-config --cflags gtk4) -o $(BLD)/main_window $(SRC)/main_window.c $(pkg-config --libs gtk4)

$(BLD)/gtk_ex2: $(SRC)/gtk_ex2.c
	gcc -o $(BLD)/gtk_ex2 $(SRC)/gtk_ex2.c `pkg-config --cflags --libs gtk+-2.0`

$(BLD)/main_wnd: $(SRC)/main_wnd.c
	gcc -o $(BLD)/main_wnd $(SRC)/main_wnd.c `pkg-config --cflags --libs gtk+-2.0`

# $(BLD)/tag: $(BLD)/tag.o
# 	$(CXX) $(CXXFLAGS) $(LDFLAGS) $(INCLUDES) $(BLD)/$(APPNAME).o -o $(BLD)/tag

# # compile only
# $(BLD)/tag.o: $(SRC)/tag.cpp
# 	$(CXX) $(CXXFLAGS) $(INCLUDES) -c $(SRC)/tag.cpp -o $(OBJ)/tag.o


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
