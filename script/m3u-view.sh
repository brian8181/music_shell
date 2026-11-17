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
    bucket = $1
    year = "----"; num = "--.--"; title = ""; ext = ""

    if (bucket == "albums") {
        artist = $2; album_dir = $3; file = $4
    } else if (bucket == "soundtrack" || bucket == "misc") {
        album_dir = $2; file = $3
        artist = (bucket == "soundtrack") ? "[Soundtrack]" : "[Compilation]"
    } else if (bucket == "singles") {
        if (NF >= 3) {
            artist = $2; album_dir = "[Single]"; file = $3
        } else {
            artist = "[Single]"; album_dir = "[Single]"; file = $2
        }
    } else {
        artist = $2; album_dir = $3; file = $NF
    }

    # Parse "YYYY - Album" if present
    if (match(album_dir, /^([0-9]{4}) - (.*)$/, a)) {
        year = a[1]; album = a[2]
    } else {
        album = album_dir
    }

    # Parse "1.01. Title.ext" or "01. Title.ext"
    if (match(file, /^(([0-9]+\.)?[0-9]+)\. (.*)(\.[^.]+)$/, f)) {
        num = f[1]; title = f[3]; ext = f[4]
    } else if (match(file, /^(.*)(\.[^.]+)$/, f)) {
        title = f[1]; ext = f[2]
    } else {
        title = file
    }

    # For soundtracks/compilations: extract track artist from "Artist - Title"
    if (bucket == "soundtrack" || bucket == "misc") {
        if (match(title, /^(.+?) - (.*)$/, t)) {
            artist = t[1]
            title  = t[2]
        } else {
            # Fallback if a specific track filename has no "Artist - " separator
            artist = (bucket == "soundtrack") ? "[OST]" : "[Various]"
        }
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