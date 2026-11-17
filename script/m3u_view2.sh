#!/usr/bin/env bash

SHOW_NUM=0
while getopts "n" opt; do
    case "$opt" in
        n) SHOW_NUM=1 ;;
        *) echo "Usage: $0 [-n] [file.m3u]" >&2; exit 1 ;;
    esac
done
shift $((OPTIND - 1))

gawk -v show_num="$SHOW_NUM" '
BEGIN {
    FS = "/"
    C_IDX    = "\033[1;38;2;247;118;142m"
    C_DIM    = "\033[38;2;92;99;112m"
    C_ARTIST = "\033[1;38;2;125;207;255m"
    C_YEAR   = "\033[38;2;187;154;247m"
    C_ALBUM  = "\033[38;2;192;202;245m"
    C_NUM    = "\033[38;2;255;158;100m"
    C_TITLE  = "\033[38;2;158;206;106m"
    C_RESET  = "\033[0m"
}

/^[[:space:]]*$/ || /^#/ { next }

{
    idx++
    artist = $2
    album_dir = $3
    file = $4

    # Split "2012 - The Wall (Immersion Box Set)" -> year & album
    if (match(album_dir, /^([0-9]{4}) - (.*)$/, a)) {
        year  = a[1]
        album = a[2]
    } else {
        year  = "----"
        album = album_dir
    }

    # Split "1.01. Title.mp3" OR "01. Title.mp3" -> disc.track, title, ext
    if (match(file, /^(([0-9]+\.)?[0-9]+)\. (.*)(\.[^.]+)$/, f)) {
        num   = f[1]
        title = f[3]
        ext   = f[4]
    } else {
        num   = "--.--"
        title = file
        ext   = ""
    }

    if (show_num) {
        printf "%s%3d%s %s│%s ", C_IDX, idx, C_RESET, C_DIM, C_RESET
    }

    printf "%s%-5s%s  %s%-18.18s%s  %s%s%s %s%-28.28s%s  %s%s%s%s\n",
        C_NUM, num, C_RESET,
        C_ARTIST, artist, C_RESET,
        C_YEAR, year, C_RESET,
        C_ALBUM, album, C_RESET,
        C_TITLE, title, C_DIM, ext, C_RESET
}
' "$@"

