#!/bin/bash

# FILE: 'file_lock.sh'
# VERSION: '0.0.1'
# FILE_DATE: 'Wed Nov  4 11:51:04 AM CST 2026'
# INFO: implements a simple file lock mechanism

touch .LOCK
echo "Lock file created"
echo "Waiting for lock to be released..."
while [ -f .LOCK ]; do
    sleep 1
done
echo "Lock released"
rm .LOCK
echo "Lock file removed"
echo "Script completed"
