str=$(tail -n10 cache/search_history_all)
echo "$str" | tr ' ' '\n' | tac | xargs