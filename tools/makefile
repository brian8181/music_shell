#// License:    None
#// File Name:  ./Makefile
#// Build Date: Tue Nov 14 04:08:48 PM CST 2023
#// Version:    0.0.1

CXX = g++
CXXFLAGS = -Wall -std=c++17 -DDEBUG -g
APPNAME = tools
BUILD = build
OBJ =  build
SRC = src

debug: all

all: tools

tools: tools.o main.o #@@PREREQUISTE@@
	 $(CXX) $(CXXFLAGS) $(BUILD)/tools.o $(BUILD)/main.o -o $(BUILD)/tools #@@CLASS_NAME@@

tools.o:
	$(CXX) $(CXXFLAGS) -c $(SRC)/tools.cpp -o $(BUILD)/tools.o
	
main.o:
	$(CXX) $(CXXFLAGS) -c $(SRC)/main.cpp -o $(BUILD)/main.o

#AUTO_INSERT_POINT_DO_NOT_REMOVE#

clean:
	-rm -f $(OBJ)/*.
	-rm -f $(BUILD)/*
	