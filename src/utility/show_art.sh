#!/usr/bin/bash

$TYPE=FRONT
$PATH=${1#*|.*$}
NAME=\\"(front|cover|album|back|media|inside|cd##|disc##)".(jpg|png|jpeg)\\"

./viewer $PATH/$NAME