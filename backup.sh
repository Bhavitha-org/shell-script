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

log(){
    echo -e "$(date "+%Y-%m-%d %H:%M:%S") | $1" | tee -a $LOGS_FILE
}

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

#find the files

FILES=$(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS)

log "Backup started" #log is a function, Backup started->$1
log "Source Directory: $SOURCE_DIR"
log "Destination Directory: $DEST_DIR"
log "Days: $DAYS" 

if [ -z $FILES ]; then        #checking variable empty or not
    log "No files to archieve...$Y SKIPPING $N"
else
    #app-logs-$timestamp.zip
    log "Files found to archieve: $FILES"
    TIMESTAMP=$(date +%F-%H-%M-%S)
    ZIP_FILE_NAME="$DEST_DIR/app-logs-$TIMESTAMP.tar.gz"
    echo "Archieve name: $ZIP_FILE_NAME"
fi

