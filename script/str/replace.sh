#!/bin/bash

# FILE: 'replace.sh'
# VERSION: '0.0.1'
# FILE_DATE: 'Fri Jul 12 07:03:30 AM CDT 2024'
# INFO: replace substr with src 

function VERSION
{
    echo -e "version: ${VERSION} - $(date)\n"
}

function HELP
{
    INFO
    echo -e "\nUsage: \n" \
              "$> insert.sh [-(v|h)] SRC DST DST_IDX DST_LEN\n"
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
DST_IDX=$5
DST_LEN=$6

#  get length of file
DST_FILE_LEN=$(cat "$DST" | wc -l)
SRC_FILE_LEN=$(cat "$SRC" | wc -l)

# get head and tail @ line number
head -$DST_IDX "$DST" > dst_head.swp
tail -(($DST_FILE_LEN-($DST_IDX+$DST_LEN))) "$DST" > dst_tail.swp

# make head to destination
rm "$DST"
mv dst_head.swp $DST

# append src to head
cat "$SRC" >> dst_head.swp
# append dst tail to dst (head + src)
cat dst_tail.swp >> dst_head.swp
# mv all to dst
mv dst_head.swp $DST

# remove tmp file
rm dst_tail.swp
