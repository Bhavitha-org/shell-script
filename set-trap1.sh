#!/bin/bash

set -e          #whenever set -e feels an error it will send signal to ERR
#                 #trap 'Commands to run' ERR -> trap syntax
trap 'echo "There is an error in $LINENO, Command: $BASH_COMMAND"' ERR       #$LINENO, $BASH_COMMAND are default variables

# echo "Hello world"
# echo "this is set-trap script"
# echoo "there is error in this line"
# echo "this is the final line"

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

for package in $@
do
    dnf list installed $package &>> LOGS_FILE
    if [ $? -ne 0 ]; then                              
        echo -e "$package not installed...$G installing now $N"
        dnf install $package -y &>> LOGS_FILE
    else 
        echo -e "$package already installed...$Y SKIPPING $N"
    fi
done