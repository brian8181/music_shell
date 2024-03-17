#! /usr/bin/bash

./fields.sh

sed -E "s/^(.+?)\|(.+?)\|(.+?)\|(.+?)\|(.+?)\|(.+?)\|(.+?)$/\\$folder~~\\$artist~~\\$date~~\\$album~~\\$disc~~\\$track~~\\$title~~/" ../test/cache.txt
