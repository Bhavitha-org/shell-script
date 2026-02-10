#!/bin/bash

USERID=$(id -u)
LOGS_FOLDER="/var/log/shell-script"
LOGS_FILE="/var/log/shell-script/backup.log"

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} #14days is the default value when user doesn't pass arg

if [ $USERID -ne 0 ]; then
    echo -e " $R please run this script with root user access $N"
fi

mkdir -p $LOGS_FOLDER

USAGE() {
    echo -e "$R USAGE: sudo backup <SOURCE_DIR> <DEST_DIR> <DAYS>[default 14 days] $N"
    exit 1
}

if [ $# -lt 2 ]; then
    USAGE
fi 

if [ ! -d $SOURCE_DIR ]; then
    echo -e "$R Source Directory: $SOURCE_DIR doesn't exist $N"
    exit 1
fi

if [ ! -d $DEST_DIR ]; then
    echo -e "$R Destination Directory: $DEST_DIR doesn't exist $N"
    exit 1
fi
