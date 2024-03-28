#!/usr/bin/bash

$TYPE=COVER
PATH=${$1%.*}
NAME=\\"(front|cover|album|back|media|inside|cd##|disc##)".(jpg|png|jpeg)\\"
NAME="$TYPE.jpg"

# example
# $PATH/cover.jpg

./viewer $PATH/$NAME