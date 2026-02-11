#!/bin/bash

USERID=$(id -u)

LOGS_FOLDER="/var/log/shell-script"
LOGS_FILE="$LOGS_FOLDER/backup.log"

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} #$3, if no arg given then default 14

log() {
    echo -e "$(date "+%Y-%m-%d %H:%M:%S") | $1" | tee -a $LOGS_FILE
}

if [ $USERID -ne 0 ]; then
    log -e "$R Please run this script with root user access $N"
fi

mkdir -p $LOGS_FOLDER

USAGE() {
    log -e "$R USAGE: sudo backup <SOURCE_DIR> <DEST_DIR> <DAYS>[default 14 days] $N"
    exit 1
}

if [ $# -lt 2 ]; then       #if min args<2, then call usage and throw error
    USAGE
fi 


if [ ! -d $SOURCE_DIR ]; then 
    log -e "$R Source Directory: $SOURCE_DIR doesn't exist $N"
    exit 1
fi 

if [ ! -d $DEST_DIR ]; then 
    log -e "$R Destination Directory: $DEST_DIR doesn't exist $N"
    exit 1
fi

#find the files

FILES=$(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS)

log "Backup started"
log "Source Directory: $SOURCE_DIR"
log "Destination Directory: $DEST_DIR"
log "Days: $DAYS"

#now zip the files, before that check whether the variable is empty

if [ -z "${FILES}" ]; then 
    log "No files to Archieve...$Y SKIPPING $N"
else
    #app-logs-$TIMESTAMP.zip
    log "Files found to archieve: $FILES"
    TIMESTAMP=$(date +%F-%H-%M-%S)
    ZIP_FILE_NAME="$DEST_DIR/app-logs-$TIMESTAMP.tar.gz"
    log "Archieve name: $ZIP_FILE_NAME"
    #find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS | tar -zcvf $ZIP_FILE_NAME (error with this: cowardly refusing to create an empty archive)
    tar -zcvf $ZIP_FILE_NAME $(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS)
    #check archieve is success or not
    if [ -f $ZIP_FILE_NAME ]; then
        log "Archeival is...$G SUCCESS $N"
        #if archieval is success, then delete logs in app-logs
        while IFS= read -r filepath;
        do 
            log "Deleting file: $filepath"
            
            rm -f "$filepath"
            log "Deleted file: $filepath"
        done <<< "$FILES"
    else 
        log "Archeival is...$R FAILURE $N"
        exit 1
    fi
fi



# 1. user should pass source_dir and dest_dir, default is 14 days, but user can override
# 2. verify the directories exist and root user too
# 3. find the files and zip them.
# 4. archieve them and place into dest_dir
# 5. check archeive is success or not
# 6. if success, you can delete from source_dir