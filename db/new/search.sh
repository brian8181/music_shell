#!/usr/bin/bash

ENQUEUE=

OPTSTRING="vhq"
while getopts ${OPTSTRING} opt; do
  case ${opt} in
    v)
      INFO
      echo -e "${FMT_FG_GREEN}${VERSION}${FMT_FG_RED} ${DEBUG:-debug}${FMT_RESET}"
      exit 0
      ;;
    h)
      HELP
      exit 0;
      ;;
    q)
      ENQUEUE=1
      ;;
    :)
      PRINT_DEBUG "Option -${OPTARG} requires an argument."
      exit 1
      ;;
    ?)
      PRINT_DEBUG "Invalid option: -${OPTARG}."
      exit 1
      ;;
  esac
done
shift $(($OPTIND-1))


SEARCH="$1"
SQL="select file from song where title like '%$SEARCH%'" 

sqlite3 music.db "$SQL" > .SEARCH_TEXT
cat -n .SEARCH_TEXT 
echo "found $(cat .SEARCH_TEXT | wc -l) ..." 

if [ ! -z ENQUEUE ]; then
    cat .SEARCH_TEXT >> .QUEUE
fi
