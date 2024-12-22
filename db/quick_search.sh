#!/bin/bash

# FILE: display_fmt_all.sh
# VERSION: 0.0.1
# FILE_DATE: Mon Dec  2 03:27:12 PM CST 2024
# INFO: dislay formated text from sqlite

COLOR_OPT=

OPTSTRING="abch"
while getopts ${OPTSTRING} opt; do
  case ${opt} in
    a)
      echo "Option -a was triggered."
      ;;
    b)
      echo "Option -b was triggered."
      ;;
    c)
      COLOR_OPT="TRUE";
      ;;
     h)
      # display help
      ;;
    ?)
      echo "Invalid option: -${OPTARG}."
      exit 1
      ;;
  esac
done
shift $(($OPTIND-1))

if [[ -z "$COLOR_OPT" ]]; then
    echo "todo (color) ..."
fi

SEARCH=$1
LIMIT=$2
# albums only, sorted
sqlite3 ~/db/music.db "SELECT format('%s : %d - %s : %0d.%02d. %s -> %s', artist, year, album, disc, track, title, file) FROM cash WHERE artist LIKE '%${SEARCH}%' OR album LIKE '%${SEARCH}%' OR title LIKE '%${SEARCH}%' ORDER BY artist, year, album, disc, track, title ${LIMIT:+" LIMIT $LIMIT"};"