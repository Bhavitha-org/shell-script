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

if [ $USERID -ne 0 ]; then
    echo -e "$R Please run this script with root user access $N"
fi

mkdir -p $LOGS_FOLDER

USAGE() {
    echo -e "$R USAGE: sudo backup <SOURCE_DIR> <DEST_DIR> <DAYS>[default 14 days] $N"
    exit 1
}

if [ $# -le 2 ]; then       #if min args<2, then call usage and throw error
    USAGE
fi 


if [ ! -d $SOURCE_DIR ]; then 
    echo -e "$R $SOURCE_DIR doesn't exist $N"
    exit 1
fi 

if [ ! -d $DEST_DIR ]; then 
    echo -e "$R $DEST_DIR doesn't exist $N"
    exit 1
fi






























# USERID=$(id -u)
# LOGS_FOLDER="/var/log/shell-script"
# LOGS_FILE="/var/log/shell-script/backup.log"

# R="\e[31m"
# G="\e[32m"
# Y="\e[33m"
# N="\e[0m"

# SOURCE_DIR=$1
# DEST_DIR=$2
# DAYS=${3:-14} #14days is the default value when user doesn't pass arg

# log(){
#     log -e "$(date "+%Y-%m-%d %H:%M:%S") | $1" | tee -a $LOGS_FILE
# }

# if [ $USERID -ne 0 ]; then
#     log -e " $R please run this script with root user access $N"
# fi

# mkdir -p $LOGS_FOLDER

# USAGE() {
#     log -e "$R USAGE: sudo backup <SOURCE_DIR> <DEST_DIR> <DAYS>[default 14 days] $N"
#     exit 1
# }

# if [ $# -lt 2 ]; then
#     USAGE
# fi 

# if [ ! -d $SOURCE_DIR ]; then
#     log -e "$R Source Directory: $SOURCE_DIR doesn't exist $N"
#     exit 1
# fi

# if [ ! -d $DEST_DIR ]; then
#     log -e "$R Destination Directory: $DEST_DIR doesn't exist $N"
#     exit 1
# fi

# #find the files

# FILES=$(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS)

# log "Backup started" #log is a function, Backup started->$1
# log "Source Directory: $SOURCE_DIR"
# log "Destination Directory: $DEST_DIR"
# log "Days: $DAYS" 

# if [ -z "${FILES}" ]; then        #checking variable empty or not
#     log "No files to archieve...$Y SKIPPING $N"
# else
#     #app-logs-$timestamp.zip
#     log "Files found to archieve: $FILES"
#     TIMESTAMP=$(date +%F-%H-%M-%S)
#     ZIP_FILE_NAME="$DEST_DIR/app-logs-$TIMESTAMP.tar.gz"
#     log "Archieve name: $ZIP_FILE_NAME"
#     tar -zcvf $ZIP_FILE_NAME $(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS)       #output of find, to input of tar

#     #check archieve is success or not
#     if [ -f $ZIP_FILE_NAME ]; then
#         log "Archeival is...$G SUCCESS $N"
#         while IFS= read -r filepath;
#             do 
#                 log "Deleting file: $filepath"
                
#                 rm -f $filepath
#                 log "Deleted file: $filepath"
#             done <<< $FILES_TO_DELETE
#     else
#         log "Archeival is...$R FAILURE $N"
#         exit 1
#     fi
# fi


# 1. user should pass source_dir and dest_dir, default is 14 days, but user can override
# 2. verify the directories exist and root user too
# 3. find the files and zip them.
# 4. archieve them and place into dest_dir
# 5. check archeive is success or not
# 6. you can delete from source_dir