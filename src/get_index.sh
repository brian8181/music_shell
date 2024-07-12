#!/bin/bash

# FILE 'src/get_index.sh'
# VERSION '0.0.1'
# FILE_DATE 'Fri Jul 12 07:03:30 AM CDT 2024'

CONFIG_PREFIX="$HOME/.music_shell"
FILE="$CONFIG_PREFIX/index"

read -r INDEX<$FILE
echo $INDEX
