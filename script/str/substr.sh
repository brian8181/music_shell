#!/bin/bash

# FILE: 'substr.sh'
# VERSION: '0.0.1'
# FILE_DATE: 'Fri Jul 12 07:03:30 AM CDT 2024'
# INFO: get substr from file src

function VERSION
{
    echo -e "version: ${VERSION} - $(date)\n"
}

function HELP
{
    INFO
    echo -e "\nUsage: \n" \
              "$> insert.sh [-(v|h)] SRC SRC_IDX SRC_LEN\n"
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
SRC_IDX=$2
SRC_LEN=$3

#  get length of file
SRC_FILE_LEN=$(cat "$SRC" | wc -l)

# get src lines
tail -$(($SRC_FILE_LEN - $SRC_IDX)) | head -$SRC_LEN > $SRC.swp

# print substr
cat "$SRC.swp"
# remove tmp
rm  "$SRC.swp"
