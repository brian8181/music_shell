#!/bin/bash

# FILE: 'insert.sh'
# VERSION: '0.0.1'
# FILE_DATE: 'Fri Jul 12 07:03:30 AM CDT 2024'
# INFO: insert item at index

function VERSION
{
    echo -e "version: ${VERSION} - $(date)\n"
}

function HELP
{
    INFO
    echo -e "\nUsage: \n" \
              "$> insert.sh [-(v|h)] SRC DST SRC_IDX SRC_LEN DST_IDX DST_LEN\n"
    echo -e "$(basename ${0}) - version: ${VERSION} - $(date)\n"
}


OPTSTRING="vh"
while getopts ${OPTSTRING} opt; do
  case ${opt} in
    v)
      VERSION
      echo -e "${FMT_FG_GREEN}${VERSION}${FMT_FG_RED} ${DEBUG:-debug}${FMT_RESET}"
      exit 0
      ;;
    h)
      HELP
      exit 0;
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

SRC=$1 # src file
DST=$2 # dst file
SRC_IDX=$3
SRC_LEN=$4
DST_IDX=$5
DST_LEN=$6

#  get length of file
DST_FILE_LEN=$(cat "$DST" | wc -l)
SRC_FILE_LEN=$(cat "$SRC" | wc -l)

# get src lines
tail -$(($SRC_FILE_LEN - $SRC_IDX)) | head -$SRC_LEN > $SRC.swp

# get head and tail @ line number
head -$SRC_IDX "$DST" > dst_head.swp
tail -(($DST_FILE_LEN-($SRC_IDX+$SRC_LEN))) "$DST" > dst_tail.swp

# make head to destination
rm "$DST"
mv dst_head.swp $DST

# insert after head
cat "$SRC.swp" >> $DST
# append tail
cat dst_tail.swp >> $DST

# remove tmp file
rm dst_tail.swp