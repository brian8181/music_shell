#! /usr/bin/bash

export folder=1
export artist=2 
export date=3
export album=4
export disc=5
export track=6
export title=7

sed -E "s/^(.+?)\|(.+?)\|(.+?)\|(.+?)\|(.+?)\|(.+?)\|(.+?)$/\\$folder~~\\$artist~~\\$date~~\\$album~~\\$disc~~\\$track~~\\$title~~/" cache.txt

