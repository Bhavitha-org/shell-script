#!/bin/bash

USERID=$(id -u)
LOGS_FOLDER="/var/log/shell-script"
LOGS_FILE="/var/log/shell-script/$0.log"

if [ $USERID -ne 0 ]; then
    echo "please run this script with root user access" | tee -a $LOGS_FILE
    exit 1
fi

VALIDATE() {
if [ $1 -ne 0 ]; then
    echo "$2 is...FAILURE" | tee -a $LOGS_FILE   #failure err will be on screen but log file has no VISIBLE err, so to print on both screen and file we use 'tee'
    exit 1
else 
    echo "$2 is...SUCCESS" | tee -a $LOGS_FILE     #-a is append 
fi
}

dnf install nginx -y &>> $LOGS_FILE
VALIDATE $? "Installing Nginx"

dnf install mysql -y &>> $LOGS_FILE
VALIDATE $? "Installing Mysql"

dnf install nodejs -y &>> $LOGS_FILE
VALIDATE $? "Installing Nodejs"