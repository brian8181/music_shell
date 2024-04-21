#!/bin/bash

SRC=$1
DEST=$2
PREFIX=$3

#remove prefix from SRC.m3u

# assert all SRC.m3u lines have prefix, then remove, save results to DEST.m3u