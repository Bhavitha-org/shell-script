#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
MESSAGE=""

DISK_USAGE=$(df -hT | grep -v Filesystem)
USAGE_THRESHOLD=3

while IFS= read -r line
do
    USAGE=$(df -hT | grep -v Filesystem | awk '{print $6}' | cut -d "%" -f1)
    PARTITION=$(df -hT | grep -v Filesystem | awk '{print $7}')

    if [ $USAGE -gt $USAGE_THRESHOLD ]; then
        MESSAGE+="High Disk usage on $PARTITION:$USAGE"
    fi 
done <<< $DISK_USAGE

echo "$MESSAGE"