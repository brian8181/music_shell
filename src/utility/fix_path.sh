#!/bin/bash

FILE=$1
MUSIC=$2

sed s/\//\\/:/ $2
sed s/'$2'/"$MUSIC"/ ./$FILE
