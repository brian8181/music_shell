#!/bin/bash

./settings.sh

TITLE=7
cut -d "|" -f $TITLE cache/cache.m3u
