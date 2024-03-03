# BUILD_VERSION = 0.1.0

CXX = g++
CXXFLAGS = -Wall -std=c++17 -DEBUG -ggdb
LDFLAGS = -ltag -L/usr/local/lib/ -lz
INCLUDES= -I/usr/local/include/taglib/
# LDFLAGS += -static -lcppunit -L/usr/local/lib/
# INCLUDES+= -I/usr/local/include/cppunit/

APPNAME=tag
SRC=./src
OBJ=./build
BLD=./build

prefix = /usr/local
mandir = $(prefix)/share/man
man1dir = $(mandir)/man1

# complie & link for debug
debug: CXXFLAGS += -DDEBUG -g
debug: all

# complie & link for debug GDBversion variable
debuggdb: CXXFLAGS += -DDEBUG -ggdb

# complie & link
all: $(BLD)\$(APPNAME)

$(BLD)\$(APPNAME): $(BLD)\$(APPNAME).o
	$(CXX) $(CXXFLAGS) $(BLD)/$(APPNAME).o $(LDFLAGS) $(INCLUDES) -o $(BLD)/$(APPNAME)

# compile only
$(BLD)\$(APPNAME).o: $(SRC)/$(APPNAME).cpp
	$(CXX) $(CXXFLAGS) -c $(SRC)/$(APPNAME).cpp -o $(BLD)/$(APPNAME).o


.PHONY: clean
clean:
	-rm -f $(OBJ)/*.o
	-rm -f $(BLD)/*.o