#!/usr/bin/env bash

DB="${MUSIC_DB:-$HOME/db/music.db}" # Adjust default path to your music.db
MODE="view"
OUT_FILE=""

usage() {
    cat <<EOF >&2
Usage: m3q [-n] [-p | -a | -o file.m3u | -r] "SQL QUERY"
  -n          Show 1-based item numbers (passes -n to m3v)
  -p          Replace MPD queue and play results immediately
  -a          Append results to current MPD queue
  -o FILE     Save results to an .m3u playlist file (and preview)
  -r          Raw output (skip m3v formatting)
EOF
    exit 1
}

M3V_FLAGS=""
while getopts "npao:r" opt; do
    case "$opt" in
        n) M3V_FLAGS="-n" ;;
        p) MODE="play" ;;
        a) MODE="append" ;;
        o) MODE="save"; OUT_FILE="$OPTARG" ;;
        r) MODE="raw" ;;
        *) usage ;;
    esac
done
shift $((OPTIND - 1))

[ $# -eq 0 ] && usage
QUERY="$1"

# Run query cleanly (-list -noheader ensures pure path lines)
RESULTS=$(sqlite3 -list -noheader "$DB" "$QUERY") || exit 1
[ -z "$RESULTS" ] && exit 0

case "$MODE" in
    view)
        printf '%s\n' "$RESULTS" | m3v $M3V_FLAGS
        ;;
    raw)
        printf '%s\n' "$RESULTS"
        ;;
    save)
        printf '%s\n' "$RESULTS" > "$OUT_FILE"
        printf '%s\n' "$RESULTS" | m3v $M3V_FLAGS
        ;;
    append)
        printf '%s\n' "$RESULTS" | mpc add
        printf '%s\n' "$RESULTS" | m3v $M3V_FLAGS
        ;;
    play)
        mpc clear >/dev/null
        printf '%s\n' "$RESULTS" | mpc add
        mpc play >/dev/null
        printf '%s\n' "$RESULTS" | m3v $M3V_FLAGS
        ;;
esac
