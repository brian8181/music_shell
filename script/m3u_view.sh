#!/usr/bin/env bash

gawk '
BEGIN {
    FS = "/"
    # Palette (Tokyo Night / Monokai hybrid)
    C_DIM    = "\033[38;2;92;99;112m"
    C_ARTIST = "\033[1;38;2;125;207;255m"
    C_YEAR   = "\033[38;2;187;154;247m"
    C_ALBUM  = "\033[38;2;192;202;245m"
    C_NUM    = "\033[38;2;255;158;100m"
    C_TITLE  = "\033[38;2;158;206;106m"
    C_RESET  = "\033[0m"
}

# Skip blank lines or #EXT comments
/^[[:space:]]*$/ || /^#/ { next }

{
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

    # Split "1.01. In the Flesh.mp3" -> disc.track, title, ext
    if (match(file, /^([0-9]+\.[0-9]+)\. (.*)(\.[^.]+)$/, f)) {
        num   = f[1]
        title = f[2]
        ext   = f[3]
    } else {
        num   = "--.--"
        title = file
        ext   = ""
    }

    printf "%s%-5s%s  %s%-18.18s%s  %s%s%s %s%-30.30s%s  %s%s%s%s\n",
        C_NUM, num, C_RESET,
        C_ARTIST, artist, C_RESET,
        C_YEAR, year, C_RESET,
        C_ALBUM, album, C_RESET,
        C_TITLE, title, C_DIM, ext, C_RESET
}
' "$@"

