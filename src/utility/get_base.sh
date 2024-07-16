#!/bin/bash

# FILE: get_base.sh'
# VERSION: '0.1.1'
# FILE_DATE: 'Wed Jul 10 12:07:23 PM CDT 2024'
# INFO get / appaly base to number

BASE=$1
N=$2

echo "obase=$BASE;$N" | bc

1000