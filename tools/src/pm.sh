#!/bin/bash

# /root/home/brian/music/albums/artist/title.mp3
PATH=$1
echo ${PATH#'/music'}