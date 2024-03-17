#!/bin/bash

FILE=$1
cat $FILE | sed 's/[|]//g