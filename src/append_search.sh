SEARCH_TERM=$1
CACHE_NAME=$2

$SEARCH_TERM >> cache/search_history

cat "$CACHE_NAME" | egrep --color=always -i "$SEARCH_TERM" | tee --append playing
