# FILE: display_fmt_all.sh
# VERSION: 0.0.1
# FILE_DATE: Mon Dec  2 03:27:12 PM CST 2024

#!/bin/bash

NO_COLOR=
PLAYLIST=

OPTSTRING="abp:nh"
while getopts ${OPTSTRING} opt; do
  case ${opt} in
    a)
      echo "Option -a was triggered."
      ;;
    b)
      echo "Option -b was triggered."
      ;;
	p)
	  PLAYLIST=${OPTARG}
	  ;;
	n)
      NO_COLOR="TRUE"
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
SEARCH=$1
LIMIT=$2

WHERE_CLAUSE="WHERE location=='albums' and artist LIKE '%${SEARCH}%' OR album LIKE '%${SEARCH}%' OR title LIKE '%${SEARCH}%' ORDER BY artist, year, album, disc, track, title ${LIMIT:+" LIMIT $LIMIT"}"

if [[ -z $PLAYLIST ]]; then
	sqlite3 ${HOME}/db/music.db "SELECT format('%s : %d - %s : %0d.%02d. %s -> %s', artist, year, album, disc, track, title, file) FROM cash WHERE location=='albums' and artist LIKE '%${SEARCH}%' OR album LIKE '%${SEARCH}%' OR title LIKE '%${SEARCH}%' ORDER BY artist, year, album, disc, track, title ${LIMIT:+" LIMIT $LIMIT"};"
else
	sqlite3 ${HOME}/db/music.db "SELECT file from cash WHERE location=='albums' and artist LIKE '%${SEARCH}%' OR album LIKE '%${SEARCH}%' OR title LIKE '%${SEARCH}%' ORDER BY artist, year, album, disc, track, title ${LIMIT:+" LIMIT $LIMIT"};" | tee ${PLAYLIST}
  MSG="created playlist [$(cat $PLAYLIST | wc -l)] @ --> ${PLAYLIST} ..."
  #echo -e "$(PrintGreen ${MSG})"
  echo $MSG
  fi

