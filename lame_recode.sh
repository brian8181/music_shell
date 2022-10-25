#!/usr/bin/bash

VBR='-v $1'
IFILE=$1
OFILE=$2

#ART='--ti front.jpg'
#OPTIONS=$ART

#lame $ART $VBR $IFILE $OFILE
lame -V2 $IFILE $OFILE