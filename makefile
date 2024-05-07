# BUILD_VERSION = 0.1.0

CXX = g++
CXXFLAGS = -Wall -std=c++17 -DEBUG -ggdb
LDFLAGS = -ltag -L/usr/local/lib/ -lz
INCLUDES= -I/usr/local/include/taglib/


APPNAME=tag
SRC=./src
OBJ=./build
BLD=./build

# complie & link
all: $(BLD)\tag

$(BLD)\tag: $(BLD)\tag.o
	$(CXX) $(CXXFLAGS) $(LDFLAGS) $(INCLUDES) $(BLD)/$(APPNAME).o -o $(BLD)/tag

# compile only
$(BLD)\tag.o: $(SRC)/tag.cpp
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c $(SRC)/tag.cpp -o $(OBJ)/tag.o

.PHONY: install
install:
	./install.sh


.PHONY: clean
clean:
	-rm -f $(OBJ)/*.o
	-rm -f $(BLD)/*.o