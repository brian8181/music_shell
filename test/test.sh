#!/bin/bash

./echo.sh Hello
./echo.sh 'Hello World'
./echo.sh "Hello World"

STR="World"

./echo.sh "Hello $STR"
./echo.sh 'Hello $STR'

#ls -al $STR


git clone git://git.savannah.gnu.org/src-highlite.git
        
autoreconf -i
mkdir build
cd build
../configure
make

