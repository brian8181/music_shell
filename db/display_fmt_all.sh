#!/bin/bash

# FILE: display_fmt_all.sh
# VERSION: 0.0.1
# FILE_DATE: Sat Apr 19 16:29:14 CDT 2025
# INFO: display formated text from sqlite

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
source $HOME/bin/display_fmt_all.conf

WHERE=$1
LIMIT=$2
DB_NAME=~/db/music.db

function PrintDefault
{
    $(PrintBright $(PrintWhite $1))
}

COLUMNS="artist, year, album, disc, track, title, file"
if [[ -z "$NO_COLOR" ]]; then
      FMT_GREEN_STR='$(PrintGreen %s)'

      # ARTIST="$(PrintGreen %s)"
      # YEAR="$(PrintMagenta %d)"
      # ALBUM="$(PrintRed %s)"
      # DISC_TRACK="$(PrintYellow %0d.%02d.)"
      # TITLE="$(PrintCyan %s)"
      # FILE="$(PrintGrey %s)"
      # SEPARATOR1="$(PrintDefault :)"
      # SEPARATOR2="$(PrintDefault -)"
      # SEPARATOR3="$(PrintDefault ->)"

      FORMAT="$ARTIST $SEPARATOR1 $YEAR $SEPARATOR2 $ALBUM $SEPARATOR1 $DISC_TRACK $TITLE $SEPARATOR3 $FILE"
      DEBUG="SELECT format('$FORMAT', '$COLUMNS') FROM cash WHERE location=='albums' ${WHERE:+" and $WHERE"} ORDER BY $COLUMNS ${LIMIT:+" LIMIT $LIMIT"};"
      echo $DEBUG
      # albums only, sorted
      sqlite3 $DB_NAME "$DEBUG"
    else
      FORMAT="%s : %d - %s : %0d.%02d. %s -> %s"
      sqlite3 $DB_NAME "SELECT format('$FORMAT', $COLUMNS) FROM cash WHERE location=='albums' ${WHERE:+" and $WHERE"} ORDER BY $COLUMNS ${LIMIT:+" LIMIT $LIMIT"};"
fi




 