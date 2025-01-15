#!/bin/bash

# FILE: display_fmt_all.sh
# VERSION: 0.0.1
# FILE_DATE: Mon Dec  2 03:27:12 PM CST 2024
# INFO: dislay formated text from sqlite

NO_COLOR=

OPTSTRING="abnh"
while getopts ${OPTSTRING} opt; do
  case ${opt} in
    a)
      echo "Option -a was triggered."
      ;;
    b)
      echo "Option -b was triggered."
      ;;
    n)
      NO_COLOR="TRUE";
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

source $HOME/bin/color.sh
WHERE=$1
LIMIT=$2


function PrintDefault
{
    $(PrintBright $(PrintWhite $1))
}

if [[ -z "$NO_COLOR" ]]; then
      FMT_GREEN_STR='$(PrintGreen %s)'

      ARTIST="$(PrintGreen %s)"
      YEAR="$(PrintMagenta %d)"
      ALBUM="$(PrintRed %s)"
      DISC_TRACK="$(PrintYellow %0d.%02d.)"
      TITLE="$(PrintCyan %s)"
      FILE="$(PrintGrey %s)"
      SEPARATOR1="$(PrintDefault :)"
      SEPARATOR2="$(PrintDefault -)"
      SEPARATOR3="$(PrintDefault ->)"

      FORMAT="$ARTIST $SEPARATOR1 $YEAR $SEPARATOR2 $ALBUM $SEPARATOR1 $DISC_TRACK $TITLE $SEPARATOR3 $FILE"
      DEBUG="SELECT format('$FORMAT', artist, year, album, disc, track, title, file) FROM cash WHERE location=='albums' ${WHERE:+" and $WHERE"} ORDER BY artist, year, album, disc, track, title${LIMIT:+" LIMIT $LIMIT"};"
      echo $DEBUG
      # albums only, sorted
      sqlite3 ~/db/music.db "$DEBUG"
    else
      sqlite3 ~/db/music.db "SELECT format('%s : %d - %s : %0d.%02d. %s -> %s', artist, year, album, disc, track, title, file) FROM cash WHERE location=='albums' ${WHERE:+" and $WHERE"} ORDER BY artist, year, album, disc, track, title ${LIMIT:+" LIMIT $LIMIT"};"
fi




