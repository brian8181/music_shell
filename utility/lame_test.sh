#!/usr/bin/bash

#../lame_recode.sh ./test1.mp3 ./test1.recode_test.mp3

# run test or comment out test
../lame_recode.sh ./test1.mp3 ./test1.test_run.mp3 -V3
../lame_recode.sh ./test2.mp3 ./test2.test_run.mp3 -V3

../lame_recode.sh ./test1.add_art_from_file.mp3 ./test1.add_art_from_file.test_run.mp3 -V3
../lame_recode.sh ./test2.add_art_from_file.mp3 ./test2.add_art_from_file.test_run.mp3 -V3.- 
