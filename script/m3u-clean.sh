#!/usr/bin/env bash

MUSIC_ROOT="${MUSIC_ROOT:-$HOME/music-lib}" # Point this to your actual music-lib root
DRY_RUN=0

usage() {
    cat <<EOF >&2
Usage: m3c [-d] [-r /path/to/music-lib] playlist.m3u8 [output.m3u8]
  -d          Dry-run: report dead/fixed paths without writing output
  -r PATH     Override music root directory (default: $MUSIC_ROOT)
EOF
    exit 1
}

while getopts "dr:" opt; do
    case "$opt" in
        d) DRY_RUN=1 ;;
        r) MUSIC_ROOT="$OPTARG" ;;
        *) usage ;;
    esac
done
shift $((OPTIND - 1))

[ $# -lt 1 ] && usage
IN_FILE="$1"
OUT_FILE="${2:-${IN_FILE%.m3u*}.clean.m3u8}"

# Ensure UTF-8 and Unix LF line endings in memory before processing
if iconv -f UTF-8 -t UTF-8 "$IN_FILE" >/dev/null 2>&1; then
    CONTENT=$(dos2unix < "$IN_FILE")
else
    CONTENT=$(dos2unix < "$IN_FILE" | iconv -f WINDOWS-1252 -t UTF-8)
fi

kept=0
dead=0
fixed=0
: > "${OUT_FILE}.tmp"

while IFS= read -r line; do
    # Preserve #EXTM3U / #EXTINF comments or skip blank lines
    if [[ -z "$line" ]]; then
        continue
    elif [[ "$line" == \#* ]]; then
        [[ $DRY_RUN -eq 0 ]] && printf '%s\n' "$line" >> "${OUT_FILE}.tmp"
        continue
    fi

    orig="$line"

    # 1. Convert Windows backslashes to forward slashes
    clean="${line//\\//}"

    # 2. Strip any old drive letters or parent prefixes before your 4 root buckets
    clean=$(printf '%s' "$clean" | sed -E 's|^.*\/(albums|singles|soundtrack|misc)\/|\1/|')

    if [[ "$clean" != "$orig" ]]; then
        ((fixed++))
    fi

    # 3. Check if file exists under MUSIC_ROOT
    if [[ -f "$MUSIC_ROOT/$clean" ]]; then
        ((kept++))
        [[ $DRY_RUN -eq 0 ]] && printf '%s\n' "$clean" >> "${OUT_FILE}.tmp"
    else
        ((dead++))
        printf '\033[38;2;247;118;142m[DEAD]\033[0m %s\n' "$clean" >&2
    fi
done <<< "$CONTENT"

if [[ $DRY_RUN -eq 1 ]]; then
    rm -f "${OUT_FILE}.tmp"
else
    mv "${OUT_FILE}.tmp" "$OUT_FILE"
fi

printf '\033[38;2;158;206;106mDone:\033[0m %d kept (%d paths normalized), %d dead removed.\n' \
    "$kept" "$fixed" "$dead" >&2
