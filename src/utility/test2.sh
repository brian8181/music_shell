#!/bin/bash

function get_array() {
 local array=("apple" "banana" "orange" "cherry")
 for element in "${array[@]}"; do
  echo "$element"
 done
}

result=$(< <(get_array))
echo "$result"