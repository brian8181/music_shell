HOME="/home/brian"
SEARCH_TERM=$1
CACHE_NAME="$HOME/.music_shell/cache/$2"
PLAYLIST_NAME=$3
IGNORE_CASE=$3

cat "$CACHE_NAME" | egrep "$SEARCH_TERM" > "$HOME/${PLAYLIST_NAME}.m3u.swp"
#cat "$CACHE_NAME" | egrep --color=always $IGNORE_CASE "$SEARCH_TERM" | tee -a "$HOME/${PLAYLIST_NAME}.m3u.swp"
cat "$HOME/${PLAYLIST_NAME}.m3u.swp" | sort -u > "$HOME/${PLAYLIST_NAME}.m3u"
rm $HOME/"${PLAYLIST_NAME}.m3u.swp"
