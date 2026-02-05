#!/bin/bash

USERID=$(id -u)
LOGS_FOLDER="/var/log/shell-script"
LOGS_FILE="/var/log/shell-script/$0.log"

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $USERID -ne 0 ]; then
    echo -e "$R please run this script with root user access $N" | tee -a $LOGS_FILE
    exit 1
fi

VALIDATE() {
if [ $1 -ne 0 ]; then
    echo "$2 is...FAILURE" | tee -a $LOGS_FILE  
    exit 1
else 
    echo "$2 is...SUCCESS" | tee -a $LOGS_FILE      
fi
}


for package in $@
do
    dnf list installed $package &>> LOGS_FILE
    if [ $? -ne 0 ]; then                              
        echo -e "$package not installed...$G installing now $N"
        dnf install $package -y &>> LOGS_FILE
        VALIDATE $? "Installing $package"
    else 
        echo -e "$package already installed...$Y SKIPPING $N"
    fi
done