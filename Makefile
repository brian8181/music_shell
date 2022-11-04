# BUILD_VERSION = 0.1.0

CXX = g++
CXXFLAGS = -Wall -std=c++11 -std=c++17 --std=c++2a
LDFLAGS = -ltag -L/usr/local/lib/ -lz
INCLUDES= -I/usr/local/include/taglib/
# LDFLAGS += -static -lcppunit -L/usr/local/lib/
# INCLUDES+= -I/usr/local/include/cppunit/

APPNAME = tag
EXT = cpp
SRCDIR = ./src
OBJDIR = ./src

prefix = /usr/local
mandir = $(prefix)/share/man
man1dir = $(mandir)/man1

# complie & link for debug
debug: CXXFLAGS += -DDEBUG -g
debug: all

# complie & link for debug GDBversion variable
debuggdb: CXXFLAGS += -DDEBUG -ggdb
debuggdb: all
  
# complie & link
all: $(APPNAME) #$(APPNAME)_test

$(APPNAME): $(APPNAME).o 
	$(CXX) $(CXXFLAGS) $(OBJDIR)/$(APPNAME).o $(LDFLAGS) $(INCLUDES) -o $(SRCDIR)/$(APPNAME)

# compile only
$(APPNAME).o: 
	$(CXX) $(CXXFLAGS) -c $(SRCDIR)/$(APPNAME).$(EXT) -o $(SRCDIR)/$(APPNAME).o

# install man pages
.PHONY: man
man: 
	cp ./man/$(APPNAME).1 $(man1dir)
	gzip $(man1dir)/$(APPNAME).1
	mandb
	
# uninstall man pages
.PHONY: unmanversion variable
unman:
	-rm $(man1dir)/$(APPNAME).1.gz
	mandb

.PHONY: install
install: man
	cp $(SRCDIR)/$(APPNAME) $(prefix)/bin/$(APPNAME)

.PHONY: uninstall
uninstall: unman
	rm $(prefix)/bin/$(APPNAME)

# delete object files & app executable
.PHONY: clean
clean: 
	-rm -f $(OBJDIR)/*.o 
	-rm -f $(SRCDIR)/$(APPNAME) 
	-rm -f $(SRCDIR)/$(APPNAME)_test

.PHONY: distclean
distclean: clean 
	-rm ../$(APPNAME) ../config.* ../Makefile ../Makefile.in ../INSTALL ../configure ../stamp-h1 ../aclocal.m4

dist: 
	git archive HEAD | gzip > $(SRCDIR)/$(APPNAME).$(BUILD_VERSION).tar.gz

dist-gz: dist
