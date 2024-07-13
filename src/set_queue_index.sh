#!/bin/bash

# FILE 'src/set_queue_index.sh'
# VERSION '0.0.1'
# FILE_DATE 'Fri Jul 12 07:03:30 AM CDT 2024'

INDEX=$1

CONFIG_PREFIX="$HOME/.music_shell"
FILE="$CONFIG_PREFIX/index"

echo "${INDEX}" > "${FILE}"
