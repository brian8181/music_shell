#!/usr/bin/bash

# Test Cases
echo "Start test cases ..."
echo

echo "Test search ..."
search.sh test > /dev/null
or_search.sh Rolling Pink > /dev/null
and_search.sh Rolling Pink > /dev/null

echo "Test config ..."
read_config_pairs.sh ~/src/music_shell/src/.music_shell/config