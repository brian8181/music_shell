#// License:    None
#// File Name:  ./Makefile
#// BLD Date: Tue Nov 14 04:08:48 PM CST 2023
#// Version:    0.0.1

CXX=g++
CXXFLAGS=-Wall -std=c++17 -DDEBUG -g
APPNAME=tools
BLD=build
OBJ=build
SRC=src

debug: all

all: $(BLD)/tools

$(BLD)/tools: $(BLD)/tools.o $(BLD)/main.o $(BLD)/intersect.o #@@PREREQUISTE@@
	 $(CXX) $(CXXFLAGS) $(BLD)/tools.o $(BLD)/main.o -o $(BLD)/tools $(BLD)/intersect.o #@@CLASS_NAME@@

$(BLD)/tools.o: $(SRC)/tools.cpp
	$(CXX) $(CXXFLAGS) -c $(SRC)/tools.cpp -o $(BLD)/tools.o

$(BLD)/main.o: $(SRC)/main.cpp
	$(CXX) $(CXXFLAGS) -c $(SRC)/main.cpp -o $(BLD)/main.o

$(BLD)/intersect.o: $(SRC)/intersect.cpp
	 $(CXX) $(CXXFLAGS) -c $(SRC)/intersect.cpp -o $(BLD)/intersect.o

#AUTO_INSERT_POINT_DO_NOT_REMOVE#

.PHONY: clean
clean:
	-rm -f $(OBJ)/*.
	-rm -f $(BLD)/*
