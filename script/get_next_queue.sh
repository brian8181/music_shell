#!/bin/bash

# FILE: 'get_queue_next_index.sh'
# VERSION: '0.0.1'
# FILE_DATE: 'Fri Jul 12 07:03:30 AM CDT 2024'
# INFO: get next playing index (in queue)

INDEX=$(get_queue_current_index.sh)
((NEXT= ${INDEX}+1))
echo $NEXT
