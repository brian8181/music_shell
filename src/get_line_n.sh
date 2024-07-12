#!/bin/bash

# FILE 'src/get_line_n.sh'
# VERSION '0.0.1'
# FILE_DATE 'Fri Jul 12 07:03:30 AM CDT 2024'

FILE=$1
N=$2

LINE=$(head -n $N $FILE | tail -n 1)
echo $LINE
