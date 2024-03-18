SEARCH_TERM=$1
CACHE_NAME=$2

$SEARCH_TERM >> cache/search_history

cat "$CACHE_NAME" | egrep --color=always -i "$SEARCH_TERM" | tee --append playing
echo -e "Match Count: \e[31m$(cat playing | wc -l) / $(cat "$CACHE_NAME" | wc -l)\e[0m ... searching for -> \e[31m\""$SEARCH_TERM"\"\e[0m"